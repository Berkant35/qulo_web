import 'package:catchpad/v2/utils/widgets/dropdowns/cp_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DropdownWithHeadline extends ConsumerWidget {
  final List<String> items;
  final String title;
  const DropdownWithHeadline(
      {required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Gap(1.h),
        CpDropdown(
          items: items,
        ),
      ],
    );
  }
}
