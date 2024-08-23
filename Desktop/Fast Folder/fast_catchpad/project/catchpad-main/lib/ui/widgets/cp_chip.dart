import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/cp_colors.dart';

class CpChip extends StatelessWidget {
  final String text;
  final bool? initialSelected;
  final bool isTogglable;
  final void Function(bool)? onSelected;
  final double? fontSize;

  const CpChip({
    required this.text,
    this.initialSelected,
    this.onSelected,
    this.fontSize,
    this.isTogglable = true,
    Key? key,
  }) : super(key: key);

  bool get selected => initialSelected == true;

  @override
  Widget build(BuildContext context) {
    final label = AutoSizeText(
      text,
      maxLines: 1,
      textScaleFactor: (MediaQuery.of(context).size.width > 600)
          ? MediaQuery.of(context).size.width * 0.0008
          : MediaQuery.of(context).size.width * 0.0018,
      style: TextStyle(fontSize: fontSize),
    );
    if (isTogglable) {
      return ChoiceChip(
        disabledColor: selected
            ? CpColors.chipDisabledSelectedColor
            : CpColors.chipDisabledUnselectedColor,
        label: label,
        onSelected: onSelected,
        selected: selected,
      );
    }

    return Chip(
      label: label,
      backgroundColor: CpColors.chipSelectedColor,
    );
  }
}
