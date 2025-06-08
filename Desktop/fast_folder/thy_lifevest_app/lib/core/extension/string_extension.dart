import 'dart:ui';

import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';

extension StringNullable on String? {
  bool get isNotEmpty => isNotNull && getValueOrDefault.isNotEmpty;

  bool get isEmpty => isNull || getValueOrDefault.isEmpty;

  String get getValueOrDefault => this ?? "";

  String get justReplace => getValueOrDefault.replaceAll(".", ',');

  String get parsedPhoneNumberFromError =>
      getValueOrDefault.replaceAll(RegExp(r'[^\d]'), '').substring(1);

  ///Check for sequential or repeated characters (3 times)
  bool get containsSequentialOrRepeatedCharacters {
    final sequentialPattern = RegExp(r'(012|123|234|345|456|567|678|789|890)');
    final repeatedPattern = RegExp(r'(\d)\1\1');
    return sequentialPattern.hasMatch(getValueOrDefault) ||
        repeatedPattern.hasMatch(getValueOrDefault);
  }

  /// Check for both letters and digits
  bool get checkBothLettersAndDigits {
    final hasLetter = getValueOrDefault.contains(RegExp(r'[a-zA-Z]'));
    final hasDigit = getValueOrDefault.contains(RegExp(r'\d'));
    return !hasLetter || !hasDigit;
  }

  int get toInt => int.tryParse(getValueOrDefault) ?? 0;

  String get replaceClear => getValueOrDefault.replaceAll(' ', '');

  String get clear => '';

  Color get toColor {
    final cleaned = getValueOrDefault.trim();

    final numberStart = RegExp(r'^[1-9]');
    if (numberStart.hasMatch(cleaned) || cleaned.startsWith('+')) {
      return AppColors.green50;
    }

    return AppColors.textPrimary;
  }

  bool minLenght(int length) =>
      this != null && getValueOrDefault.length >= length;

  bool isMinMaxBetween(int minLenght, int maxLength) {
    return getValueOrDefault.length < minLenght ||
        getValueOrDefault.length > maxLength;
  }

  bool isNotEqual(String value) {
    return getValueOrDefault != value;
  }

  DateTime get parseStringToDate {
    return DateTime.parse(getValueOrDefault);
  }

  DateTime? get tryParseStringToDate {
    return DateTime.tryParse(getValueOrDefault);
  }

  // capitilaize all first letter of sencetence
  String? get capitalise {
    return this
        ?.split(' ')
        .map<String>((e) => e.toLowerCase())
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ');
  }

  String? removeLastPattern(String pattern) {
    if (isEmpty || pattern.isEmpty) return this;

    if (getValueOrDefault.length < pattern.length) return this;

    final lastPart = getValueOrDefault.substring(
      getValueOrDefault.length - pattern.length,
    );
    return lastPart == pattern
        ? getValueOrDefault.substring(
          0,
          getValueOrDefault.length - pattern.length,
        )
        : this;
  }

  String get formatRate {
    try {
      double value = double.parse(getValueOrDefault);
      String formattedValue = value.toStringAsFixed(2);
      return formattedValue;
    } catch (e) {
      return "-";
    }
  }
}
