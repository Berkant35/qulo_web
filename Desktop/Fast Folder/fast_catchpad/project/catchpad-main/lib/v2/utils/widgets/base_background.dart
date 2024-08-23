import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  final Widget child;
  BorderRadiusGeometry? borderRadius;
  BaseBackground({
    super.key,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.11, 1.0],
            colors: [
              CpColors.cpEerieBlack,
              Color(0xff1B1B1B),
              CpColors.cpChineseBlack,
            ],
          ),
        ),
        child: child);
  }
}
