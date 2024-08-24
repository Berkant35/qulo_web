import 'package:audiotodo/ui/base/parts/audiotodo_parts/record/advice_for_meeting.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/record/middle_content/middle_text_of_speech.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/record/top_record_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/custom_colors.dart';
import '../../../../line/viewmodel/global_providers.dart';
import '../../../../utilities/constants/custom_assets/asset_paths.dart';
import '../../../../utilities/constants/enums/meet/audio_steppers.dart';

class IdleAndRecord extends ConsumerStatefulWidget {
  final WidgetRef customRef;

  const IdleAndRecord(
    this.customRef, {
    super.key,
  });

  @override
  ConsumerState createState() => _IdleAndRecordState();
}

class _IdleAndRecordState extends ConsumerState<IdleAndRecord> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.fillWhiteColor,
      child: Column(
        children: [
          const Expanded(flex: 8, child: TopRecordControl()),
          Expanded(flex: 2, child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: const AdviceForMeeting(),
          )),
          Expanded(flex: 15, child: MiddleTextOfSpeech(widget.customRef)),
          Expanded(
              flex: 2,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  // Animasyon süresi (milisaniye cinsinden)
                  curve: Curves.easeInOut,
                  color: ref.watch(currentAudioStepManager) ==
                          AudioToDoSteps.idle
                      ? CustomColors.fillWhiteColor
                      : Colors.transparent,
                  child: const SizedBox())
          )
        ],
      ),
    );
  }
}
