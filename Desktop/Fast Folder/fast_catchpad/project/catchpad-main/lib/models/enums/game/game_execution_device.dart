import 'package:flutter/widgets.dart';

import '../../../utils/l10n/l10n.dart';

enum GameExecutionDevice {
  app,
  pads;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case app:
        return inst.game_execution_device_enum_app;
      case pads:
        return inst.game_execution_device_enum_pads;
    }
  }
}
