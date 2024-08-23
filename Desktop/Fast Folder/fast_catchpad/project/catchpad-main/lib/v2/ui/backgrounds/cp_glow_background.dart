import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/cp_colors.dart';

class CpGlowBackGround extends ConsumerWidget {
  final Widget? child;
  final bool half;
  const CpGlowBackGround({
    super.key,
    this.child,
    this.half = false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(
            children: [
              Positioned(
                top: half ? -10.h : -20.h,
                left: -50.w,
                child: Container(
                  width: 120.h,
                  height: 120.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.fromARGB(60, 222, 245, 154),
                        Color.fromARGB(1, 222, 245, 154),
                      ],
                    ),
                  ),
                ),
              ),

              child ?? const SizedBox.shrink()
            ],
          ),
        ));
  }
}
