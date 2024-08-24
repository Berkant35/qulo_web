import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/exceptions/exception_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDioExceptions extends ExceptionBase {
  static const undefined = "undefined";

  static handleDioExceptions(String errorMessage, WidgetRef ref,
      {String? title}) {
    ExceptionBase.sendExceptionToServer("CustomDioExceptions", title: title, description: errorMessage);
  }
}
