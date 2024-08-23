import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cp_colors.dart';

class DeletableListtile extends ConsumerWidget {
  final String number;
  final String tileTitle;
  final List<Widget> children;
  final VoidCallback onDelete;

  const DeletableListtile({
    super.key,
    required this.children,
    required this.number,
    required this.tileTitle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              clipBehavior: Clip.hardEdge,
              child: ExpansionTile(
                  backgroundColor: CpColors.defBgColor,
                  collapsedBackgroundColor: CpColors.defBgColor,
                  leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: CpColors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(child: Text(number))),
                  trailing: const Icon(Icons.arrow_drop_down),
                  title: Text(tileTitle),
                  children: children)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IconButton(onPressed: onDelete, icon: const Icon(Icons.clear)),
        )
      ],
    );
  }
}
