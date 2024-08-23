import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/game/game_model.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../prov/global_providers.dart';
import '../../../utils/game_consts.dart';
import '../../../utils/utils.dart';

class DistanceSetupWidget extends ConsumerWidget {
  const DistanceSetupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final gameId = ref.read(currentGameProv)!.id;

    final key = CacheSetupKeys.distance.name;

    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initDistance, distance;

    if (initSetup.distance == null || initSetup.distance?.def == null) {
      assert(false);

      initDistance = NumRange.def(defaultGameDistanceMM.mmToCm.toInt());
    } else {
      initDistance = initSetup.distance!;
    }

    if (setup.distance == null || setup.distance?.def == null) {
      assert(false);

      distance = initDistance;
    } else {
      distance = setup.distance!;
    }

    Future<void> setDistance(int dst) async {
      dst = dst.cmToMm.toInt();

      final NumRange dis;
      if (setup.distance == null) {
        assert(false);

        dis = NumRange.def(dst);
      } else {
        dis = setup.distance!.copyWith(def: dst);
      }

      final newSetup = setup.copyWith(distance: dis);
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: dst, gameId: gameId);

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    // the distance values are mm, we wanna convert to cm
    // in the selector.

    final min = initDistance.min.mmToCm.toInt();
    final max = initDistance.max.mmToCm.toInt();
    final step = initDistance.step.mmToCm.toInt();

    final sec =
        (ref.watch(currentCacheSetupManager)[key + '/' + gameId] != null)
            ? (ref.watch(currentCacheSetupManager)[key + '/' + gameId] as int)
                .mmToCm
                .toInt()
            : distance.def!.mmToCm.toInt();

    return NumberPicker(
      value: sec,
      minValue: min,
      maxValue: max,
      step: step,
      itemHeight: 20,
      itemWidth: 60,
      axis: Axis.horizontal,
      onChanged: (dst) => setDistance(dst).then((value) async {
        final pref = await SharedPreferences.getInstance();

        final result = pref.get(PrefKeys.distanceSensorMayNotEffective);
        final int distanceMessageShouldAppear = 100;
        if (setup.distance!.def! > distanceMessageShouldAppear &&
            (result == null || result == false) &&
            CustomDialogs.dontShowDialog == false) {
          CustomDialogs.sureDialogWithCheckBox(
              ref, L10n.inst(context).game_ui_dialog_title_sensor_may,
              prefKey: PrefKeys.distanceSensorMayNotEffective, pressOk: () {
            CustomDialogs.dontShowDialog = false;
          });
        }
      }),
      haptics: true,
      textMapper: (val) =>
          val + L10n.inst(context).activity_distance_selection_cm_unit,
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
