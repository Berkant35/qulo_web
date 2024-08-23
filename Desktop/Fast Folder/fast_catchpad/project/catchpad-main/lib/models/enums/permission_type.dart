import 'package:flutter/widgets.dart';

import '../../catch_pad_icons.dart';
import '../../utils/utils.dart';

enum PermissionType {
  location,
  bluetooth;

  Icon get icon {
    switch (this) {
      case PermissionType.location:
        return const Icon(CatchPadIcons.location);
      case PermissionType.bluetooth:
        return const Icon(CatchPadIcons.bluetooth);
    }
  }

  String permissionStr(BuildContext context) {
    final inst = L10n.inst(context);
    switch (this) {
      case location:
        return inst.request_permission_location;
      case bluetooth:
        return inst.request_permission_bluetooth;
    }
  }

  String activateStr(BuildContext context) {
    final inst = L10n.inst(context);
    switch (this) {
      case location:
        return inst.request_activate_location;
      case bluetooth:
        return inst.request_activate_bluetooth;
    }
  }
}
