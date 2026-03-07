import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App theme configuration
class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBeigePaper,
      colorScheme: const ColorScheme.light(
        primary: AppColors.darkBlueFrame,
        secondary: AppColors.yellowTop,
        surface: AppColors.lightBeigePaper,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkText,
        onSurface: AppColors.darkText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.yellowTop,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.white,
        elevation: 2,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.yellowTop;
          }
          return AppColors.lightBeigePaper;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.darkBlueFrame;
          }
          return AppColors.darkText.withOpacity(0.3);
        }),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.darkText,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.darkText,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.darkText,
        ),
        bodyMedium: TextStyle(
          color: AppColors.darkText,
        ),
      ),
    );
  }
}

