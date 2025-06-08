import 'package:flutter/cupertino.dart';
import 'package:thy_lifevest_app/core/constant/api/base/error_dto.dart';
import 'package:thy_lifevest_app/core/extension/string_extension.dart';

class Failure {
  final String? errorText;
  final int? code;
  final String? errorTitle;
  final List<ErrorDto> errors;

  const Failure({
    this.errorText,
    this.code,
    this.errorTitle,
    this.errors = const [],
  });

  String get message => errorText.getValueOrDefault;
}
