import 'package:flutter/cupertino.dart';

import '../../utils/cp_colors.dart';

// we wanna use the CupertinoSwitch, however,
// there is no themeing option in ThemeData,
// so we have to implement a custom widget.
class CpSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  const CpSwitch({
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: CpColors.switchActiveColor,
      trackColor: CpColors.switchTrackColor,
    );
  }
}
