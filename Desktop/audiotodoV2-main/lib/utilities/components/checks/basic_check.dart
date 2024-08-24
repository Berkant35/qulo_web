import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class BasicCheck extends ConsumerStatefulWidget {
  final Function(bool checked) onCheck;
  final String explain;

  const BasicCheck({
    required this.onCheck,
    required this.explain,
    super.key,
  });

  @override
  ConsumerState createState() => _BasicCheckState();
}

class _BasicCheckState extends ConsumerState<BasicCheck> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: checked,
          checkColor: CustomColors.fillWhiteColor,
          hoverColor: CustomColors.accentColor,
          activeColor: CustomColors.accentColor,
          onChanged: (bool? newValue) {
            setState(() => checked = newValue ?? false);
            widget.onCheck(newValue ?? false);
          },
        ),
        Text(
          widget.explain,
          style: ThemeValueExtension.subtitle,
        )
      ],
    );
  }
}
