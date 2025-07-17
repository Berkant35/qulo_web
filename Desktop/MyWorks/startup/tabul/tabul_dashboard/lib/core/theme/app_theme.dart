import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

/// Ana uygulama tema konfigürasyonu
/// Light ve Dark mode desteği ile kapsamlı tema yönetimi
class AppTheme {
  AppTheme._();

  // ==================== LIGHT THEME ====================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.accent,
        onTertiary: AppColors.white,
        tertiaryContainer: AppColors.accentLight,
        onTertiaryContainer: AppColors.accentDark,
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.errorBg,
        onErrorContainer: AppColors.errorDark,
        background: AppColors.backgroundLight,
        onBackground: AppColors.textPrimaryLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        outline: AppColors.borderLight,
        outlineVariant: AppColors.dividerLight,
        shadow: AppColors.shadowLight,
        scrim: AppColors.black,
        inverseSurface: AppColors.gray800,
        onInverseSurface: AppColors.white,
        inversePrimary: AppColors.primaryLight,
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge
            .copyWith(color: AppColors.textPrimaryLight),
        displayMedium: AppTypography.displayMedium
            .copyWith(color: AppColors.textPrimaryLight),
        displaySmall: AppTypography.displaySmall
            .copyWith(color: AppColors.textPrimaryLight),
        headlineLarge:
            AppTypography.h1.copyWith(color: AppColors.textPrimaryLight),
        headlineMedium:
            AppTypography.h2.copyWith(color: AppColors.textPrimaryLight),
        headlineSmall:
            AppTypography.h3.copyWith(color: AppColors.textPrimaryLight),
        titleLarge:
            AppTypography.h4.copyWith(color: AppColors.textPrimaryLight),
        titleMedium:
            AppTypography.h5.copyWith(color: AppColors.textPrimaryLight),
        titleSmall:
            AppTypography.h6.copyWith(color: AppColors.textPrimaryLight),
        bodyLarge:
            AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryLight),
        bodyMedium: AppTypography.bodyMedium
            .copyWith(color: AppColors.textPrimaryLight),
        bodySmall: AppTypography.bodySmall
            .copyWith(color: AppColors.textSecondaryLight),
        labelLarge: AppTypography.labelLarge
            .copyWith(color: AppColors.textPrimaryLight),
        labelMedium: AppTypography.labelMedium
            .copyWith(color: AppColors.textSecondaryLight),
        labelSmall: AppTypography.labelSmall
            .copyWith(color: AppColors.textTertiaryLight),
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        shadowColor: AppColors.shadowLight,
        surfaceTintColor: Colors.transparent,
        titleTextStyle:
            AppTypography.h5.copyWith(color: AppColors.textPrimaryLight),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.radiusLG,
          side: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: AppSpacing.buttonPaddingMedium,
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMD),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(120, 44),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          padding: AppSpacing.buttonPaddingMedium,
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMD),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(120, 44),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: AppSpacing.buttonPaddingMedium,
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMD),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(80, 44),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: AppSpacing.inputPaddingMedium,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTypography.labelMedium
            .copyWith(color: AppColors.textSecondaryLight),
        hintStyle: AppTypography.bodyMedium
            .copyWith(color: AppColors.textTertiaryLight),
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.error),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.borderLight, width: 2),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusXS),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.gray400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.gray200;
        }),
      ),

      // Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.backgroundLight,
        indicatorColor: AppColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.all(
          AppTypography.labelSmall
              .copyWith(color: AppColors.textSecondaryLight),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textTertiaryLight);
        }),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        labelStyle: AppTypography.labelMedium
            .copyWith(color: AppColors.textPrimaryLight),
        side: const BorderSide(color: AppColors.borderLight),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusSM),
        padding: AppSpacing.buttonPaddingSmall,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusXL),
        titleTextStyle:
            AppTypography.h5.copyWith(color: AppColors.textPrimaryLight),
        contentTextStyle: AppTypography.bodyMedium
            .copyWith(color: AppColors.textPrimaryLight),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.gray200,
        circularTrackColor: AppColors.gray200,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.gray200,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.1),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle:
            AppTypography.bodySmall.copyWith(color: AppColors.white),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textTertiaryLight,
        labelStyle: AppTypography.labelLarge,
        unselectedLabelStyle: AppTypography.labelLarge,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.backgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
        ),
        elevation: 0,
      ),

      // Scaffold Background Color
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // ==================== DARK THEME ====================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.black,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.black,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.accentLight,
        onTertiary: AppColors.black,
        tertiaryContainer: AppColors.accentDark,
        onTertiaryContainer: AppColors.accentLight,
        error: AppColors.errorLight,
        onError: AppColors.black,
        errorContainer: AppColors.errorDark,
        onErrorContainer: AppColors.errorLight,
        background: AppColors.backgroundDark,
        onBackground: AppColors.textPrimaryDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        outline: AppColors.borderDark,
        outlineVariant: AppColors.dividerDark,
        shadow: AppColors.shadowDark,
        scrim: AppColors.black,
        inverseSurface: AppColors.gray100,
        onInverseSurface: AppColors.black,
        inversePrimary: AppColors.primaryDark,
      ),

      // Typography
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge
            .copyWith(color: AppColors.textPrimaryDark),
        displayMedium: AppTypography.displayMedium
            .copyWith(color: AppColors.textPrimaryDark),
        displaySmall: AppTypography.displaySmall
            .copyWith(color: AppColors.textPrimaryDark),
        headlineLarge:
            AppTypography.h1.copyWith(color: AppColors.textPrimaryDark),
        headlineMedium:
            AppTypography.h2.copyWith(color: AppColors.textPrimaryDark),
        headlineSmall:
            AppTypography.h3.copyWith(color: AppColors.textPrimaryDark),
        titleLarge: AppTypography.h4.copyWith(color: AppColors.textPrimaryDark),
        titleMedium:
            AppTypography.h5.copyWith(color: AppColors.textPrimaryDark),
        titleSmall: AppTypography.h6.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge:
            AppTypography.bodyLarge.copyWith(color: AppColors.textPrimaryDark),
        bodyMedium:
            AppTypography.bodyMedium.copyWith(color: AppColors.textPrimaryDark),
        bodySmall: AppTypography.bodySmall
            .copyWith(color: AppColors.textSecondaryDark),
        labelLarge:
            AppTypography.labelLarge.copyWith(color: AppColors.textPrimaryDark),
        labelMedium: AppTypography.labelMedium
            .copyWith(color: AppColors.textSecondaryDark),
        labelSmall: AppTypography.labelSmall
            .copyWith(color: AppColors.textTertiaryDark),
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        shadowColor: AppColors.shadowDark,
        surfaceTintColor: Colors.transparent,
        titleTextStyle:
            AppTypography.h5.copyWith(color: AppColors.textPrimaryDark),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.radiusLG,
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.black,
          elevation: 0,
          padding: AppSpacing.buttonPaddingMedium,
          shape: RoundedRectangleBorder(borderRadius: AppSpacing.radiusMD),
          textStyle: AppTypography.buttonMedium,
          minimumSize: const Size(120, 44),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        contentPadding: AppSpacing.inputPaddingMedium,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.radiusMD,
          borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
        ),
        labelStyle: AppTypography.labelMedium
            .copyWith(color: AppColors.textSecondaryDark),
        hintStyle: AppTypography.bodyMedium
            .copyWith(color: AppColors.textTertiaryDark),
        errorStyle:
            AppTypography.bodySmall.copyWith(color: AppColors.errorLight),
      ),

      // Scaffold Background Color
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // Visual Density
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // ==================== UTILITY METHODS ====================

  /// Theme'i context'e göre al
  static ThemeData getTheme(bool isDark) {
    return isDark ? darkTheme : lightTheme;
  }

  /// Theme extension'ları
  static ThemeData withExtensions(ThemeData theme) {
    return theme.copyWith(
      extensions: [
        // Custom theme extension'ları buraya eklenebilir
      ],
    );
  }
}
