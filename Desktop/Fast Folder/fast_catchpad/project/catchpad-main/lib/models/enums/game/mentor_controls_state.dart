import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';

/// wether the mentor should have pausing, resuming
/// permissions etc.
enum MentorControlsState {
  deny,
  ask,
  allow;

  bool get isAsk => this == ask;
  bool get isAllowed => this == allow;
  bool get isDenied => this == deny;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case allow:
        return inst.mentor_controls_state_mentor;
      case deny:
        return inst.mentor_controls_state_auto;
      case ask:
        return inst.mentor_controls_state_ask;
    }
  }

  bool satisfiesAllConditions(WidgetRef ref) {
    return !isAsk;
  }
}
