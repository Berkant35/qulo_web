import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/permission_provider.dart';

export 'permission_model.dart';

abstract class PermissionManager {
  static List<Permission> androidPermissions = [
    Permission.bluetoothScan,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,

  ];
  static List<Permission> iosPermissions = [
    Permission.bluetooth,
  ];
  static final initPermissions = [
    PermissionModel.fromInitialPermissions(
      permissions: [
        Permission.location,
      ],
      type: PermissionType.location,
      isRequired: true,
    ),
    PermissionModel.fromInitialPermissions(
      permissions: [
        if (Platform.isAndroid) ...androidPermissions else ...iosPermissions
      ],
      type: PermissionType.bluetooth,
      isRequired: true,
    ),
  ];

  static PermList _permissions(WidgetRef ref) => ref.read(permissionsProvider);

  static bool allAreGranted(WidgetRef ref) {
    final per = _permissions(ref);

    return per.every((element) => element.isGranted);
  }

  static Future<bool> recheckAllAreGranted(WidgetRef ref) async {
    final per = await checkStatus(ref);

    return per.every((element) => element.isGranted);
  }

  static Future<PermList> checkStatus(WidgetRef ref) async {
    final per = _permissions(ref);
    final newLs = <PermissionModel>[];

    for (final model in per) {
      final newModel = await model.reevalStatus();

      newLs.add(newModel);
    }

    return newLs;
  }
}
