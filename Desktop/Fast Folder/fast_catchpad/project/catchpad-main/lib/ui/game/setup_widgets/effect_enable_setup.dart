import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/effect/show_effect_prov.dart';
import 'package:catchpad/prov/effect/vibration_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EffectEnableSetup extends ConsumerWidget {
  const EffectEnableSetup({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = CacheSetupKeys.effectOnOff.name;
    final gameId = ref.read(currentGameProv)!.id;

    return Switch.adaptive(
        value: ref.watch(currentEffectEnableManager),
        onChanged: (val) {
          ref.read(currentEffectEnableManager.notifier).changeState();
          ref.read(currentCacheSetupManager.notifier).setCacheAnyValue(ref,
              whichSetupKey: key, val: val, gameId: gameId);
        });
  }
}

class VibrationEnableSetup extends ConsumerWidget {
  const VibrationEnableSetup({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = CacheSetupKeys.vibrationOnOff.name;
    final gameId = ref.read(currentGameProv)!.id;

    return Switch.adaptive(
        value: ref.watch(currentVibrationDegree),
        onChanged: (val) {
          ref.read(currentVibrationDegree.notifier).changeState();
          ref.read(currentCacheSetupManager.notifier).setCacheAnyValue(ref,
              whichSetupKey: key, val: val, gameId: gameId);
        });
  }
}
