import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/utils/domain/i_error.dart';

class ErrorManager {
  final List<IError> _errors;

  ErrorManager(this._errors);

  Future<void> report(Object error, [StackTrace? stackTrace, bool fatal = false]) async {
    final futures = <Future<void>>[];

    for (var errorTracker in _errors) {
      if (errorTracker.supported) {
        final future = errorTracker.reportError(error, stackTrace, fatal).catchError((e) {
          debugPrint('[ErrorManager] Provider error ignored: $e');
        });
        futures.add(future);
      }
    }

    await Future.wait(futures);
  }
}
