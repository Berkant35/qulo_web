import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/list_item/basic_navigate_list_item.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(contentTitle: S.current.settings),
      body: Column(
        children: [
          BasicNavigateListItem(
              path: NavigationConstants.authForgotPasswordPage,
              title: S.current.forgot_password,
              subtitle: ""),
          GapSizedBox.smallGap,
          BasicNavigateListItem(
              path: NavigationConstants.deleteAccountPage,
              title: S.current.settings_close_account,
              subtitle: S.current.settings_close_account_subtitle),
        ],
      ),
    );
  }
}
