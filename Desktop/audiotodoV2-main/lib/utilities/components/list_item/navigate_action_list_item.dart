import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/extensions/context_extension.dart';

class NavigateActionListItem extends ConsumerWidget {
  final String contentMessage;
  final String imagePath;
  final TodoPlatforms todoPlatform;
  final VoidCallback onTap;

  const NavigateActionListItem(
      {super.key,
      required this.contentMessage,
      required this.imagePath,
      required this.onTap,
      required this.todoPlatform});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedState = ref
        .read(authManager)!
        .todoPlatformTokens != null && ref
            .read(authManager)!
            .todoPlatformTokens!
            .containsKey(todoPlatform.name) &&
        ref
            .read(authManager)!
            .todoPlatformTokens![todoPlatform.name]!
            .isNotEmpty;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 0.2.h),
      child: Container(
        color: CustomColors.fillWhiteColor,
        child: ListTile(
            //change back color
            onTap: onTap,
            title: Text(
              contentMessage,
              style: ThemeValueExtension.listTileTitleStyle.copyWith(),
            ),
            subtitle: Text(
              connectedState
                  ? S.current.integration_connected
                  : S.current.integration_not_connected,
              style: ThemeValueExtension.subtitle.copyWith(
                  color: connectedState
                      ? CustomColors.primaryColor
                      : CustomColors.greyColor),
            ),
            leading: Image.asset(
              imagePath,
              width: 10.w,
              height: 10.w,
              fit: BoxFit.contain,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 4.h,
                color: CustomColors.primaryColor,
              ),
              onPressed: onTap,
            )),
      ),
    );
  }
}

/*;*/
