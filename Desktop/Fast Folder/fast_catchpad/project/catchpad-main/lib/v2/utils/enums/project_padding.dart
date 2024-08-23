import 'package:flutter/material.dart';

enum ProjectPadding {
  small,
  medium,
  normal,
  large,
  extraLarge;

  double get value {
    switch (this) {
      case ProjectPadding.small:
        return 8;
      case ProjectPadding.medium:
        return 16;
      case ProjectPadding.normal:
        return 24;
      case ProjectPadding.large:
        return 32;
      case ProjectPadding.extraLarge:
        return 40;
      default:
        return 8;
    }
  }

  EdgeInsetsGeometry get padding {
    switch (this) {
      case ProjectPadding.small:
        return const EdgeInsets.all(8);
      case ProjectPadding.medium:
        return const EdgeInsets.all(16);
      case ProjectPadding.normal:
        return const EdgeInsets.all(24);
      case ProjectPadding.large:
        return const EdgeInsets.all(32);
      case ProjectPadding.extraLarge:
        return const EdgeInsets.all(40);
      default:
        return const EdgeInsets.all(8);
    }
  }
}
