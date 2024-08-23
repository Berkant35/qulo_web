import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CpSearchBarFilterIcon extends ConsumerStatefulWidget {
  final double? height;
  final TextEditingController? controller;
  const CpSearchBarFilterIcon({this.height, this.controller, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CpSearchBarFilterIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 0, color: CpColors.cpWolfram),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(width: 1, color: CpColors.cpPrimary),
            ),
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(
              Icons.search,
              color: CpColors.cpWolfram,
            ),
            suffixIconConstraints: BoxConstraints.tight(
                Size(widget.height ?? 48, widget.height ?? 48)),
            suffixIcon: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: CpColors.cpPrimary,
                child: CatchpadIconsV2.filter,
              ),
            ),
            hintText: 'Ara',
            hintStyle:
                const TextStyle(color: CpColors.cpWolfram, fontSize: 20)),
      ),
    );
  }
}
