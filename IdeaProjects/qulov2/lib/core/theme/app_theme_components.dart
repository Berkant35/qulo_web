part of 'app_theme.dart';

// AppBar
final _appBarTheme = AppBarTheme(
  backgroundColor: AppColors.surface,
  foregroundColor: AppColors.onSurface,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
    color: AppColors.onSurface,
  ),
);

// Elevated Button (primary action - purple)
final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.purple,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    ),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    elevation: 0,
  ),
);

// Outlined Button
final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: AppColors.purple,
    minimumSize: const Size(double.infinity, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    ),
    side: const BorderSide(color: AppColors.purple),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);

// Text Button
final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: AppColors.purple,
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  ),
);

// Input Decoration
final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: AppColors.surfaceVariant,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    borderSide: const BorderSide(color: AppColors.purple, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    borderSide: const BorderSide(color: AppColors.error),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.6)),
);

// Card
final _cardTheme = CardThemeData(
  color: AppColors.surface,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
    side: const BorderSide(color: AppColors.outlineVariant),
  ),
  margin: EdgeInsets.zero,
);

// Bottom Nav
const _bottomNavTheme = BottomNavigationBarThemeData(
  backgroundColor: AppColors.surface,
  selectedItemColor: AppColors.purple,
  unselectedItemColor: AppColors.onSurfaceVariant,
  type: BottomNavigationBarType.fixed,
  elevation: 8,
);

// Chip
final _chipTheme = ChipThemeData(
  backgroundColor: AppColors.surfaceVariant,
  selectedColor: AppColors.purpleSurface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
  ),
  side: BorderSide.none,
  labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
);

// Dialog
final _dialogTheme = DialogThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
  ),
  backgroundColor: AppColors.surface,
);

// SnackBar
final _snackBarTheme = SnackBarThemeData(
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
  ),
);
