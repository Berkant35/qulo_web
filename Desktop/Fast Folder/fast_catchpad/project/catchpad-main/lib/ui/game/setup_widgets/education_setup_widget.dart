import '../../../models/enums/game/education_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../prov/game/curr_game_prov.dart';
import '../../widgets/multi_chip_selector.dart';

class EducationSetupWidget extends ConsumerWidget {
  const EducationSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(currentGameSetupProv)!;
    final controls = setup.controlsSetup;

    final operation = controls.gameEducationTypeSelectionSetup;

    if (operation == null) {
      assert(false);
      return const SizedBox();
    }

    return MultiChipSelector<EducationType>(
      onChange: (e) {
        ref.read(currentGameProv.notifier).setSetup(
              setup.copyWith(
                controlsSetup: controls.copyWith(
                  gameEducationTypeSelectionSetup: operation.copyWith(
                    selectedOperations: e,
                  ),
                ),
              ),
            );
      },
      min: 1,
      max: 1,
      allElements: EducationType.values.toSet(),
      selectedElements: operation.selectedOperations,
      disabledElements: const {},
      getId: (e) => e.name,
      getLabel: (e) => e.textNotation(context),
    );
  }
}
