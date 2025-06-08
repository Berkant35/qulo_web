import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppRadioTheme {
  static RadioThemeData get radioTheme => RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.thyPrimary;
      }
      return AppColors.gray200;
    }),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
