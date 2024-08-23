import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/enums/game/math_operation.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../widgets/multi_chip_selector.dart';

class OperationSetupWidget extends ConsumerWidget {
  const OperationSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final operation = controls.gameOperationSelectionSetup;

    if (operation == null) {
      assert(false);
      return const SizedBox();
    }

    return MultiChipSelector<MathOperation>(
      onChange: (e) {
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  gameOperationSelectionSetup: operation.copyWith(
                    selectedOperations: e,
                  ),
                ),
              ),
            );
      },
      min: 1,
      allElements: MathOperation.values.toSet(),
      selectedElements: operation.selectedOperations,
      disabledElements: const {},
      getId: (e) => e.name,
      getLabel: (e) => e.textNotation(context),
    );
  }
}
