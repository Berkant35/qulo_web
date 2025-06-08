import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';

class AppTabBarTheme {
  static TabBarTheme tabBarTheme = TabBarTheme(
    labelColor: AppColors.textPrimary,
    unselectedLabelColor: AppColors.gray200,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: AppColors.gray50,
    indicatorColor: AppColors.thyPrimary,
    unselectedLabelStyle: AppTextStyles.px14w500,
    labelStyle: AppTextStyles.px14w500,
    labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  );
}
