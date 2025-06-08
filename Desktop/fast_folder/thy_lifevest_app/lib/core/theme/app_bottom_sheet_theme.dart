import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';

class AppBottomSheetTheme {
  static const BottomSheetThemeData bottomSheetThemeData = BottomSheetThemeData(
    backgroundColor: AppColors.white,
    dragHandleColor: AppColors.gray500With15Alpha,
    dragHandleSize: Size(60, 5),
  );
}
