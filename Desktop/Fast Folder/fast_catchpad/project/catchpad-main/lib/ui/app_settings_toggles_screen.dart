import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/ui/bar_setup_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/consts.dart';
import '../utils/cp_colors.dart';
import '../utils/settings/app_settings_toggles.dart';

class AppSettingTogglesScreen extends ConsumerStatefulWidget {
  const AppSettingTogglesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppSettingTogglesScreenState();
}

class _AppSettingTogglesScreenState
    extends ConsumerState<AppSettingTogglesScreen> {


  @override
  Widget build(BuildContext context) {
    final toggleprov = ref.watch(appSettingsToggleProvider);
    final togglenotify = ref.watch(appSettingsToggleProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: CpColors.defBgColor,
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(defPaddingSize),
          children: [
            SwitchListTile.adaptive(
                value: toggleprov.enableAddingUser,
                title: const Text('Enable Adding User'),
                onChanged: (newvalue) async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('enableAddingUser', newvalue);
                  togglenotify.setAddingUser(newvalue);
                }),
            SwitchListTile.adaptive(
                value:  toggleprov.enableDeviceAdminOptions,
                title: const Text('Enable Device Admin Options'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('enableDeviceAdminOptions', newvalue);
                  togglenotify.setDeviceAdminOptions(newvalue);
                }),
            SwitchListTile.adaptive(
                value: toggleprov.enableAddingToFirestore,
                title: const Text('Enable Adding FireStore Options'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('enableAddingToFirestore', newvalue);
                  togglenotify.setFireStoreAdding(newvalue);
                }),
            SwitchListTile.adaptive(
                value: toggleprov.enableEnvironmentSelection,
                title: const Text('Enable Environment Selection'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('enableEnvironmentSelection', newvalue);
                  togglenotify.setEnvironmentSelection(newvalue);
                }),
            SwitchListTile.adaptive(
                value: toggleprov.isDebuggingByDeveloper,
                title: const Text('Enable Developer Debugging'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isDebuggingByDeveloper', newvalue);
                  togglenotify.setDevDebug(newvalue);
                }),

            SwitchListTile.adaptive(
                value: toggleprov.enableLeaderboardViewer,
                title: const Text('Enable Leaderboard Viewer'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setBool('enableLeaderboardViewer', newvalue);
                  togglenotify.setLeaderboardViewer(newvalue);
                }),
            SwitchListTile.adaptive(
                value: toggleprov.enableToForce,
                title: const Text('Enable Force Sleep'),
                onChanged: (newvalue) async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();

                  prefs.setBool('enableForceToSleep', newvalue);
                  togglenotify.setEnableForceToSleep(newvalue);
                }),
            ListTile(
              title: const AutoSizeText('Bar düzenleme ekranı'),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () {
                if (Platform.isIOS) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const BarSetupWidget()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BarSetupWidget()));
                }
              },
            ),
            /*Row(
              children: [
                Flexible(
                    child: TextButton.icon(
                        onPressed: () async {
                          EasyLoading.show();
                          await UsersApi.instance.deleteWhereIndexValueIsNull();
                          EasyLoading.dismiss();
                        },
                        icon: const Icon(Icons.delete),
                        label: const AutoSizeText(
                            'delete where index\nvalue == null')))
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
