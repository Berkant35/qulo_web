import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';

/*
abstract class CpColors {
  static const cpBg = Color.fromARGB(255, 1, 2, 10);
  static const cpYellow = Color(0xfff8d323);
  static const cpBasicWhite = Colors.white;
  static const inputBorderBg = Color.fromARGB(255, 28, 31, 44);

  static const Color error = CpMainColors.cpRed,
      warning = CpMainColors.cpYellow,
      success = CpMainColors.cpGreen,
      info = CpMainColors.cpBlue;

  static const Color red = Color.fromARGB(255, 255, 0, 0),
      green = Color.fromARGB(255, 0, 255, 0),
      blue = Color.fromARGB(255, 0, 0, 255),
      yellow = Color.fromARGB(255, 255, 255, 0);

  static const cpSidesColorsModel = SidesColorsModel(
    tl: CpColors.green,
    tr: CpColors.yellow,
    bl: CpColors.blue,
    br: CpColors.red,
  );

  static const Color defTextColor = Color(0xFFFFFFFF);
  static const Color defDisabledColor = Color(0xFF5F6574);

  static const Color captionColor = Color(0xFF6F7A8F),
      body1Color = captionColor;
  static const Color _headlineColor = Color(0xFFFFFFFF),
      headline1Color = _headlineColor,
      headline2Color = _headlineColor,
      headline3Color = _headlineColor,
      headline4Color = _headlineColor,
      headline5Color = _headlineColor,
      headline6Color = _headlineColor;

  static const Color switchTrackColor = Color(0xFF30374F),
      switchActiveColor = Color(0xFF1A84E6);

  static const Color _bgGC1 = Color(0xFF2B2E3C), bgGC2 = Color(0xFF1C1E27);
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_bgGC1, bgGC2],
  );

  static const _btn1GC1 = Color(0xFF2359E3), _btn1GC2 = Color(0xFF12A8E8);
  static const button1Gradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [_btn1GC1, _btn1GC2],
  );

  static const button1Color = Color(0xFF009FE3);
  static const button2Color = Color(0xFF333846);

  static const appbarColor = Color(0xFF333846);

  static const _btmbarGC1 = Color(0xFF363942), _btmbarGC2 = Color(0xFF5F6574);
  static const bottomBarGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [_btmbarGC1, _btmbarGC2],
  );

  static const authTopPartColor1 = Color(0xFF5A606F);
  static const dialogBgColor = Color(0xFF333846);
  static const resultTileColor = Color(0xFF333846);
  static const resultTileTrophybgColor = Color(0xFF5A606F);
  static const resultTileWinnerTrophyColor = Color(0xFFFF7A1B);
  static const resultTileUnWinnerTrophyColor = Color(0xFF009FE3);
  static const padGroupTitleColor = Color(0xFF323644);

  static const bottomBarColor = Color(0xFF535866);
  static const bottomBarDisabledColor = Color(0xFF777c88);

  static const Color textFieldFill = Color(0xFF12141B);
  static const Color defBgColor = Color(0xFF12141B);
  static const Color gameScoreBorderColor = Color(0xFF141528);
  static const Color chipSelectedColor = Color(0xFF1A84E6),
      chipUnselectedColor = Color(0xFF5F6574);
  static Color chipDisabledSelectedColor = chipSelectedColor.withOpacity(0.5),
      chipDisabledUnselectedColor = chipUnselectedColor.withOpacity(0.5);
}*/
abstract class CpColors {
  //https://www.color-name.com/hex/909090 i set game from this site
  static const cpPrimary = Color(0xffCEFE38);
  static const cpSecondary = Color(0x8CC3E163);

  static const cpDividerGradient = Color(0xff93F351);

  static const cpPear = Color(0xFFCAFD39);

  static const cpFrenchLime = Color(0xFFA1F54A);

  static const cpProgressColor = Color(0xFF70FF00);
  static const cpNewGreen = Color.fromARGB(255, 21, 255, 0);
  static const cpLightGreen = Color.fromARGB(255, 13, 255, 0);

  static const cpLightGreyIGA = Color(0xFFD9D9D9);
  static const cpLightWhiteIGA = Color(0xFFF5F5F7);
  static const cpBorderSecondary = Color(0x00A4F074);
  static const cpBlackOut = Color(0xFF222222);
  static const cpDireWolf = Color(0xff282828);

  static const cpDarkJungleGreen = Color(0xff1F2120);
  static const cpChineseBlack = Color(0xff101010);
  static const cpWolfram = Color(0xffB5B6B7);

