import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/theme/app_button_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_data_table_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_drop_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_input_decoration_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_radio_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_switch_theme.dart';
import 'package:thy_lifevest_app/core/theme/app_tab_bar_theme.dart';

import '../constant/theme/app_colors.dart';
import 'app_bottom_sheet_theme.dart';
import 'app_checkbox_theme.dart';
import 'app_slider_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: 0,
      scrolledUnderElevation: 0,
    ),
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationTheme,

    filledButtonTheme: AppButtonTheme.filledButtonTheme,
    outlinedButtonTheme: AppButtonTheme.outlinedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonTheme,
    iconButtonTheme: AppButtonTheme.iconButtonTheme,
    checkboxTheme: AppCheckboxTheme.checkboxThemeData,
    dividerColor: AppColors.transparent,
    tabBarTheme: AppTabBarTheme.tabBarTheme,
    switchTheme: AppSwitchTheme.switchTheme,
    radioTheme: AppRadioTheme.radioTheme,
    dividerTheme: const DividerThemeData(color: AppColors.gray50),
    dataTableTheme: AppDataTableTheme.dataTableThemeData,
    sliderTheme: AppSliderTheme.sliderVideoTheme,
    dropdownMenuTheme: AppDropTheme.dropdownMenuTheme,

    bottomSheetTheme: AppBottomSheetTheme.bottomSheetThemeData,
  );
}
