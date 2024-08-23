import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/user_api.dart';
import '../models/auth/login_user.dart';
import '../models/auth/register_user.dart';
import '../models/enums/auth/auth_error.dart';

abstract class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static UserCredential? userCredential;
  static login(
      {required WidgetRef ref,
      required BuildContext context,
      required LoginUser user}) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim());
    } catch (e) {
      catchAuthException(context, e);
    }
  }

  static register(
      {required RegisterUser user,
      required BuildContext context,
      required WidgetRef ref}) async {
    AuthError? regErr = await isExistChecker(user, context);
    if (regErr != null) {
      handleAuthError(context, regErr);
      return regErr;
    }
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email!.trim(),
        password: user.password!.trim(),
      );
      await userCredential!.user!.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        logger.e('Create user with email and password in register error: ' +
            e.toString());
      }
      if (e is AuthError) {
        return e;
      }
      return AuthError.failed;
    }
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim());
    } catch (e) {
      if (kDebugMode) {
        logger.e('Sign in with email and password after register error: ' +
            e.toString());
      }
      if (e is AuthError) {
        return e;
      }
      return AuthError.failed;
    }

    final err = await completeReg(userCredential, user, ref);
    if (err != null) {
      logger.e(err.name);
      return err;
    }
    String email = user.email!.trim();
    final userfromfbstore =
        await UsersApi.instance.getUserFromEmailAddress(email);
    ref.read(currentUserProv.notifier).update(userfromfbstore);
    return null;
    final num = parsePhoneNum(user.phoneNum!);

    /* try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber: num,
        verificationCompleted: (creds) async {
          completeReg(userCredential, user, ref);
          /* final auth = FirebaseAuth.instance;
          UserCredential? userCredential;
          try {
            userCredential = await auth.createUserWithEmailAndPassword(
              email: user.email!,
              password: user.password!,
            );
          } catch (e) {
            catchAuthException(context, e);
          }
          await completeReg(userCredential, user, ref);
          final SharedPreferences _sharedPreferences =
              await SharedPreferences.getInstance();
          logger.i('verificationCompleted');
          _sharedPreferences.setBool('firsttime', false); */
          //context.go(RouteTable.initialLocation);
        },
        verificationFailed: (e) {
          logger.e('verificationFailed $e');
          catchAuthException(context, e);
        },
        codeSent: (
          verificationId,
          forceResendingToken,
        ) async {
          logger.i('codessent');
          logger.i(
              'verificationId $verificationId forceResendingToken $forceResendingToken');
          ref.read(phoneVerProv.notifier).state.forceResendingToken =
              forceResendingToken;
          ref.read(phoneVerProv.notifier).state.verificationId = verificationId;

          /// will return either a `UserCredential` or an `Exception`
          final res =
              await ref.watch(phoneVerProv).showCodeVerifyDialog(context);
          if (res is UserCredential) {
            userCredential = res;
            logger.i('right here');
            try {
              userCredential = await auth.createUserWithEmailAndPassword(
                email: user.email!,
                password: user.password!,
              );
              userCredential = await auth.signInWithEmailAndPassword(
                  email: user.email!, password: user.password!);
              ref
                  .read(currentUserCredential.notifier)
                  .update((state) => userCredential);
              ref.read(currentUserProv.notifier).update((state) => user);
            } catch (e) {
              catchAuthException(context, e);
            }
            await completeReg(userCredential, user, ref);
          } else if (res is Exception) {
            logger.e('codeSent error $res');
            catchAuthException(context, res);
          }
        },
        codeAutoRetrievalTimeout: (newId) {
          logger.e('time out new id is : $newId');
          //ref.read(phoneVerProv.notifier).state.verificationId = newId;
        },
      );
    } catch (e) {
      logger.e('VerifyPhoneNumber method error: ' + e.toString());
      catchAuthException(context, e);
      return null;
    } */
    return null;
  }

  static String parsePhoneNum(String phoneNum) {
    if (phoneNum.startsWith('0')) {
      phoneNum = phoneNum.substring(1);
    }

    return '+90' + phoneNum;
  }

  static void handleAuthError(BuildContext context, AuthError? err) {
    if (err != null) {
      EasyLoading.showError(err.textNotation(context),
          dismissOnTap: true, duration: const Duration(milliseconds: 1500));
    }
  }

  static AuthError? handleFirebaseAuthException(FirebaseAuthException e) {
    AuthError? err;
    switch (e.code) {
      case 'email-already-in-use':
        err = AuthError.emailAlreadyInUse;
        break;

      case 'invalid-email':
        err = AuthError.invalidEmail;
        break;

      case 'operation-not-allowed':
        err = AuthError.operationNotAllowed;
        break;

      case 'weak-password':
        err = AuthError.weakPassword;
        break;

      case 'account-exists-with-different-credential':
        err = AuthError.accountExistsWithDifferentCredential;
        break;

      case 'invalid-credential':
        err = AuthError.invalidCredential;
        break;

      case 'user-disabled':
        err = AuthError.userDisabled;
        break;

      case 'user-not-found':
        err = AuthError.userNotFound;
        break;

      case 'wrong-password':
        err = AuthError.wrongPassword;
        break;

      case 'invalid-verification-code':
        err = AuthError.invalidVerificationCode;
        break;

      case 'invalid-verification-id':
        err = AuthError.invalidVerificationId;
        break;
    }

    return err;
  }

  static void catchAuthException(BuildContext context, e) {
    AuthError? err;

    if (e is FirebaseAuthException) {
      err = handleFirebaseAuthException(e);
    } else if (e is AuthError) {
      err = e;
    }

    handleAuthError(context, err ?? AuthError.failed);
  }

  static Future<bool> userNameExists(String uname) async {
    try {
      final u = await UsersApi.instance.getUserFromUserName(uname);
      return u != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> emailExists(String email) async {
    try {
      final u = await UsersApi.instance.getUserFromEmailAddress(email.trim());
      return u != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> phoneExists(String phone) async {
    try {
      final u = await UsersApi.instance.getUserFromPhone(phone);
      return u != null;
    } catch (e) {
      return false;
    }
  }

  static Future<AuthError?> completeFbReg(
      WidgetRef ref, RegisterUser user) async {
    try {
      final reg = await UsersApi.instance.addUser(user, ref);

      if (!reg) {
        logger.e('failed');
        return AuthError.failed;
      }
    } catch (e) {
      logger.e('CompleteFbReg method error: ' + e.toString());
      return AuthError.failed;
    }

    return null;
  }

  static Future<AuthError?> completeReg(
      UserCredential? userCredential, RegisterUser user, WidgetRef ref) async {
    final credsUser = userCredential?.user;

    if (credsUser == null) {
      return AuthError.failed;
    }

    try {
      await credsUser.updateDisplayName(user.name);
      user.uid = credsUser.uid;
      final err = await completeFbReg(ref, user);
      return err;
    } catch (e) {
      logger.e('completeReg method error: ' + e.toString());
      return AuthError.failed;
    }
  }

  static Future<AuthError?> isExistChecker(
      RegisterUser user, BuildContext context) async {
    /*if ((user.phoneNum != null && await phoneExists(user.phoneNum!))) {
      handleAuthError(context, AuthError.phoneAlreadyInUse);
      return AuthError.phoneAlreadyInUse;
    }*/
    if ((user.email != null && await emailExists(user.email!.trim()))) {
      handleAuthError(context, AuthError.emailAlreadyInUse);
      return AuthError.emailAlreadyInUse;
    }
    if (await userNameExists(user.userName)) {
      handleAuthError(context, AuthError.userNameAlreadyInUse);
      return AuthError.userNameAlreadyInUse;
    }
    return null;
  }
}
