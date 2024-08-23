import 'package:flutter/material.dart';

class GradientTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final List<Color>? colors;
  final double? fontSize;

  const GradientTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.colors,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: colors ??
              [
                Colors.lightGreenAccent,
                const Color.fromARGB(255, 236, 244, 161)
              ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Text(
          text,
          style: TextStyle(
              letterSpacing: -1,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: fontSize),
        ),
      ),
    );
  }
}
