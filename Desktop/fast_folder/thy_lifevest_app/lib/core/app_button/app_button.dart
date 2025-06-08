import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/app_button/enum/button_type.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_text_styles.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';

import '../constant/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final void Function()? onTap;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final Widget? icon;
  final Widget? child;
  final Widget? trailing;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final bool isUnderlined;
  final Color? textColor;
  final IconAlignment iconAlignment;
  final ButtonType _buttonType;
  final VisualDensity? visualDensity;

  const AppButton.filled({
    super.key,
    this.text,
    this.backgroundColor,
    this.textStyle,
    this.onTap,
    this.borderColor,
    this.height,
    this.width,
    this.icon,
    this.child,
    this.trailing,
    this.radius,
    this.padding,
    this.textColor,
    this.visualDensity,
    this.iconAlignment = IconAlignment.start,
    this.isUnderlined = false,
  }) : _buttonType = ButtonType.filled;

  const AppButton.outline({
    super.key,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.onTap,
    this.height,
    this.width,
    this.icon,
    this.trailing,
    this.child,
    this.radius,
    this.padding,
    this.textColor,
    this.visualDensity,
    this.iconAlignment = IconAlignment.start,
    this.isUnderlined = false,
  }) : _buttonType = ButtonType.outlined;

  const AppButton.icon({
    super.key,
    required this.icon,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.onTap,
    this.height,
    this.width,
    this.child,
    this.radius,
    this.padding,
    this.visualDensity,
    this.trailing,
    this.textColor,
    this.iconAlignment = IconAlignment.start,
    this.isUnderlined = false,
  }) : assert(icon != null, "Icon is not equals null"),
       _buttonType = ButtonType.icon;

  const AppButton.text({
    super.key,
    this.text,
    this.onTap,
    TextStyle? style,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.textColor,
    this.iconAlignment = IconAlignment.start,
    this.isUnderlined = false,
  }) : textStyle = style,
       backgroundColor = null,
       borderColor = null,
       icon = null,
       child = null,
       trailing = null,
       visualDensity = null,
       _buttonType = ButtonType.text;

  @override
  Widget build(BuildContext context) {
    switch (_buttonType) {
      case ButtonType.filled:
        return _buildStandartButton(context);
      case ButtonType.outlined:
        return _buildOutlineButton(context);
      case ButtonType.icon:
        return _buildIconButton(context);
      case ButtonType.text:
        return _buildTextButton(context);
    }
  }

  Widget _buildStandartButton(BuildContext context) {
    if (icon != null) {
      return GestureDetector(
        onTapDown: (v) => onTap?.call(),
        child: FilledButton.icon(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
            padding: WidgetStatePropertyAll(padding),
            fixedSize: WidgetStatePropertyAll(
              Size(width ?? double.maxFinite, height ?? 50),
            ),
            side:
                borderColor.isNotNull
                    ? WidgetStatePropertyAll(
                      BorderSide(
                        color: borderColor ?? AppColors.thyPrimary,
                        width: 1.5,
                      ),
                    )
                    : null,
            shape:
                radius.isNull
                    ? null
                    : WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius ?? 8),
                      ),
                    ),
          ),
          icon: icon!,
          label:
              child ??
              Text(
                text.getValueOrDefault,
                style:
                    textStyle ??
                    AppTextStyles.px16w500.copyWith(
                      color: AppColors.thyPrimary,
                    ),
              ),
        ),
      );
    }
    return GestureDetector(
      onTapDown: (v) => onTap?.call(),
      child: FilledButton(
        onPressed: null,
        style: ButtonStyle(
          visualDensity: visualDensity,
          fixedSize: WidgetStatePropertyAll(
            Size(width ?? double.maxFinite, height ?? 50),
          ),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          padding: WidgetStatePropertyAll(padding),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 8),
            ),
          ),
          side:
              borderColor.isNotNull
                  ? WidgetStatePropertyAll(
                    BorderSide(
                      color: borderColor ?? AppColors.thyPrimary,
                      width: 1.5,
                    ),
                  )
                  : null,
        ),
        child:
            child ??
            Text(
              text.getValueOrDefault,
              style:
                  textStyle ??
                  AppTextStyles.px16w600.copyWith(
                    color: textColor ?? AppColors.white,
                  ),
            ),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    if (icon != null) {
      return GestureDetector(
        onTapDown: (v) => onTap?.call(),
        child: OutlinedButton.icon(
          onPressed: null,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(padding),
            fixedSize: WidgetStatePropertyAll(
              Size(width ?? double.maxFinite, height ?? 50),
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: borderColor ?? AppColors.thyPrimary,
                width: 1.5,
              ),
            ),
            shape:
                radius.isNull
                    ? null
                    : WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius ?? 8),
                      ),
                    ),
          ),
          icon: icon!,
          iconAlignment: iconAlignment,
          label:
              child ??
              Text(
                text.getValueOrDefault,
                style:
                    textStyle ??
                    AppTextStyles.px14w500.copyWith(
                      color: textColor ?? AppColors.thyPrimary,
                    ),
              ),
        ),
      );
    }

    return GestureDetector(
      onTapDown: (v) => onTap?.call(),
      child: OutlinedButton(
        onPressed: null,
        style: ButtonStyle(
          visualDensity: visualDensity,
          fixedSize: WidgetStatePropertyAll(
            Size(width ?? double.maxFinite, height ?? 50),
          ),
          padding: WidgetStatePropertyAll(padding),
          side: WidgetStatePropertyAll(
            BorderSide(color: borderColor ?? AppColors.thyPrimary, width: 1.5),
          ),
          shape:
              radius.isNull
                  ? null
                  : WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius ?? 8),
                    ),
                  ),
        ),
        child:
            child ??
            Text(
              text.getValueOrDefault,
              style:
                  textStyle ??
                  AppTextStyles.px14w500.copyWith(
                    color: textColor ?? AppColors.thyPrimary,
                  ),
            ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (v) => onTap?.call(),
      child: IconButton(
        onPressed: null,
        icon: icon ?? const SizedBox.shrink(),
        padding: padding,
        visualDensity: visualDensity,
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (v) => onTap?.call(),
      child: TextButton(
        onPressed: null,
        style: ButtonStyle(
          fixedSize:
              width != null || height != null
                  ? WidgetStatePropertyAll(
                    Size(width ?? double.maxFinite, height ?? 50),
                  )
                  : null,
          shape:
              radius.isNull
                  ? null
                  : WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius ?? 8),
                    ),
                  ),
          padding: WidgetStatePropertyAll(padding),
        ),
        child: Text(
          text.getValueOrDefault,
          style: (textStyle ?? AppTextStyles.px14w500).copyWith(
            color: textColor,
            decoration: isUnderlined ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}
