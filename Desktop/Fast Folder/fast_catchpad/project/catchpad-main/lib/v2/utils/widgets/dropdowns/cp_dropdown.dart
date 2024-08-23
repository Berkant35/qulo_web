import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CpDropdown extends ConsumerWidget {
  final List<String> items;
  const CpDropdown({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDropdown<String>(
      hintText: 'Seç',
      items: items,
      decoration: const CustomDropdownDecoration(
          closedFillColor: CpColors.cpDireWolf,
          expandedFillColor: CpColors.cpDireWolf,
          closedSuffixIcon:
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          expandedSuffixIcon:
              Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
          headerStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          listItemStyle: TextStyle(color: Colors.white)),
      onChanged: (value) {
      },
    );
  }
}
