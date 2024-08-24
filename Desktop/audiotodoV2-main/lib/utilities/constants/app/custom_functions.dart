


import '../../../generated/l10n.dart';

class CustomFunctions {
  static String formatMilliseconds(int milliseconds) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    Duration duration = Duration(milliseconds: milliseconds);
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  static String getWeekdayFromInt(int dayNumber) {
    String weekday;

    switch (dayNumber) {
      case 1:
        weekday = S.current.monday;
        break;
      case 2:
        weekday = S.current.tuesday;
        break;
      case 3:
        weekday = S.current.wednesday;
        break;
      case 4:
        weekday = S.current.thursday;
        break;
      case 5:
        weekday = S.current.friday;
        break;
      case 6:
        weekday = S.current.saturday;
        break;
      case 7:
        weekday = S.current.friday;
        break;
      default:
        weekday = S.current.monday;
    }

    return weekday;
  }
}