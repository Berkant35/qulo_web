import 'package:flutter/material.dart';

/// Uygulama tipografi sistemi
/// Inter font family kullanarak kapsamlı text style yönetimi
class AppTypography {
  AppTypography._();

  /// Font family - Inter (sistem font'u olarak)
  static const String fontFamily = 'Inter';

  // ==================== HEADING STYLES ====================

  /// H1 - Ana başlık
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.02,
  );

  /// H2 - İkincil başlık
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.02,
  );

  /// H3 - Üçüncül başlık
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.01,
  );

  /// H4 - Dördüncül başlık
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: -0.01,
  );

  /// H5 - Beşinci başlık
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0,
  );

  /// H6 - Altıncı başlık
  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0,
  );

  // ==================== BODY STYLES ====================

  /// Body Large - Ana içerik metni (büyük)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  /// Body Medium - Ana içerik metni (orta)
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  /// Body Small - Ana içerik metni (küçük)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.01,
  );

  // ==================== LABEL STYLES ====================

  /// Label Large - Form etiketleri ve buton metinleri
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.01,
  );

  /// Label Medium - Küçük etiketler
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.02,
  );

  /// Label Small - Çok küçük etiketler
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.02,
  );

  // ==================== CAPTION STYLES ====================

  /// Caption Large - Açıklama metinleri
  static const TextStyle captionLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.02,
  );

  /// Caption Medium - Küçük açıklama metinleri
  static const TextStyle captionMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.02,
  );

  /// Caption Small - En küçük açıklama metinleri
  static const TextStyle captionSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.03,
  );

  // ==================== BUTTON STYLES ====================

  /// Button Large - Büyük buton metinleri
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.01,
  );

  /// Button Medium - Orta buton metinleri
  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.01,
  );

  /// Button Small - Küçük buton metinleri
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0.02,
  );

  // ==================== DISPLAY STYLES ====================

  /// Display Large - Hero metinler
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.03,
  );

  /// Display Medium - Büyük display metinler
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.025,
  );

  /// Display Small - Küçük display metinler
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.02,
  );

  // ==================== OVERLINE STYLES ====================

  /// Overline - Üst etiket
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.1,
  );

  // ==================== UTILITY METHODS ====================

  /// Text style'a renk uygula
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Text style'a font weight uygula
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Text style'a font size uygula
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Text style'a opacity uygula
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }

  /// Text style'a decoration uygula
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) {
    return style.copyWith(decoration: decoration);
  }

  /// Responsive font size hesapla
  static double getResponsiveFontSize(double baseSize, double screenWidth) {
    // Breakpoint'lere göre font size ayarla
    if (screenWidth < 600) {
      return baseSize * 0.85; // Mobile
    } else if (screenWidth < 1024) {
      return baseSize * 0.95; // Tablet
    } else {
      return baseSize; // Desktop
    }
  }

  /// Theme'e göre text color al
  static Color getTextColor(bool isDark) {
    return isDark ? Colors.white : Colors.black87;
  }

  /// Secondary text color al
  static Color getSecondaryTextColor(bool isDark) {
    return isDark ? Colors.white70 : Colors.black54;
  }

  /// Disabled text color al
  static Color getDisabledTextColor(bool isDark) {
    return isDark ? Colors.white38 : Colors.black38;
  }
}
