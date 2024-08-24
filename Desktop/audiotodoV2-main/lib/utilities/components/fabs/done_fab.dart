import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoneFab extends ConsumerWidget {
  final bool isDone;
  final VoidCallback onPressed;
  final Color? activeColor;
  final Color? deActiveColor;
  final IconData? deActiveIconData;
  final double? radius;

  const DoneFab(
      {super.key,
      required this.isDone,
      required this.onPressed,
      this.radius,
      this.activeColor,
      this.deActiveColor,
      this.deActiveIconData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: radius,
      width: radius,
      child: FittedBox(
        child: FloatingActionButton.small(
          onPressed: onPressed,
          backgroundColor: isDone
              ? activeColor ?? CustomColors.primaryColor
              : deActiveColor ?? CustomColors.fillWhiteColor,
          foregroundColor: isDone
              ? deActiveColor ?? CustomColors.fillWhiteColor
              : activeColor ?? CustomColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: isDone
                      ? deActiveColor ?? CustomColors.fillWhiteColor
                      : activeColor ?? CustomColors.primaryColor,
                  strokeAlign: 1),
              borderRadius: BorderRadius.circular(50.w)),
          child: Icon(
            isDone ? Icons.done : deActiveIconData ?? Icons.done,
            size: IconSizeExtension.medium.sizeValue,
          ),
        ),
      ),
    );
  }
}
