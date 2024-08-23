import 'package:catchpad/utils/cp_colors.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UtilLocalizations {
  static Widget getCountryFlag(String? code) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: CpColors.cpPrimary, // Çerçeve rengi
          width: 1.0, // Çerçeve genişliği
        ),
      ),
      width: radius(),
      height: radius(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius()),
        child: FittedBox(
          fit: BoxFit.cover,
          child: CountryFlag.fromCountryCode(
            code?.toUpperCase() ?? "TR",
          ),
        ),
      ),
    );
  }

  static double radius() => 82;
}
