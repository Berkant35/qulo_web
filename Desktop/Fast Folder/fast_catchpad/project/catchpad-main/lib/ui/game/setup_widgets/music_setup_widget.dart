import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game/attachment/attachment.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../widgets/multi_chip_selector.dart';

class MusicSetupWidget extends ConsumerWidget {
  const MusicSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final music = controls.gameMusicSelectionSetup;

    if (music == null) {
      assert(false);
      return const SizedBox();
    }

    return MultiChipSelector<Attachment>(
      onChange: (e) {
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  gameMusicSelectionSetup: music.copyWith(
                    selectedMusics: e,
                  ),
                ),
              ),
            );
      },
      min: 1,
      max: 1,
      allElements: music.selectableMusics,
      selectedElements: music.selectedMusics,
      disabledElements: const {},
      getId: (e) => e.id,
      getLabel: (e) => e.fileName,
    );
  }
}
