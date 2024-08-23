import 'package:flutter/material.dart';

enum ProjectRadius {
  small,
  medium,
  normal,
  large,
  extraLarge;

  double get value {
    switch (this) {
      case ProjectRadius.small:
        return 8;
      case ProjectRadius.medium:
        return 16;
      case ProjectRadius.normal:
        return 24;
      case ProjectRadius.large:
        return 32;
      case ProjectRadius.extraLarge:
        return 40;
      default:
        return 8;
    }
  }

  BorderRadiusGeometry get radius {
    switch (this) {
      case ProjectRadius.small:
        return BorderRadius.circular(8);
      case ProjectRadius.medium:
        return BorderRadius.circular(16);
      case ProjectRadius.normal:
        return BorderRadius.circular(24);
      case ProjectRadius.large:
        return BorderRadius.circular(32);
      case ProjectRadius.extraLarge:
        return BorderRadius.circular(40);
      default:
        return BorderRadius.circular(8);
    }
  }
}
