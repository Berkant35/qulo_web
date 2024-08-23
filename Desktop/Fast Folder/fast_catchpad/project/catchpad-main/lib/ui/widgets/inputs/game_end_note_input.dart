import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameEndNoteInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const GameEndNoteInput({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState createState() => _GameEndNoteInputState();
}

class _GameEndNoteInputState extends ConsumerState<GameEndNoteInput> {


  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defPaddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defPaddingSize),
            child: Text(
              DateTime.now().nowTimeTextddMMyyyyHHmm,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          TextFormField(
            controller: widget.controller,
            decoration:  InputDecoration(
              hintText: inst.content_dialog_enter_your_note_here,
            ),
            maxLines: 5,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
