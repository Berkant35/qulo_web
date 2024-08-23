import 'dart:io';

import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_screens/all_periods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/buttons/cp_button_2.dart';

class ChoosePeriodicallyQueue extends ConsumerWidget {
  const ChoosePeriodicallyQueue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CpButtonWithIcon2(
            iconWidget: ref.watch(currentPeriodicallyQueueManager).isNotEmpty
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            onPressed: () async {
              if (Platform.isIOS) {
                await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const AllPeriods(
                              selectableForm: true,
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllPeriods(
                        selectableForm: true,
                      ),
                    ));
              }
            },
            child: Text(ref.watch(currentPeriodicallyQueueManager).isNotEmpty
                ? ref.watch(currentPeriodicallyQueueManager).keys.first
                : L10n.inst(context).select)),
      ],
    );
  }
}

class IncludePeriodicallyQueueSwitchWidget extends ConsumerWidget {
  const IncludePeriodicallyQueueSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = CacheSetupKeys.periodicOnOff.name;
    final gameId = ref.read(currentGameProv)!.id;

    return Switch.adaptive(
        value: (ref.watch(currentCacheSetupManager)[key] != null)
            ? (ref.watch(currentCacheSetupManager)[key])
            : ref.watch(currentIncludePeriodicallyQueueManager),
        onChanged: (val) {

          ref
              .read(currentIncludePeriodicallyQueueManager.notifier)
              .changState(val);

          ref
              .read(currentCacheSetupManager.notifier)
              .setCacheAnyValue(ref, whichSetupKey: key, val: val,gameId: gameId);

        });
  }
}
