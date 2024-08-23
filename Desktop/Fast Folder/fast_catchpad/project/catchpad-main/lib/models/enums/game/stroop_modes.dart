

import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum StroopModes {
  text,
  color;

  String textNotation(BuildContext context) {
  final inst = L10n.inst(context);

  switch (this) {
    case StroopModes.text:
      return inst.stroop_text;
    case StroopModes.color:
      return inst.stroop_color;
  }
}
}