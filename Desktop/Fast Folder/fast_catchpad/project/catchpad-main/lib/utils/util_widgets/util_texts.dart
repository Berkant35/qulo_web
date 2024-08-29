import 'dart:math';

import 'package:catchpad/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../cp_colors.dart';

class CustomCpInfoTexts {
  static Widget targetCounter(
      String text1, String text2, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: CpColors.cpPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 28.sp),
        ),
        Text(text2,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white))
      ],
    );
  }

  static Widget noScoreInGameWidget(
      BuildContext context, List<List<TextSpan>> listOfTextSpans) {
    return Column(
      children: [
        ...listOfTextSpans.map((e) {
          return RichText(text: TextSpan(children: e));
        }).joinWidgetList(
          (index) => const SizedBox(height: defPaddingSize),
        )
      ],
    );
  }

  static Widget seeLeaderboardToCompare(String? text, BuildContext context,
      {bool type1 = false}) {
    return Container(
      width: 54.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        border: const Border(
          bottom: BorderSide(
            color: CpColors.cpDavysGrey,
            width: 2.0,
          ),
        ),
        color: CpColors.cpChineseBlack.withOpacity(0.2),
      ),
      child: type1 && text != null
          ? Center(
            child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontSize: 11.sp),
              ),
          )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  L10n.inst(context).iga_see_leaderboard_to_compare,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white, fontSize: 11.sp),
                ),
                Gap(0.5.w),
                GradientText(
                  L10n.inst(context).iga_see_leaderboard_to_compare_2,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 11.sp),
                  gradientType: GradientType.linear,
                  colors: const [
                    CpColors.cpPrimary,
                    CpColors.cpLightGreen,
                  ],
                ),
                Gap(0.5.w),
                Text(
                  L10n.inst(context).iga_see_leaderboard_to_compare_3,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white, fontSize: 11.sp),
                ),
              ],
            ),
    );
  }

  static Widget shareQrPopUpText(BuildContext context) {
    final l10n = L10n.inst(context);

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 16.sp, color: Colors.white,fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: l10n.iga_share_performance_video,
            ),
            WidgetSpan(
              child: GradientText(
                " CatchPad",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 15.sp,fontWeight: FontWeight.bold),
                gradientType: GradientType.linear,
                colors: const [
                  CpColors.cpPrimary,
                  CpColors.cpLightGreen,
                ],
              ),
            ),
            TextSpan(
              text: l10n.iga_share_performance_video_chance,
            ),
          ],
        ),
      ),
    );
  }


}
