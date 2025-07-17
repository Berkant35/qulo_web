import 'package:flutter/material.dart';

/// Uygulama renk paleti sistemi
/// Light ve Dark mode desteği ile kapsamlı renk yönetimi
class AppColors {
  AppColors._();

  // ==================== PRIMARY COLORS ====================

  /// Ana marka rengi - Tabul blue
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryVariant = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E40AF);

  // ==================== SECONDARY COLORS ====================

  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryVariant = Color(0xFF475569);
  static const Color secondaryLight = Color(0xFF94A3B8);
  static const Color secondaryDark = Color(0xFF334155);

  // ==================== ACCENT COLORS ====================

  static const Color accent = Color(0xFF7C3AED);
  static const Color accentLight = Color(0xFF8B5CF6);
  static const Color accentDark = Color(0xFF6D28D9);

  // ==================== SEMANTIC COLORS ====================

  /// Success - Green
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);
  static const Color successBg = Color(0xFFECFDF5);

  /// Warning - Amber
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningBg = Color(0xFFFEF3C7);

  /// Error - Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorBg = Color(0xFFFEF2F2);

  /// Info - Blue
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoBg = Color(0xFFEFF6FF);

  // ==================== NEUTRAL COLORS ====================

  /// Grays - Tailwind CSS inspired
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  /// Pure colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ==================== TEXT COLORS ====================

  /// Primary text color
  static const Color textPrimary = Color(0xFF1F2937);

  /// Secondary text color
  static const Color textSecondary = Color(0xFF6B7280);

  // ==================== BACKGROUND COLORS ====================

  /// Light mode backgrounds
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color cardLight = Color(0xFFFFFFFF);

  /// Dark mode backgrounds
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF334155);

  // ==================== TEXT COLORS ====================

  /// Light mode text
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textTertiaryLight = Color(0xFF64748B);
  static const Color textDisabledLight = Color(0xFF94A3B8);

  /// Dark mode text
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textTertiaryDark = Color(0xFF94A3B8);
  static const Color textDisabledDark = Color(0xFF64748B);

  // ==================== BORDER COLORS ====================

  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF475569);
  static const Color dividerLight = Color(0xFFF1F5F9);
  static const Color dividerDark = Color(0xFF334155);

  // ==================== SHADOW COLORS ====================

  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);

  // ==================== GRADIENT COLORS ====================

  /// Primary gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Secondary gradient
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Accent gradient
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==================== HELPER METHODS ====================

  /// Rengin opacity'sini ayarla
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Theme'e göre renk seç
  static Color getColorByTheme({
    required Color lightColor,
    required Color darkColor,
    required bool isDark,
  }) {
    return isDark ? darkColor : lightColor;
  }

  /// Background color'u theme'e göre al
  static Color getBackgroundColor(bool isDark) {
    return isDark ? backgroundDark : backgroundLight;
  }

  /// Surface color'u theme'e göre al
  static Color getSurfaceColor(bool isDark) {
    return isDark ? surfaceDark : surfaceLight;
  }

  /// Text color'u theme'e göre al
  static Color getTextPrimaryColor(bool isDark) {
    return isDark ? textPrimaryDark : textPrimaryLight;
  }

  static Color getTextSecondaryColor(bool isDark) {
    return isDark ? textSecondaryDark : textSecondaryLight;
  }

  /// Border color'u theme'e göre al
  static Color getBorderColor(bool isDark) {
    return isDark ? borderDark : borderLight;
  }
}
