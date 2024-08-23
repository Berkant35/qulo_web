import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

enum MathOperation {
  add,
  subtract,
  multiply,
  divide;

  String get symbolNotation {
    switch (this) {
      case MathOperation.add:
        return '+';
      case MathOperation.subtract:
        return '-';
      case MathOperation.multiply:
        return '×';
      case MathOperation.divide:
        return '÷';
    }
  }

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case add:
        return inst.operation_enum_add;
      case subtract:
        return inst.operation_enum_subtract;
      case multiply:
        return inst.operation_enum_multiply;
      case divide:
        return inst.operation_enum_divide;
    }
  }

  /// the result is not guaranteed to be
  /// a non-null value, because we do not have one
  /// if divide is not exact (e.g. 6/4 = 1.5)
  int? apply(List<int> nums) {
    if (this == MathOperation.subtract || this == MathOperation.divide) {
      nums.sort((a, b) => b.compareTo(a));
    }

    switch (this) {
      case MathOperation.add:
        return nums.reduce((a, b) => a + b);
      case MathOperation.multiply:
        return nums.reduce((a, b) => a * b);

      case MathOperation.subtract:
        return nums.reduce((a, b) => a - b);
      case MathOperation.divide:
        bool undividable = false;

        final res = nums.reduce(
          (a, b) {
            if (a % b != 0) {
              undividable = true;
            }
            return a ~/ b;
          },
        );

        if (undividable) {
          return null;
        }

        return res;
    }
  }
}
