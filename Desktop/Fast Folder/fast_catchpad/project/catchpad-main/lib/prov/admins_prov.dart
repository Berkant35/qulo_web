import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/user_api.dart';
import '../models/permissions_model.dart';
import '../utils/settings/app_settings_toggles.dart';

final userPermissionProvider =
    StateNotifierProvider<PermissionsProvider, PermissionsModel>(
  (ref) =>
      PermissionsProvider(PermissionsModel(adminEmails: [], usernamepool: [])),
);

class PermissionsProvider extends StateNotifier<PermissionsModel> {
  PermissionsProvider(PermissionsModel state) : super(state);

  Future<void> setAdminEmails() async {
    final adminmails = await UsersApi.instance.getAdminEmails();
    final userNamePool = await UsersApi.instance.getUserNamePool();
    if (userNamePool.contains('egehancetinel')) {
      logger.d('contains egehancetinel true');
    }
    state =
        PermissionsModel(adminEmails: adminmails, usernamepool: userNamePool);
    return;
  }

  removeUserName(String username) {
    state = PermissionsModel(
        adminEmails: state.adminEmails,
        usernamepool: state.usernamepool..remove(username));
  }

  Future<void> addingFireStoreFix(WidgetRef ref) async {
    final _auth = FirebaseAuth.instance;
    final curUser = _auth.currentUser;
    await UsersApi.instance.getAdminEmails();
    if (state.adminEmails.contains(curUser?.email)) {
      final prefs = await SharedPreferences.getInstance();
      bool? enableAddingToFirestore = prefs.getBool('enableAddingToFirestore');
      if (enableAddingToFirestore == null) {
        prefs.setBool('enableAddingToFirestore', false);
        ref.read(appSettingsToggleProvider.notifier).disableFireStoreAdding();
      }
    }
  }

  bool checkIfUsernameExists(String nickname) {
    if (state.usernamepool.contains(nickname)) {
      logger.d('contains nickname true');
    }
    return state.usernamepool.contains(nickname);
  }
}
