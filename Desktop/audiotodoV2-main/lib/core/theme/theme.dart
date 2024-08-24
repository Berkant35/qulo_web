import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_colors.dart';

class CustomTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: CustomColors.primaryColor,
    hintColor: CustomColors.secondaryColor,
    splashFactory: NoSplash.splashFactory,
    // removes color when holding the button
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: CustomColors.fillWhiteColor.withOpacity(0.95),
    primarySwatch: MaterialColor(0xFF028960,  <int, Color>{
      50: Color(CustomColors.primaryColor.value),
      100: Color(CustomColors.primaryColor.value),
      200: Color(CustomColors.primaryColor.value),
      300: Color(CustomColors.primaryColor.value),
      400: Color(CustomColors.primaryColor.value),
      500: Color(CustomColors.primaryColor.value),
      600: Color(CustomColors.primaryColor.value),
      700: Color(CustomColors.primaryColor.value),
      800: Color(CustomColors.primaryColor.value),
      900: Color(CustomColors.primaryColor.value),
    }),
    cardColor: CustomColors.fillWhiteColor,
    errorColor: CustomColors.errorColor,
    appBarTheme: const AppBarTheme(
      color: CustomColors.primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primaryColor,
        foregroundColor: CustomColors.fillWhiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: CustomColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
