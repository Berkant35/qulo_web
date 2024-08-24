import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/todos/per_draggable_widget.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/components/dialogs/record_dialogs.dart';
import 'package:audiotodo/utilities/components/icon/todo_match_icon_button.dart';
import 'package:audiotodo/utilities/components/sheets/sheets.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/widget_extensions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PreViewResult extends ConsumerStatefulWidget {
  const PreViewResult({
    super.key,
  });

  @override
  ConsumerState createState() => _PreViewResultState();
}

class _PreViewResultState extends ConsumerState<PreViewResult> {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {




    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.55.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: chips()),
          Expanded(
            flex: 10,
            child: CustomShowCaseWidget(
                showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                    (element) =>
                        element.key == ShowCaseStates.resultToDoCards.name),
                onPressedTarget: () {},
                showCaseContentWidget: todoList(ref)),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: samePaddingWithVertically(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!ref
                      .read(currentResultViewControlState.notifier)
                      .createForDetail)
                    CustomShowCaseWidget(
                      showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                          (element) =>
                              element.key ==
                              ShowCaseStates.resultButtonFinish.name),
                      onPressedTarget: () =>
                          Sheets.cancelCurrentMeeting(context, ref),
                      showCaseContentWidget: TodoMatchIconButton(
                        Icons.dnd_forwardslash,
                        () => Sheets.cancelCurrentMeeting(context, ref),
                        svgPicture: IconPaths.icPdfButton.customSvgIcon(),
                        imagePath: IconPaths.icCancelPng,
                      ),
                    ),
                  CustomShowCaseWidget(
                    showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) =>
                            element.key ==
                            ShowCaseStates.resultButtonsOffice.name),
                    showCaseContentWidget: TodoMatchIconButton(
                      Icons.picture_as_pdf,
                      () =>
                          Sheets.saveToMicrosoftFileSheetFunction(context, ref),
                      svgPicture: IconPaths.icPdfButton.customSvgIcon(),
                      imagePath: AssetPaths.icOffice,
                    ),
                    onPressedTarget: (){},
                  ),
                  CustomShowCaseWidget(
                    showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) =>
                            element.key ==
                            ShowCaseStates.resultButtonThirdParty.name),
                    onPressedTarget: (){},
                    showCaseContentWidget: TodoMatchIconButton(
                      Icons.link,
                      () => Sheets.saveToThirdPartySheetFunction(context, ref),
                      svgPicture: IconPaths.icShareButton.customSvgIcon(),
                      imagePath: AssetPaths.icThirdShare,
                    ),
                  ),
                  CustomShowCaseWidget(
                    showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                        (element) =>
                            element.key ==
                            ShowCaseStates.resultButtonRateUs.name),
                    onPressedTarget: (){},
                    showCaseContentWidget: TodoMatchIconButton(
                      Icons.star,
                      () => RecordDialogs.giveRateAboutMeet(ref),
                      svgPicture: IconPaths.icLike
                          .customSvgIcon(color: CustomColors.fillWhiteColor),
                      imagePath: AssetPaths.icLikePng,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  EdgeInsets samePaddingWithHorizontally() =>
      EdgeInsets.symmetric(horizontal: EdgeExtension.normalEdge.edgeValue);

  EdgeInsets samePaddingWithVertically() =>
      EdgeInsets.symmetric(vertical: EdgeExtension.normalEdge.edgeValue);

  TextStyle titleTheme() =>
      ThemeValueExtension.headline6.copyWith(fontWeight: FontWeight.w700);

  TextStyle contentTitleTheme() =>
      ThemeValueExtension.headline6.copyWith(fontWeight: FontWeight.w700);

  Widget chips() {
    final repsonseTodo = ref.watch(currentMeetControllerManager)!.responseTodo;

    return CustomShowCaseWidget(
      showCaseInfo: ref.read(currentAllShowCases).firstWhere((element) =>
          element.key == ShowCaseStates.resultAssignedPersons.name),
      onPressedTarget: () {},
      showCaseContentWidget: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.people_outline, size: 4.h),
                  SizedBox(
                    width: 2.w,
                  ),
                  Flexible(
                    child: Text(
                      S.current.result_recognized_people_name,
                      style: ThemeValueExtension.titleTextStyle.copyWith(
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
              repsonseTodo!.recognizePersonNames != null &&
                      repsonseTodo.recognizePersonNames!.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      children: repsonseTodo.recognizePersonNames!.map((name) {
                        return Draggable<String>(
                          data: name ?? '',
                          feedback: Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: Chip(
                                backgroundColor: CustomColors.primaryColor,
                                label: Text(
                                  name,
                                  style: ThemeValueExtension.chip.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          child: Chip(
                            backgroundColor: CustomColors.primaryColor,
                            label: Text(
                              name,
                              style: ThemeValueExtension.chip.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Text(
                        '${S.current.result_recognized_empty}!',
                        style: ThemeValueExtension.subtitle.copyWith(
                          overflow: TextOverflow.clip,
                          color: CustomColors.errorColor,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todoList(WidgetRef childRef) {
    final responseTodo =
        childRef.watch(currentMeetControllerManager)!.responseTodo;

    return Column(
      children: [
        Expanded(
          flex: 9,
          child: PageView.builder(
            controller: controller,
            itemCount: responseTodo!.todos!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final responsePerTodo = responseTodo.todos![index];
              if (!mounted) {
                childRef
                    .read(currentPerTodoEditControlState.notifier)
                    .setCurrentResponseTodoModel(childRef, responsePerTodo);
              }

              return PerDraggableWidget(responsePerTodo, index);
            },
          ),
        ),
        if (responseTodo.todos!.isNotEmpty)
          SmoothPageIndicator(
            controller: controller,
            count: responseTodo.todos!.length,
            effect: ExpandingDotsEffect(
              dotColor: CustomColors.grey2Color,
              radius: 25.0.w,
              dotHeight: 1.14.h,
              dotWidth: 2.14.w,
              activeDotColor: CustomColors.primaryColor,
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
