import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../utils/l10n/l10n.dart';
import '../../../../widgets/multi_chip_selector.dart';

class AudioGameAudioSetupWidget extends ConsumerWidget {
  const AudioGameAudioSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final audioStatus = controls.gameAudioControls;

    // some games do not wanna setup audio status,
    // in the ui we wanna show this widget but in
    // a completely disabled way.
    final gameAudioSetup = audioStatus?.gameAudioSetup;
    final isAvailable = gameAudioSetup != null;
    final isEnabled = isAvailable && gameAudioSetup.isEnabled == true;
    final isChangable = isAvailable && gameAudioSetup.isChangable == true;
    final selectionIsDisabled = !isAvailable || !isChangable;

    const allEls = {true, false};

    return MultiChipSelector<bool>(
      onChange: (e) {
        final val = e.elementAt(0);
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  gameAudioControls: audioStatus?.copyWith(
                    gameAudioSetup: gameAudioSetup?.copyWith(
                      isEnabled: val,
                    ),
                  ),
                ),
              ),
            );
      },
      min: isAvailable ? 1 : 0,
      max: isAvailable ? 1 : 0,
      allElements: allEls,
      selectedElements: isAvailable
          ? {
              isEnabled,
            }
          : {},
      disabledElements: selectionIsDisabled ? allEls : const {},
      getId: (e) => e.toString(),
      getLabel: (e) => e
          ? L10n.inst(context).game_ui_audio_status_enabled
          : L10n.inst(context).game_ui_audio_status_disabled,
    );
  }
}
