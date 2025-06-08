import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppCheckboxTheme {
  static CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    side: WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: AppColors.thyPrimary, width: 1.5);
      }
      return const BorderSide(color: AppColors.gray, width: 1);
    }),
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
    checkColor: WidgetStateProperty.all(AppColors.thyPrimary),
    fillColor: const WidgetStatePropertyAll(AppColors.white),
  );
}
