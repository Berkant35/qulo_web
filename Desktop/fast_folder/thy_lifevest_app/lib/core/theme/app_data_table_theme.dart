import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';

class AppDataTableTheme {
  static final dataTableThemeData = DataTableThemeData(
    headingTextStyle: AppTextStyles.px14w600.copyWith(
      color: AppColors.textPrimary,
    ),
    headingRowAlignment: MainAxisAlignment.center,
    dataTextStyle: AppTextStyles.px12w400.copyWith(
      color: AppColors.textPrimary,
    ),
  );
}
