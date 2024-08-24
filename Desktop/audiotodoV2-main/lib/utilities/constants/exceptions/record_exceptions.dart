import 'package:audiotodo/utilities/constants/exceptions/exception_base.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordExceptions extends ExceptionBase {
  static handleRecordException(String errorMessage, WidgetRef ref,{String? title}) {
    ExceptionBase.sendExceptionToServer("RecordExceptions", title: title, description: errorMessage);
  }
}