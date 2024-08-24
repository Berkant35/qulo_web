import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

class AuthDialogs {
  static createUserActionSuccess(WidgetRef ref) => AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: S.current.create_user_success_dialog_title,
        desc: S.current.welcome_please_enter_with_login,
        btnOkOnPress: () => NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.authLoginPage),
      ).show();

  static createUserActionFailed(WidgetRef ref, String errorMessage,
          {String? title}) =>
      AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: title ?? S.current.user_creation_failed,
        desc: errorMessage,
        btnOkOnPress: () {
          StackTrace stackTrace = StackTrace.current;
          logger.i(stackTrace);
        },
      ).show();

  static createUserPrivacyPolicyNotAccepted(WidgetRef ref) => AwesomeDialog(
          context: ref.context,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: S.current.dialog_no_accepted_privacy_title,
          desc: S.current.dialog_no_accepted_privacy_content,
          btnOkText: S.current.done)
      .show();

  //not found user
  static notFoundUser() => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentContext!,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: S.current.dialog_not_found_user,
        desc: S.current.dialog_not_found_user_desc,
        btnOkText: S.current.contiune,
        btnOkOnPress: () {},
      ).show();

  //not verified user
  static notVerifiedUser() => AwesomeDialog(
    context: NavigationService.instance.navigatorKey.currentContext!,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: S.current.dialog_not_verified_user,
    desc: S.current.dialog_not_verified_user_desc,
    btnOkText: S.current.contiune,
    btnOkOnPress: () {},
  ).show();


  // close Account
  static closeAccount(WidgetRef ref, Map<String, bool> selectedReasons) =>
      AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: S.current.dialog_sure_close_account_title,
        desc: S.current.dialog_sure_close_account_content,
        btnCancelText: S.current.cancel,
        btnOkText: S.current.contiune,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          final currentUserModel = ref.read(authManager);
          // Add your account deletion logic here
          final res = await ref
              .read(authManager.notifier)
              .deleteAccount(selectedReasons, currentUserModel!);
          if (res) {
            NavigationService.instance
                .navigateToPageClear(path: NavigationConstants.authLoginPage);
          }else{
            BasicDialogs.failSaveDialog(ref);
          }
        },
      ).show();
}
