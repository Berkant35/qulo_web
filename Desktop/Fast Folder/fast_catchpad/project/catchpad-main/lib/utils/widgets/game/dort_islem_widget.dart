import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/enums/game/math_operation.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../utils.dart';

final operationColorsProv =
    StateProvider<Map<MathOperation, Color>>((ref) => {});

class DortIslemWidget extends ConsumerWidget {
  final MapEntry<MathOperation, List<int>> combination;
  const DortIslemWidget({
    required this.combination,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final operation = combination.key;
    final numbers = combination.value;

    final operationColors = ref.watch(operationColorsProv);

    final setup = ref.read(currentGameSetupProv)!;
    final controls = setup.controlsSetup;
    final executionDevicesSetup = controls.gameExecutionDevicesSelectionSetup!;

    return Column(
      children: [
        if (executionDevicesSetup.isPlayableOnPads)
          Wrap(
            children: operationColors.entries
                .map(
                  (e) => Text(
                    e.key.symbolNotation,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: e.value,
                        ),
                  ),
                )
                .joinWidgetList(
                  (e) => const SizedBox(
                    width: defPaddingSize * 2,
                  ),
                ),
          ),
        if (executionDevicesSetup.isPlayableOnApp)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: numbers
                .map(
                  (e) => Text(
                    e.toString(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
                .joinWidgetList(
                  (e) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: defPaddingSize),
                    child: Text(
                      operation.symbolNotation,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
          ),
      ],
    );
  }
}
