import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/constant/theme/custom_outline_input_border.dart';

class AppInputDecorationTheme {
  static final inputDecorationTheme = InputDecorationTheme(
    border: const CustomOutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray100, width: 1),
    ),
    enabledBorder: const CustomOutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray100, width: 1),
    ),
    focusedBorder: const CustomOutlineInputBorder(
      borderSide: BorderSide(color: AppColors.gray300, width: 1),
    ),
    errorBorder: const CustomOutlineInputBorder(
      borderSide: BorderSide(color: AppColors.red200, width: 1),
    ),
    focusedErrorBorder: const CustomOutlineInputBorder(
      borderSide: BorderSide(color: AppColors.red200, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    errorStyle: AppTextStyles.validatorPx14w400.copyWith(
      color: AppColors.red200,
    ),
    hintStyle: AppTextStyles.px16w400,
    labelStyle: AppTextStyles.px16w400.copyWith(color: AppColors.gray500),
    floatingLabelStyle: AppTextStyles.px12w400.copyWith(
      color: AppColors.textPrimary,
    ),
    errorMaxLines: 2,
  );

  static InputDecoration otpInputDecoration({bool hasError = false}) {
    return InputDecoration(
      counterText: "",
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: hasError ? AppColors.red200 : Colors.transparent,
          width: hasError ? 1 : 0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: hasError ? AppColors.red200 : Colors.transparent,
          width: hasError ? 1 : 0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: hasError ? AppColors.red200 : Colors.transparent,
          width: hasError ? 1 : 0,
        ),
      ),
      filled: true,
      fillColor: AppColors.transparent,
    );
  }
}
