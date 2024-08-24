import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BasicNavigateListItem extends StatelessWidget {
  final String path;
  final String title;
  final String subtitle;

  const BasicNavigateListItem(
      {super.key,
      required this.path,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.fillWhiteColor,
      child: ListTile(
        onTap: () async =>
            await NavigationService.instance.navigateToPage(path: path),
        title: Text(title, style: ThemeValueExtension.listTileTitleStyle),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle,
                style: ThemeValueExtension.subtitle
                    .copyWith(color: CustomColors.grey2Color))
            : null,
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 4.h,
          color: CustomColors.primaryColor,
        ),
      ),
    );
  }
}
