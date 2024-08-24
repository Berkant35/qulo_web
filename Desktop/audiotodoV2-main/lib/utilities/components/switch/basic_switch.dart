import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/custom_colors.dart';

class BasicSwitch extends ConsumerWidget {
  final String content;
  final Function(bool) onChanged;
  final bool switchValue;
  const BasicSwitch({required this.switchValue,required this.content,required this.onChanged,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Switch(
            value: switchValue,
            onChanged: (val)=>onChanged(val),
            activeTrackColor: CustomColors.primaryColor,
            inactiveThumbColor: CustomColors.profileGreyColor,
            inactiveTrackColor: CustomColors.grey2Color,
            thumbColor: CustomColors.fillWhiteColorM,
        ),
        Text(content,style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w400
        ),)
      ],
    );
  }
}
