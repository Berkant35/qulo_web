import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../models/num_range.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../utils/game_consts.dart';
import '../../../utils/utils.dart';

class DelaySetupWidget extends ConsumerWidget {
  const DelaySetupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final game = ref.watch(currentGameProv)!;

    final key = CacheSetupKeys.delay.name + game.id;

    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initDelay, delay;

    if (initSetup.delay == null || initSetup.delay?.def == null) {
      assert(false);
      initDelay = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initDelay = initSetup.delay!;
    }

    if (setup.delay == null || setup.delay?.def == null) {
      assert(false);

      delay = initDelay;
    } else {
      delay = setup.delay!;
    }

    void setDuration(int sec) {
      final newSetup = setup.copyWith(
        delay: initDelay.copyWith(def: sec),
      );
      final gameId = ref.read(currentGameProv)!.id;
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initDelay.min;
    final max = initDelay.max;
    final step = initDelay.step;

    Future(() {
      if (ref.context.mounted) {
        ref.read(currentCacheSetupManager.notifier).getPerValue(ref,
            whichSetupKey: key,
            typeOfVal: "int",
            cacheEnum: CacheSetupKeys.delay,
            gameId: game.id, setVal: (val) {
          setDuration(val);
        });
      }
    });

    final sec = ((ref.watch(currentCacheSetupManager)[key] != null) &&
            (ref.watch(currentCacheSetupManager)[key] as int) < max &&
            (ref.watch(currentCacheSetupManager)[key] as int) > min)
        ? ref.watch(currentCacheSetupManager)[key]
        : delay.def!;

    return NumberPicker(
      value: sec,
      minValue: min,
      maxValue: max,
      step: step,
      itemHeight: 20,
      itemWidth: 60,
      axis: Axis.horizontal,
      onChanged: setDuration,
      textMapper: (val) {
        if ((game.id == 's13')) {
          switch (val) {
            case '300':
              return L10n.inst(context).difficulty_easy;
            case '450':
              return L10n.inst(context).difficulty_medium;
            case '600':
              return L10n.inst(context).difficulty_hard;
            default:
          }
        }
        return val + (game.id == "s16"
            ? L10n.inst(context).activity_duration_selection_millisecond_unit
            : L10n.inst(context).activity_duration_selection_second_unit);
      },
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
