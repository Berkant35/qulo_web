import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IgaBasicBackIcon extends ConsumerWidget {
  final Function() onPressed;

  const IgaBasicBackIcon({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 10.h,
        ));
  }
}
