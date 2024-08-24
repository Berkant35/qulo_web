import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../line/viewmodel/global_providers.dart';
import '../../../utilities/components/list_item/navigate_action_list_item.dart';

class IntegrationMenu extends ConsumerStatefulWidget {
  const IntegrationMenu({
    super.key,
  });

  @override
  ConsumerState createState() => _IntegrationMenuState();
}

class _IntegrationMenuState extends ConsumerState<IntegrationMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicBackAppBar(
          contentTitle: S.current.drawer_integrations,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NavigateActionListItem(
              contentMessage: S.current.integration_click_up,
              imagePath: AssetPaths.icClickUp,
              onTap: () {
                ref
                    .read(currentIntegrationHelpState.notifier)
                    .changState(TodoPlatforms.clickUp, ref);
                NavigationService.instance.navigateToPage(
                    path: NavigationConstants.clickUpIntegrationPage);
              },
              todoPlatform: TodoPlatforms.clickUp,
            ),
            /*NavigateActionListItem(
              contentMessage: S.current.integration_menu_jira,
              imagePath: AssetPaths.icJira,
              onTap: () {},
              todoPlatform: TodoPlatforms.jira,
            ),*/
            NavigateActionListItem(
              contentMessage: S.current.integration_menu_jira_software,
              imagePath: AssetPaths.icJiraSoftware,
              onTap: () {
                ref
                    .read(currentIntegrationHelpState.notifier)
                    .changState(TodoPlatforms.jiraSoftware, ref);
                NavigationService.instance.navigateToPage(
                    path: NavigationConstants.jiraSoftwareIntegrationPage);
              },
              todoPlatform: TodoPlatforms.jiraSoftware,
            )
          ],
        ));
  }
}
