import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppSliderTheme {
  static SliderThemeData get sliderVideoTheme {
    return const SliderThemeData(
      trackHeight: 1.5,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0),
      activeTrackColor: AppColors.white,
      inactiveTrackColor: AppColors.white200,
      thumbColor: AppColors.red500,
      overlayColor: AppColors.red500,
    );
  }
}
