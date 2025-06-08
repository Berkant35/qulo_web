import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppSwitchTheme {
  static SwitchThemeData switchTheme = SwitchThemeData(
    trackColor: const WidgetStateProperty.fromMap({
      WidgetState.selected: AppColors.thyPrimary,
      WidgetState.disabled: AppColors.gray100,
    }),
    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
      return const Icon(Icons.circle, size: 24, color: AppColors.white);
    }),
    thumbColor: const WidgetStatePropertyAll(AppColors.white),
    trackOutlineColor: const WidgetStatePropertyAll(AppColors.transparent),
  );
}
