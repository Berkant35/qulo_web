
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension CustomTimeFormat on DateTime {

  String get nameDayAndHHmm =>
      DateFormat('EEEE, HH:mm').format(this);

  String get ddMMyyyy =>
      DateFormat('dd-MM-yyyy').format(this);

  String get timeHour => DateFormat('HH:mm').format(this);

  String get dayNameAndDate =>
      DateFormat('EEEE, dd-MM-yyyy').format(this);

  String get nowTimeTextddMMyyyyHHmm =>
      DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

  String get nowTimeHHmmss =>
      DateFormat('HH:mm:ss').format(DateTime.now());

  String get nowTimeddMMyyyyHHmmss =>
      DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

}
extension ContextExt on BuildContext {
bool get isPhone => MediaQuery.of(this).size.width < 600.0;
bool get isTablet => MediaQuery.of(this).size.width >= 600.0;
}