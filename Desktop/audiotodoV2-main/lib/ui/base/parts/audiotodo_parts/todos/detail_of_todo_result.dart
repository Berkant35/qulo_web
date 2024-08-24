import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/app/speechings/text_to_speech/text_to_speech_manager.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/result_view_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/tts_keys.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../utilities/constants/enums/meet/audio_steppers.dart';
import '../end/review_record.dart';

class DetailOfTodoResult extends ConsumerStatefulWidget {
  final WidgetRef parentRef;

  const DetailOfTodoResult({
    super.key,
    required this.parentRef,
  });

  @override
  ConsumerState createState() => _DetailOfTodoResultState();
}

class _DetailOfTodoResultState extends ConsumerState<DetailOfTodoResult> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final tts = ref.watch(currentTextToSpeechControlNotifier);
    final currentUser = ref.read(authManager);
    final ttsController = ref.read(currentTextToSpeechControlNotifier.notifier);
    Future(() {
      ttsController.initializeFlutterTts(ref);

      if (ref.read(currentMeetControllerManager) == null) {
        return;
      }

      ttsController.addNewTextState(
          ref,
          TTsContentKeys.summary.name,
          TtsState.playing,
          ref
                  .read(currentMeetControllerManager)!
                  .responseTodo
                  ?.meetContentSummarize ??
              "");

      ttsController.addNewTextState(
          ref,
          TTsContentKeys.pureText.name,
          TtsState.playing,
          ref.read(currentMeetControllerManager)!.responseTodo?.meetPureText ??
              "");

      final audioStep = ref.watch(currentAudioStepManager);
      if (audioStep != AudioToDoSteps.reviewMeet) {
        ref
            .read(currentResultViewControlState.notifier)
            .changState(ResultViewStates.cloudResult);
      }
    });

    return Column(
      children: [
        Expanded(
            flex: 2,
            child: CustomShowCaseWidget(
                showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                    (element) =>
                        element.key == ShowCaseStates.resultSummary.name),
                onPressedTarget: () {},
                showCaseContentWidget: const ReviewRecord())),
        const Spacer(),
        Expanded(flex: 3, child: header(ref)),
        Expanded(
            flex: 12,
            child: Padding(
              padding: samePaddingWithHorizontally(),
              child: CustomShowCaseWidget(
                showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                    (element) =>
                        element.key == ShowCaseStates.resultPureText.name),
                onPressedTarget: () {},
                showCaseContentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.result_summary,
                            style: contentTitleTheme(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.15.w),
                            child: TextToSpeechControlButton(
                                onPressed: () async {
                                  if (isPlaying) {
                                    ttsController.stopTts(
                                        ref, TTsContentKeys.summary.name);
                                    return;
                                  }

                                  setState(() {
                                    isPlaying = true;
                                    ttsController
                                        .playTts(
                                            ref, TTsContentKeys.summary.name)
                                        .then((value) {
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    });
                                  });
                                },
                                iconSize: 4.w,
                                primaryColor: CustomColors.primaryColor,
                                iconColor: CustomColors.fillWhiteColor,
                                forceIconControlIsStop:
                                    tts[TTsContentKeys.summary.name] ==
                                        TtsState.stopped,
                                recordingPlayerControl: false),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: ref.read(currentMeetControllerManager) != null
                            ? Text(
                                ref
                                        .read(currentMeetControllerManager)!
                                        .responseTodo
                                        ?.meetContentSummarize ??
                                    "",
                                style: contentBodyTheme(),
                              )
                            : const SizedBox(),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.result_pure_text,
                            style: contentTitleTheme(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.15.w),
                            child: TextToSpeechControlButton(
                                onPressed: () {
                                  if (isPlaying) {
                                    ttsController.stopTts(
                                        ref, TTsContentKeys.pureText.name);
                                    return;
                                  }
                                  setState(() {
                                    isPlaying = true;
                                    ttsController
                                        .playTts(
                                            ref, TTsContentKeys.pureText.name)
                                        .then((value) {
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    });
                                  });
                                },
                                iconSize: 4.w,
                                primaryColor: CustomColors.primaryColor,
                                iconColor: CustomColors.fillWhiteColor,
                                forceIconControlIsStop:
                                    tts[TTsContentKeys.pureText.name] ==
                                        TtsState.stopped,
                                recordingPlayerControl: false),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        child: ref.read(currentMeetControllerManager) != null
                            ? Text(
                                ref
                                        .read(currentMeetControllerManager)!
                                        .responseTodo
                                        ?.meetPureText ??
                                    "",
                                style: contentBodyTheme(),
                              )
                            : const SizedBox(),
                      ),
                    )
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 3,
          child: Padding(
            padding: samePaddingWithVertically(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeuStadiumTextButton(
                    text: !ref
                        .read(currentResultViewControlState.notifier)
                        .createForDetail
                        ? ("${S.current.result_again_send_to_gpt}(${currentUser!.totalRecreateCount ?? 0})")
                        : S.current.delete,
                    isPrimaryButton: !ref
                        .read(currentResultViewControlState.notifier)
                        .createForDetail,

                    forceColor: !ref
                        .read(currentResultViewControlState.notifier)
                        .createForDetail
                        ? null
                        : CustomColors.errorColor.withOpacity(0.8),
                    onPressed: regenerateFunc),
                SizedBox(
                  width: 2.h,
                ),
                CustomShowCaseWidget(
                  showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                      (element) =>
                          element.key == ShowCaseStates.resultToDos.name),
                  onPressedTarget: results,
                  showCaseContentWidget: NeuStadiumTextButton(
                      text: S.current.result_go_to_todo_match_page,
                      isPrimaryButton: false,
                      onPressed: results),
                )
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  void results() => ref
      .read(currentResultViewControlState.notifier)
      .changState(ResultViewStates.todoMatch);

  Future<void> regenerateFunc() async {
    //next
    // final currentGlobalKey = ref.read(currentAllShowCases.notifier).showCSGlobalKeys[ShowCaseStates.resultRegenerate.name]!;

    //Close current showcase
    // final widgetIds = ShowCaseWidget.of(context).ids;
    // final cr = ref.read(currentAllShowCases.notifier).showCSGlobalKeys[ShowCaseStates.resultRegenerate.name]!;
    // final index = widgetIds!.indexOf(cr);

    // ShowCaseWidget.of(context).completed(currentGlobalKey);
    // ShowCaseWidget.of(context).dismiss();


    !ref.read(currentResultViewControlState.notifier).createForDetail
        ? BasicDialogs.sureDialog(() => ref
                .read(currentMeetControllerManager.notifier)
                .createTodoListFromGpt(widget.parentRef, isOnce: false),ref,(c){

          // ShowCaseWidget.of(context).startShowCase(widgetIds.sublist(index) ?? []);
          // logger.i("Widget IDS: $widgetIds");
    })
        : BasicDialogs.sureDeleteDialog(() => ref
                .read(currentSelectMeetState.notifier)
                .deleteMeet(
                    ref.read(currentMeetControllerManager)!.meetId!, ref)
                .then((value) {
              ref
                  .read(currentMeetControllerManager.notifier)
                  .changeCurrentMeetState(null);
              NavigationService.instance.navigatePopUp();
            }));
  }

  Widget header(WidgetRef ref) {
    final date = ref.watch(currentMeetControllerManager)?.createdDateTime!;

    return date != null
        ? Padding(
            padding: samePaddingWithHorizontally(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subTitle(date.nameDayAndHHmm),
                    subTitle(date.ddMMyyyy),
                  ],
                ),
                Flexible(
                  child: Text(
                    ref
                            .watch(currentMeetControllerManager)
                            ?.responseTodo
                            ?.meetSuggestedTitle ??
                        S.current.result_suggested_title_null,
                    style: titleTheme(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  EdgeInsets samePaddingWithHorizontally() =>
      EdgeInsets.symmetric(horizontal: EdgeExtension.normalEdge.edgeValue);

  EdgeInsets samePaddingWithVertically() =>
      EdgeInsets.symmetric(vertical: EdgeExtension.lowEdge.edgeValue);

  TextStyle titleTheme() => ThemeValueExtension.listTileTitleStyle
      .copyWith(fontWeight: FontWeight.w700);

  TextStyle contentTitleTheme() =>
      ThemeValueExtension.subtitle.copyWith(fontWeight: FontWeight.w700);

  Text subTitle(String date) {
    return Text(
      date,
      style: subTitleTheme(),
    );
  }

  TextStyle subTitleTheme() {
    return ThemeValueExtension.highBody.copyWith(color: CustomColors.greyColor);
  }

  contentBodyTheme() {
    return ThemeValueExtension.highBody.copyWith(
        color: CustomColors.fillBlackElevationColor,
        overflow: TextOverflow.clip);
  }
}
