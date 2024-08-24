part of 'auth_manager.dart';

class AuthService extends AuthManager {
  final _dataBase = FirebaseDbManager();

  @override
  Future<bool> createCustomUserWithEmailAndPassword(
      String email, String password, UserModel userModel, WidgetRef ref) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email!, password: password);

      if (userCredential.user != null) {
        await firebaseAuth.currentUser!.sendEmailVerification();

        final res = await _dataBase.saveUser(
            userModel.copyWith(userId: userCredential.user!.uid),
            userCredential.user!.uid,
            ref);

        return res;
      } else {
        return false;
      }
    } catch (e) {
      logger.e(e);
      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
      return false;
    }
  }

  @override
  Future<UserModel?> currentUser(WidgetRef ref) async {
    var userCredential = firebaseAuth.currentUser;
    if (userCredential != null && userCredential.emailVerified) {
      return await _dataBase.readUser(userCredential.uid, ref);
    } else {
      return null;
    }
  }

  @override
  Future<UserModel?> signIn(
      String email, String password, WidgetRef ref) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null || !userCredential.user!.emailVerified) {
        AuthDialogs.notVerifiedUser();
        return null;
      }

      final curUser = await _dataBase.readUser(userCredential.user!.uid, ref);
      if (curUser == null) AuthDialogs.notFoundUser();
      return curUser;
    } catch (e) {
      logger.e("Error Message: ${e.toString()}");
      FirebaseExceptions.handleFirebaseException(e.toString(), ref,
          title: S.current.login_failed);
      return null;
    }
  }

  @override
  Future<void> forgotPassword(String email, WidgetRef ref) async {
    try {
      logger.i("Email: $email");
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        BasicDialogs.customBasicShowDialog(
            ref: ref,
            title: S.current.password_reset_title,
            dialogType: DialogType.success,
            content: S.current.password_reset_description);
      });
    } catch (e) {
      logger.e("Error: $e");
      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateEmail(String email, String password, WidgetRef ref) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword, WidgetRef ref) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<bool> updateCurrentUser(WidgetRef ref) async {
    try {
      final currentNewUser = ref.read(authManager);
      await _dataBase.dbBase
          .collection('users')
          .doc(currentNewUser!.userId)
          .set(currentNewUser.toJson());

      return true;
    } catch (e) {
      await BasicDialogs.failSaveDialog(ref);

      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
      return false;
    }
  }

  @override
  Future<bool> updateProfilePhoto(String photoUrl, WidgetRef ref) async {
    try {
      final currentNewUser = ref.read(authManager);
      await _dataBase.dbBase
          .collection('users')
          .doc(currentNewUser!.userId)
          .update({'photoUrl': photoUrl});

      return true;
    } catch (e) {
      await BasicDialogs.failSaveDialog(ref);

      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
      return false;
    }
  }

  @override
  Future<bool> deleteAccount(
      Map<String, bool> reasons, UserModel userModel) async {
    try {
      final user = firebaseAuth.currentUser;

      if (user != null) {
        await FirebaseCollectionEnums.users.reference
            .doc(userModel.userId)
            .delete();
        await FirebaseCollectionEnums.close_accounts.reference.add({
          "deleteLastStateOfUser": userModel.toJson(),
          "reasons": reasons,
        });
        await user.delete();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
