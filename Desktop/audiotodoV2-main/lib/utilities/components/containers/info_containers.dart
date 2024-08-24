import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/extensions/edge_extension.dart';

class InfoContainer extends ConsumerWidget {
  final String title;
  final String? titleSecond;
  final String subTitle;
  final String? subTitleSecond;
  final IconData? iconData;

  const InfoContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      this.iconData,
      this.titleSecond,
      this.subTitleSecond});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 45.w,
      height: 16.h,
      decoration: BoxDecoration(
        color: CustomColors.fillWhiteColor,
        boxShadow: [
          BoxShadow(
            color: CustomColors.grey2Color.withOpacity(0.5),
            spreadRadius: 0.2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        // gradient:  LinearGradient(colors: [
        //   CustomColors.greyColor,
        //   CustomColors.grey2Color,
        //   CustomColors.greyColor.withOpacity(0.7),
        // ], begin: Alignment.topCenter, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(EdgeExtension.normalEdge.edgeValue),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                localInfo(context, title, subTitle),
                if (titleSecond != null && subTitleSecond != null)
                  localInfo(context, titleSecond!, subTitleSecond!)
              ],
            ),
            if (iconData != null)
              Icon(iconData, size: 10.w, color: CustomColors.secondaryColor)
          ],
        ),
      ),
    );
  }

  Column localInfo(
      BuildContext context, String localTitle, String localSubtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(localTitle,
            style: ThemeValueExtension.titleTextStyle),
        SizedBox(height: 0.25.h),
        Text(localSubtitle,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: CustomColors.greyColor, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
