import 'package:flutter/services.dart';

class AppTextInputFormatters {
  static final AppTextInputFormatters _instance =
      AppTextInputFormatters._init();

  AppTextInputFormatters._init();

  factory AppTextInputFormatters() {
    return _instance;
  }

  final _lengthLimitingTextInputFormatter11 = LengthLimitingTextInputFormatter(
    11,
  );

  final _denyFirstlyZero = FilteringTextInputFormatter.deny(RegExp(r'^0+'));

  final _digitsOnly = FilteringTextInputFormatter.digitsOnly;

  final _charactersOnly = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-ZçÇşŞıİğĞöÖüÜ\s]+'),
  );

  final _lengthLimitingTextInputFormatter2 = LengthLimitingTextInputFormatter(
    2,
  );

  final _lengthLimitingTextInputFormatter4 = LengthLimitingTextInputFormatter(
    4,
  );
  final _between1and31 = FilteringTextInputFormatter.allow(
    RegExp(r'^(3[01]|[12][0-9]|[1-9])$'),
  );

  List<TextInputFormatter> get identificationNumber {
    return [_lengthLimitingTextInputFormatter11, _digitsOnly];
  }

  List<TextInputFormatter> get day {
    return [
      _digitsOnly,
      _denyFirstlyZero,
      _lengthLimitingTextInputFormatter2,
      _between1and31,
    ];
  }

  List<TextInputFormatter> get year {
    return [_digitsOnly, _denyFirstlyZero, _lengthLimitingTextInputFormatter4];
  }

  List<TextInputFormatter> get number {
    return [_digitsOnly];
  }

  List<TextInputFormatter> get name {
    return [_charactersOnly];
  }

  get denyFirstlyZero => FilteringTextInputFormatter.deny(RegExp(r'^0+'));
}
