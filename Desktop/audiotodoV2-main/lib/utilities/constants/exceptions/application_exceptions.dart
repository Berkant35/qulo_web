


import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/exceptions/exception_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationExceptions extends ExceptionBase {
   static handleRecordException(String errorMessage, WidgetRef ref,{String? title}) {
     logger.e("ApplicationExceptions @$errorMessage@");
     ExceptionBase.sendExceptionToServer("ApplicationExceptions", title: title, description: errorMessage);
  }
}


class VersionCustomException implements Exception {
  final String description;

  VersionCustomException(this.description);

  @override
  String toString() {
    return '$this $description';
  }
}
