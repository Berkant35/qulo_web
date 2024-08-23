import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextLogoWidget extends ConsumerWidget {
  const TextLogoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.asset(
      "assets/app_icon/text_logo_v2.png",
      width: 30.w,
      height: 8.h,
    );
  }
}

class TextLogoWidgetV2 extends ConsumerWidget {
  final double? size;
  const TextLogoWidgetV2({this.size, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.asset(
      "assets/app_icon/text_logo_v2.png",
      width: size,
    );
  }
}
