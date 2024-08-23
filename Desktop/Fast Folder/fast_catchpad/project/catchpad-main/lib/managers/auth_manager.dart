import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/user_api.dart';
import '../models/auth/login_user.dart';
import '../models/auth/phone_ver_model.dart';
import '../models/auth/register_user.dart';
import '../models/enums/auth/auth_error.dart';
import '../prov/app_settings_prov.dart';
import '../prov/auth/auth_prov.dart';
import '../prov/auth/current_user_prov.dart';
import '../prov/game/selected_players_prov.dart';
import '../utils/widgets/error_snackbar.dart';

abstract class AuthManager {
  static void handleAuthError(BuildContext context, AuthError? err) {
    if (err != null) {
      ErrorSnackbar(err.textNotation(context)).show(context);
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

  static Future<AuthError?> handleLogin({
    required WidgetRef ref,
    required BuildContext context,
    required LoginUser user,
  }) async {
    final isEmail = user.isEmail || (user.isUsername && user.email != null);
    final isPhone = user.isPhone || (user.isUsername && user.phoneNum != null);

    if (isEmail) {
      try {
        await ref.read(authProvider.notifier).login(
              user.email!,
              user.password!,
            );
      } catch (e) {
        catchAuthException(context, e);
        return null;
      }
    } else if (isPhone) {
      final auth = FirebaseAuth.instance;

      assert(user.phoneNum != null);
      final num = parsePhoneNum(user.phoneNum!);

      /* try { */
      await auth.verifyPhoneNumber(
        phoneNumber: num,
        verificationCompleted: (creds) async {
          // completeReg(userCredential);
        },
        verificationFailed: (e) {
          catchAuthException(context, e);
        },
        codeSent: (
          verificationId,
          forceResendingToken,
        ) async {
          ref.read(phoneVerProv.notifier).state.forceResendingToken =
              forceResendingToken;
          ref.read(phoneVerProv.notifier).state.verificationId = verificationId;

          /// will return either a `UserCredential` or an `Exception`
          final res =
              await ref.watch(phoneVerProv).showCodeVerifyDialog(context);

          if (res is Exception) {
            catchAuthException(context, res);
          }
        },
        codeAutoRetrievalTimeout: (newId) {
          ref.read(phoneVerProv.notifier).state.verificationId = newId;
        },
      );
      /* } catch (e) {
        catchAuthException(context, e);
        return null;
      } */
    }

    return null;
  }

  static String parsePhoneNum(String phoneNum) {
    if (phoneNum.startsWith('0')) {
      phoneNum = phoneNum.substring(1);
    }

    return '+90' + phoneNum;
  }

  static Future<AuthError?> handleRegister({
    required WidgetRef ref,
    required BuildContext context,
    required RegisterUser user,
  }) async {
    Future<bool> userNameExists(String uname) async {
      try {
        final u = await UsersApi.instance.getUserFromUserName(uname);
        return u != null;
      } catch (e) {
        return false;
      }
    }

    Future<bool> emailExists(String email) async {
      try {
        final u = await UsersApi.instance.getUserFromEmailAddress(email);
        return u != null;
      } catch (e) {
        return false;
      }
    }

    Future<bool> phoneExists(String phone) async {
      try {
        final u = await UsersApi.instance.getUserFromPhone(phone);
        return u != null;
      } catch (e) {
        return false;
      }
    }
    /*
    if ((user.phoneNum != null && await phoneExists(user.phoneNum!))) {
      return AuthError.phoneAlreadyInUse;
    }*/

    if ((user.email != null && await emailExists(user.email!))) {
      return AuthError.emailAlreadyInUse;
    }

    if (await userNameExists(user.userName)) {
      return AuthError.userNameAlreadyInUse;
    }

    Future<AuthError?> completeFbReg() async {
      try {
        final reg = await UsersApi.instance.addUser(user, ref);

        if (!reg) {
          return AuthError.failed;
        }

        ref.read(allUsersProv.notifier).state = [
          ...ref.read(allUsersProv),
          user,
        ];

        ref.read(currentUserProv.notifier).update(user);

        await ref.read(appSettingsProv.notifier).setRegisterd(true);

        // GoRouter.of(context).goNamed(RouteTable.initialLocation);
      } catch (e) {
        return AuthError.failed;
      }

      return null;
    }

    Future<AuthError?> completeReg(UserCredential? userCredential) async {
      final credsUser = userCredential?.user;

      if (credsUser == null) {
        return AuthError.failed;
      }

      try {
        await credsUser.updateDisplayName(user.name);
        user.uid = credsUser.uid;
        return await completeFbReg();
      } catch (e) {
        return AuthError.failed;
      }
    }

    UserCredential? userCredential;

    if (user.isEmail) {
      final auth = FirebaseAuth.instance;

      UserCredential? userCredential;
      try {
        userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );
      } catch (e) {
        catchAuthException(context, e);
        return null;
      }

      await completeReg(userCredential);
    } else {
      final auth = FirebaseAuth.instance;

      assert(user.phoneNum != null);
      final num = parsePhoneNum(user.phoneNum!);

      try {
        //return completeFbReg();
        await auth.verifyPhoneNumber(
          phoneNumber: num,
          verificationCompleted: (creds) async {
            completeReg(userCredential);
          },
          verificationFailed: (e) {
            catchAuthException(context, e);
          },
          codeSent: (
            verificationId,
            forceResendingToken,
          ) async {
            ref.read(phoneVerProv.notifier).state.forceResendingToken =
                forceResendingToken;
            ref.read(phoneVerProv.notifier).state.verificationId =
                verificationId;

            /// will return either a `UserCredential` or an `Exception`
            final res =
                await ref.watch(phoneVerProv).showCodeVerifyDialog(context);

            if (res is UserCredential) {
              userCredential = res;
              await completeReg(userCredential);
            } else if (res is Exception) {
              catchAuthException(context, res);
            }
          },
          codeAutoRetrievalTimeout: (newId) {
            ref.read(phoneVerProv.notifier).state.verificationId = newId;
          },
        );
      } catch (e) {
        catchAuthException(context, e);
        return null;
      }
    }

    return null;
  }
}
