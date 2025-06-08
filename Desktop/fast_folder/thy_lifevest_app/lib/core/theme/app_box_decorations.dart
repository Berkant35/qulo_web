import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

/// Sistemik box decoration'lar için merkezi sınıf
/// THY marka renklerine uygun modern card tasarımları
class AppBoxDecorations {
  /// Temel card decoration - Minimal gölge ve border radius ile
  /// Genel kullanım için uygundur
  static const basicCardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowGray,
        offset: Offset(0, 2),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
  );

  /// Elevated card decoration - Daha belirgin gölge efekti ile
  /// Önemli içerikler ve vurgulanması gereken kartlar için
  static const elevatedCardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: AppColors.gray500With15Alpha,
        offset: Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: AppColors.gray500With50Alpha,
        offset: Offset(0, 2),
        blurRadius: 6,
        spreadRadius: 0,
      ),
    ],
  );

  /// Primary card decoration - THY primary rengi ile border
  /// Ana işlevler ve aksiyon kartları için
  static const primaryCardDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.all(Radius.circular(16)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.thyPrimary, width: 1.5),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowGray,
        offset: Offset(0, 2),
        blurRadius: 8,
        spreadRadius: 0,
      ),
    ],
  );

  /// Surface card decoration - Soft background rengi ile
  /// Secondary içerikler ve bilgi kartları için
  static const surfaceCardDecoration = BoxDecoration(
    color: AppColors.gray50,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    border: Border.fromBorderSide(
      BorderSide(color: AppColors.gray100, width: 1),
    ),
  );

  ShapeBorder get bottomDialogRectangleBorder => const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16),
    ),
  );
}
