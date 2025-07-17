import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Uygulama shadow sistemi
/// Tutarlı elevation ve shadow yönetimi
class AppShadows {
  AppShadows._();

  // ==================== ELEVATION LEVELS ====================

  /// Level 0 - Shadow yok
  static const List<BoxShadow> none = [];

  /// Level 1 - Çok hafif shadow
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// Level 2 - Hafif shadow
  static const List<BoxShadow> md = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// Level 3 - Orta shadow
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  /// Level 4 - Büyük shadow
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  /// Level 5 - Çok büyük shadow
  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 10),
      blurRadius: 10,
      spreadRadius: -5,
    ),
  ];

  /// Level 6 - Inner shadow
  static const List<BoxShadow> inner = [
    BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // ==================== COMPONENT SPECIFIC SHADOWS ====================

  /// Card shadow'ları
  static const List<BoxShadow> cardDefault = md;
  static const List<BoxShadow> cardHover = lg;
  static const List<BoxShadow> cardPressed = sm;
  static const List<BoxShadow> cardElevated = xl;

  /// Button shadow'ları
  static const List<BoxShadow> buttonDefault = sm;
  static const List<BoxShadow> buttonHover = md;
  static const List<BoxShadow> buttonPressed = none;
  static const List<BoxShadow> buttonFloating = lg;

  /// Modal shadow'ları
  static const List<BoxShadow> modalDefault = xxl;
  static const List<BoxShadow> drawerShadow = xl;
  static const List<BoxShadow> popupShadow = lg;

  /// Input field shadow'ları
  static const List<BoxShadow> inputDefault = sm;
  static const List<BoxShadow> inputFocused = md;
  static const List<BoxShadow> inputError = [
    BoxShadow(
      color: Color(0x26EF4444), // Error color with opacity
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 2,
    ),
  ];

  /// Navbar shadow'ları
  static const List<BoxShadow> navbarShadow = sm;
  static const List<BoxShadow> sidebarShadow = md;

  // ==================== DARK MODE SHADOWS ====================

  /// Dark mode shadow'ları
  static const List<BoxShadow> darkSm = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> darkMd = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> darkLg = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> darkXl = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> darkXxl = [
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
    BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 10),
      blurRadius: 10,
      spreadRadius: -5,
    ),
  ];

  // ==================== UTILITY METHODS ====================

  /// Theme'e göre shadow seç
  static List<BoxShadow> getBoxShadow({
    required List<BoxShadow> lightShadow,
    required List<BoxShadow> darkShadow,
    required bool isDark,
  }) {
    return isDark ? darkShadow : lightShadow;
  }

  /// Shadow level'a göre shadow al
  static List<BoxShadow> getShadowByLevel(int level, {bool isDark = false}) {
    final shadows = isDark ? _getDarkShadows() : _getLightShadows();
    return shadows[level.clamp(0, shadows.length - 1)];
  }

  /// Light shadow'ları
  static List<List<BoxShadow>> _getLightShadows() {
    return [none, sm, md, lg, xl, xxl];
  }

  /// Dark shadow'ları
  static List<List<BoxShadow>> _getDarkShadows() {
    return [none, darkSm, darkMd, darkLg, darkXl, darkXxl];
  }

  /// Custom shadow oluştur
  static BoxShadow createShadow({
    required Color color,
    required Offset offset,
    required double blurRadius,
    double spreadRadius = 0,
  }) {
    return BoxShadow(
      color: color,
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }

  /// Shadow'u opacity ile ayarla
  static List<BoxShadow> withOpacity(List<BoxShadow> shadows, double opacity) {
    return shadows
        .map((shadow) => shadow.copyWith(
              color: shadow.color.withOpacity(shadow.color.opacity * opacity),
            ))
        .toList();
  }

  /// Glow effect
  static List<BoxShadow> createGlow({
    required Color color,
    double blurRadius = 10,
    double spreadRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(0.3),
        offset: const Offset(0, 0),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ];
  }

  /// Text shadow'ları
  static List<Shadow> textShadow = [
    const Shadow(
      color: AppColors.shadowLight,
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static List<Shadow> textShadowDark = [
    const Shadow(
      color: AppColors.shadowDark,
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// Theme'e göre text shadow al
  static List<Shadow> getTextShadow(bool isDark) {
    return isDark ? textShadowDark : textShadow;
  }
}
