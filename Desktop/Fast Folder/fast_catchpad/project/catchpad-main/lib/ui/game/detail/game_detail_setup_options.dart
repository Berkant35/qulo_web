import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/game/setup_widgets/auto_start_enable_widgt.dart';
import 'package:catchpad/ui/game/setup_widgets/choose_periodically_queue.dart';
import 'package:catchpad/ui/game/setup_widgets/effect_enable_setup.dart';
import 'package:catchpad/ui/game/setup_widgets/environment_type_setup_widget.dart';
import 'package:catchpad/ui/game/setup_widgets/sticker_setup_widget.dart';
import 'package:catchpad/ui/game/setup_widgets/value_of_keyboard_setup_widget.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../managers/game/game_manager.dart';
import '../../../models/enums/utility/show_case_enum.dart';
import '../../../prov/dialogs/show_case_prov.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/detail_game_prov.dart';
import '../../../prov/game/selected_players_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/utils.dart';
import '../setup_widgets/challenge_detail_setup.dart';
import '../setup_widgets/challenge_type_setup_widget.dart';
import '../setup_widgets/choose_music_setup_widget.dart';
import '../setup_widgets/delay_setup_widget.dart';
import '../setup_widgets/distance_setup_widget.dart';
import '../setup_widgets/duration_setup_widget.dart';
import '../setup_widgets/education_setup_widget.dart';
import '../setup_widgets/execution_devices_setup_widget.dart';
import '../setup_widgets/game_option_setup_widget.dart';
import '../setup_widgets/game_players_setup/audio/audio_game_audio_setup_widget.dart';
import '../setup_widgets/game_players_setup/audio/audio_music_setup_widget.dart';
import '../setup_widgets/game_players_setup/audio/audio_sound_effects_setup_widget.dart';
import '../setup_widgets/game_players_setup/game_players_setup_widget.dart';
import '../setup_widgets/mentor_controls_setup_widget.dart';
import '../setup_widgets/music_setup_widget.dart';
import '../setup_widgets/operation_setup_widget.dart';
import '../setup_widgets/quiz_setup_widget.dart';
import '../setup_widgets/radius_setup_widget.dart';
import '../setup_widgets/sensor_type_setup_widget.dart';
import '../setup_widgets/threshhold_value_setup_widget.dart';

class GameDetailSetupOptions extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const GameDetailSetupOptions({
    required this.formKey,
    super.key,
  });

  @override
  ConsumerState<GameDetailSetupOptions> createState() =>
      _GameDetailSetupOptionsState();
}

