import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:thy_lifevest_app/core/error/failure.dart';

class UIState<T> {
  late UIStateStatus status;
  late T data;
  late Failure failure;

  UIState.idle() : status = UIStateStatus.idle;

  UIState.loading() : status = UIStateStatus.loading;

  UIState.success(this.data) : status = UIStateStatus.success;

  UIState.error(
    this.failure, {
    StackTrace? stackTrace,
    bool logException = true,
  }) {
    status = UIStateStatus.error;
    if (logException) {
      log(logException.toString());
    }

    // sl<ExceptionLogger>().captureException(failure, stackTrace: stackTrace);
  }
}

enum UIStateStatus { idle, loading, success, error }

extension UIStateStatusExtension on UIStateStatus {
  bool get isIdle => this == UIStateStatus.idle;

  bool get isLoading => this == UIStateStatus.loading;

  bool get isSuccess => this == UIStateStatus.success;

  bool get isError => this == UIStateStatus.error;

  Widget when({
    required Widget Function() loading,
    required Widget Function() success,
    required Widget Function() error,
    required Widget Function() orElse,
  }) {
    switch (this) {
      case UIStateStatus.loading:
        return loading();
      case UIStateStatus.success:
        return success();
      case UIStateStatus.error:
        return error();
      default:
        return orElse();
    }
  }
}
