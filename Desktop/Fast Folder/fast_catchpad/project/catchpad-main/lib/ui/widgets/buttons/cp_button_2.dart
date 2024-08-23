import 'package:flutter/material.dart';

import '../../../utils/cp_colors.dart';
import 'cp_btn.dart';

class CpButton2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final bool fullWidth;

  const CpButton2({
    required this.onPressed,
    required this.child,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CpBtn(
        color: CpColors.button2Color,
        onPressed: onPressed,
        child: child,
        fullWidth: fullWidth,
      );
}

class CpButtonWithIcon2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final bool fullWidth;
  final Widget iconWidget;

  const CpButtonWithIcon2({
    required this.onPressed,
    required this.child,
    required this.iconWidget,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CpBtnWithIcon(
        color: CpColors.button2Color,
        onPressed: onPressed,
        child: child,
        fullWidth: fullWidth,
        icon: iconWidget,
      );
}