import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HeadStepperWidget extends ConsumerWidget {
  final int headNumber;

  const HeadStepperWidget(this.headNumber, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 4.w,
          height: 4.w,
          decoration: const ShapeDecoration(
            shape: OvalBorder(
              side: BorderSide(width: 3.14, color: CpColors.cpPrimary),
            ),
          ),
        ),
        Text(
          headNumber.toString(),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(
              fontWeight: FontWeight.w900,
              color: CpColors.cpPrimary),
        )
      ],
    );
  }
}
