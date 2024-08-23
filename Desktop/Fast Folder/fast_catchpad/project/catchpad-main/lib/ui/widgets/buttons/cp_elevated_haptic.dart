import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpElevatedHaptic extends StatefulWidget {
  final IconData? icon;
  final Function()? onPressed;
  const CpElevatedHaptic({super.key, this.icon, this.onPressed});

  @override
  State<CpElevatedHaptic> createState() => _CpElevatedHapticState();
}

class _CpElevatedHapticState extends State<CpElevatedHaptic> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await SystemChannels.platform.invokeMethod<void>(
          'HapticFeedback.vibrate',
          'HapticFeedbackType.lightImpact',
        );
        widget.onPressed?.call();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        backgroundColor: CpColors.body1Color,
      ),
      child: Center(
        child: Icon(
          widget.icon,
          size: 25.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
