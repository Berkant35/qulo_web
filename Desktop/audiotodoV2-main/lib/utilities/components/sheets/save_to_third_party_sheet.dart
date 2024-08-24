import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/buttons/neu_stadium_button.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

class SaveToThirdPartySheet extends ConsumerStatefulWidget {
  const SaveToThirdPartySheet({
    super.key,
  });

  @override
  ConsumerState createState() => _SaveToThirdPartySheetState();
}

class _SaveToThirdPartySheetState extends ConsumerState<SaveToThirdPartySheet> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: EdgeExtension.mediumEdge.edgeValue,
          right: EdgeExtension.normalEdge.edgeValue,
          left: EdgeExtension.normalEdge.edgeValue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.integration_process,
              style: ThemeValueExtension.headline6,
            ),
            Text(
              S.current.integration_process_explain,
              style: ThemeValueExtension.subtitle,
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  imageWithText(
                      AssetPaths.icClickUp,
                      ThirdTodoAppConstants.clickUpName,
                      ref
                          .read(authManager)!
                          .todoPlatformTokens != null && ref
                              .read(authManager)!
                              .todoPlatformTokens!
                              .keys
                              .contains(ThirdTodoAppConstants.clickUpMapKey)
                          ? () => NavigationService.instance.navigateToPage(
                              path: NavigationConstants.clickUpSelectTeamPage)
                          : null,
                      ThirdTodoAppConstants.clickUpMapKey),
                  imageWithText(
                      AssetPaths.icJiraSoftware,
                      ThirdTodoAppConstants.jiraSoftwareName,
                      ref
                          .read(authManager)!
                          .todoPlatformTokens != null && ref
                              .read(authManager)!
                              .todoPlatformTokens!
                              .keys
                              .contains(TodoPlatforms.jiraSoftware.name)
                          ? () => NavigationService.instance.navigateToPage(
                              path:
                                  NavigationConstants.jiraSoftwareProjectsPage)
                          : null,
                      ThirdTodoAppConstants.jiraSoftwareName),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  NeuStadiumTextButton neuStadiumTextButton(VoidCallback? onTap) {
    return NeuStadiumTextButton(
      onPressed: onTap,
      text: S.current.contiune,
    );
  }

  Widget imageWithText(
      String path, String text, VoidCallback? onTap, String todoAppKeyName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(path,
                  width: IconSizeExtension.medium.sizeValue,
                  height: IconSizeExtension.medium.sizeValue,
                  fit: BoxFit.contain),
              GapSizedBox.smallGapW,
              headerTitle(text,
                  todoAppKey: todoAppKeyName, containsState: onTap != null),
            ],
          ),
          neuStadiumTextButton(onTap)
        ],
      ),
    );
  }

  Widget headerTitle(String text,
      {String? todoAppKey, bool containsState = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: ThemeValueExtension.headline6),
        if (todoAppKey != null)
          Text(
            containsState
                ? S.current.integration_connected
                : S.current.integration_not_connected,
            style: ThemeValueExtension.subtitle.copyWith(
                color: containsState
                    ? CustomColors.primaryColor
                    : CustomColors.grey2Color),
          ),
      ],
    );
  }
}
