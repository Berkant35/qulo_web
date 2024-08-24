import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension AppBarExtension on AppBar {
  static AppBar get noneAppBar => AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      );

  static AppBar get primaryColorAppBar => AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: CustomColors.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      );
}

extension IconExtension on String {
  SvgPicture customSvgIcon({Color? color,double? iconSize}) {
    return SvgPicture.asset(
      this,
      width: iconSize,
      semanticsLabel: 'Acme Logo',
      fit: BoxFit.contain,
      color: color,
    );
  }
}
