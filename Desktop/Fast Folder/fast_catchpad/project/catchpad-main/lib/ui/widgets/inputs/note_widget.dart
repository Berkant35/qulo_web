import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../../utils/l10n/l10n.dart';


class NoteWidget extends ConsumerStatefulWidget {
  bool isLoading;
  NoteWidget({super.key, this.isLoading = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends ConsumerState<NoteWidget> {
  void _changeLoading() {
    widget.isLoading = !widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: context.padding.onlyTopHigh,
            child: const TextField(
              maxLength: 500,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Note',
                  alignLabelWithHint: true),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _changeLoading();
              });
            },
            icon: widget.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ))
                : const SizedBox.shrink(),
            label: const Text('Notu Kaydet'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => CpColors.bgGC2),
                shape: MaterialStateProperty.resolveWith((states) =>
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))))),
          ),
        ],
      ),
    ));
  }
}
