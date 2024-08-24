import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';

class PermissionDialogs {
  static mustGoToSettings(WidgetRef ref) => AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.warning,
        animType: AnimType.bottomSlide,
        title: S.current.permission_denied,
        desc: S.current.permission_denied_explain,
        btnOkOnPress: () {
          openAppSettings();
        },
        btnCancelOnPress: () => logger.e("Denied Permission!"),
      ).show();
}
