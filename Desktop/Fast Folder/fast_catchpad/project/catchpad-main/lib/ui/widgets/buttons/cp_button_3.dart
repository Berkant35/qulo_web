import 'package:flutter/material.dart';

import '../../../utils/cp_colors.dart';
import 'cp_btn.dart';

class CpButton3 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final bool fullWidth;

  const CpButton3({
    required this.onPressed,
    required this.child,
    this.fullWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CpBtn(
        color: Colors.transparent,
        border: Border.all(
          color: CpColors.defTextColor,
          width: 2,
        ),
        onPressed: onPressed,
        child: child,
        fullWidth: fullWidth,
      );
}
