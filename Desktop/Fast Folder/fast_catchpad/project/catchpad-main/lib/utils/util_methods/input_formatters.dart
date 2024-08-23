import 'package:flutter/services.dart';
import 'package:regexpattern/regexpattern.dart';

class CustomInputFormatters {
  static TextInputFormatter onlyNumber = TextInputFormatter.withFunction((oldValue, newValue) {
    final isValid = newValue.text.isNumeric();

    if (isValid || newValue.text.isEmpty) return newValue;

    return oldValue;
  });
}
