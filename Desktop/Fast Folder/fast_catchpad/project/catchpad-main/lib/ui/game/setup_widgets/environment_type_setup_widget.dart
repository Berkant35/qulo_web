import 'package:catchpad/models/enums/icon_paths.dart';
import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../../models/game/static_game_model.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../utils/l10n/l10n.dart';

enum EnvironmentType { indoor, outdoor }

class EnvironmentTypeSetupWidget extends ConsumerStatefulWidget {
  const EnvironmentTypeSetupWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SensorTypeSetupWidgetState();
}

class _SensorTypeSetupWidgetState
    extends ConsumerState<EnvironmentTypeSetupWidget> {
  final GlobalKey ctkey = GlobalKey();
  EnvironmentType? selected;
  late String gameId;
  final key = CacheSetupKeys.sensor.name;
  bool onceTime = false;
  List<EnvironmentType> list = [
    EnvironmentType.indoor,
    EnvironmentType.outdoor
  ];

  setSensorType(int value, WidgetRef ref, {StaticGameSetupModel? setup}) {
    final setup = ref.watch(currentGameSetupProv)!;
    final newSetup = setup.copyWith(chosedSensorIndex: value);
    ref.read(currentGameProv.notifier).setSetup(newSetup);
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final setup = ref.watch(currentGameSetupProv)!;
    gameId = ref.read(currentGameMetaDataProv)!.id;
    // selected ??= setup.environmentType;

    // it returns icon and name according sensore type
    List getIconAndNameAccordingCatchType(EnvironmentType? sensorsType) {
      switch (sensorsType) {
        case EnvironmentType.indoor:
          return [const Icon(Icons.home_filled), 'Kapali'];

        case EnvironmentType.outdoor:
          return [const Icon(Icons.terrain_rounded), 'Acik'];
        default:
          return [
            const Icon(Icons.terrain_rounded),
            inst.game_ui_device_sensor_none
          ];
      }
    }

    return DropdownButtonFormField<EnvironmentType>(
      dropdownColor: CpColors.appbarColor,
      key: ctkey,
      value: selected,
      items: list
          .map(
            (e) => DropdownMenuItem<EnvironmentType>(
              value: e,
              child: Row(
                children: [
                  getIconAndNameAccordingCatchType(e)[0],
                  Padding(
                    padding: context.padding.onlyLeftLow,
                    child: Text(getIconAndNameAccordingCatchType(e)[1]),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selected = value;
        });
        logger.i("Selected!! $selected");

        Future(() {
          setSensorType(list.indexOf(value), ref);
        });
      },
      borderRadius: BorderRadius.circular(10),
    );
  }
}
