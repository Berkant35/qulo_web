import 'package:catchpad/managers/game/game_manager.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/iga_background_ble.dart';
import 'package:catchpad/ui/emb/iga/iga_onboarding/onboarding_four_helper_parts/onboarding_four_stepper.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/game/player/player_model.dart';
import '../../../../../models/game/player/selected_player_model.dart';
import '../../../../../prov/default_color_prov.dart';
import '../../../../../prov/game/curr_game_prov.dart';
import '../../../../../prov/game/detail_game_prov.dart';
import '../../../../../prov/game/selected_players_prov.dart';
import '../../../../../prov/global_providers.dart';
import '../../../../../utils/cp_colors.dart';
import '../../../../../utils/util_widgets/util_dialogs.dart';

class OnBoardingFourHowPlayPart extends ConsumerStatefulWidget {
  const OnBoardingFourHowPlayPart({
    super.key,
  });

  @override
  ConsumerState createState() => _OnBoardingFourHowPlayPartState();
}

class _OnBoardingFourHowPlayPartState
    extends ConsumerState<OnBoardingFourHowPlayPart> {
  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
  }

  void addPostFrameCallback() {
    return SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final ftr = <Future>[];

        ref.read(bleConPr).keys.forEach((element) {
          ftr.add(PadManager.ledOffNoResponse(element.id, ref: ref));
        });

        Future.wait(ftr);

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
                player: player, staged: stagedGeneralPlayer);

            ref.read(selectedGeneralPlayerProv.notifier).setTo(selectedPlayer);
          }
        }
      },
    );
  }

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final setup = ref.watch(detailGameSetupProv);
    final gameMetaData = ref.watch(detailGameProv);

    final metaDataList = gameMetaData!.metaData.earnings;
    if (!ref.read(currentSafeInGameToggleState)) {
      logger.w("Pad Show trigger!");
      Future(() {
        ref
            .read(currentSafeInGameToggleState.notifier)
            .changState(false, ref);
        ref
            .read(currentSafeInGameToggleState.notifier)
            .startPadShow(ref,[], forcedVal: true);
      });
    }
    // bu switch. basliklar metadatadan cekilip uppercase func kullanildiginda kucuk 'i' ler buyumedigi icin yazildi
    final String title = switch (gameMetaData.id) {
      's4' => L10n.inst(context).language == 'tr'
          ? 'EKİP İŞİ'
          : L10n.inst(context).game_title_4,
      's14' => L10n.inst(context).language == 'tr'
          ? 'DİKKAT DİKKAT'
          : L10n.inst(context).game_title_14,
      '84' => L10n.inst(context).language == 'tr'
          ? 'DİNLE YAKALA'
          : L10n.inst(context).game_title_111,
      // TODO: Handle this case.
      String() => '',
    };

    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 14,
                child: Column(
                  children: [
                    header(
                        currentGame: (ref.read(appLangProv)!.name == 'Türkçe' &&
                                (gameMetaData.id == 's14' ||
                                    gameMetaData.id == 's4' ||
                                    gameMetaData.id == '84'))
                            ? title
                            : gameMetaData.metaData.name,
                        context: context,
                        inst: inst),
                    for (int i = 0;
                        i < gameMetaData.metaData.igaTextSpans.length;
                        i++)
                      OnBoardingFourStepper(
                        headNumber: i + 1,
                        canMultiplePickColor:
                            gameMetaData.metaData.igaMultiplePickColor,
                        canPickColor: gameMetaData.metaData.igaPickColor,
                        textSpans: gameMetaData.metaData.igaTextSpans[i],
                        isColorStep: i == 0,
                      )
                  ],
                )),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${inst.game_ui_earnings}:',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14.sp),
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: metaDataList.map((e) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: Colors.white),
                                    color: Colors.transparent,
                                  ),
                                  child: Text(
                                    e.textNotation(context),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 11.sp),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      /// The code `Text()` is creating a widget that displays text on the screen.

                      SizedBox(
                        height: 2.h,
                      ),

                      () {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: isClicked
                              ? const CircularProgressIndicator(
                                  color: CpColors.cpPrimary,
                                )
                              : CustomCatchpadButtons
                                  .buildBackGroundGradientButtonV2(
                                      onPressed: isClicked == true
                                          ? null
                                          : () async {
                                              ref
                                                  .read(currentBulBakalim
                                                      .notifier)
                                                  .changState(false);

                                              final length = ref
                                                  .watch(bleConPr)
                                                  .values
                                                  .where((element) =>
                                                      element.connectionState ==
                                                      DeviceConnectionState
                                                          .connected)
                                                  .length;

                                              final firstPlayerDiscoveredDeviceslength =
                                                  ref
                                                      .read(igaBackGroundManager
                                                          .notifier)
                                                      .firstPlayerDiscoveredDevices
                                                      .length;

                                              final secondPlayerDiscoveredDeviceslength = ref
                                                  .read(igaBackGroundManager
                                                      .notifier)
                                                  .secondPlayerDiscoveredDevices
                                                  .length;

                                              final easyDiscoveredDeviceslength =
                                                  ref
                                                      .read(igaBackGroundManager
                                                          .notifier)
                                                      .easyDiscoveredDevices
                                                      .length;

                                               if (length < IgaConsts.mustDeviceCount ||
                                                   firstPlayerDiscoveredDeviceslength !=
                                                       secondPlayerDiscoveredDeviceslength) {
                                                 logger.w(
                                                     "Length: $length \n $firstPlayerDiscoveredDeviceslength \n $secondPlayerDiscoveredDeviceslength");
                                                 CustomCatchpadDialogs
                                                     .connectionWait(
                                                         context, ref);

                                                 // return;
                                               }
                                              setState(() {
                                                isClicked = true;
                                              });
                                              if (!ref.context.mounted) {
                                                return;
                                              }
                                              ref
                                                  .read(
                                                      currentSafeInGameToggleState
                                                          .notifier)
                                                  .changState(true, ref);
                                              final b = ref
                                                  .watch(selectedPlayersProv)
                                                  .allPlayersSatisfyConditionsWithWidgetRef(
                                                      ref,
                                                      isIga: true);

                                              final specialConditionForEkipIsi = ref
                                                  .read(
                                                      selectedGeneralPlayerProv)
                                                  ?.player
                                                  .clrs
                                                  .isNotEmpty;

                                              if ((!b) &&
                                                  gameMetaData
                                                      .metaData.igaPickColor &&
                                                  !(specialConditionForEkipIsi !=
                                                          null &&
                                                      specialConditionForEkipIsi &&
                                                      gameMetaData.id ==
                                                          's4')) {
                                                CustomCatchpadDialogs.notSelectedIga(
                                                    context,
                                                    L10n.inst(context)
                                                        .dialog_game_condition_color_empty_title,
                                                    L10n.inst(context)
                                                        .game_detail_not_selected_color_description);

                                                setState(() {
                                                  isClicked = false;
                                                });

                                                return;
                                              }

                                              final players = ref.read(
                                                  selectedPlayersPlayersProv);

                                              final gameDevs = ref
                                                  .read(bleConPr)
                                                  .keys
                                                  .toList();

                                              for (var dev in gameDevs) {
                                                await PadSensorManager
                                                        .configAccSensor(
                                                            deviceId: dev.id,
                                                            ref: ref,
                                                            model: setup!
                                                                .accConfig,
                                                            intModel:
                                                                accInterruptConfigModelWithMinusOne)
                                                    .timeout(const Duration(
                                                        seconds: 1));
                                              }

                                              //TODO ---/---
                                              /*if (firstPlayerDiscoveredDeviceslength !=
                                                    secondPlayerDiscoveredDeviceslength &&
                                                count !=
                                                    (firstPlayerDiscoveredDeviceslength +
                                                        secondPlayerDiscoveredDeviceslength)) {
                                              logger.e("Not enough device");
                                              Restart.restartApp();
                                              return;
                                              }*/

                                              if (ref.context.mounted) {
                                                await GameManager.pushGame(
                                                  context: context,
                                                  ref: ref,
                                                ).then((value) {


                                                  if (ref.context.mounted) {
                                                    final ftr = <Future>[];



                                                    ref
                                                        .read(
                                                            currentDevicesManagerProvider
                                                                .notifier)
                                                        .connectedDevice
                                                        .forEach(
                                                            (devId, value) {
                                                      ftr.add(PadManager
                                                          .toggleInGame(devId,
                                                              ref: ref,
                                                              inGame: false));
                                                    });

                                                    Future.wait(ftr)
                                                        .then((value) {
                                                      logger.i(
                                                          "All Device toggle in game false len(${ftr.length})");
                                                    });
                                                  }
                                                });
                                              }

                                              setState(() {
                                                isClicked = false;
                                              });

                                              // ref
                                              //     .read(currentIgaPageManager.notifier)
                                              //     .changState(IGAStates.lastRegister);
                                            },
                                      text: inst.game_ui_start_now,
                                      fillColor: CpColors.cpFrenchLime,
                                      fontSize: 14.sp,
                                      width: 18.w,
                                      height: 10.h,
                                      textColor: Colors.black),
                        );
                      }(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  bool readyForStart() {
    final allOptions = ref.watch(currentGameSetupProv)!.allOptionsSelected(ref);

    return allOptions;
  }

  Row header(
      {required String currentGame,
      required BuildContext context,
      required AppLocalizations inst}) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
            flex: 14,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentGame.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: CpColors.cpPrimary),
                    ),
                    Text(
                      inst.iga_title_how_to_play,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Image.asset(
                    "assets/iga/question_mark.png",
                    height: 11.h,
                  ),
                )
              ],
            )),
        //question_mark.png
      ],
    );
  }
}
