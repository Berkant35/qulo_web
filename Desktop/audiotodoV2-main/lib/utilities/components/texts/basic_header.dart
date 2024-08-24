import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import '../../constants/extensions/context_extension.dart';

class BasicTitleWithHeader extends StatelessWidget {
  final String title;
  final String explain;

  final Color? titleTextColor;
  final Color? contentTextColor;

  const BasicTitleWithHeader(
      {required this.title,
      required this.explain,
      this.titleTextColor,
      this.contentTextColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return headerInfoCol(title, explain);
  }

  Widget headerInfoCol(String infoOne, String infoTwo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          infoOne,
          style: ThemeValueExtension.headline6.copyWith(
              color: titleTextColor ?? CustomColors.profileGreyColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          infoTwo,
          style: ThemeValueExtension.highBody.copyWith(
            color: contentTextColor ?? CustomColors.profileGreyColor,
          ),
        ),
      ],
    );
  }
}
