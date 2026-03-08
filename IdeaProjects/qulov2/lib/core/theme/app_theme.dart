import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

part 'app_theme_components.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: Colors.black,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
          onError: Colors.white,
          outline: AppColors.border,
          outlineVariant: AppColors.border,
          surfaceContainerHighest: AppColors.surfaceInput,
        ),
        textTheme: AppTextStyles.textTheme,
        scaffoldBackgroundColor: AppColors.scaffold,
        appBarTheme: _appBarTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        bottomNavigationBarTheme: _bottomNavTheme,
        navigationBarTheme: _navigationBarTheme,
        chipTheme: _chipTheme,
        dialogTheme: _dialogTheme,
        snackBarTheme: _snackBarTheme,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.surfaceInput,
          linearMinHeight: 4,
        ),
      );
}