class _GameDetailSetupOptionsState
    extends ConsumerState<GameDetailSetupOptions> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        GameManager.showConnectedDevicesDialog(
          context: context,
          ref: ref,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(detailGameProv);
    final setup = ref.watch(detailGameSetupProv);
    final curSetup = ref.watch(currentGameSetupProv);
    final UsedSensorsType userSensorType =
        curSetup!.sensorTypes.keys.elementAt(curSetup.chosedSensorIndex);

    if (game == null || setup == null) {
      assert(false);
      return const SizedBox();
    }
    final controls = setup.controlsSetup;
    final audioControls = controls.gameAudioControls;
    final accConfigModel = setup.accConfig;
    return Column(
      children: [
        CustomShowCaseWidget(
          showCaseInfo: ref.read(currentAllShowCases).firstWhere(
              (element) => element.key == Tips.exerciseSettingsTitle.name),
          showCaseContentWidget: Column(
            children: {
              if (setup.sensorTypes.length > 1)
                L10n.inst(context).game_ui_device_sensor:
                    const SensorTypeSetupWidget(),
              if (userSensorType == UsedSensorsType.tap)
                L10n.inst(context).game_ui_device_sensitivity:
                    ThreshHoldValueSetupWidget(
                        usedSensorsType: userSensorType,
                        accConfigModel: accConfigModel ?? defAccConfigModel),

              /// we have trouble with distance sensor when the environment is changed(inside/outside)
              // if (setup.distance != null &&
              //     userSensorType == UsedSensorsType.distance)
              //   L10n.inst(context).game_ui_environment:
              //       const EnvironmentTypeSetupWidget(),
              if (setup.distance != null &&
                  userSensorType == UsedSensorsType.distance)
                L10n.inst(context).game_ui_distance:
                    const DistanceSetupWidget(),


              if (setup.timeout != null &&
                  userSensorType == UsedSensorsType.none)
                L10n.inst(context).game_ui_timeout: const TimeoutSetupWidget(),
              if (setup.duration != null)
                L10n.inst(context).game_ui_duration:
                    const DurationSetupWidget(),
              if (setup.delay != null && userSensorType != UsedSensorsType.none)
                (game.id == 's13')
                        ? L10n.inst(context).difficulty
                        : L10n.inst(context).game_ui_delay:
                    const DelaySetupWidget(),

              if (setup.radius != null)
                L10n.inst(context).game_ui_radius: const RadiusSetupWidget(),
              if (setup.vibrationActiveDegree != null &&
                  ref
                      .read(currentDevicesManagerProvider)
                      .values
                      .any((device) => device.hwVersion == 'v2.0'))
                L10n.inst(context).game_ui_vibration_active:
                    const VibrationEnableSetup(),
              if (setup.gameDropOptionsModel != null)
                setup.gameDropOptionsModel!.dropOptionTitle:
                    const GameOptionSetupWidget(),
              /*if (setup.vibrationActiveDegree != null &&
                  ref.watch(currentVibrationDegree) &&
                  ref
                      .read(currentDevicesManagerProvider)
                      .values
                      .any((device) => device.hwVersion == 'v2.0'))
                L10n.inst(context).game_ui_vibration_degree:
                    const VibrationRadiusWidget(),*/
              if (controls.gameMusicSelectionSetup != null)
                L10n.inst(context).game_ui_music: const MusicSetupWidget(),
              if (controls.mentorControlsState.isAsk)
                L10n.inst(context).game_ui_controls_type:
                    const MentorControlsSetupWidget(), //71 72
              if (controls.gameOperationSelectionSetup != null)
                L10n.inst(context).game_ui_operations:
                    const OperationSetupWidget(),
              if (controls.gameEducationTypeSelectionSetup != null)
                L10n.inst(context).education_type_learn:
                    const EducationSetupWidget(),
              if (controls.gameExecutionDevicesSelectionSetup != null)
                L10n.inst(context).game_ui_execution_devices:
                    const ExecutionDevicesSetupWidget(),
              if (setup.autoStart)
                L10n.inst(context).game_ui_auto_start:
                    const AutoStartEnableWidget(),
              if (audioControls?.gameAudioSetup?.isChangable == true)
                L10n.inst(context).game_ui_audio_game_audio_status:
                    const AudioGameAudioSetupWidget(),
              if (audioControls?.musicSetup?.isChangable == true)
                L10n.inst(context).game_ui_audio_music_status:
                    const AudioMusicSetupWidget(),
              if (setup.isIncludePeriodicQueue != null)
                L10n.inst(context).game_ui_periodic_queue_status:
                    const IncludePeriodicallyQueueSwitchWidget(),
              if (setup.isIncludePeriodicQueue != null &&
                  ref.watch(currentIncludePeriodicallyQueueManager))
                L10n.inst(context).game_ui_periodic_queue:
                    const ChoosePeriodicallyQueue(),
              if (audioControls?.soundEffectsSetup?.chooseMusic == true)
                L10n.inst(context).game_ui_audio_change_status:
                    const ChooseMusicSetupWidget(),
              if (ref
                  .read(currentEffectConditionManager.notifier)
                  .gameIdList
                  .contains(game.id))
                L10n.inst(context).game_ui_effect_change_status:
                    const EffectEnableSetup(),
              if (setup.keyboardType != null && game.id == '49')
                L10n.inst(context).game_ui_keyboard_title_for_distance:
                    ValueOfKeyboardSetupWidget(formKey: widget.formKey),
              if (setup.keyboardType != null && game.id == '50')
                L10n.inst(context).game_ui_keyboard_title_for_pass_count:
                    ValueOfKeyboardSetupWidget(formKey: widget.formKey),
              if (audioControls?.soundEffectsSetup?.isChangable == true)
                L10n.inst(context).game_ui_audio_sound_effects_status:
                    const AudioSoundEffectsSetupWidget(),
              if (setup.challengeTypes != null &&
                  setup.challengeTypes!.length > 1)
                L10n.inst(context).game_ui_device_challenge:
                    ChallengeTypeSetupWidget(),

              if (setup.controlsSetup.gameStickerMatchSelectionSetup != null)
                "": //L10n.inst(context).game_ui_set_colors_with_exercises:
                    const StickerSetup(),
              if (setup.controlsSetup.gameQuizSelectionSetup != null)
                "": //L10n.inst(context).game_ui_set_colors_with_exercises:
                    const QuizSetup(),
            }.entries.map(
              (e) {
                final tip = Tips.getFromMapKey(e.key!, context);
                return e.key != L10n.inst(context).game_ui_device_challenge
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomShowCaseWidget(
                                    showCaseInfo: ref
                                        .read(currentAllShowCases.notifier)
                                        .allShowCases
                                        .firstWhere((element) =>
                                            element.key == tip.name),
                                    showCaseContentWidget: Text(
                                      e.key!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                  tip != Tips.none
                                      ? IconButton(
                                          onPressed: () => ref
                                              .read(
                                                  currentAllShowCases.notifier)
                                              .showCaseCustom(
                                                  context: context,
                                                  globalKey: ref
                                                      .read(currentAllShowCases
                                                          .notifier)
                                                      .tipGlobalKeys[tip.name]!),
                                          icon: Icon(
                                            Icons.help_outline,
                                            size: 2.6.h,
                                            color: CpColors.captionColor,
                                          ))
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Center(
                                child: e.value,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  e.key!,
                                  style: Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Center(
                                    child: e.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const ChallengeDetailSetup()
                        ],
                      );
              },
            ).joinWidgetList(
              (e) => const SizedBox(height: defPaddingSize),
            ),
          ),
        ),
        Consumer(builder: (context, ref, _) {
          final selectedPlayers = ref.watch(selectedPlayersProv);

          return Column(
            children: [
              if (selectedPlayers.isNotEmpty)
                Row(
                  children: [
                    Text(
                      L10n.inst(context).game_ui_players,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              const Padding(
                padding: EdgeInsets.all(defPaddingSize),
                child: GamePlayersSetupWidget(),
              ),
            ],
          );
        }),
      ].joinWidgetList(
        (e) => const SizedBox(height: defPaddingSize),
      ),
    );
  }
}
