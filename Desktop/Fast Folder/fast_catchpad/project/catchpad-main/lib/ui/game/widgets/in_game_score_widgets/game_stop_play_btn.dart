 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../prov/game/round_prov.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/buttons/cp_button_2.dart';

class GameStopPlayButton extends StatelessWidget {
  const GameStopPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final roundState = ref.watch(gameRoundProv);
            if (roundState == GameRoundEnum.ongoing) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30),
                child: CpButton2(
                  child: Text(L10n.inst(context).stop),
                  onPressed: ref.read(gameRoundProv.notifier).setPaused,
                ),
              );
            }

            if (
                //
                roundState == GameRoundEnum.paused
                    //
                    ||
                    //
                    roundState == GameRoundEnum.enabled
                //

                ) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30),
                child: CpButton2(
                  child: Text(L10n.inst(context).play),
                  onPressed: ref.read(gameRoundProv.notifier).setOngoing,
                ),
              );
            }

            // if [GameRoundEnum.enabled] or [GameRoundEnum.disabled],
            // then the user does not have any actions to take
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
