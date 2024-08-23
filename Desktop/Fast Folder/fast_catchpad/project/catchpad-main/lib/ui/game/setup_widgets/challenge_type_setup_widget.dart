

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../models/enums/game/challenge_type.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../utils/l10n/l10n.dart';

@deprecated
class ChallengeTypeSetupWidget extends ConsumerWidget {
   ChallengeTypeSetupWidget({
    Key? key,
  }) : super(key: key);
  final GlobalKey challengeTypekey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final setup = ref.watch(currentGameSetupProv)!;
    setChallengeType(int value) {
      final newSetup = setup.copyWith(choosedChallengeTypeIndex: value);
      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }
    final selectedValue = setup.choosedChallengeTypeIndex;

    return Container(
      key: challengeTypekey,
      child: GestureDetector(
        onTapDown: (details) {
          try {
            var widthOfParent = challengeTypekey.currentContext?.size?.width;
            widthOfParent = widthOfParent! / 3;
            if (details.localPosition.dx < widthOfParent) {
              if (selectedValue == 0) return;
              //setSensorType(selectedValue - 1);
            } else if (details.localPosition.dx > widthOfParent * 2) {
              if (selectedValue == setup.challengeTypes!.length - 1) {
                setChallengeType(selectedValue - 1);
              } else {
                setChallengeType(selectedValue + 1);
              }
            }
          } catch (e) {
            logger.d(e.toString());
          }
        },
        child: NumberPicker(
          minValue: 0,
          maxValue: setup.challengeTypes!.length - 1,
          axis: Axis.horizontal,
          value: selectedValue,
          itemWidth: (MediaQuery.of(context).size.width > 600)
              ? MediaQuery.of(context).size.width * 0.14
              : MediaQuery.of(context).size.width * 0.16,
          textStyle: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontSize: MediaQuery.of(context).size.aspectRatio * 20),
          selectedTextStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: MediaQuery.of(context).size.aspectRatio * 22),
          itemHeight: 20,
          onChanged: setChallengeType,
          haptics: true,
          infiniteLoop: true,
          itemCount: 2,
          textMapper: (numberText) {
            final typeEquilivance =
            setup.challengeTypes!.keys.elementAt(int.parse(numberText));
            switch (typeEquilivance) {
              case ChallengeType.sequential:
                return inst.game_ui_device_challenge_sequential;
              case ChallengeType.random:
                return inst.game_ui_device_challenge_randomly;
              case ChallengeType.custom:
                return inst.game_ui_device_challenge_sequential;
            }
          },
        ),
      ),
    );
  }
}
