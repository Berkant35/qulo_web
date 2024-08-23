import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../prov/game/curr_game_prov.dart';

class AutoStartEnableWidget extends ConsumerWidget {
  const AutoStartEnableWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = CacheSetupKeys.autoStartOnOff.name;

    return Switch.adaptive(
        value: (ref.watch(currentCacheSetupManager)[key] != null)
            ? (ref.watch(currentCacheSetupManager)[key])
            : ref.watch(currentFirstActionStateManager),
        onChanged: (val) {
          final setup = ref.read(currentGameSetupProv)!;
          final game = ref.read(currentGameProv)!;
          final newSetup = setup.copyWith(
            autoStart: val,
          );
          ref.read(currentGameProv.notifier).setSetup(newSetup);
          ref.read(currentFirstActionStateManager.notifier).changState(val);
          ref.read(currentCacheSetupManager.notifier).setCacheAnyValue(ref,
              whichSetupKey: key, val: val, gameId: game.id);
        });
  }
}
