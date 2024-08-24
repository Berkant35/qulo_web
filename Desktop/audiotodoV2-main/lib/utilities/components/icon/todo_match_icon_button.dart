import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';

class TodoMatchIconButton extends ConsumerWidget {
  final IconData iconData;
  final SvgPicture? svgPicture;
  final VoidCallback onPressed;
  final String? imagePath;
  final String? text;
  final Color? iconColor;

  const TodoMatchIconButton(this.iconData, this.onPressed,
      {super.key, this.svgPicture, this.iconColor, this.imagePath, this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(

      child: imagePath != null
          ? NeumorphicButton(
        onPressed: onPressed,
           //color
            style: const NeumorphicStyle(
              color: CustomColors.primaryColor,
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Padding(
              padding:  EdgeInsets.all(1.w),
              child: Image.asset(
                  imagePath!,
                  width: 12.w,
                  height: 12.w,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
            ),
          )
          : svgPicture ??
              Icon(
                iconData,
                size: 5.h,
                color: iconColor ?? CustomColors.fillBlackElevationColor,
              ),
    );
  }
}

Widget getPlatformSpecificArrowIcon() {
  return Platform.isIOS
      ? const Icon(Icons.arrow_forward_ios)
      : const Icon(Icons.arrow_forward);
}
