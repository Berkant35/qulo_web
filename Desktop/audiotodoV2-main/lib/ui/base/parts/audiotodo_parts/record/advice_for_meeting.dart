import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../line/viewmodel/global_providers.dart';
import '../../../../../utilities/constants/enums/meet/audio_steppers.dart';

class AdviceForMeeting extends ConsumerStatefulWidget {
  const AdviceForMeeting({
    super.key,
  });

  @override
  ConsumerState createState() => _AdviceForMeetingState();
}

class _AdviceForMeetingState extends ConsumerState<AdviceForMeeting> {
  List<String> demoExamples = [
    S.current.static_advice_1,
    S.current.static_advice_2,
    S.current.static_advice_3,
    S.current.static_advice_4,
    S.current.static_advice_5,
    S.current.static_advice_6,
    S.current.static_advice_7,
    S.current.static_advice_8,
    S.current.static_advice_9,
    S.current.static_advice_10
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, customRef, child) {
        final audioStep = customRef.watch(currentAudioStepManager);

        return Container(
          width: 100.w,
          color: Colors.white,
          child: audioStep == AudioToDoSteps.record
              ? Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      for (int i = 0; i < demoExamples.length; i++)
                        RotateAnimatedText(
                          "“${demoExamples[i]}”",
                          textStyle: ThemeValueExtension.subtitle
                              .copyWith(fontStyle: FontStyle.italic),
                          duration: const Duration(milliseconds: 4000),
                        ),
                    ],
                    totalRepeatCount: 1,
                    repeatForever: true,
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
