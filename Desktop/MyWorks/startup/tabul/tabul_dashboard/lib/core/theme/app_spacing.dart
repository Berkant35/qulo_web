import 'package:flutter/material.dart';

/// Uygulama spacing sistemi
/// 8px grid sistemi kullanarak tutarlı boşluk yönetimi
class AppSpacing {
  AppSpacing._();

  // ==================== BASE SPACING ====================

  /// Base unit - 8px
  static const double baseUnit = 8.0;

  // ==================== SPACING VALUES ====================

  /// 2px
  static const double xs = baseUnit * 0.25;

  /// 4px
  static const double sm = baseUnit * 0.5;

  /// 8px
  static const double md = baseUnit * 1;

  /// 12px
  static const double lg = baseUnit * 1.5;

  /// 16px
  static const double xl = baseUnit * 2;

  /// 20px
  static const double xxl = baseUnit * 2.5;

  /// 24px
  static const double xxxl = baseUnit * 3;

  /// 32px
  static const double huge = baseUnit * 4;

  /// 40px
  static const double massive = baseUnit * 5;

  /// 48px
  static const double giant = baseUnit * 6;

  /// 64px
  static const double colossal = baseUnit * 8;

  // ==================== COMPONENT SPECIFIC SPACING ====================

  /// Container padding'ler
  static const EdgeInsets containerPaddingSmall = EdgeInsets.all(sm);
  static const EdgeInsets containerPaddingMedium = EdgeInsets.all(md);
  static const EdgeInsets containerPaddingLarge = EdgeInsets.all(xl);
  static const EdgeInsets containerPaddingXLarge = EdgeInsets.all(xxxl);

  /// Card padding'ler
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingMedium = EdgeInsets.all(xl);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(xxxl);

  /// Button padding'ler
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  static const EdgeInsets buttonPaddingMedium = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: lg,
  );
  static const EdgeInsets buttonPaddingLarge = EdgeInsets.symmetric(
    horizontal: xxxl,
    vertical: xl,
  );

  /// Input field padding'ler
  static const EdgeInsets inputPaddingSmall = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: sm,
  );
  static const EdgeInsets inputPaddingMedium = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: lg,
  );
  static const EdgeInsets inputPaddingLarge = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: xl,
  );

  /// Page padding'ler
  static const EdgeInsets pagePaddingMobile = EdgeInsets.all(xl);
  static const EdgeInsets pagePaddingTablet = EdgeInsets.all(xxxl);
  static const EdgeInsets pagePaddingDesktop = EdgeInsets.all(huge);

  /// Section margin'ler
  static const EdgeInsets sectionMarginSmall = EdgeInsets.only(bottom: xl);
  static const EdgeInsets sectionMarginMedium = EdgeInsets.only(bottom: xxxl);
  static const EdgeInsets sectionMarginLarge = EdgeInsets.only(bottom: huge);

  // ==================== LAYOUT SPACING ====================

  /// Header yüksekliği
  static const double headerHeight = 64.0;

  /// Sidebar genişliği
  static const double sidebarWidth = 280.0;
  static const double sidebarWidthCollapsed = 72.0;

  /// Content max width
  static const double contentMaxWidth = 1200.0;

  /// Modal spacing
  static const EdgeInsets modalPadding = EdgeInsets.all(xxxl);
  static const double modalBorderRadius = xl;

  /// Drawer padding
  static const EdgeInsets drawerPadding = EdgeInsets.all(xl);

  // ==================== GRID SPACING ====================

  /// Grid gap'ler
  static const double gridGapSmall = md;
  static const double gridGapMedium = xl;
  static const double gridGapLarge = xxxl;

  /// List item spacing
  static const double listItemSpacing = md;
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: lg,
  );

  // ==================== UTILITY METHODS ====================

  /// Responsive padding al
  static EdgeInsets getResponsivePadding(double screenWidth) {
    if (screenWidth < 600) {
      return pagePaddingMobile;
    } else if (screenWidth < 1024) {
      return pagePaddingTablet;
    } else {
      return pagePaddingDesktop;
    }
  }

  /// Responsive margin al
  static EdgeInsets getResponsiveMargin(double screenWidth) {
    if (screenWidth < 600) {
      return const EdgeInsets.symmetric(horizontal: xl, vertical: lg);
    } else if (screenWidth < 1024) {
      return const EdgeInsets.symmetric(horizontal: xxxl, vertical: xl);
    } else {
      return const EdgeInsets.symmetric(horizontal: huge, vertical: xxxl);
    }
  }

  /// Vertical spacing widget
  static Widget verticalSpace(double height) => SizedBox(height: height);

  /// Horizontal spacing widget
  static Widget horizontalSpace(double width) => SizedBox(width: width);

  /// Gap widget'lar
  static Widget get gapXS => SizedBox(height: xs, width: xs);
  static Widget get gapSM => SizedBox(height: sm, width: sm);
  static Widget get gapMD => SizedBox(height: md, width: md);
  static Widget get gapLG => SizedBox(height: lg, width: lg);
  static Widget get gapXL => SizedBox(height: xl, width: xl);
  static Widget get gapXXL => SizedBox(height: xxl, width: xxl);
  static Widget get gapXXXL => SizedBox(height: xxxl, width: xxxl);

  /// Vertical gap'ler
  static Widget get vGapXS => SizedBox(height: xs);
  static Widget get vGapSM => SizedBox(height: sm);
  static Widget get vGapMD => SizedBox(height: md);
  static Widget get vGapLG => SizedBox(height: lg);
  static Widget get vGapXL => SizedBox(height: xl);
  static Widget get vGapXXL => SizedBox(height: xxl);
  static Widget get vGapXXXL => SizedBox(height: xxxl);

  /// Horizontal gap'ler
  static Widget get hGapXS => SizedBox(width: xs);
  static Widget get hGapSM => SizedBox(width: sm);
  static Widget get hGapMD => SizedBox(width: md);
  static Widget get hGapLG => SizedBox(width: lg);
  static Widget get hGapXL => SizedBox(width: xl);
  static Widget get hGapXXL => SizedBox(width: xxl);
  static Widget get hGapXXXL => SizedBox(width: xxxl);

  /// Border radius değerleri
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));

  /// Circular border radius
  static BorderRadius circular(double radius) => BorderRadius.circular(radius);

  /// Top border radius
  static BorderRadius topRadius(double radius) => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      );

  /// Bottom border radius
  static BorderRadius bottomRadius(double radius) => BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );

  /// Custom spacing hesapla
  static double spacing(double multiplier) => baseUnit * multiplier;

  /// Safe area padding'i dahil et
  static EdgeInsets withSafeArea(EdgeInsets padding, BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return EdgeInsets.only(
      left: padding.left + mediaQuery.padding.left,
      top: padding.top + mediaQuery.padding.top,
      right: padding.right + mediaQuery.padding.right,
      bottom: padding.bottom + mediaQuery.padding.bottom,
    );
  }
}
