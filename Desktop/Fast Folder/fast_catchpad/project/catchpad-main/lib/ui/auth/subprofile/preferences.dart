import 'dart:io';

import 'package:catchpad/my_app.dart';
import 'package:catchpad/prov/app_settings_prov.dart';
import 'package:catchpad/prov/auth/auth_prov.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/dialogs/show_case_prov.dart';
import 'package:catchpad/ui/auth/profile_screen.dart';
import 'package:catchpad/ui/widgets/repair_fab_button.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../models/bottom_bar_item.dart';
import '../../../utils/route_table.dart';
import '../../../utils/settings/app_settings_toggles.dart';

class Preferences extends ConsumerWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggleprov = ref.watch(appSettingsToggleProvider);
    final togglenotify = ref.watch(appSettingsToggleProvider.notifier);
    final inst = L10n.inst(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(inst.preferences),
      ),
      body: Column(
        children: [
          SwitchListTile.adaptive(
              value: toggleprov.enableTriggerSound,
              title: Text(L10n.inst(context).switch_title_enable_trigger_sound),
              onChanged: (newvalue) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('enableTriggerSoundEffect', newvalue);
                togglenotify.enableTriggerSound(newvalue);
              }),
          if(adminIdList.contains(ref.read(currentUserProv)?.uid))
          ListTile(
            leading: Text(
              inst.pad_set_names,
            ),
            trailing: getPlatformSpecificArrowIcon(),
            onTap: () async {
              if (Platform.isIOS) {
                await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const RepairOfNames()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RepairOfNames(),
                    ));
              }
            },
          ),
          ListTile(
            leading: Text(
              inst.preferences_refresh_show_case,
            ),
            trailing: getPlatformSpecificArrowIcon(),
            onTap: () async {
              ref
                  .read(currentAllShowCases.notifier)
                  .clearAllOnboardingShowCaseFromLocale(ref);

              GoRouter.of(context).pop();

              ref.read(bottomBarProvider.notifier)
                  .setBottomBarItem(1, ref);

            },
          ),
        ],
      ),
    );
  }
}
