import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary - Purple (mor elmas)
  static const purple = Color(0xFF9C27B0);
  static const purpleDark = Color(0xFF7B1FA2);
  static const purpleLight = Color(0xFFCE93D8);
  static const purpleSurface = Color(0xFFF3E5F5);

  // Secondary - Green (yesil elmas)
  static const green = Color(0xFF4CAF50);
  static const greenDark = Color(0xFF388E3C);
  static const greenLight = Color(0xFFA5D6A7);
  static const greenSurface = Color(0xFFE8F5E9);

  // Neutrals
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF5F5F5);
  static const onSurface = Color(0xFF1A1A1A);
  static const onSurfaceVariant = Color(0xFF666666);
  static const outline = Color(0xFFE0E0E0);
  static const outlineVariant = Color(0xFFF0F0F0);

  // Semantic
  static const error = Color(0xFFE53935);
  static const errorSurface = Color(0xFFFFEBEE);
  static const success = Color(0xFF43A047);
  static const errorLight = Color(0xFFFDE8E8);
  static const warning = Color(0xFFFFA726);
  static const info = Color(0xFF42A5F5);

  // Gradients
  static const purpleGradient = LinearGradient(
    colors: [purple, purpleDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const greenGradient = LinearGradient(
    colors: [green, greenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
