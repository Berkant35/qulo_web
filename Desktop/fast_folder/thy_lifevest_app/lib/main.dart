import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'core/init/injection_container.dart' as locator;

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await locator.init();

      runApp(const THYLifevest());
    },
    (Object error, [StackTrace? stackTrace]) {
      debugPrint('Error caught in main: $error');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    },
  );
}
