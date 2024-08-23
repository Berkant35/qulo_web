import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/game/game_controls_setup.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../widgets/multi_chip_selector.dart';

class ExecutionDevicesSetupWidget extends ConsumerWidget {
  const ExecutionDevicesSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final devices = controls.gameExecutionDevicesSelectionSetup;

    if (devices == null) {
      assert(false);
      return const SizedBox();
    }

    return MultiChipSelector<GameExecutionDevice>(
      onChange: (e) {
        ref.read(currentGameProv.notifier).setSetup(setup.copyWith(
              controlsSetup: controls.copyWith(
                gameExecutionDevicesSelectionSetup: devices.copyWith(
                  selectedDevices: e,
                ),
              ),
            ));
      },
      min: 1,
      allElements: GameExecutionDevice.values.toSet(),
      selectedElements: devices.selectedDevices,
      disabledElements: const {},
      getId: (e) => e.name,
      getLabel: (e) => e.textNotation(context),
    );
  }
}
