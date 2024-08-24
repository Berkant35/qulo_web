import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';

class GlowLogo extends ConsumerWidget {
  final Color? customGlowColor;
  final Color? backColor;
  final double? size;
  final double? radius;
  final bool showMicIcon;
  final bool animationTrigger;
  final bool isKeyboardOpened;

  const GlowLogo({
    super.key,
    this.customGlowColor,
    this.backColor,
    this.size,
    this.radius,
    this.showMicIcon = true,
    this.isKeyboardOpened = false,
    this.animationTrigger = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AvatarGlow(
      startDelay: const Duration(milliseconds: 600),
      glowColor: customGlowColor ?? CustomColors.fillWhiteColor,
      endRadius: radius ?? 60.h,
      duration: const Duration(milliseconds: 2400),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration.zero,
      shape: BoxShape.circle,
      animate: animationTrigger,
      curve: Curves.fastEaseInToSlowEaseOut,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size ?? (isKeyboardOpened ? buildH() : buildH()),
            height: size ?? (isKeyboardOpened ? buildH() : buildH()),
            decoration: BoxDecoration(
              color: backColor ?? CustomColors.secondaryColor.withOpacity(0.75),
              borderRadius: BorderRadius.all(Radius.circular(60.h)),
              boxShadow: [
                BoxShadow(
                  color: CustomColors.primaryColor.withOpacity(0.9),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
          ),
          if (showMicIcon)
            Padding(
              padding:  EdgeInsets.only(left: 1.w),
              child: ShowCaseLogo(
                width: logoSize(),
                height: logoSize(),
                iconColor: Colors.white,
                assetPath: IconPaths.icLogoMainSvg,
              ),
            )
        ],
      ),
    );
  }

  double buildH() => 24.h;

  double logoSize() => 42.w;
}
