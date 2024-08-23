import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  final double size;
  final void Function()? onTap;
  const SocialButton({
    super.key,
    required this.imagePath,
    required this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        minRadius: size,
        maxRadius: size,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
