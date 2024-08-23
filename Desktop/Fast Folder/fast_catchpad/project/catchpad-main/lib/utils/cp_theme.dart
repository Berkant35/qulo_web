import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cp_colors.dart';





///OLD
abstract class CpTheme {

  static ThemeData themeV2 = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: CpColors.cpPrimary,
    useMaterial3: false,
    scaffoldBackgroundColor: CpColors.cpDarkJungleGreen, // Ara yüzün ana arkaplan rengi
    cardColor: CpColors.cpDarkJungleGreen, // Kartların arkaplan rengi
    buttonTheme: const ButtonThemeData(
      buttonColor: CpColors.cpPrimary, // Butonların varsayılan arka plan rengi
      splashColor: CpColors.cpSecondary, // Butonlara dokunulduğunda yayılan efektin rengi
      disabledColor: CpColors.cpDavysGrey, // Engellenmiş butonların arka plan rengi
      hoverColor: CpColors.cpSecondary, // Fare üzerine gelindiğinde butonun arka plan rengi
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: CpColors.cpDarkLiver,
        fontSize: 13.sp,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: CpColors.cpDarkLiver,
        fontSize: 14.sp,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),

      bodySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
      ),
      // Diğer metin stilleri buraya eklenir
      labelSmall: TextStyle(
        fontSize: 18.sp, // Örnek olarak düğme metni için bir stil
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp, // Örnek olarak düğme metni için bir stil
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      ///Created For Iga You should use on iga
      headlineLarge: TextStyle(
        fontSize: 14.sp, // Örnek olarak düğme metni için bir stil
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 14.sp, // Örnek olarak düğme metni için bir stil
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 10.sp, // Örnek olarak düğme metni için bir stil
        fontWeight: FontWeight.w400,
        color: Colors.white,
      )
    ),

    // Diğer ThemeData parametreleri buraya eklenir
  );



  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: false,
    fontFamily: 'Poppins',
    appBarTheme: _appBarTheme(),
    inputDecorationTheme: _inputTheme(),
    textTheme: _textTheme(),
    textSelectionTheme: _textSelectionTheme(),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            return states.contains(MaterialState.disabled)
                ? CpColors.defDisabledColor
                : CpColors.defTextColor;
          },
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: CpColors.chipSelectedColor,
      disabledColor: CpColors.chipDisabledSelectedColor,
      backgroundColor: CpColors.chipUnselectedColor,
    ),
  );
  static AppBarTheme _appBarTheme() {
    return const AppBarTheme(
      backgroundColor: CpColors.appbarColor,
      elevation: 0,
    );
  }

  static TextSelectionThemeData _textSelectionTheme() {
    return const TextSelectionThemeData(
      cursorColor: CpColors.info,
      selectionColor: CpColors.info,
    );
  }

  static InputDecorationTheme _inputTheme() {
    final rad = BorderRadius.circular(16);
    final mtB = OutlineInputBorder(
      borderRadius: rad,
      borderSide: const BorderSide(width: 0),
    );

    return InputDecorationTheme(
      fillColor: CpColors.textFieldFill,
      filled: true,
      border: mtB,
      enabledBorder: mtB,
      disabledBorder: mtB,
      errorBorder: OutlineInputBorder(
        borderRadius: rad,
        borderSide: const BorderSide(color: CpColors.error),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: rad,
        borderSide: const BorderSide(color: CpColors.info),
      ),
    );
  }

  static TextTheme _textTheme() {
    return const TextTheme(
      caption: TextStyle(
        color: CpColors.captionColor,
      ),
      bodyText1: TextStyle(
        color: CpColors.body1Color,
      ),
      headline1: TextStyle(
        color: CpColors.headline1Color,
      ),
      headline2: TextStyle(
        color: CpColors.headline2Color,
      ),
      headline3: TextStyle(
        color: CpColors.headline3Color,
      ),
      headline4: TextStyle(
        color: CpColors.headline4Color,
      ),
      headline5: TextStyle(
        color: CpColors.headline5Color,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        color: CpColors.headline6Color,
      ),

    );
  }






}


