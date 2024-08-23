import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../utils/l10n/l10n.dart';
import '../../../../widgets/multi_chip_selector.dart';

class AudioMusicSetupWidget extends ConsumerWidget {
  const AudioMusicSetupWidget({
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
    final musSetup = audioStatus?.musicSetup;
    final isAvailable = musSetup != null;
    final isEnabled = isAvailable && musSetup.isEnabled == true;
    final isChangable = isAvailable && musSetup.isChangable == true;
    final selectionIsDisabled = !isAvailable || !isChangable;

    const allEls = {true, false};

    return MultiChipSelector<bool>(
      onChange: (e) {
        final val = e.elementAt(0);
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  gameAudioControls: audioStatus?.copyWith(
                    musicSetup: musSetup?.copyWith(
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
