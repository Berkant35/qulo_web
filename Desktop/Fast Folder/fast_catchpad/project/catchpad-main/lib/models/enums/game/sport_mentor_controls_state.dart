import 'package:flutter/material.dart';
import '../../../utils/utils.dart';

/// wether the mentor should have pausing, resuming
/// permissions etc.
enum ExerciseOperation {
  selectAllPad,
  selectPadsDynamically,
  increaseOnePad;

  bool get isSelectAll => this == selectAllPad;
  bool get isSelectDynamically => this == selectPadsDynamically;
  bool get isIncreaseOnePad => this == increaseOnePad;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) { // TODO Fix inst returning string texts
      case selectAllPad:
        return inst.mentor_controls_state_auto;
      case selectPadsDynamically:
        return inst.mentor_controls_state_ask;
      case increaseOnePad:
        return inst.mentor_controls_state_ask;
    }
  }

}
