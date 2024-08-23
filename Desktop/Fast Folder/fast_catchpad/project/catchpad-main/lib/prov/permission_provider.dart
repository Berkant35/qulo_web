import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/permission/permission_manager.dart';

export '../models/permission/permission_manager.dart';

final permissionsProvider = StateNotifierProvider<PermissionProvider, PermList>(
  (_) => PermissionProvider(PermissionManager.initPermissions),
);

class PermissionProvider extends StateNotifier<PermList> {
  PermissionProvider(PermList state) : super(state);

  void update(PermissionModel model) {
    final newLs = <PermissionModel>[];

    for (var item in state) {
      if (item == model) {
        newLs.add(model);
      } else {
        newLs.add(item);
      }
    }

    state = newLs;
  }

  set updateList(PermList value) {
    state = value;
  }
}
