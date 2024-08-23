import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../enums/permission_type.dart';

export 'package:permission_handler/permission_handler.dart';

export '../enums/permission_type.dart';

part 'permission_model.freezed.dart';

typedef PermList = List<PermissionModel>;

@freezed
class PermissionModel with _$PermissionModel {
  const PermissionModel._();

  factory PermissionModel.fromInitialPermissions({
    required List<Permission> permissions,
    required bool isRequired,
    required PermissionType type,
  }) {
    return PermissionModel(
      permissions: Map.fromEntries(
        permissions.map(
          (e) => MapEntry(e, PermissionStatus.denied),
        ),
      ),
      type: type,
      isRequired: isRequired,
    );
  }

  const factory PermissionModel({
    required Map<Permission, PermissionStatus> permissions,
    required bool isRequired,
    required PermissionType type,
    IconData? icon,
  }) = _PermissionModel;

  bool get isGranted {
    final allGranted = permissions.values.every(
      (status) {
        return status == PermissionStatus.granted;
      },
    );

    return allGranted;
  }

  Future<PermissionModel> reevalStatus() async {
    final newPermissions = <Permission, PermissionStatus>{};

    for (var permission in permissions.keys) {
      final newStat = await permission.status;

      newPermissions[permission] = newStat;
    }

    return copyWith(permissions: newPermissions);
  }

  List<Permission> reorderPermissions(List<Permission> per) {
    final ret = List<Permission>.from(per);
    ret.sort(
      (a, b) => a.value.compareTo(b.value),
    );

    return ret;
  }

  bool get anyPermanentlyDenied {
    final anyDenied = permissions.values.any(
      (status) {
        return status == PermissionStatus.permanentlyDenied;
      },
    );

    return anyDenied;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    if (other is! PermissionModel) {
      return false;
    }

    final thisPer = reorderPermissions(permissions.keys.toList());
    final otherPer = reorderPermissions(other.permissions.keys.toList());

    return const ListEquality().equals(thisPer, otherPer);
  }

  @override
  int get hashCode => reorderPermissions(
        permissions.keys.toList(),
      )
          .map(
            (e) => e.value,
          )
          .reduce(
            (a, b) => a ^ b,
          );
}
