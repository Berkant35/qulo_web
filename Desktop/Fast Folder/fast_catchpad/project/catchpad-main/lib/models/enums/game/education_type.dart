import '../../../utils/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum EducationType {
  learn,
  read;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case learn:
        return inst.education_type_learn;
      case read:
        return inst.education_type_read;
    }
  }
}
