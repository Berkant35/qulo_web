import 'package:audiotodo/generated/l10n.dart';
import 'package:intl/intl.dart';

extension CustomTimeFormat on DateTime {
  String get queryDayAndHHmm => DateFormat('dd-MM-yyyy HH:mm').format(this);

  String get nameDayAndHHmm => S.current.language_code == 'en'
      ? DateFormat('EEEE, hh:mm a').format(this)
      : DateFormat('EEEE, HH:mm').format(this);

  String get forceExpirationServerFormat => DateFormat('yyyy-MM-dd HH:mm').format(this);

  String get forceddMMyyyy => DateFormat('dd-MM-yyyy').format(this);

  String get ddMMyyyy => S.current.language_code == 'en'
      ? DateFormat('MM-dd-yyyy').format(this) // Amerikan formatı: MM-dd-yyyy
      : DateFormat('dd-MM-yyyy').format(this);

  String get timeHour => S.current.language_code == 'en'
      ? DateFormat('hh:mm a').format(this)
      : DateFormat('HH:mm').format(this);

  String get dayNameAndDate => S.current.language_code == 'en'
      ? DateFormat('EEEE, MM-dd-yyyy')
          .format(this) // Amerikan formatı: EEEE, MM-dd-yyyy
      : DateFormat('EEEE, dd-MM-yyyy').format(this);

  String get nowTimeTextddMMyyyyHHmm => S.current.language_code == 'en'
      ? DateFormat('MM-dd-yyyy hh:mm a')
          .format(DateTime.now()) // Amerikan formatı: MM-dd-yyyy hh:mm a
      : DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

  String dayDifference() {
    final now = DateTime.now();
    final difference = now.difference(this).inDays;

    if (difference == 0) {
      return S.current.today;
    } else if (difference == 1) {
      return S.current.yesterday;
    } else {
      return DateFormat('dd-MM-yyyy').format(this);
    }
  }
}

extension MonthNameExtension on int {
  String get monthNameByNumber {
    switch (this) {
      case 1:
        return S.current.january;
      case 2:
        return S.current.february;
      case 3:
        return S.current.march;
      case 4:
        return S.current.april;
      case 5:
        return S.current.may;
      case 6:
        return S.current.june;
      case 7:
        return S.current.july;
      case 8:
        return S.current.august;
      case 9:
        return S.current.september;
      case 10:
        return S.current.october;
      case 11:
        return S.current.november;
      case 12:
        return S.current.december;
      default:
        return '';
    }
  }
}

extension GetDateTimeFromSpecialFormat on String {
  DateTime fromddMMyyyy(String text) {
    try {
      return DateFormat("dd-MM-yyyy").parse(text);
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get fromddMMyyyyDate => DateFormat("dd-MM-yyyy").parse(this);
  DateTime get fromddMMyyyyDateSecond => DateFormat("yyyy-MM-dd").parse(this);

  DateTime get fromddMMyyyyHHmmToDateTime {
    final bool isEnglish = S.current.language_code == 'en';

    // Determine if the string appears to be in 24-hour format
    final bool is24HourFormat =
        RegExp(r'\d{2}-\d{2}-\d{4} \d{2}:\d{2}').hasMatch(this);

    final String format =
        is24HourFormat ? "dd-MM-yyyy HH:mm" : "dd-MM-yyyy hh:mm a";

    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      throw FormatException(
          "Invalid date format: $this. Expected format: $format");
    }
  }
}