/*
abstract class CpTheme {


  static ThemeData myTheme = ThemeData(
    applyElevationOverlayColor: false,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      alignedDropdown: false,
      colorScheme: ColorScheme(
        background: Color(0xff000000),
        brightness: Brightness.light,
        error: Color(0xffba1a1a),
        errorContainer: Color(0xffffdad6),
        inversePrimary: Color(0xffaad600),
        inverseSurface: Color(0xffbbbbba),
        onBackground: Color(0xffcefe38),
        onError: Color(0xffffffff),
        onErrorContainer: Color(0xff410002),
        onInverseSurface: Color(0xfff3f1e9),
        onPrimary: Color(0xff000000),
        onPrimaryContainer: Color(0xff000000),
        onSecondary: Color(0xff000000),
        onSecondaryContainer: Color(0xff161f00),
        onSurface: Color(0xffffffff),
        onSurfaceVariant: Color(0xffc6c7c3),
        onTertiary: Color(0xffffffff),
        onTertiaryContainer: Color(0xff171e00),
        outline: Color(0xffcefe38),
        outlineVariant: Color(0xffc6c8b8),
        primary: Color(0xffcefe38),
        primaryContainer: Color(0xffcefe38),
        secondary: Color(0xffcefe38),
        secondaryContainer: Color(0xffd5ec93),
        shadow: Color(0xfffffbff),
        surface: Color(0xfffff8f8),
        surfaceTint: Color(0xff506600),
        surfaceVariant: Color(0xffe3e4d3),
        tertiary: Color(0xffe2ff87),
        tertiaryContainer: Color(0xffd6ec91),
      ),
      height: 36,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
      minWidth: 88,
      padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),

      textTheme: ButtonTextTheme.normal,
    ),
    canvasColor: const Color(0xff000000),
    cardColor: const Color(0xfffff8f8),
    colorScheme: const ColorScheme(
      background: Color(0xff000000),
      brightness: Brightness.light,
      error: Color(0xffba1a1a),
      errorContainer: Color(0xffffdad6),
      inversePrimary: Color(0xffaad600),
      inverseSurface: Color(0xffbbbbba),
      onBackground: Color(0xffcefe38),
      onError: Color(0xffffffff),
      onErrorContainer: Color(0xff410002),
      onInverseSurface: Color(0xfff3f1e9),
      onPrimary: Color(0xff000000),
      onPrimaryContainer: Color(0xff000000),
      onSecondary: Color(0xff000000),
      onSecondaryContainer: Color(0xff161f00),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffc6c7c3),
      onTertiary: Color(0xffffffff),
      onTertiaryContainer: Color(0xff171e00),
      outline: Color(0xffcefe38),
      outlineVariant: Color(0xffc6c8b8),
      primary: Color(0xffcefe38),
      primaryContainer: Color(0xffcefe38),
      secondary: Color(0xffcefe38),
      secondaryContainer: Color(0xffd5ec93),
      shadow: Color(0xfffffbff),
      surface: Color(0xfffff8f8),
      surfaceTint: Color(0xff506600),
      surfaceVariant: Color(0xffe3e4d3),
      tertiary: Color(0xffe2ff87),
      tertiaryContainer: Color(0xffd6ec91),
    ),
    dialogBackgroundColor: Color(0xff000000),
    disabledColor: Color(0x61000000),
    dividerColor: Color(0x1fffffff),
    focusColor: Color(0x1f000000),
    highlightColor: Color(0x66bcbcbc),
    hintColor: Color(0x99000000),
    hoverColor: Color(0x0a000000),
    iconTheme: IconThemeData(color: Color(0xdd000000)),
    indicatorColor: Color(0xff000000),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: false,
      filled: false,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isCollapsed: false,
      isDense: false,
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    platform: TargetPlatform.windows,
    primaryColor: Color(0xffcefe38),
    primaryColorDark: Color(0xff1976d2),
    primaryColorLight: Color(0xffbbdefb),
    primaryIconTheme: IconThemeData(color: Color(0xff000000)),
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Color(0xdd000000),
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodyText2: TextStyle(
        color: Color(0xdd000000),
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      // Diğer stiller buraya eklenmelidir...
    ),
    scaffoldBackgroundColor: Color(0xff000000),
    secondaryHeaderColor: Color(0xffe3f2fd),
    shadowColor: Color(0xff000000),
    splashColor: Color(0x66c8c8c8),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Color(0xdd000000),
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
      ),
      bodyText2: TextStyle(
        color: Color(0xdd000000),
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
      ),
      // Diğer stiller buraya eklenmelidir...
    ),
    toggleableActiveColor: Color(0xff00695c),
  );

}*/