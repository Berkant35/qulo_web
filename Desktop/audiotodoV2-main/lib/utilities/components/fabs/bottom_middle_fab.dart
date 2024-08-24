import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';

final class BottomMiddleFab extends ConsumerWidget {
  const BottomMiddleFab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const mainIndex = 1;

    return SizedBox(
      width: 19.w,
      height: 19.w,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: "bottomCenterFloatingAction",
          elevation: 0,

          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 2.45, color: CustomColors.primaryColor),
              borderRadius: BorderRadius.circular(100)),
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          hoverElevation: 0,
          disabledElevation: 0,

          highlightElevation: 0,
          // Gölgelendirme animasyonunu kaldırır
          focusElevation: 0,
          // Gölgelendirme animasyonunu kaldırır
          onPressed: () => ref
              .read(currentNavigationIndex.notifier)
              .changeState(mainIndex, ref),
          backgroundColor: ref.watch(currentNavigationIndex) == mainIndex
              ? CustomColors.fillWhiteColor
              : CustomColors.primaryColor,

          child:  ShowCaseLogo(
            width: 14.w,
            height: 14.w,
            iconColor: ref.watch(currentNavigationIndex) == mainIndex
                ? CustomColors.primaryColor
                : CustomColors.fillWhiteColor,
            assetPath: ref.watch(currentNavigationIndex) == mainIndex
                ? IconPaths.icLogoMinimalBigSvg
                : IconPaths.icLogoMinimalBigSvg,
          ),
          // child:  Icon(
          //   Icons.mic,
          //   size: 4.5.h,
          //   color: ref.watch(currentNavigationIndex) == mainIndex
          //       ? CustomColors.fillWhiteColor
          //       : CustomColors.primaryColor,
          // ),
        ),
      ),
    );
  }
}
