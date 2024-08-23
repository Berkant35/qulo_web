import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../models/num_range.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../utils/game_consts.dart';
import '../../../utils/utils.dart';

class DurationSetupWidget extends ConsumerStatefulWidget {
  const DurationSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DurationSetupWidgetState();
}

class _DurationSetupWidgetState extends ConsumerState<DurationSetupWidget> {
  @override
  Widget build(BuildContext context) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.gameDuration.name;

    final setup = ref.watch(currentGameSetupProv)!;

    final game = ref.watch(currentGameProv)!;
    NumRange initDuration, duration;

    if (initSetup.duration == null || initSetup.duration?.duration == null) {
      assert(false);

      initDuration = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initDuration = initSetup.duration!;
    }

    if (setup.duration == null || setup.duration?.duration == null) {
      assert(false);

      duration = initDuration;
    } else {
      duration = setup.duration!;
    }
    final gameId = ref.read(currentGameProv)!.id;

    void setDuration(int sec) {
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      final newSetup = setup.copyWith(
        duration: initDuration.copyWith(def: sec),
      );

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initDuration.min;
    final max = initDuration.max;
    final step = initDuration.step;

    final sec =
        ((ref.watch(currentCacheSetupManager)[key + '/' + gameId] != null))
            ? ref.watch(currentCacheSetupManager)[key + '/' + gameId]
            : duration.def!;

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
        //for fuar
        if ((game.id == 's16' || game.id == 's14') &&
            ((game.id == 's14' && val == '40') ||
                (game.id == 's16' && val == '120')) &&
            adminIdList.contains(ref.read(currentUserProv)!.uid)) {
          return 'Sınırsız';
        }

        return val + L10n.inst(context).activity_duration_selection_second_unit;
      },
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}

class TimeoutSetupWidget extends ConsumerWidget {
  const TimeoutSetupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.timeout.name;
    final setup = ref.watch(currentGameSetupProv)!;

    final game = ref.watch(currentGameProv)!;
    NumRange initDuration, timeout;

    if (initSetup.timeout == null || initSetup.timeout?.duration == null) {
      assert(false);

      initDuration = NumRange.def(defaultTimeOutDuration.inSeconds);
    } else {
      initDuration = initSetup.timeout!;
    }

    if (setup.timeout == null || setup.timeout?.duration == null) {
      assert(false);

      timeout = initDuration;
    } else {
      timeout = setup.timeout!;
    }
    final gameId = ref.read(currentGameProv)!.id;

    void setDuration(int sec) {
      final newSetup = setup.copyWith(
        timeout: initDuration.copyWith(def: sec),
      );
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);
      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initDuration.min;
    final max = initDuration.max;
    final step = initDuration.step;

    dynamic cacheValue;

    Future(() {
      if(ref.context.mounted){
        cacheValue = ref.read(currentCacheSetupManager.notifier).getPerValue(ref,
            whichSetupKey: key,
            typeOfVal: "int",
            cacheEnum: CacheSetupKeys.timeout,
            gameId: gameId, setVal: (val) {
              setDuration(val);
            });
      }
    });

    final sec = (ref.watch(currentCacheSetupManager)[key] != null)
        ? (ref.watch(currentCacheSetupManager)[key] as int)
        : timeout.def!;

    return NumberPicker(
      value: (ref.watch(currentCacheSetupManager)[key] != null)
          ? (ref.watch(currentCacheSetupManager)[key] as int)
          : sec,
      minValue: min,
      maxValue: max,
      step: step,
      itemHeight: 20,
      itemWidth: 60,
      axis: Axis.horizontal,
      onChanged: setDuration,
      textMapper: (val) {
        //for fuar
        if ((game.id == 's16' || game.id == 's14') &&
            ((game.id == 's14' && val == '40') ||
                (game.id == 's16' && val == '120')) &&
            adminIdList.contains(ref.read(currentUserProv)!.uid)) {
          return 'Sınırsız';
        }

        return val +
            ' ' +
            (ref.read(currentGameProv)!.id == '67' ||
                    ref.read(currentGameProv)!.id == '84' ||
                    ref.read(currentGameProv)!.id == 's16'
                ? L10n.inst(context)
                    .activity_duration_selection_millisecond_unit
                : L10n.inst(context).activity_duration_selection_second_unit);
      },
      textStyle: Theme.of(context).textTheme.caption,
      selectedTextStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
