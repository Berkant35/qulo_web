import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../models/num_range.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../utils/game_consts.dart';
import '../../../utils/utils.dart';

class RadiusSetupWidget extends ConsumerWidget {
  const RadiusSetupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.radius.name;
    final gameId = ref.read(currentGameProv)!.id;
    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initRadius, radius;

    if (initSetup.radius == null || initSetup.radius?.def == null) {
      assert(false);

      initRadius = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initRadius = initSetup.radius!;
    }

    if (setup.radius == null || setup.radius?.def == null) {
      assert(false);

      radius = initRadius;
    } else {
      radius = setup.radius!;
    }

    void setDuration(int sec) {
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      final newSetup = setup.copyWith(
        radius: initRadius.copyWith(def: sec),
      );

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initRadius.min;
    final max = initRadius.max;
    final step = initRadius.step;


    final sec = ((ref
                    .watch(currentCacheSetupManager)[key + '/' + gameId] !=
                null) &&
            (ref.watch(currentCacheSetupManager)[key + '/' + gameId] as int) <
                max &&
            (ref.watch(currentCacheSetupManager)[key + '/' + gameId] as int) >
                min)
        ? ref.watch(currentCacheSetupManager)[key + '/' + gameId]
        : radius.def!;

    return NumberPicker(
      value: sec,
      minValue: min,
      maxValue: max,
      step: step,
      itemHeight: 20,
      itemWidth: 60,
      axis: Axis.horizontal,
      onChanged: setDuration,
      textMapper: (val) =>
          val + L10n.inst(context).activity_radius_selection_second_unit,
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}


class VibrationRadiusWidget extends ConsumerWidget {
  const VibrationRadiusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.vibrationRadius.name;
    final gameId = ref.read(currentGameProv)!.id;
    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initRadius, vibrationRadius;

    if (initSetup.vibrationActiveDegree == null || initSetup.vibrationActiveDegree?.def == null) {
      assert(false);

      initRadius = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initRadius = initSetup.vibrationActiveDegree!;
    }

    if (setup.vibrationActiveDegree == null || setup.vibrationActiveDegree?.def == null) {
      assert(false);
      vibrationRadius = initRadius;
    } else {
      vibrationRadius = setup.vibrationActiveDegree!;
    }

    void setDuration(int sec) {
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      final newSetup = setup.copyWith(
        vibrationActiveDegree: initRadius.copyWith(def: sec),
      );

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initRadius.min;
    final max = initRadius.max;
    final step = initRadius.step;


    final sec = ((ref
        .watch(currentCacheSetupManager)[key + '/' + gameId] !=
        null) &&
        (ref.watch(currentCacheSetupManager)[key + '/' + gameId] as int) <
            max &&
        (ref.watch(currentCacheSetupManager)[key + '/' + gameId] as int) >
            min)
        ? ref.watch(currentCacheSetupManager)[key + '/' + gameId]
        : vibrationRadius.def!;

    return NumberPicker(
      value: sec,
      minValue: min,
      maxValue: max,
      step: step,
      itemHeight: 20,
      itemWidth: 60,
      axis: Axis.horizontal,
      onChanged: setDuration,
      textMapper: (val) =>
      val + L10n.inst(context).activity_radius_selection_second_unit,
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}