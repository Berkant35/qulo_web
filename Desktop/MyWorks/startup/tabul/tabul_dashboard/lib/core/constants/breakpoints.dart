import 'package:flutter/material.dart';

/// Device type enumerations
enum DeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Responsive breakpoint sabitleri
/// Mobile-first approach ile tasarlanmış breakpoint sistemi
class Breakpoints {
  Breakpoints._();

  // ==================== BREAKPOINT VALUES ====================

  /// Mobile breakpoint (0-600px)
  static const double mobile = 600;

  /// Tablet breakpoint (600-1024px)
  static const double tablet = 1024;

  /// Desktop breakpoint (1024-1440px)
  static const double desktop = 1440;

  /// Large desktop breakpoint (1440px+)
  static const double largeDesktop = 1920;

  // ==================== UTILITY METHODS ====================

  /// Screen width'e göre device type'ı belirle
  static DeviceType getDeviceType(double width) {
    if (width < mobile) {
      return DeviceType.mobile;
    } else if (width < tablet) {
      return DeviceType.tablet;
    } else if (width < largeDesktop) {
      return DeviceType.desktop;
    } else {
      return DeviceType.largeDesktop;
    }
  }

  /// Context'e göre device type al
  static DeviceType getDeviceTypeFromContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return getDeviceType(screenWidth);
  }

  /// Mobile device mi kontrol et
  static bool isMobile(double width) {
    return width < mobile;
  }

  /// Tablet device mi kontrol et
  static bool isTablet(double width) {
    return width >= mobile && width < tablet;
  }

  /// Desktop device mi kontrol et
  static bool isDesktop(double width) {
    return width >= tablet && width < largeDesktop;
  }

  /// Large desktop device mi kontrol et
  static bool isLargeDesktop(double width) {
    return width >= largeDesktop;
  }

  /// Context ile mobile kontrolü
  static bool isMobileFromContext(BuildContext context) {
    return isMobile(MediaQuery.of(context).size.width);
  }

  /// Context ile tablet kontrolü
  static bool isTabletFromContext(BuildContext context) {
    return isTablet(MediaQuery.of(context).size.width);
  }

  /// Context ile desktop kontrolü
  static bool isDesktopFromContext(BuildContext context) {
    return isDesktop(MediaQuery.of(context).size.width);
  }

  /// Context ile large desktop kontrolü
  static bool isLargeDesktopFromContext(BuildContext context) {
    return isLargeDesktop(MediaQuery.of(context).size.width);
  }

  // ==================== RESPONSIVE VALUES ====================

  /// Responsive value seç
  static T responsive<T>({
    required double width,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (width < Breakpoints.mobile) {
      return mobile;
    } else if (width < Breakpoints.tablet) {
      return tablet ?? mobile;
    } else if (width < Breakpoints.largeDesktop) {
      return desktop ?? tablet ?? mobile;
    } else {
      return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }

  /// Context ile responsive value seç
  static T responsiveFromContext<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    return responsive<T>(
      width: width,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  // ==================== RESPONSIVE COLUMNS ====================

  /// Grid column sayısını screen size'a göre belirle
  static int getGridColumns(double width) {
    return responsive<int>(
      width: width,
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 4,
    );
  }

  /// Context ile grid column sayısı al
  static int getGridColumnsFromContext(BuildContext context) {
    return getGridColumns(MediaQuery.of(context).size.width);
  }

  // ==================== RESPONSIVE PADDING ====================

  /// Screen size'a göre padding değeri
  static double getResponsivePadding(double width) {
    return responsive<double>(
      width: width,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
      largeDesktop: 40.0,
    );
  }

  /// Context ile responsive padding al
  static double getResponsivePaddingFromContext(BuildContext context) {
    return getResponsivePadding(MediaQuery.of(context).size.width);
  }

  // ==================== SIDEBAR BEHAVIOR ====================

  /// Sidebar'ın default durumunu belirle
  static bool shouldShowSidebar(double width) {
    return width >= tablet;
  }

  /// Sidebar'ın collapsed durumunu belirle
  static bool shouldCollapseSidebar(double width) {
    return width < desktop;
  }

  /// Context ile sidebar durumu
  static bool shouldShowSidebarFromContext(BuildContext context) {
    return shouldShowSidebar(MediaQuery.of(context).size.width);
  }

  static bool shouldCollapseSidebarFromContext(BuildContext context) {
    return shouldCollapseSidebar(MediaQuery.of(context).size.width);
  }

  // ==================== CONTAINER CONSTRAINTS ====================

  /// Maximum container width'i belirle
  static double getMaxContainerWidth(double screenWidth) {
    return responsive<double>(
      width: screenWidth,
      mobile: screenWidth,
      tablet: screenWidth * 0.9,
      desktop: 1200.0,
      largeDesktop: 1400.0,
    );
  }

  /// Context ile max container width
  static double getMaxContainerWidthFromContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return getMaxContainerWidth(screenWidth);
  }

  // ==================== RESPONSIVE FONT SIZES ====================

  /// Screen size'a göre font size çarpanı
  static double getFontSizeMultiplier(double width) {
    return responsive<double>(
      width: width,
      mobile: 0.9,
      tablet: 1.0,
      desktop: 1.1,
      largeDesktop: 1.2,
    );
  }

  /// Context ile font size multiplier
  static double getFontSizeMultiplierFromContext(BuildContext context) {
    return getFontSizeMultiplier(MediaQuery.of(context).size.width);
  }

  // ==================== ANIMATION DURATIONS ====================

  /// Device type'a göre animation duration
  static int getAnimationDuration(double width) {
    return responsive<int>(
      width: width,
      mobile: 200,
      tablet: 250,
      desktop: 300,
      largeDesktop: 300,
    );
  }

  /// Context ile animation duration
  static int getAnimationDurationFromContext(BuildContext context) {
    return getAnimationDuration(MediaQuery.of(context).size.width);
  }

  // ==================== DEBUG HELPERS ====================

  /// Current breakpoint bilgisi
  static String getBreakpointInfo(double width) {
    final deviceType = getDeviceType(width);
    return '${deviceType.name.toUpperCase()}: ${width.toInt()}px';
  }

  /// Context ile breakpoint info
  static String getBreakpointInfoFromContext(BuildContext context) {
    return getBreakpointInfo(MediaQuery.of(context).size.width);
  }

  /// Tüm breakpoint'leri liste olarak döndür
  static Map<String, double> get allBreakpoints => {
        'mobile': mobile,
        'tablet': tablet,
        'desktop': desktop,
        'largeDesktop': largeDesktop,
      };
}
