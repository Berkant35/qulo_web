import 'package:catchpad/catch_pad_icons.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomShapeWidget extends ConsumerStatefulWidget {
  const CustomShapeWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomShapeWidgetState();
}

class _CustomShapeWidgetState extends ConsumerState<CustomShapeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(18)),
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          const Text('Padlerinizi renklere göre diziniz'),
          Gap(1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CatchPadIcons.cpCircle,
                color: CpColors.red,
                size: Theme.of(context).textTheme.displaySmall?.fontSize,
              ),
              stick(),
              Icon(
                CatchPadIcons.cpCircle,
                color: CpColors.cpFrenchLime,
                size: Theme.of(context).textTheme.displaySmall?.fontSize,
              ),
              stick(),
              Icon(
                CatchPadIcons.cpCircle,
                color: CpColors.blue,
                size: Theme.of(context).textTheme.displaySmall?.fontSize,
              ),
            ],
          ),
          stick(isVertical: true),
          Icon(
            CatchPadIcons.cpCircle,
            color: CpColors.cpBasicWhite,
            size: Theme.of(context).textTheme.displaySmall?.fontSize,
          ),
        ],
      ),
    );
  }

  Widget stick({bool isVertical = false}) {
    return Container(
      height: isVertical ? 5.h : 1,
      color: Colors.white,
      width: isVertical ? 1 : 10.w,
    );
  }
}
