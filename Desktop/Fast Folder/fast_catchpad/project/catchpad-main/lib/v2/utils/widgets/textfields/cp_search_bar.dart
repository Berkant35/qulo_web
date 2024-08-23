import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CpSearchBar extends ConsumerStatefulWidget {
  final TextEditingController? controller;
  const CpSearchBar({this.controller, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<CpSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
          hintText: 'Ara',
          hintStyle: const TextStyle(color: CpColors.cpWolfram, fontSize: 20)),
    );
  }
}
