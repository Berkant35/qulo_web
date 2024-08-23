import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CustomCatchpadButtons {
  static Widget buildGradientButtonWithBorder({
    required VoidCallback? onPressed,
    required BuildContext context,
    required String text,
    Color backGroundColor1 = const Color.fromARGB(92, 204, 254, 56),
    Color backGroundColor2 = const Color.fromARGB(49, 204, 254, 56),
    Color borderColor = CpColors.cpPrimary,
    double borderWidth = 2,
    double? width,
    TextStyle? textStyle,
    double? height,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(width: borderWidth, color: borderColor),
          gradient: LinearGradient(
            colors: [backGroundColor1, backGroundColor2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(19.0),
        ),
        child: Center(
          child: Text(text,
              textAlign: TextAlign.center,
              style: textStyle ??
                  Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp)),
        ),
      ),
    );
  }

  static Widget buildGradientAccentButton({
    required VoidCallback? onPressed,
    required String text,
    Color color = Colors.black,
    List<Color>? customGradientColor,
    double? width,
    double? height,
    double? borderThickness,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder:
            buildRoundedRectangleBorder(borderThickness: borderThickness),
        child: Container(
          width: width,
          height: height,
          padding: contentPadding ?? EdgeInsets.symmetric(vertical: 1.h),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: CpColors.cpPrimary.withOpacity(0.4),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: customGradientColor ??
                  [
                    CpColors.cpPrimary.withOpacity(0.01),
                    CpColors.cpPrimary.withOpacity(0.02)
                  ],
            ),
            shape:
                buildRoundedRectangleBorder(borderThickness: borderThickness),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildBackGroundGradientButton({
    required VoidCallback onPressed,
    required String text,
    double? fontSize,
    EdgeInsetsGeometry? padding,
    Widget? icon,
    double width = 100.0,
    double? height,
    Color? borderColor,
    Color? backGroundColor1,
    Color? backGroundColor2,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder: buildRoundedRectangleBorder(),
        child: Container(
          height: height,
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(1.00, -0.01),
              end: const Alignment(-1, 0.01),
              colors: [
                backGroundColor1 ?? CpColors.cpPear,
                backGroundColor2 ?? CpColors.cpFrenchLime
              ],
            ),
            shape: borderlessShape(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon ?? const SizedBox.shrink(),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildBackGroundGradientButtonV2({
    required VoidCallback? onPressed,
    required String text,
    double width = 100.0,
    double? height,
    Color? borderColor,
    double? fontSize,
    Color? fillColor,
    Color? textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        onLongPress: onPressed,
        customBorder: buildRoundedRectangleBorder(),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(1.00, -0.01),
              end: const Alignment(-1, 0.01),
              colors: [
                fillColor ?? CpColors.cpTuftsBlue,
                fillColor ?? CpColors.cpTuftsBlue
              ],
            ),
            shape: borderlessShape(),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static RoundedRectangleBorder borderlessShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusPx()),
    );
  }

  static Widget buildGradientBorderButton({
    required VoidCallback? onPressed,
    required String text,
    double width = 100.0,
    double? height,
    double? borderRadius,
    Color? backColor,
    Color? inTextColor,
    Gradient? gradient,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder: buildRoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            color: backColor ?? Colors.transparent,
            border: buildGradientBorder(),
            borderRadius: buildBorderRadius(borderRadius: borderRadius),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildGradientBorderWithGradientTextButton({
    required VoidCallback? onPressed,
    required String text,
    double width = 100.0,
    double? height,
    double? borderRadius,
    Color?

        /// In the provided code, the `backColor` parameter is used in various button building
        /// methods to specify the background color of the button. It allows you to customize the
        /// background color of the button according to your requirements when creating different
        /// types of buttons. By providing a specific `backColor` value, you can control the visual
        /// appearance of the button's background.
        backColor,
    List<Color>? inTextColor,
    Gradient? gradient,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder: buildRoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            gradient: gradient,
            color: backColor ?? Colors.transparent,
            border: buildGradientBorder(),
            borderRadius: buildBorderRadius(borderRadius: borderRadius),
          ),
          child: Center(
            child: GradientText(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              colors:
                  inTextColor ?? [CpColors.cpPrimary, CpColors.cpFrenchLime],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildBorderTextButton({
    required VoidCallback? onPressed,
    required String text,
    double width = 100.0,
    double? height,
    double? borderRadius,
    Color? backColor,
    List<Color>? inTextColor,
    Gradient? gradient,
    double borderWidth = 1,
    Color? textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder: buildRoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 1.h),
          decoration: BoxDecoration(
            color: backColor ?? Colors.black,
            gradient: gradient,
            border: Border.all(color: Colors.white, width: borderWidth),
            borderRadius: buildBorderRadius(borderRadius: borderRadius),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18.sp,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildBorderButton(
      {required VoidCallback onPressed,
      required WidgetRef ref,
      required String text,
      double width = 100.0,
      double? height,
      double? borderRadius,
      EdgeInsetsGeometry? padding,
      double? borderThickness,
      Color? inTextColor,
      Color? backColor,
      Color? borderColor}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: CpColors.cpDavysGrey,
        onTap: onPressed,
        customBorder: buildRoundedRectangleBorder(borderRadius: borderRadius),
        child: Container(
          height: height,
          padding: padding ?? EdgeInsets.symmetric(vertical: 1.h),
          decoration: ShapeDecoration(
            color: backColor ?? Colors.white.withOpacity(0.04),
            shape: buildRoundedRectangleBorder(
                borderColor: borderColor,
                borderRadius: borderRadius,
                borderThickness: borderThickness),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(ref.context).textTheme.titleLarge!.copyWith(
                    color: inTextColor ?? borderColor, fontSize: 18.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static RoundedRectangleBorder buildRoundedRectangleBorder(
      {Color? borderColor, double? borderRadius, double? borderThickness}) {
    return RoundedRectangleBorder(
      side: BorderSide(
          width: borderThickness ?? 0.5.w,
          color: borderColor ?? CpColors.cpPrimary),
      borderRadius: buildBorderRadius(borderRadius: borderRadius),
    );
  }

  static buildGradientBorder() {
    return GradientBoxBorder(
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CpColors.cpPrimary,
            CpColors.cpFrenchLime,
          ]),
      width: 0.32.w,
    );
  }

  static BorderRadius buildBorderRadius({double? borderRadius}) =>
      BorderRadius.circular(borderRadius ?? radiusPx());

  static double radiusPx() => 24.px;

  static Widget tempButton({required WidgetRef ref}) => Container(
        width: 25.w,
        height: 4.h,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        decoration: ShapeDecoration(
          color: CpColors.cpAntiFlashLight,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: CpColors.cpEerieBlack),
            borderRadius: buildBorderRadius(),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 2.h,
            ),
            Text(
              'Customize',
              style: Theme.of(ref.context).textTheme.bodySmall,
            ),
          ],
        ),
      );
}
