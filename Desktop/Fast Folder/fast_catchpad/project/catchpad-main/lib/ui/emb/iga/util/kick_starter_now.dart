

import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/emb/iga/iga_enums.dart';

class KickStarterNow extends ConsumerWidget {
  const KickStarterNow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentIgaPageManager);
    return Row(
      mainAxisAlignment: shouldBeShowByPage(currentPage) ? MainAxisAlignment.start:MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 2.5.w,
        ),
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  IgaAssets.qr_kickstarter.getPath,
                  scale: 28,
                ),
                Container(
                  width: 7.5.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: CpColors.cpLightWhiteIGA
                        .withOpacity(0.3),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 0.5.w,
            ),
            SizedBox(
              height: 15.h,
              width: 15.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.25.h,
                  ),
                  // Text(
                  //   "NOW ON",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displayMedium!
                  //       .copyWith(
                  //       height: 0.08.h, fontSize: 16.5.sp),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.15.w),
                    child: Image.asset(
                      IgaAssets.iga_kickstarter.getPath,
                      scale: 5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        if (!shouldBeShowByPage(currentPage))
          SizedBox(
            width: 62.w,
          ),
        if (!shouldBeShowByPage(currentPage))
          CpLogoV2(
            size: 7.w,
          ),
      ],
    );
  }

  bool shouldBeShowByPage(IGAStates currentPage) {
    return (currentPage == IGAStates.onBoardingOne ||
        currentPage == IGAStates.onBoardingTwo ||
        currentPage == IGAStates.onBoardingThree || currentPage == IGAStates.lastRegister);
  }
}