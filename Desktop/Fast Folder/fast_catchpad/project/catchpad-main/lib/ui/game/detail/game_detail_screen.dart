import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/game/metadata/game_metadata_model.dart';
import 'package:catchpad/prov/cancel_stream_prov.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game/selected_players_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad/utils/route_table.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading/loading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../managers/game/game_manager.dart';
import '../../../models/enums/utility/show_case_enum.dart';
import '../../../models/extensions/extensions.dart';
import '../../../prov/dialogs/show_case_prov.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/game_logic_consts.dart';
import '../../../utils/utils.dart';
import '../../widgets/buttons/cp_button_1.dart';
import '../../widgets/default_bg.dart';
import '../setup_widgets/threshhold_value_setup_widget.dart';
import 'game_detail_properties.dart';
import 'game_detail_setup_options.dart';

class GameDetailScreen extends ConsumerStatefulWidget {
  const GameDetailScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends ConsumerState<GameDetailScreen> {
  final globalFormKey = GlobalKey<FormState>();

  ValueNotifier<bool> isActiveButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(currentAllShowCases.notifier).showCaseIn(
          context: context,
          customGlobalKeys: [
            ref
                .read(currentAllShowCases.notifier)
                .tipGlobalKeys[Tips.aboutExercise.name]!,
            ref
                .read(currentAllShowCases.notifier)
                .tipGlobalKeys[Tips.exerciseSettingsTitle.name]!
          ],
          ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(detailGameProv);
    // final setup = ref.watch(detailGameSetupProv);
    // final curSetup = ref.watch(currentGameSetupProv); Böyleydi.

    final setup = ref.watch(currentGameSetupProv);

    ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {
      ref
          .read(currentAutoDisposeTimerManager.notifier)
          .restartTimer(deviceId, ref);
    });
    ref.read(bleConPr).keys.forEach((device) {
      if (!ref.read(currentDevicesManagerProvider).keys.contains(device.id)) {
        try {
          PadManager.getDeviceInfo(device.id, ref: ref)
              .then((deviceInfo) async {
            if (deviceInfo != null) {
              await ref
                  .read(currentDevicesManagerProvider.notifier)
                  .setDevice(deviceInfo, device.id, ref);
            }

            if (ref.context.mounted) {
              ref
                  .read(currentDevicesManagerProvider.notifier)
                  .setConnectedDevice(device, ref);
            }
          });
        } catch (e) {
          logger.e("Error:$e");
        }
      }
    });

    ConfigScale scale = defConfigScale;
    ConfigMode mode = defConfigMode;
    DataRate dataRate = defDataRate;
    if (game == null || setup == null) {
      assert(false);
      return const SizedBox();
    }
    final meta = game.metaData;

    /*ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {});*/

    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) async {
        // check the user movement and if he slide to right from left side, page goes back
        if (details.globalPosition.dx <
            MediaQuery.of(context).size.width * 0.15) {
          Navigator.of(context).pop();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Loading(
        child: Scaffold(
          floatingActionButton: ref.watch(catchPadEventManager)?.eventGameId !=
                  game.id
              ? null
              : FloatingActionButton.extended(
                  backgroundColor: CpColors.button1Color,
                  onPressed: () async {
                    context
                        .pushNamed(RouteTable.rChooseCatchpadEventCompetitor);
                  },
                  label: Row(
                    children: [
                      Text(
                        "Seç",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.emoji_events_outlined,
                        size: 28,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
          body: Form(
            key: globalFormKey,
            child: SafeArea(
              child: DefaultBg(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        _gameImage(meta),
                        _backButton(context),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(defPaddingSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GameDetailSetupOptions(
                            formKey: globalFormKey,
                          ),
                        ].joinWidgetList(
                          (e) => const SizedBox(height: defPaddingSize * 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: CpColors.bgGC2,
              padding: const EdgeInsets.all(halfDefPaddingSize),
              child: ValueListenableBuilder<bool>(
                builder: (BuildContext context, val, child) {
                  final allOptions = setup.allOptionsSelected(ref);
                  bool allOptionsSelected = readyForStart();
                  return CpButton1(
                    gameStart: true,
                    onPressed: () {
                      // logger.i("Is Active Button: ${isActiveButton.value} ${readyForStart()} ");

                      if (isActiveButton.value) {
                        return null;
                      }

                      /// Remove detect bug
                      if (!readyForStart()) {
                        /*AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: L10n.inst(context)
                                .color_count_bigger_than_pad_count_error_title,
                            desc: L10n.inst(context)
                                .color_count_bigger_than_pad_count_error_description,
                            btnCancelOnPress: () {})
                            .show();*/

                        return (null);
                      }

                      bool allOptionsSelected = readyForStart();

                      final players = ref.read(selectedPlayersPlayersProv);
                      final selectedColor =
                          players.colors.length == players.length;

                      /// TODO burda allow same color opsiyonlu oyunları belirlemek lazım
                      if (!selectedColor && !setup.allowSameColor) return null;
                      // Getting the sensor type for the game
                      // When it comes to use different sensors for different pads in games
                      // Then we will handle sensors and write characteristics separately for those pads
                      // For now just 1 sensor type is used for all pads so we get only one sensor type

                      UsedSensorsType userSensorType;

                      userSensorType = setup.sensorTypes.keys
                          .elementAt(setup.chosedSensorIndex);

                      bool startGameConditions = true;
                      String showDesc = "";
                      //1: Go
                      //4: Edu

                      // int getModeNumber() {
                      //   switch (this) {
                      //     case VariantsType.PRO:
                      //       return 3;
                      //     case VariantsType.SPORT:
                      //       return 0;
                      //     case VariantsType.EDU:
                      //       return 1;
                      //     case VariantsType.EMB:
                      //       return 2;
                      //     case VariantsType.GO:
                      //       return 4;
                      //   }
                      // }
                      // Var Olan PRO - SPOR (3,0)

                      if (userSensorType == UsedSensorsType.distance) {
                        startGameConditions = !ref
                            .watch(currentDevicesManagerProvider)
                            .values
                            .any((value) {

                              debugPrint("Variant ID: ${value.variantId}");
                              return ( value.variantId == "1" ||
                                  value.variantId == "4");
                        });


                        if(ref
                            .read(currentDevicesManagerProvider)
                            .values
                            .any((value) =>
                        value.variantId == "-1" ) && !startGameConditions){
                          startGameConditions = true;
                        }


                        if (!startGameConditions) {
                          showDesc =
                              L10n.inst(context).unsupported_distance_content;
                        }
                      }

                      //0: Sport
                      //4: Go
                      if (GameLogicConstants.stickerGamesIdList
                          .contains(ref.read(currentGameProv)!.id)) {
                        startGameConditions = !ref
                            .watch(currentDevicesManagerProvider)
                            .values
                            .any((value) =>
                                value.variantId == "0" ||
                                value.variantId == "4");

                        if(ref
                            .read(currentDevicesManagerProvider)
                            .values
                            .any((value) =>
                         value.variantId == "-1" ) && !startGameConditions){
                           startGameConditions = true;
                         }

                        //false
                        if (!startGameConditions) {
                          showDesc = L10n.inst(context)
                              .unsupported_sticker_content_desc;
                        }
                      }

                      final gameDevs = setup.getGameDevicesForConfig(ref);

                      //TODO You should collect in a single class that special start game conditions
                      //TODO Maybe set a parameter under static game model for return true false with alert dialog texts

                      final periodState =
                          ref.watch(currentIncludePeriodicallyQueueManager);
                      final period = ref.watch(currentPeriodicallyQueueManager);

                      if (setup.isIncludePeriodicQueue != null &&
                          periodState &&
                          period.isEmpty) {
                        return () => AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.bottomSlide,
                                title: L10n.inst(context)
                                    .period_not_selected_error_title,
                                desc: L10n.inst(context)
                                    .period_not_selected_error_description,
                                btnCancelOnPress: () {
                                  // logger.i(
                                  //     "1.Condition: ${setup.isIncludePeriodicQueue}"
                                  //     "2.Condition: ${setup.isIncludePeriodicQueue!}"
                                  //     "3.Condition: $periodState"
                                  //     "4.Condition: ${period.isEmpty}");
                                },
                                btnCancelText: L10n.inst(context).form_cancel)
                            .show();
                      }
                      final selectedGeneralPlayer =
                      ref.read(selectedPlayersProv);
                      final selectedGeneralPlayer2 =
                      ref.watch(selectedGeneralPlayerProv);
                      if (game.id == "68") {

                        if (selectedGeneralPlayer2 != null &&
                            selectedGeneralPlayer.colors.length >
                                selectedGeneralPlayer2.player.devs.length) {
                          return () => AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.bottomSlide,
                                  title: L10n.inst(context)
                                      .color_count_bigger_than_pad_count_error_title,
                                  desc: L10n.inst(context)
                                      .color_count_bigger_than_pad_count_error_description,
                                  btnCancelOnPress: () {},
                                  btnCancelText: L10n.inst(context).form_cancel)
                              .show();
                        }
                      }

                      //Check max color count per player
                      // if(selectedGeneralPlayer.colors.length>)


                      //TODO ------------------------------wwws
                      if (!allOptionsSelected) {
                        return () => AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.bottomSlide,
                                title: L10n.inst(context).set_options,
                                desc: L10n.inst(context)
                                    .you_must_set_before_start,
                                btnCancelOnPress: () {},
                                btnCancelText: L10n.inst(context).form_cancel)
                            .show();
                      }

                      //check any color same in player colors

                      return () async {
                        isActiveButton.value = true;
                        isActiveButton.notifyListeners();

                        try {
                          globalFormKey.currentState!.save();
                          if (!globalFormKey.currentState!.validate()) {
                            return;
                          }

                          if (!startGameConditions) {
                            logger.e("Game Condition Not Okey");
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: L10n.inst(context).unsupported_content,
                              desc: showDesc,
                              btnOkOnPress: _launchUrl,
                              btnOkText: L10n.inst(context).go_store_for_buy,
                              btnCancelOnPress: () {},
                            ).show();
                          } else {
                            if (userSensorType == UsedSensorsType.force &&
                                isManuallyChanged == false) {
                              for (var dev in gameDevs) {
                                await PadSensorManager.configAccSensor(
                                    deviceId: dev.id,
                                    ref: ref,
                                    model: setup.accConfig,
                                    intModel:
                                        accInterruptConfigModelWithMinusOne);
                              }
                            }

                            ref
                                .read(currentDevicesManagerProvider)
                                .keys
                                .forEach((deviceId) {
                              ref
                                  .read(currentAutoDisposeTimerManager.notifier)
                                  .restartTimer(deviceId, ref);
                            });

                            ref
                                .read(currentPlayTraceManager.notifier)
                                .changePlayTraceState(
                                    PlayTraceStates.game, ref);

                            ref
                                .read(currentShareController.notifier)
                                .disposeState(ref);

                            await GameManager.pushGame(
                              context: context,
                              ref: ref,
                            ).then((value) {
                              isActiveButton.value = false;
                              isActiveButton.notifyListeners();
                              final ftr = <Future>[];
                              ref
                                  .read(currentDevicesManagerProvider.notifier)
                                  .connectedDevice
                                  .forEach((devId, value) {
                                ftr.add(PadManager.toggleInGame(devId,
                                    ref: ref, inGame: false));
                              });
                              if (ref.read(currentGameProv)!.id == 's35') {
                                ref
                                    .read(currentBulBakalim.notifier)
                                    .changState(false);
                              }
                            });
                          }
                        } catch (e) {
                          logger.e(
                            "Error: $e"
                          );

                          EasyLoading.dismiss();
                          FirebaseCollectionEnums.logs.reference
                              .doc("loading_state")
                              .set({"errorText": e.toString()});
                          if (ref.context.mounted) {
                            final conDevs = ref
                                .read(bleConenctionStateProv)
                                .value
                                ?.keys
                                .toList();
                            GameManager.resetEverythingAfterGameEnds(
                                ref, conDevs ?? [], []);
                          }
                        } finally {
                          isActiveButton.value = false;
                          isActiveButton.notifyListeners();
                        }
                      };
                    }(),
                    fullWidth: true,
                    child: Text(
                      L10n.inst(context).game_ui_start_now +
                          (!readyForStart()
                              ? !(ref
                                      .watch(boolValueProvider)
                                      .resetEverythingAfterGameEnds)
                                  ? ""
                                  : !allOptionsSelected
                                      ? ""
                                      : ""
                              : ""),
                    ),
                  );
                },
                valueListenable: isActiveButton,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool readyForStart() {
    final allOptions = ref.watch(currentGameSetupProv)!.allOptionsSelected(ref);

    //logger.e(ref.watch(boolValueProvider).resetEverythingAfterGameEnds);
    //logger.e(ref.watch(currentGameSetupProv)!.allOptionsSelected(ref));
    return allOptions;
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        ref
            .read(currentPlayTraceManager.notifier)
            .saveToFirebaseNewTrace(ref);
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.height * 0.09,
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CpColors.bgGC2.withOpacity(0.6),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gameImage(GameMetaDataModel meta) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.isTablet ? 12.h : 18.h),
            // TODO Image size değerlerine göre padding ver
            child: Image.asset(
              meta.fullImgPath,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 40.h,
            ),
          ),
          CustomShowCaseWidget(
            showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                (element) => element.key == Tips.aboutExercise.name),
            showCaseContentWidget: Container(
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                      Radius.circular(context.isTablet ? 4.w : 10.w))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defPaddingSize, vertical: defPaddingSize / 2),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                meta.name,
                                maxLines: 1,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () => ref
                                        .read(currentAllShowCases.notifier)
                                        .showCaseCustom(
                                            context: context,
                                            globalKey: ref
                                                    .read(currentAllShowCases
                                                        .notifier)
                                                    .tipGlobalKeys[
                                                Tips.padSound.name]!),
                                    icon: Icon(
                                      Icons.help_outline,
                                      size: 2.6.h,
                                      color: CpColors.captionColor,
                                    )),
                                CustomShowCaseWidget(
                                  showCaseInfo: ref
                                      .read(currentAllShowCases.notifier)
                                      .allShowCases
                                      .firstWhere((element) =>
                                          element.key == Tips.padSound.name),
                                  showCaseContentWidget: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                buzzerManagerProvider.notifier)
                                            .changeBuzzerStatus(ref);
                                        isManuallyChanged = true;
                                      },
                                      icon: Icon(
                                          ref.watch(buzzerManagerProvider)
                                              ? Icons.volume_up
                                              : Icons.volume_off)),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          meta.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 2.h,
                        )
                      ],
                    ),
                    const GameDetailProperties(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://catchpad.com/en/products');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
