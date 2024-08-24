import 'package:audiotodo/utilities/components/dialogs/permission_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

typedef CustomPermissionHandler = Map<Permission, bool>;

class PermissionHandlerNotifier extends StateNotifier<CustomPermissionHandler> {
  PermissionHandlerNotifier(CustomPermissionHandler state) : super({});

  void setPermissionStatus(Permission permission, bool permissionStatus) {
    state.update(permission, (value) => permissionStatus);
  }

  Future<bool> giveGrantedToAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.speech,
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.microphone,
    ].request();
    return statuses.values.any((element) => !element.isGranted);
  }

  Future<bool> giveGrantedToAllPermissionsGalleryAndCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    return statuses.values.any((element) => !element.isGranted);
  }

  Future<bool> checkPerPermissionAndGetPermissionFromUser(
      {required Permission permission,
      VoidCallbackAction? function,
      required WidgetRef ref}) async {
    final permissionStatus = await permission.status;

    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.limited:
        final result = await permission.request();
        setPermissionStatus(permission, result.isGranted);
        return returnRes(result);
      case PermissionStatus.granted:
        setPermissionStatus(permission, true);
        return true;
      case PermissionStatus.restricted:
        await PermissionDialogs.mustGoToSettings(ref);
        final result = await permission.isGranted;
        setPermissionStatus(permission, result);
        return result;
      case PermissionStatus.permanentlyDenied:
        setPermissionStatus(permission, false);
        openAppSettings();
        return false;
      case PermissionStatus.provisional:
        setPermissionStatus(permission, true);
        return true;
    }
  }

  bool returnRes(PermissionStatus result) => result.isGranted;
}
