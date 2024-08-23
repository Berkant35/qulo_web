

import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ValueOfKeyboardSetupWidget extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  const ValueOfKeyboardSetupWidget({
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ValueOfKeyboardSetupWidgetState();
}

class _ValueOfKeyboardSetupWidgetState extends ConsumerState<ValueOfKeyboardSetupWidget> {
  late TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _valueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _valueController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return L10n.inst(context).classes_screen_empty_field;
        }
        return null;
      },
      keyboardType: ref.read(currentGameSetupProv)!.keyboardType,
      onChanged: (value) {
        final newSetup = ref
            .read(currentGameSetupProv)!
            .copyWith(keyboardValue: value);
        ref.read(currentGameProv.notifier).setSetup(newSetup);
      },

    );
  }
}


