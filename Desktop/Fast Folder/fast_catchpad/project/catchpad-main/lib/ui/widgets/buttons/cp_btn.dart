import 'package:flutter/material.dart';

import '../../../utils/consts.dart';

class CpBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Gradient? gradient;
  final Color? color;
  final BoxBorder? border;
  final double? customHigh;
  final double? customWidth;
  final bool fullWidth;

  const CpBtn({
    this.gradient,
    this.color,
    required this.onPressed,
    required this.child,
    this.border,
    this.customHigh,
    this.customWidth,
    this.fullWidth = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final body = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: gradient,
        color: color,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defPaddingSize,
              vertical: halfDefPaddingSize,
            ),
            child: SizedBox(
              height: 23,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
    return fullWidth ? body : Row(children: [body]);
  }
}

class CpBtnWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Gradient? gradient;
  final Color? color;
  final BoxBorder? border;
  final bool fullWidth;
  final Widget icon;

  const CpBtnWithIcon({
    this.gradient,
    this.color,
    required this.onPressed,
    required this.child,
    required this.icon,
    this.border,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: gradient,
        color: color,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            icon,
            TextButton(
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: halfDefPaddingSize,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Center(child: child),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return fullWidth
        ? body
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [body]);
  }
}
