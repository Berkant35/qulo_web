import 'package:catchpad/models/enums/game/game_end_type.dart';
import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/models/game/static_game_setup_model.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_selection.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SensorTypeSetupWidgetV2 extends ConsumerStatefulWidget {
  const SensorTypeSetupWidgetV2({
    super.key,
  });

  @override
  ConsumerState createState() => _SensorTypeSetupWidgetV2State();
}

class _SensorTypeSetupWidgetV2State
    extends ConsumerState<SensorTypeSetupWidgetV2> {
  // Contains sensors...
  List<UsedSensorsType> gameLimitSensors = [];
  UsedSensorsType? selected;
  bool isExpanded = false;
  bool sensitivitySettingsIsExpanded = false;
  bool distanceSettingsIsExpanded = false;
  final key = CacheSetupKeys.sensor.name;

  @override
  Widget build(BuildContext context) {
    ref.read(currentGameProv.notifier).setSetup(StaticGameSetupModel(
        type: GameEndType.duration,
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.uncatchCount,
        sensorTypes: {UsedSensorsType.distance: true}));

    

    final inst = L10n.inst(context);
    final setup = ref.watch(currentGameSetupProv)!;
    final game = ref.watch(currentGameMetaDataProv)!;

    gameLimitSensors = setup.sensorTypes.entries.map((e) => e.key).toList();
    final UsedSensorsType userSensorType =
        setup.sensorTypes.keys.elementAt(setup.chosedSensorIndex);

    selected ??= userSensorType;

    return CustomCatchpadSelections.buildSelectSensor(
        ref: ref,
        context: context,
        isExpanded: isExpanded,
        sensitivitySettingsIsExpanded: sensitivitySettingsIsExpanded,
        distanceSettingsIsExpanded: distanceSettingsIsExpanded,
        onTapHeaderIcon: (val) {
          setState(() {
            selected = val;
          });
          setSensorType(gameLimitSensors.indexOf(val), ref, gameId: game.id);
        },
        onExpandedFunction: (val) {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        onSensitivityExpanded: (val) {
          setState(() {
            sensitivitySettingsIsExpanded = !sensitivitySettingsIsExpanded;
          });
        },
        onDistanceExpanded: (val) {
          print("On Distance: $val");
          setState(() {
            distanceSettingsIsExpanded = !distanceSettingsIsExpanded;
          });
        });
  }

  setSensorType(int value, WidgetRef ref,
      {StaticGameSetupModel? setup, required String gameId}) {
    final setup = ref.watch(currentGameSetupProv)!;
    final newSetup = setup.copyWith(chosedSensorIndex: value);
    ref.read(currentGameProv.notifier).setSetup(newSetup);
    logger.i(selected);
    ref.read(currentCacheSetupManager.notifier).setSensorCache(ref,
        whichSetupKey: key, gameId: gameId, val: selected!);
  }
}
