import 'dart:math';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/l10n.dart';

export 'package:life_saver_extensions/life_saver_extensions.dart';

export 'consts.dart';
export 'l10n/l10n.dart';
export 'settings/app_settings_toggles.dart';

String twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

String formatBySeconds(Duration duration) =>
    twoDigits(duration.inSeconds.remainder(60));

String formatByMinutes(Duration duration) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return '$twoDigitMinutes:${formatBySeconds(duration)}';
}

String formatByHours(Duration duration) {
  return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
}

extension MeasuresInt on num {
  String cmStr(BuildContext context) => toString().cmStr(context);

  String mmStr(BuildContext context) => toString().mmStr(context);

  String sStr(BuildContext context) => toString().sStr(context);

  String msStr(BuildContext context) => toString().msStr(context);
}

extension Format on num {
  String msTommssSSS(BuildContext context) => DateFormat('mm:ss:SSS')
      .format(DateTime.fromMillisecondsSinceEpoch(toInt()));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MeasuresStr on String {
  String cmStr(BuildContext context) {
    return '$this ${L10n.inst(context).activity_distance_selection_cm_unit}';
  }

  String mmStr(BuildContext context) {
    return '$this ${L10n.inst(context).activity_distance_selection_mm_unit}';
  }

  String sStr(BuildContext context) {
    return '$this ${L10n.inst(context).activity_duration_selection_second_unit}';
  }

  String msStr(BuildContext context) {
    return '$this ${L10n.inst(context).activity_duration_selection_millisecond_unit}';
  }
}

extension TheTimeSystem on num {
  num get secToMs => this * 1000;

  num get msToSec {
    final val = this / 1000;

    if (this is int) {
      return val.round();
    }

    return val;
  }
}

extension TheMetricSystem on num {
  num get cmToMm => this * 10;

  num get mmToCm {
    final val = this / 10;

    if (this is int) {
      return val.round();
    }

    return val;
  }
}

extension CpDuration on Duration {
  String formatSecondsMilli(BuildContext context) {
    final int milsec = inMilliseconds % 1000;
    return [
      inSeconds,
      milsec.toString().padLeft(3, '0'),
      /* inMilliseconds
          .toString()
          .padRight(2, '0')
          .substring(0, 2), //TODO Fix this */
    ].join('.').sStr(context);
  }

  double durationToDoubleForGraph() {
    final textToParseDouble = [
      inSeconds,
      inMilliseconds.toString().padRight(2, '0').substring(0, 2),
    ].join('.');


    try {
      return double.parse(textToParseDouble);
    } catch (e) {
      return Random().nextDouble();
    }
  }

  operator /(num other) => Duration(
        microseconds: (inMicroseconds / other).round(),
      );
}

Duration parseDuration(String input, {String separator = '.'}) {
  final parts = input.split(separator).map((t) => t.trim()).toList();
  int? weeks;
  int? days;
  int? hours;
  int? minutes;
  int? seconds;
  int? milliseconds;
  int? microseconds;

  for (String part in parts) {
    final match = RegExp(r'^(\d+)(w|d|h|min|m|s|ms|us)$').matchAsPrefix(part);
    //if (match == null) throw const FormatException('Invalid duration format');
    if (match == null) return const Duration();

    int value = int.parse(match.group(1)!);
    String? unit = match.group(2);
    logger.d('value: $value, unit: $unit');
    switch (unit) {
      case 'w':
        if (weeks != null) {
          throw const FormatException('Weeks specified multiple times');
        }
        weeks = value;
        break;
      case 'd':
        if (days != null) {
          throw const FormatException('Days specified multiple times');
        }
        days = value;
        break;
      case 'h':
        if (hours != null) {
          throw const FormatException('Days specified multiple times');
        }
        hours = value;
        break;
      case 'min':
      case 'm':
        if (minutes != null) {
          throw const FormatException('Days specified multiple times');
        }
        minutes = value;
        break;
      case 's':
        if (seconds != null) {
          throw const FormatException('Days specified multiple times');
        }
        seconds = value;
        break;
      case 'ms':
        if (milliseconds != null) {
          throw const FormatException('Days specified multiple times');
        }
        milliseconds = value;
        break;
      case 'us':
        if (microseconds != null) {
          throw const FormatException('Days specified multiple times');
        }
        microseconds = value;
        break;
      default:
        throw FormatException('Invalid duration unit $unit');
    }
  }

  return Duration(
      days: (days ?? 0) + (weeks ?? 0) * 7,
      hours: hours ?? 0,
      minutes: minutes ?? 0,
      seconds: seconds ?? 0,
      milliseconds: milliseconds ?? 0,
      microseconds: microseconds ?? 0);
}
