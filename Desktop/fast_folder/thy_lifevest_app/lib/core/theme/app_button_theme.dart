import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';

class AppButtonTheme {
  static FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(0, 30)),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
      backgroundColor: const WidgetStatePropertyAll(AppColors.thyPrimary),
      maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 60)),
      textStyle: WidgetStatePropertyAll(AppTextStyles.px14w600),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      iconColor: const WidgetStatePropertyAll(AppColors.white),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(0, 30)),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      side: const WidgetStatePropertyAll(
        BorderSide(color: AppColors.thyPrimary),
      ),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8)),
      maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 60)),
      textStyle: WidgetStatePropertyAll(AppTextStyles.px14w600),
      foregroundColor: const WidgetStatePropertyAll(AppColors.thyPrimary),
      iconColor: const WidgetStatePropertyAll(AppColors.thyPrimary),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(0, 30)),
      maximumSize: const WidgetStatePropertyAll(Size(double.infinity, 60)),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      textStyle: WidgetStatePropertyAll(AppTextStyles.px14w600),
      foregroundColor: const WidgetStatePropertyAll(AppColors.thyPrimary),
      iconColor: const WidgetStatePropertyAll(AppColors.thyPrimary),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );

  static IconButtonThemeData iconButtonTheme = const IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.all(8)),
      iconSize: WidgetStatePropertyAll(16),
      foregroundColor: WidgetStatePropertyAll(AppColors.thyPrimary),
    ),
  );
}
