


import 'package:flutter/material.dart';

class CustomDivider {
  static Widget gradientDivider({
    required Gradient gradient,
    double height = 10.0,
    double width = 70.0,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
      ),
    );
  }
}