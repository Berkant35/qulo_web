import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/enums/game/mentor_controls_state.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../widgets/multi_chip_selector.dart';

class MentorControlsSetupWidget extends ConsumerWidget {
  const MentorControlsSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final mentorControls = controls.mentorControlsState;

    return MultiChipSelector<MentorControlsState>(
      onChange: (e) {
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  mentorControlsState: e.elementAt(0),
                ),
              ),
            );
      },
      min: 1,
      max: 1,
      allElements: const {
        MentorControlsState.allow,
        MentorControlsState.deny,
      },
      selectedElements: {mentorControls},
      disabledElements: const {},
      getId: (e) => e.name,
      getLabel: (e) => e.textNotation(context),
    );
  }
}
