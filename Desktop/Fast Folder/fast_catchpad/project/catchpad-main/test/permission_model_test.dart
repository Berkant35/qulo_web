import 'package:catchpad/models/permission/permission_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'PermissionModel:',
    () {
      final locationAndBluetooth = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.location,
          Permission.bluetooth,
        ],
        type: PermissionType.location,
      );

      final locationAndBluetooth2 = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.location,
          Permission.bluetooth,
        ],
        type: PermissionType.location,
      );

      final locationAndBluetooth3 = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.bluetooth,
          Permission.location,
        ],
        type: PermissionType.bluetooth,
      );

      final onlyBluetooth = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.bluetooth,
        ],
        type: PermissionType.bluetooth,
      );

      final locationAndCamera = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.location,
          Permission.camera,
        ],
        type: PermissionType.location,
      );

      final cameraAndCalendar = PermissionModel.fromInitialPermissions(
        isRequired: true,
        permissions: [
          Permission.calendar,
          Permission.camera,
        ],
        type: PermissionType.location,
      );

      test(
        'same permissions in the same order should be equal',
        () {
          expect(
            locationAndBluetooth,
            locationAndBluetooth2,
          );
        },
      );
      test(
        'same permissions but in different order should be equal',
        () {
          expect(
            locationAndBluetooth,
            locationAndBluetooth3,
          );
        },
      );
      test(
        'only one permission matching, with different permission count should not be equal',
        () {
          expect(
            locationAndBluetooth == onlyBluetooth,
            false,
          );
        },
      );
      test(
        'only one permission matchinng, with same permission count should not be equal',
        () {
          expect(
            locationAndBluetooth == locationAndCamera,
            false,
          );
        },
      );
      test(
        'none of the permissions matching should not be equal',
        () {
          expect(
            locationAndBluetooth == cameraAndCalendar,
            false,
          );
        },
      );
    },
  );
}
