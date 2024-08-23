import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CpHeadlineWithIcon extends ConsumerWidget {
  final List<InlineSpan>? texts;
  final String? iconPath;
  final String? iconPathSecond;

  const CpHeadlineWithIcon(
      {this.texts, this.iconPath, this.iconPathSecond, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconPathSecond != '')
          Image.asset(
            iconPath ?? '',
            height: 5.h,
            width: 5.h,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        RichText(
            text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 20.sp),
                children: texts)),
                
        if (iconPath != '')
          Image.asset(
            iconPath ?? '',
            height: 5.h,
            width: 5.h,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
      ],
    );
  }
}
