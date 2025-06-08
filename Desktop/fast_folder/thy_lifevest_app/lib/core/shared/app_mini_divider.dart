import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppMiniDivider extends StatelessWidget {
  const AppMiniDivider({
    super.key,
    this.topPadding,
    this.bottomPadding,
  });

  final double? topPadding;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 60,
      margin: EdgeInsets.only(top: topPadding ?? 12, bottom: bottomPadding ?? 16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
