import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../prov/global_providers.dart';
import '../../../utils/emb/iga/iga_consts.dart';

num selectedThresholdValue = 0;
bool isManuallyChanged = false;

class ThreshHoldValueSetupWidget extends ConsumerStatefulWidget {
  const ThreshHoldValueSetupWidget(
      {super.key,
      required this.usedSensorsType,
      required this.accConfigModel,
      this.isNewVersion = false});
  final UsedSensorsType usedSensorsType;
  final AccConfigModel? accConfigModel;

  final bool isNewVersion;

  @override
  ConsumerState createState() => _ThreshHoldValueSetupWidgetState();
}

class _ThreshHoldValueSetupWidgetState
    extends ConsumerState<ThreshHoldValueSetupWidget> {
  @override
  void initState() {
    getSliderData();
    super.initState();
  }

  late double min, max, def, defui;
  late int division;

  @override
  Widget build(BuildContext context) {
    final gameId = ref.read(currentGameProv)!.id;

    final key = CacheSetupKeys.sensitivity.name;

    dynamic cacheValue;

    Future(() {
      if(ref.context.mounted){
        cacheValue = ref.read(currentCacheSetupManager.notifier).getPerValue(ref,
            whichSetupKey: key,
            typeOfVal: "int",
            cacheEnum: CacheSetupKeys.sensitivity,
            gameId: gameId, setVal: (val) {
              setVal((val as int).toDouble(), key, gameId,ref);
            });
      }
    });

    defui = ref.read(currentEmbModeManager) == 1
        ? IgaConsts.igaAccDef
        : cacheValue ?? defui;

    return widget.isNewVersion
        ? buildNewColumn(key, gameId)
        : buildOldColumn(key, gameId);
  }

  Column buildNewColumn(String key, String gameId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Slider(
            value: (ref.read(currentEmbModeManager) == 1)
                ? IgaConsts.igaAccDef.toDouble()
                : (ref.watch(currentCacheSetupManager)[key] != null)
                    ? (ref.watch(currentCacheSetupManager)[key] as int)
                        .toDouble()
                    : defui,
            divisions: division,
            min: min,
            max: max,
            thumbColor: Colors.white,
            onChanged: (value) {
              setVal(value, key, gameId,ref);
            },
            activeColor: widget.isNewVersion ? CpColors.cpPrimary : null,
            inactiveColor: widget.isNewVersion ? CpColors.cpPlatinum : null,
          ),
        ),
        Text(
          '${(ref.watch(currentCacheSetupManager)[key] != null) ? (ref.watch(currentCacheSetupManager)[key] as int) : defui.toInt()} ',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        //${(kDebugMode) ? '|$selectedThresholdValue' : ''}
      ],
    );
  }

  Row buildOldColumn(String key, String gameId) {
    return Row(
      children: [
        Text(
            '${(ref.watch(currentCacheSetupManager)[key] != null) ? (ref.watch(currentCacheSetupManager)[key] as int) : defui.toInt()} '),
        //${(kDebugMode) ? '|$selectedThresholdValue' : ''}
        Expanded(
          child: Slider(
            value: (ref.read(currentEmbModeManager) == 1)
                ? IgaConsts.igaAccDef.toDouble()
                : (ref.watch(currentCacheSetupManager)[key] != null)
                    ? (ref.watch(currentCacheSetupManager)[key] as int)
                        .toDouble()
                    : defui,
            divisions: division,
            min: min,
            max: max,
            onChanged: (value) {
              setVal(value, key, gameId,ref);
            },
          ),
        ),
      ],
    );
  }

  void setVal(double value, String key, String gameId,WidgetRef ref) {
    isManuallyChanged = true;
    setState(() {
      defui = value;
      switch (defui) {
        case 1:
          def = ref.read(currentGameProv)!.id != '84' ? 80 : 90;
          break;
        case 2:
          def = ref.read(currentGameProv)!.id != '84' ? 70 : 85;
          break;
        case 3:
          def = ref.read(currentGameProv)!.id != '84' ? 60 : 80;
          break;
        case 4:
          def = ref.read(currentGameProv)!.id != '84' ? 55 : 75;
          break;
        case 5:
          def = ref.read(currentGameProv)!.id != '84' ? 50 : 70;
          break;
        case 6:
          def = ref.read(currentGameProv)!.id != '84' ? 45 : 65;
          break;
        case 7:
          def = ref.read(currentGameProv)!.id != '84' ? 40 : 60;
          break;
        case 8:
          def = ref.read(currentGameProv)!.id != '84' ? 30 : 55;
          break;
        case 9:
          def = ref.read(currentGameProv)!.id != '84' ? 20 : 50;
          break;
        case 10:
          def = ref.read(currentGameProv)!.id != '84' ? 10 : 45;
          break;
        default:
          def = (9 - value) * 10;
      }

      selectedThresholdValue = def;
      final setup = ref.read(currentGameProv)!.setup;
      StaticGameModel? selectedGame = ref.read(currentGameProv);

      selectedGame!.setup = setup.copyWith(
          accConfig: setup.accConfig?.copyWith(
        threshold: def.toInt(),
      ));
      ref.read(currentCacheSetupManager.notifier).setCacheAnyValue(ref,
          whichSetupKey: key, val: defui.toInt(), gameId: gameId);

      ref.read(currentGameProv.notifier).setState(selectedGame);
    });
  }

  void getSliderData() {
    min = 1.toDouble();
    max = 10.toDouble();
    def = defAccThreshold.toDouble();
    division = 9;
    if (widget.accConfigModel != null &&
        widget.accConfigModel!.threshold != null) {
      def = widget.accConfigModel!.threshold!.toDouble();
    }
    selectedThresholdValue = def;
    defui = (11 - (def / 10).ceil()).toDouble();

    //  0 - 127
    //  0 - 12.7 level 1
    //  12.7 - 25.4 level 2
    //  25.4 - 38.1 level 3
    //  38.1 - 50.8 level 4
    //  50.8 - 63.5 level 5
    //  63.5 - 76.2 level 6
    //  76.2 - 88.9 level 7
    //  88.9 - 101.6 level 8
    //  101.6 - 114.3 level 9
    //  114.3 - 127 level 10
    // level 1 10
    // level 2 20
    // level 3 30
    // level 4 40
    // level 5 50
    // level 6 60
    // level 7 70
    // level 8 80
    // level 9 90
    // level 10 100
    //  1
    //  5
    //  15
  }
}
