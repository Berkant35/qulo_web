import 'dart:async';

import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/components/dialogs/record_dialogs.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/player_states.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../line/viewmodel/global_providers.dart';
import '../../../../../../utilities/components/buttons/neu_text_button.dart';
import '../../../../../../utilities/components/sheets/sheets.dart';
import '../../../../../../utilities/constants/enums/meet/audio_steppers.dart';
import '../../idle/audio_step_idle_of_middle.dart';

part 'middle_text_of_speech_mixin.dart';

class MiddleTextOfSpeech extends ConsumerStatefulWidget {
  final WidgetRef customRef;

  const MiddleTextOfSpeech(
    this.customRef, {
    super.key,
  });

  @override
  ConsumerState createState() => _MiddleTextOfSpeechState();
}

class _MiddleTextOfSpeechState extends ConsumerState<MiddleTextOfSpeech>
    with TickerProviderStateMixin, _MiddleTextOfSpeechMixin {
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    slideAnimate();
    _scrollController = ScrollController();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _playerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return dynamicConsumer();
  }

  Consumer dynamicConsumer() {
    return Consumer(
      builder: (context, customRef, child) {
        final audioStep = customRef.watch(currentAudioStepManager);
        customRef.watch(currentMeetControllerManager);
        if (audioStep == AudioToDoSteps.record ||
            audioStep == AudioToDoSteps.reviewMeet) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        return _body(audioStep, context);
      },
    );
  }

  Container _body(AudioToDoSteps audioStep, BuildContext context) {
    return Container(
      color: CustomColors.fillWhiteColor,
      child: audioStep == AudioToDoSteps.idle
          ? const AudioStepIdleOfMiddle()
          : recordingSteps(audioStep, context),
    );
  }

  Stack recordingSteps(AudioToDoSteps audioStep, BuildContext context) {
    return Stack(
      children: [
        contentOfMiddle(audioStep),
        if (audioStep == AudioToDoSteps.reviewMeet) cancelState(context),
        audioStep == AudioToDoSteps.record
            ? recordState(context)
            : generateState(),
      ],
    );
  }

  Positioned cancelState(BuildContext context) {
    return Positioned(
      right: 6.w,
      height: 6.h,
      child: IconButton(
        onPressed: () => Sheets.cancelCurrentMeeting(context, ref),
        icon: Icon(
          Icons.cancel,
          size: 4.h,
          color: CustomColors.primaryColor,
        ),
      ),
    );
  }

  Align generateState() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomShowCaseWidget(
        showCaseInfo: widget.customRef.read(currentAllShowCases).firstWhere(
            (element) =>
                element.key == ShowCaseStates.reviewGenerateAndSave.name),
        onPressedTarget: generateAndSave,
        showCaseContentWidget: NeuTextButton(
          text: S.current.generate_and_save,
          onPressed: generateAndSave,
        ),
      ),
    );
  }

  SlideTransition recordState(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CustomShowCaseWidget(
          showCaseInfo: widget.customRef.read(currentAllShowCases).firstWhere(
              (element) => element.key == ShowCaseStates.doneMeet.name),
          showCaseContentWidget: NeuTextButton(
            text: S.current.done,
            onPressed: ref.read(currentRecorderControllerManager) != null
                ? () {
                    RecordDialogs.saveOptions(ref);
                  }
                : () => Sheets.cancelCurrentMeeting(context, ref),
          ),
          onPressedTarget: ref.read(currentRecorderControllerManager) != null
              ? () {
                  RecordDialogs.saveOptions(ref);
                }
              : () => Sheets.cancelCurrentMeeting(context, ref),
        ),
      ),
    );
  }

  Widget contentOfMiddle(AudioToDoSteps audioStep) {
    return Container(
      height: 47.h,
      decoration: contentCoverDecoration(),
      child: Center(
        child: Padding(
          padding: getPadding(),
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomShowCaseWidget(
              showCaseInfo: widget.customRef
                  .read(currentAllShowCases)
                  .firstWhere((element) =>
                      element.key == ShowCaseStates.speechToText.name),
              onPressedTarget: () {},
              showCaseContentWidget: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: contentDecoration(),
                child: contentText(audioStep),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView contentText(AudioToDoSteps audioStep) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
          padding: EdgeInsets.all(EdgeExtension.mediumEdge.edgeValue),
          child: textStates(audioStep)),
    );
  }

  Widget textStates(AudioToDoSteps audioStep) {
    if (ref.read(currentMeetControllerManager)?.meetContent != null &&
        ref.read(currentMeetControllerManager)!.meetContent!.length > 250) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    return ((audioStep == AudioToDoSteps.record ||
                audioStep == AudioToDoSteps.reviewMeet) &&
            ref.read(currentMeetControllerManager) != null)
        ? Text(
            ref.read(currentMeetControllerManager)!.meetContent ?? "",
            style: textStateStyle(),
            textAlign: TextAlign.start,
          )
        : const SizedBox();
  }
}
