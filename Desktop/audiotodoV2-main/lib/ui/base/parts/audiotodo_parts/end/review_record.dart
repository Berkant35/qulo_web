import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/app/custom_functions.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/player_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/result_view_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/theme/custom_colors.dart';
import '../../../../../line/viewmodel/app/utilities/show_case_manager.dart';
import '../../../../../utilities/components/buttons/custom_play_stop_button.dart';
import '../../../../../utilities/constants/enums/meet/audio_steppers.dart';
import '../../../../../utilities/constants/extensions/context_extension.dart';

class ReviewRecord extends ConsumerStatefulWidget {
  const ReviewRecord({
    super.key,
  });

  @override
  ConsumerState createState() => _ReviewRecordState();
}

class _ReviewRecordState extends ConsumerState<ReviewRecord> {
  static const emptyTime = '00:00:00';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buildEdgeInsets(),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomShowCaseWidget(
                showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) => element.key == ShowCaseStates.playOrPause.name),
                showCaseContentWidget: CustomPlayStopButton(
                  onPressed: pressStopButton,
                  circleRadius: 20.w,
                  iconSize: 3.25.h,
                  recordingOrPlayer: false,
                ),
                onPressedTarget: pressStopButton,
              ),
              ref.watch(currentPlayerManagerState) != null
                  ? StreamBuilder<int?>(
                      stream: ref
                          .watch(currentPlayerManagerState)!
                          .onCurrentDurationChanged,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String formattedDuration =
                              CustomFunctions.formatMilliseconds(
                                  snapshot.data!
                                      // ~/ 2
                              );
                          return Text(
                            formattedDuration,
                            style: ThemeValueExtension.subtitle.copyWith(
                                color:
                                    ref.watch(currentResultViewControlState) ==
                                                ResultViewStates.cloudResult &&
                                            ref.read(currentAudioStepManager) !=
                                                AudioToDoSteps.reviewMeet
                                        ? CustomColors.primaryColor
                                        : CustomColors.fillWhiteColor),
                          );
                        } else {
                          return Text(
                            emptyTime,
                            style: ThemeValueExtension.subtitle.copyWith(
                                color:
                                    ref.read(currentResultViewControlState) ==
                                                ResultViewStates.cloudResult &&
                                            ref.read(currentAudioStepManager) !=
                                                AudioToDoSteps.reviewMeet
                                        ? CustomColors.primaryColor
                                        : CustomColors.fillWhiteColor),
                          );
                        }
                      },
                    )
                  : const SizedBox(),
            ],
          ),
          Positioned(
            left: 22.w,
            bottom: 2.h,
            child: ref.watch(currentPlayerManagerState) != null
                ? AudioFileWaveforms(
                    size: Size(60.w, 4.h),
                    playerController: ref.watch(currentPlayerManagerState)!,
                    enableSeekGesture: true,
                    waveformType: WaveformType.long,
                    waveformData: const [],
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor:
                          ref.watch(currentResultViewControlState) ==
                                      ResultViewStates.cloudResult &&
                                  ref.read(currentAudioStepManager) !=
                                      AudioToDoSteps.reviewMeet
                              ? Colors.black
                              : Colors.white,
                      liveWaveColor: ref.watch(currentResultViewControlState) ==
                                  ResultViewStates.cloudResult &&
                              ref.read(currentAudioStepManager) !=
                                  AudioToDoSteps.reviewMeet
                          ? Colors.black12
                          : Colors.white30,
                      spacing: 8,
                      seekLineColor: CustomColors.accentColor,
                      seekLineThickness: 2.5,
                      showTop: true,
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void pressStopButton() {
                  if (ref.read(currentPlayerControlState) !=
                      CustomPlayerStates.listen) {
                    ref
                        .read(currentPlayerManagerState.notifier)
                        .startPlayer(ref);
                  } else {
                    ref
                        .read(currentPlayerManagerState.notifier)
                        .pausePlayer(ref);
                  }
                }

  EdgeInsets buildEdgeInsets() {
    return EdgeInsets.symmetric(
        horizontal: ref.watch(currentResultViewControlState) ==
                    ResultViewStates.cloudResult &&
                ref.read(currentAudioStepManager) != AudioToDoSteps.reviewMeet
            ? 4.w
            : 0);
  }
}
