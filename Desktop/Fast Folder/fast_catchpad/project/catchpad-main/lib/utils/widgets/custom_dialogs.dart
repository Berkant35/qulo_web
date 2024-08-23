import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDialogs {
  //TODO PADLER ŞARDAYKEN UYKUYA GONDERMEME DIALOGU OLUSTURULACAK!

  static bool dontShowDialog = false;

  static void sureDialog(WidgetRef ref, String desc, {Function? pressOk}) {
    final sureDialog = AwesomeDialog(
      context: ref.context,
      dialogType: DialogType.info,
      title: L10n.inst(ref.context).content_dialog_sure_title,
      desc: desc,
      btnCancelText: L10n.inst(ref.context).cancel,
      btnCancelOnPress: () {},
      btnOkText: L10n.inst(ref.context).ok,
      btnOkOnPress: pressOk != null ? () => pressOk() : null,
    );

    sureDialog.show();
  }


  static void connectionNotCompleted(WidgetRef ref,{Function? pressOk,String? desc2}){
    final connectionNotCompletedDialog = AwesomeDialog(
      context: ref.context,
      dialogType: DialogType.info,
      title: L10n.inst(ref.context).connection_not_completed_dialogue_title,
      desc: desc2 ?? L10n.inst(ref.context).connection_not_completed_dialogue_content,
      btnCancelText: L10n.inst(ref.context).cancel,
      btnCancelOnPress: () {},
      btnOkText: L10n.inst(ref.context).ok,
      btnOkOnPress: pressOk != null ? () => pressOk() : null,
    );

    connectionNotCompletedDialog.show();
  }

  static void screenShotShare(WidgetRef ref,Widget widget) {
    final sureDialog = AwesomeDialog(
      context: ref.context,
      dialogType: DialogType.noHeader,
      title: L10n.inst(ref.context).content_dialog_sure_title,
      body: widget,
      btnOkIcon: Icons.share,
      btnOkText: L10n.inst(ref.context).share,
      btnOkOnPress: () => ref.read(currentShareController.notifier)
          .sharePlusAction(
          ref),
    );
    sureDialog.show();
  }




  static Future<void> sureDialogWithCheckBox(WidgetRef ref, String desc,
      {Function? pressOk, required String prefKey,String? title}) async {
    dontShowDialog = true;

    final pref = await SharedPreferences.getInstance();
    var checkBoxValue = false;
    final sureDialog = AwesomeDialog(
      context: ref.context,
      dialogType: DialogType.warning,
      desc: desc,
      body: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Text(
                title ?? L10n.inst(ref.context).game_ui_dialog_title_sensor_may,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CheckboxListTile(
                title: Text(L10n.inst(ref.context)
                    .game_ui_dialog_title_dont_show_again),
                value: checkBoxValue,
                onChanged: (customValue) {
                  setState(() {
                    pref.setBool(prefKey, customValue ?? false);

                    checkBoxValue = customValue ?? false;
                  });


                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ],
          );
        },
      ),
      btnOkText: L10n.inst(ref.context).ok,
      btnOkOnPress: pressOk != null ? () => pressOk() : null,
    );

    sureDialog.show();
  }

  static void successTitleAndOk(WidgetRef ref, String title, String desc,
      {Function? pressOk}) {
    final successTitleAndOkDialog = AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.success,
        title: title,
        desc: desc,
        btnCancelText: L10n.inst(ref.context).cancel,
        btnCancelOnPress: () {},
        btnOkText: L10n.inst(ref.context).ok,
        btnOkOnPress: pressOk != null ? () => pressOk : null);

    successTitleAndOkDialog.show();
  }

  static void failed(WidgetRef ref, String title, String desc,
      {Function? pressOk,String? customTitle}) {
    final failedDialog = AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.error,
        title: title,
        desc: desc,
        btnOkText: customTitle ?? L10n.inst(ref.context).cancel,
        btnOkOnPress: () => pressOk != null ? pressOk() : null);

    failedDialog.show();
  }
}
