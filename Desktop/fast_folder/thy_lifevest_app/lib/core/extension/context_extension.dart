import 'dart:ui';

import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double get space4 => 4;

  double get space4W => 4;

  double get space8 => 8;

  double get space8W => 8;

  double get space12 => 12;

  double get space12W => 12;

  double get space16 => 16;

  double get space16W => 16;

  double get space32 => 32;

  double get space32W => 32;
}

extension ModalRouteExtension on BuildContext {
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;

  bool get hasErrorFormState =>
      findAncestorStateOfType<FormFieldState>()?.hasError ?? false;
}

extension InsetsExtension on BuildContext {
  bool get isKeyboardOpen =>
      PlatformDispatcher.instance.views.first.viewInsets.bottom > 0;
}
