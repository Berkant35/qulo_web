import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/iga_game_setup/iga_single_player_setup_widget.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/game/player/player_model.dart';
import '../../../../../models/game/player/selected_player_model.dart';
import '../../../../../prov/default_color_prov.dart';
import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../prov/game/detail_game_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';
import '../../../../../utils/widgets/emb/iga/iga_util_widgets/head_stepper_widget.dart';

class OnBoardingFourStepper extends ConsumerStatefulWidget {
  final int headNumber;

  /// if null, means this is a general player

  final List<TextSpan> textSpans;
  final bool isColorStep;
  final bool canPickColor;
  final bool canMultiplePickColor;

  const OnBoardingFourStepper(
      {super.key,
        required this.headNumber,
        required this.canPickColor,
        required this.canMultiplePickColor,
        required this.textSpans,
        required this.isColorStep});

  @override
  ConsumerState createState() => _OnBoardingFourStepperState();
}

class _OnBoardingFourStepperState extends ConsumerState<OnBoardingFourStepper> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) {

        ref.read(currentDefaultColorManager.notifier).refresh();

        ref.read(selectedPlayersProv.notifier).empty();
        final selectedOnes = ref.read(selectedPlayersProv);
        final selectedCount = selectedOnes.length;
        final setup = ref.read(detailGameSetupProv);

        if (setup == null) {
          assert(false);
          return;
        }

        final playerCountRange = setup.playerCount!;

        final minPlayerCount = playerCountRange.min;

        final stagedPlayer = setup.stagedPlayerModel;
        final generalStagedPlayer = setup.generalStagedPlayerModel;

        if (stagedPlayer == null && generalStagedPlayer == null) {
          assert(false);
          return;
        }

        // if the state does not have enoguh players added,
        // which has to be at this moment, we wanna initialize
        // empty players.
        if (selectedCount < minPlayerCount && stagedPlayer != null) {
          ref.read(selectedPlayersProv.notifier).setTo({});

          for (var i = selectedCount; i < minPlayerCount; i++) {

            final player = PlayerModel.id();

            final selectedPlayer = SelectedPlayerModel(
              player: player,
              staged: stagedPlayer,
            );

            ref.read(selectedPlayersProv.notifier).add(selectedPlayer);
          }
        }

        //
        var stagedGeneralPlayer = setup.generalStagedPlayerModel;
        if (stagedGeneralPlayer != null) {

          final generalPlayerProv = ref.read(selectedGeneralPlayerProv);

          if (generalPlayerProv == null) {
            final player = PlayerModel.general();

            final gamePadCount = setup.padCount!;

            if (stagedGeneralPlayer.hasDevs &&
                stagedGeneralPlayer.deviceCount == null) {
              stagedGeneralPlayer = stagedGeneralPlayer.copyWith(
                deviceCount: gamePadCount,
              );
            }

            final selectedPlayer = SelectedPlayerModel(
              player: player,
              staged: stagedGeneralPlayer,
            );

            ref.read(selectedGeneralPlayerProv.notifier).setTo(selectedPlayer);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameMetaData = ref.watch(detailGameProv);
    final players = ref.watch(selectedPlayersProv);
    final generalPlayer = ref.watch(selectedGeneralPlayerProv);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: HeadStepperWidget(widget.headNumber)),
              Flexible(
                  flex: 8,
                  child: Row(
                    children: [
                      Flexible(
                          child: RichText(
                              text: TextSpan(children: widget.textSpans))),
                      if (widget.isColorStep && widget.canPickColor)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            "assets/iga/pick_hand.png",
                            height: 8.h,
                          ),
                        )
                    ],
                  )),
              const Spacer()
            ],
          ),
          if (widget.isColorStep && widget.canPickColor && !ref.read(detailGameSetupProv)!.allowSameColor)
            Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 8,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            ...players.map(
                                  (player) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        if (players.first == player && players.length>1)
                                          Padding(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: Container(
                                              height: 8.h,
                                              width: 8.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.04),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '1. \n ${instForGameScreen.player}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color:
                                                    CpColors.cpBasicWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                            height: 66,
                                            width: 30.w,
                                            child: IGASinglePlayerSetupWidget(
                                                id: player.id)),
                                        if (players.last == player && players.length>1)
                                          Container(
                                            height: 8.h,
                                            width: 8.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                                  .withOpacity(0.04),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '2. \n ${instForGameScreen.player}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color:
                                                  CpColors.cpBasicWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    if (players.first == player) const Gap(30)
                                  ],
                                );
                              },
                            ),

                          ],
                        ),
                        if (players.length > 1)
                          Image.asset(
                            IgaAssets.vs.getPath,
                            height: 8.h,
                          ),
                      ],
                    )),
              ],
            ),
             if(widget.isColorStep && widget.canPickColor && ref.read(detailGameSetupProv)!.allowSameColor)
               const Row(
                 children: [
                   Spacer(
                     flex: 2,
                   ),
                   IGASingleGeneralPlayerSetupWidget(
                       // id: players.first.id
                   ),
                   Spacer(flex: 1,)
                 ],
               ),
        ],
      ),
    );
  }
}