  static const cpQuickSilver = Color(0xff9F9F9F);
  static const cpEerieBlack = Color(0xff1C1C1C);
  static const cpLightGrey = Color(0xffD2D2D2);
  static const cpAntiFlashLight = Color(0xFFF1F1F1);
  static const cpDarkLiver = Color(0xB24D4D4D);
  static const cpPhilippineSilver = Color(0xffB8B8B8);
  static const cpTaupeGrey = Color(0xB2898989);
  static const cpDavysGrey = Color(0xff5D5C5A);
  static const cpDarkGrey = Color(0x00252623);

  static const cpLead = Color.fromRGBO(34, 33, 33, 1);
  static const cpTuftsBlue = Color(0xff3E82DF);
  static const cpPhilippineGrey = Color(0xff909090);
  static const cpPlatinum = Color(0xffE3E3E3);
  static const cpFieryRed = Color(0xffDF1B31);

  static const cpLightColors = [cpPrimary, cpSecondary];

  static const cpBg = Color.fromARGB(255, 1, 2, 10);
  static const cpYellow = Color(0xfff8d323);
  static const cpBasicWhite = Colors.white;
  static const inputBorderBg = Color.fromARGB(255, 28, 31, 44);

  static const Color error = CpMainColors.cpRed,
      warning = CpMainColors.cpYellow,
      success = CpMainColors.cpGreen,
      info = CpMainColors.cpBlue;

  static const Color red = Color.fromARGB(255, 255, 0, 0),
      green = Color.fromARGB(255, 0, 255, 0),
      blue = Color.fromARGB(255, 0, 0, 255),
      yellow = Color.fromARGB(255, 255, 255, 0);

  static const cpSidesColorsModel = SidesColorsModel(
    tl: CpColors.green,
    tr: CpColors.yellow,
    bl: CpColors.blue,
    br: CpColors.red,
  );

  static const Color defTextColor = Color(0xFFFFFFFF);
  static const Color defDisabledColor = Color(0xFF5F6574);

  static const Color captionColor = Color(0xFF6F7A8F),
      body1Color = captionColor;
  static const Color _headlineColor = Color(0xFFFFFFFF),
      headline1Color = _headlineColor,
      headline2Color = _headlineColor,
      headline3Color = _headlineColor,
      headline4Color = _headlineColor,
      headline5Color = _headlineColor,
      headline6Color = _headlineColor;

  static const Color switchTrackColor = Color(0xFF30374F),
      switchActiveColor = Color(0xFF1A84E6);

  static const Color _bgGC1 = Color(0xFF2B2E3C), bgGC2 = Color(0xFF1C1E27);
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_bgGC1, bgGC2],
  );

  static const _btn1GC1 = Color(0xFF2359E3), _btn1GC2 = Color(0xFF12A8E8);
  static const button1Gradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [_btn1GC1, _btn1GC2],
  );

  static const button1Color = Color(0xFF009FE3);
  static const button2Color = Color(0xFF333846);

  static const appbarColor = Color(0xFF333846);

  static const _btmbarGC1 = Color(0xFF363942), _btmbarGC2 = Color(0xFF5F6574);
  static const bottomBarGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [_btmbarGC1, _btmbarGC2],
  );

  static const authTopPartColor1 = Color(0xFF5A606F);
  static const dialogBgColor = Color(0xFF333846);
  static const resultTileColor = Color(0xFF333846);
  static const resultTileTrophybgColor = Color(0xFF5A606F);
  static const resultTileWinnerTrophyColor = Color(0xFFFF7A1B);
  static const resultTileUnWinnerTrophyColor = Color(0xFF009FE3);
  static const padGroupTitleColor = Color(0xFF323644);

  static const bottomBarColor = Color(0xFF535866);
  static const bottomBarDisabledColor = Color(0xFF777c88);
  static const linearProgressEmptyColor = Color(0xFF71736B);

  static const Color textFieldFill = Color(0xFF12141B);
  static const Color defBgColor = Color(0xFF12141B);
  static const Color gameScoreBorderColor = Color(0xFF141528);
  static const Color chipSelectedColor = Color(0xFF1A84E6),
      chipUnselectedColor = Color(0xFF5F6574);
  static Color chipDisabledSelectedColor = chipSelectedColor.withOpacity(0.5),
      chipDisabledUnselectedColor = chipUnselectedColor.withOpacity(0.5);
}
