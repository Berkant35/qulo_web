import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/buttons/custom_play_stop_button.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../line/viewmodel/app/utilities/show_case_manager.dart';
import '../../../../../../utilities/constants/enums/app/show_case_states.dart';

class RecordingControlWidget extends ConsumerStatefulWidget {
  const RecordingControlWidget({
    super.key,
  });

  @override
  ConsumerState createState() => _RecordingControlWidgetState();
}

class _RecordingControlWidgetState
    extends ConsumerState<RecordingControlWidget> {
  static const startTimeText = '00:00:00';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomShowCaseWidget(
              showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                      (element) => element.key == ShowCaseStates.playOrPause.name),
              showCaseContentWidget: CustomPlayStopButton(
                onPressed: () => ref
                    .read(currentMeetControllerManager.notifier)
                    .controlMeetingManageButton(ref),
                circleRadius: 25.w,
                iconSize: 4.h,
                recordingOrPlayer: true,
              ),
              onPressedTarget: () => ref
                  .read(currentMeetControllerManager.notifier)
                  .controlMeetingManageButton(ref),
            ),
            ref.watch(currentRecorderControllerManager) != null
                ? StreamBuilder<Duration?>(
                    stream: ref
                        .read(currentRecorderControllerManager)!
                        .onCurrentDuration,
                    builder: (context, snapshot) {
                      final dateTime = ref
                          .read(currentRecorderControllerManager.notifier)
                          .currentDurationLocal();
                      String? hours;
                      String? minutes;
                      String? seconds;
                      if (dateTime != null) {
                        hours = dateTime.inHours
                            .remainder(24)
                            .toString()
                            .padLeft(2, '0');
                        minutes = dateTime.inMinutes
                            .remainder(60)
                            .toString()
                            .padLeft(2, '0');
                        seconds = dateTime.inSeconds
                            .remainder(60)
                            .toString()
                            .padLeft(2, '0');
                      }

                      return Text(
                        dateTime != null
                            ? '$hours:$minutes:$seconds'
                            : startTimeText,
                        style: ThemeValueExtension.subtitle
                            .copyWith(color: CustomColors.fillWhiteColor),
                      );
                    })
                : const SizedBox(),
          ],
        ),
        Positioned(left: 22.w, bottom: -1.h, child: _recordWaves()),
      ],
    );
  }

  Widget _recordWaves() {
    return Lottie.asset(
      AssetPaths.lottieLoading,
      height: 8.h,
      width: 30.h,
      fit: BoxFit.fill,
      animate: ref.watch(currentWaveAnimationControlState),
      repeat: true,
    );
  }
}

