import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_dialog_shower/dialog/dialog_shower.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

class BasicDialogs {

  /// This dialog just show title and content text with custom animation type
  /// you can't use this dialog for custom button or custom body
  static customBasicShowDialog(
      {required WidgetRef ref,
          required String title,
          required DialogType dialogType,
          required String content}) => AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.info,
        title: title,
        desc: content,
      ).show();


  static successfullySavedDialog(WidgetRef ref) => AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: S.current.successfully_saved,
      ).show();

  static failSaveDialog(WidgetRef ref) => AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: S.current.something_went_wrong,
      ).show();

  static dontChangeAnythingDialog(WidgetRef ref) => AwesomeDialog(
        context: NavigationService.instance.navigatorKey.currentState!.context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: S.current.something_went_wrong,
      ).show();

  static sureDeleteDialog(Function() deleteFunction) => AwesomeDialog(
    context: NavigationService.instance.navigatorKey.currentState!.context,
    dialogType: DialogType.warning,
    animType: AnimType.topSlide,
    title: S.current.dialog_sure_delete_title,
    desc: S.current.dialog_sure_delete_content,
    btnCancelText: S.current.cancel,
    btnCancelOnPress: () {},
    btnOkText: S.current.contiune,
    btnOkOnPress: () => deleteFunction(),
  ).show();


  // Sure to exit from app dialog
  static sureExitDialog(WidgetRef ref) => AwesomeDialog(
    context: NavigationService.instance.navigatorKey.currentState!.context,
    dialogType: DialogType.warning,
    animType: AnimType.topSlide,
    title: S.current.dialog_sure_exit_title,
    desc: S.current.dialog_sure_exit_content,
    btnCancelText: S.current.cancel,
    btnCancelOnPress: () {},
    btnOkText: S.current.contiune,
    btnOkOnPress: () => ref.read(authManager.notifier).signOut(),
  ).show();


  static Future<void> sureDialog(Function() sureAfterDoneFunciton,WidgetRef ref,Function(DismissType c) onDismissCallback) => AwesomeDialog(
    context: NavigationService.instance.navigatorKey.currentState!.context,
    dialogType: DialogType.warning,
    animType: AnimType.topSlide,
    title: S.current.dialog_sure_recreate_title,
    desc: S.current.dialog_sure_recreate_content,
    btnCancelText: S.current.cancel,
    onDismissCallback: (c) => onDismissCallback(c),
    btnCancelOnPress: () {
      ShowCaseWidget.of(ref.context).next();},
    btnOkText: S.current.contiune,
    btnOkOnPress: () => sureAfterDoneFunciton(),
  ).show();

}
