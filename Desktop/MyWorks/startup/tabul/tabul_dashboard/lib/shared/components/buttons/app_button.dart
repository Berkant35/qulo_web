import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Uygulama button component'i
/// Farklı variant'lar ve size'lar destekleyen button sistemi
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.fullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.iconPosition = AppButtonIconPosition.left,
  });

  /// Button text'i
  final String text;

  /// Tap callback
  final VoidCallback? onPressed;

  /// Button variant'ı
  final AppButtonVariant variant;

  /// Button size'ı
  final AppButtonSize size;

  /// Full width olsun mu
  final bool fullWidth;

  /// Loading state'i
  final bool isLoading;

  /// Disabled state'i
  final bool isDisabled;

  /// Icon widget'ı
  final Widget? icon;

  /// Icon pozisyonu
  final AppButtonIconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _getHeight(),
      child: _buildButton(context, colorScheme),
    );
  }

  /// Button widget'ını oluştur
  Widget _buildButton(BuildContext context, ColorScheme colorScheme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return _buildElevatedButton(context, colorScheme);
      case AppButtonVariant.secondary:
        return _buildOutlinedButton(context, colorScheme);
      case AppButtonVariant.tertiary:
        return _buildTextButton(context, colorScheme);
      case AppButtonVariant.danger:
        return _buildDangerButton(context, colorScheme);
    }
  }

  /// Primary (elevated) button
  Widget _buildElevatedButton(BuildContext context, ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: _getOnPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getBackgroundColor(colorScheme),
        foregroundColor: _getForegroundColor(colorScheme),
        elevation: _getElevation(),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        textStyle: _getTextStyle(context),
        minimumSize: Size(_getMinWidth(), _getHeight()),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Secondary (outlined) button
  Widget _buildOutlinedButton(BuildContext context, ColorScheme colorScheme) {
    return OutlinedButton(
      onPressed: _getOnPressed(),
      style: OutlinedButton.styleFrom(
        foregroundColor: _getForegroundColor(colorScheme),
        side: BorderSide(
          color: _getBorderColor(colorScheme),
          width: 1.5,
        ),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        textStyle: _getTextStyle(context),
        minimumSize: Size(_getMinWidth(), _getHeight()),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Tertiary (text) button
  Widget _buildTextButton(BuildContext context, ColorScheme colorScheme) {
    return TextButton(
      onPressed: _getOnPressed(),
      style: TextButton.styleFrom(
        foregroundColor: _getForegroundColor(colorScheme),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        textStyle: _getTextStyle(context),
        minimumSize: Size(_getMinWidth(), _getHeight()),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Danger button
  Widget _buildDangerButton(BuildContext context, ColorScheme colorScheme) {
    return ElevatedButton(
      onPressed: _getOnPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.white,
        elevation: _getElevation(),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        textStyle: _getTextStyle(context),
        minimumSize: Size(_getMinWidth(), _getHeight()),
      ),
      child: _buildButtonContent(),
    );
  }

  /// Button content (text + icon + loading)
  Widget _buildButtonContent() {
    if (isLoading) {
      return _buildLoadingContent();
    }

    if (icon == null) {
      return Text(text);
    }

    return _buildIconTextContent();
  }

  /// Loading content
  Widget _buildLoadingContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _getLoadingSize(),
          height: _getLoadingSize(),
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
        AppSpacing.hGapSM,
        Text(text),
      ],
    );
  }

  /// Icon + text content
  Widget _buildIconTextContent() {
    final iconWidget = SizedBox(
      width: _getIconSize(),
      height: _getIconSize(),
      child: icon!,
    );

    if (iconPosition == AppButtonIconPosition.left) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          AppSpacing.hGapSM,
          Text(text),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          AppSpacing.hGapSM,
          iconWidget,
        ],
      );
    }
  }

  // ==================== STYLE GETTERS ====================

  /// OnPressed callback
  VoidCallback? _getOnPressed() {
    if (isDisabled || isLoading) return null;
    return onPressed;
  }

  /// Background color
  Color _getBackgroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return colorScheme.primary;
      case AppButtonVariant.danger:
        return AppColors.error;
      default:
        return Colors.transparent;
    }
  }

  /// Foreground color
  Color _getForegroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return colorScheme.onPrimary;
      case AppButtonVariant.secondary:
        return colorScheme.primary;
      case AppButtonVariant.tertiary:
        return colorScheme.primary;
      case AppButtonVariant.danger:
        return AppColors.white;
    }
  }

  /// Border color
  Color _getBorderColor(ColorScheme colorScheme) {
    return colorScheme.primary;
  }

  /// Elevation
  double _getElevation() {
    return variant == AppButtonVariant.primary ||
            variant == AppButtonVariant.danger
        ? 0
        : 0;
  }

  /// Padding
  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return AppSpacing.buttonPaddingSmall;
      case AppButtonSize.medium:
        return AppSpacing.buttonPaddingMedium;
      case AppButtonSize.large:
        return AppSpacing.buttonPaddingLarge;
    }
  }

  /// Border radius
  double _getBorderRadius() {
    return AppSpacing.md;
  }

  /// Text style
  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case AppButtonSize.small:
        return AppTypography.buttonSmall;
      case AppButtonSize.medium:
        return AppTypography.buttonMedium;
      case AppButtonSize.large:
        return AppTypography.buttonLarge;
    }
  }

  /// Height
  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  /// Min width
  double _getMinWidth() {
    switch (size) {
      case AppButtonSize.small:
        return 80;
      case AppButtonSize.medium:
        return 120;
      case AppButtonSize.large:
        return 140;
    }
  }

  /// Icon size
  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  /// Loading indicator size
  double _getLoadingSize() {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }
}

// ==================== ENUMS ====================

/// Button variant'ları
enum AppButtonVariant {
  primary,
  secondary,
  tertiary,
  danger,
}

/// Button size'ları
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Icon pozisyonu
enum AppButtonIconPosition {
  left,
  right,
}
