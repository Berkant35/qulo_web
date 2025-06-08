import 'package:flutter/foundation.dart';

abstract class IError {
  /// Gelen bir hatayı error provider'a raporlar.
  ///
  /// [error]: Yakalanan hata nesnesi.
  /// [stackTrace]: İlgili stack trace bilgisi (opsiyonel).
  Future<void> reportError(Object error, [StackTrace? stackTrace, bool fatal = false]);

  bool get supported => !kDebugMode;
}
