import 'dart:core';

import 'package:intl/intl.dart';
import 'package:thy_lifevest_app/core/constant/app_constant.dart';
import 'package:thy_lifevest_app/core/constant/app_strings.dart';

extension CustomTimeFormat on DateTime {
  String get queryDayAndHHmm {
    return "${_addLeadingZero(day)}-${_addLeadingZero(month)}-$year ${_addLeadingZero(hour)}:${_addLeadingZero(minute)}";
  }

  String get nameDayAndHHmm {
    final weekDay = _getWeekDayName(weekday);
    return "$weekDay, ${_addLeadingZero(hour)}:${_addLeadingZero(minute)}";
  }

  String get forceExpirationServerFormat {
    return "$year-${_addLeadingZero(month)}-${_addLeadingZero(day)} ${_addLeadingZero(hour)}:${_addLeadingZero(minute)}";
  }

  String get forceddMMyyyy {
    return "${_addLeadingZero(day)}-${_addLeadingZero(month)}-$year";
  }

  String get ddMMyyyy {
    return "${_addLeadingZero(day)}-${_addLeadingZero(month)}-$year";
  }

  String get ddMMyyyyDotSeperated {
    return "${_addLeadingZero(day)}.${_addLeadingZero(month)}.$year";
  }

  String get formattedAsDdMmYyyyWithSlashes {
    return "${_addLeadingZero(day)}/${_addLeadingZero(month)}/$year";
  }

  String get timeHour {
    return "${_addLeadingZero(hour)}:${_addLeadingZero(minute)}";
  }

  String get hhmmss {
    return "${_addLeadingZero(hour)}:${_addLeadingZero(minute)}:${_addLeadingZero(second)}";
  }

  String ddMMMMYYYY({String separator = ' '}) {
    return DateFormat(
      'dd MMMM yyyy',
      AppConstants.locale.languageCode,
    ).format(this).replaceAll(' ', separator);
  }

  String get ddMMMMhhmm {
    return DateFormat(
      'dd MMMM $hhmm',
      AppConstants.locale.languageCode,
    ).format(this);
  }

  String get ddMMDotSeperated {
    return DateFormat('dd.MM', AppConstants.locale.languageCode).format(this);
  }

  String get dayNameAndDate {
    final weekDay = _getWeekDayName(weekday);
    return "$weekDay, ${_addLeadingZero(day)}-${_addLeadingZero(month)}-$year";
  }

  String get nowTimeTextddMMyyyyHHmm {
    final now = DateTime.now();
    return "${_addLeadingZero(now.day)}-${_addLeadingZero(now.month)}-${now.year} ${_addLeadingZero(now.hour)}:${_addLeadingZero(now.minute)}";
  }

  String get yyyyMMdd {
    return "$year-${_addLeadingZero(month)}-${_addLeadingZero(day)}";
  }

  String ddMMyyyyAndTime({String separator = ' | '}) {
    return "$ddMMyyyy$separator$timeHour";
  }

  String get hhmm {
    return "${_addLeadingZero(hour)}:${_addLeadingZero(minute)}";
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return AppStrings.monday;
      case DateTime.tuesday:
        return AppStrings.tuesday;
      case DateTime.wednesday:
        return AppStrings.wednesday;
      case DateTime.thursday:
        return AppStrings.thursday;
      case DateTime.friday:
        return AppStrings.friday;
      case DateTime.saturday:
        return AppStrings.saturday;
      case DateTime.sunday:
        return AppStrings.sunday;
      default:
        return "";
    }
  }

  bool get isUnder18 {
    final now = DateTime.now();
    final age = now.year - year;
    if (age < 18) {
      return true;
    } else if (age == 18) {
      if (now.month < month) {
        return true;
      } else if (now.month == month) {
        if (now.day < day) {
          return true;
        }
      }
    }
    return false;
  }

  bool get isToday {
    final now = DateTime.now();

    return now.year == year && now.month == month && now.day == day;
  }

  bool get isYesterday {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return yesterday.year == year &&
        yesterday.month == month &&
        yesterday.day == day;
  }

  String get dayValue {
    if (isToday) {
      return "${AppStrings.toDay} $hhmm";
    }

    if (isYesterday) {
      return "${AppStrings.yesterday} $hhmm";
    }

    return ddMMMMhhmm;
  }

  String get dayName {
    if (isToday) {
      return AppStrings.toDay;
    }
    if (isYesterday) {
      return AppStrings.yesterday;
    }

    switch (weekday) {
      case DateTime.monday:
        return AppStrings.monday;
      case DateTime.tuesday:
        return AppStrings.tuesday;
      case DateTime.wednesday:
        return AppStrings.wednesday;
      case DateTime.thursday:
        return AppStrings.thursday;
      case DateTime.friday:
        return AppStrings.friday;
      case DateTime.saturday:
        return AppStrings.saturday;
      case DateTime.sunday:
        return AppStrings.sunday;
      default:
        return "";
    }
  }
}

extension DurationExtension on Duration {
  String get formatDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  //19dk 53sn formatDuration
  String get formatDurationWithLocale {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "$twoDigitMinutes${AppStrings.minuteAbbreviation} $twoDigitSeconds${AppStrings.secondAbbreviation}";
  }
}
