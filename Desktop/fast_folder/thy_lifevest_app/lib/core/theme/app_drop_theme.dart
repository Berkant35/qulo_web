import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';

class AppDropTheme {
  static DropdownMenuThemeData get dropdownMenuTheme {
    return DropdownMenuThemeData(
      textStyle: AppTextStyles.px12w600.copyWith(
        color: AppColors.white,
        overflow: TextOverflow.ellipsis,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: AppTextStyles.px12w600,
        hintStyle: AppTextStyles.px12w600,
        filled: true,
        errorStyle: AppTextStyles.px10w400.copyWith(color: Colors.red),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        iconColor: AppColors.white,
        fillColor: AppColors.textPrimary50.withValues(alpha: 0.15),
        prefixIconColor: AppColors.white,
      ),
      menuStyle: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        ),
      ),
    );
  }
}
