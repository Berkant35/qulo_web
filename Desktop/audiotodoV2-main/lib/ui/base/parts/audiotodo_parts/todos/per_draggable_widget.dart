import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/components/dialogs/util_dialogs.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/string_extensions.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'draggable_helper/draggable_todo.dart';

class PerDraggableWidget extends ConsumerStatefulWidget {
  final ResponsePerTodoModel perTodoModel;
  final int index;

  const PerDraggableWidget(
    this.perTodoModel,
    this.index, {
    super.key,
  });

  @override
  ConsumerState createState() => _PerDraggableWidgetState();
}

class _PerDraggableWidgetState extends ConsumerState<PerDraggableWidget> {
  List<String> names = [];

  @override
  Widget build(BuildContext context) {
    names = ref.watch(currentPerTodoEditControlState)?.assignedPersons ?? [];
    // final ShowPlatformDatePicker platformDatePicker =
    //     ShowPlatformDatePicker(buildContext: context);

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: EdgeExtension.lowEdge.edgeValue,
            vertical: EdgeExtension.lowEdge.edgeValue),
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Opacity(
            opacity: ref.watch(tempTodoListState).any((element) =>
                    element.todoTitle == widget.perTodoModel.todoTitle)
                ? 1
                : 0.5,
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                shadowDarkColor: CustomColors.lightGreenColor,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(
                    Radius.circular(EdgeExtension.lowEdge.edgeValue))),
                depth: -15,
                intensity: 0.15,
                surfaceIntensity: 0.04,
                lightSource: LightSource.top,
                color: CustomColors.primaryColor,
              ),
              child: Column(
                children: [
                  Expanded(flex: 2, child: topDraggable(ref,widget.index)),
                  Expanded(flex: 7, child: contentDraggable()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container topDraggable(WidgetRef customRef, int index) {
    final targetTodo = customRef
        .watch(tempTodoListState)
        .where((element) => element.todoTitle == widget.perTodoModel.todoTitle)
        .toList();

    final time = targetTodo.isNotEmpty
        ? (targetTodo.first.deadlineTime != null &&
                targetTodo.first.deadlineTime!.isDate())
            ? targetTodo.first.deadlineTime
            : ""
        : "";

    return Container(
      decoration: BoxDecoration(
        color: CustomColors.fillWhiteColor,
        border: Border.all(
            color: CustomColors.lightGreenColor,
            width: 0.5.w,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(EdgeExtension.lowEdge.edgeValue),
            topRight: Radius.circular(EdgeExtension.lowEdge.edgeValue)),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: EdgeExtension.lowEdge.edgeValue),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: tabBarOfCard(time,widget.index),
            ),
            Expanded(
              flex: 6,
              child: CustomShowCaseWidget(
                showCaseInfo: index == 0
                    ? customRef.read(currentAllShowCases).firstWhere(
                        (element) =>
                            element.key ==
                            ShowCaseStates.resultAddOrRemove.name)
                    : null,
                onPressedTarget: () {},
                showCaseContentWidget: Row(
                  children: [
                    Expanded(flex: 5, child: targetAssignPeople()),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () async {
                            //Todo open pop up
                            final name =
                                await UtilDialogs.getName(context, ref);
                            if (name == null) return;
                            addNewAssignPersonName(name);
                            // assignPeopleAndUpdateToCloud(data);
                          },
                          icon: const Icon(Icons.add_circle),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewAssignPersonName(String name) {
    final list = ref
        .watch(tempTodoListState)
        .where((element) => element.todoTitle == widget.perTodoModel.todoTitle)
        .toList();

    final currentPerTodoModel =
        list.isNotEmpty ? list.first : widget.perTodoModel;

    //check if is already contain return
    if (currentPerTodoModel.assignedPersons?.contains(name) ?? false) return;

    final updatedPerTodoModel = currentPerTodoModel.copyWith(assignedPersons: [
      ...currentPerTodoModel.assignedPersons?.toList() ?? [],
      name.toString()
    ]);
    //
    // logger.i(updatedPerTodoModel.assignedPersons);
    ref.read(tempTodoListState.notifier).update(ref, updatedPerTodoModel);
  }

  Widget tabBarOfCard(String? time,int index) {
    logger.i("Time: $time");
    return GestureDetector(
      onTap: getDeadlineDate,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  end: BorderSide(
                    color: CustomColors.lightGreenColor,
                    width: 0.4.w,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: CustomShowCaseWidget(
                        showCaseInfo: index == 0 ? ref.read(currentAllShowCases).firstWhere(
                            (element) =>
                                element.key ==
                                ShowCaseStates.resultAddDate.name) : null,
                        onPressedTarget: () {},
                        showCaseContentWidget: Container(
                          decoration: BoxDecoration(
                              color: CustomColors.primaryColor,
                              border: Border.all(
                                width: 0.w,
                                color: CustomColors.accentColor,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.px),
                                bottomLeft: Radius.circular(
                                    EdgeExtension.lowEdge.edgeValue),
                                bottomRight: Radius.circular(
                                    EdgeExtension.lowEdge.edgeValue),
                              )),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Center(
                                child: Text(
                                  time!.isNotEmpty
                                      ? time.fromddMMyyyyDate.year.toString()
                                      : "yyyy",
                                  style: ThemeValueExtension.subtitle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.fillWhiteColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 3; i++)
                                      Icon(
                                        Icons.circle,
                                        size: 1.15.h,
                                        color: CustomColors.fillWhiteColor,
                                      )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                time.isNotEmpty
                                    ? time.fromddMMyyyyDate.month
                                        .monthNameByNumber
                                        .substring(0, 3)
                                    : "mm",
                                style: ThemeValueExtension.subtitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.accentColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                time.isNotEmpty
                                    ? time.fromddMMyyyyDate.day.toString()
                                    : "dd",
                                style: ThemeValueExtension.headline6.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.accentColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  void getDeadlineDate() async {
    final choosedDeadLineDate = await UtilDialogs.selectDate(context);

    if (choosedDeadLineDate != null) {
      final updatedPerTodoModel = widget.perTodoModel.copyWith(
          deadlineTime: CustomTimeFormat(choosedDeadLineDate!).forceddMMyyyy,
          assignedPersons: ref.watch(tempTodoListState).isNotEmpty
              ? ref
                  .watch(tempTodoListState)
                  .where((element) =>
                      element.todoTitle == widget.perTodoModel.todoTitle)
                  .toList()
                  .first
                  .assignedPersons
              : []);

      ref.read(tempTodoListState.notifier).update(ref, updatedPerTodoModel);
    }
  }

  Padding targetAssignPeople() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: DragTarget<String>(
        onWillAccept: (data) {
          addNewAssignPersonName(data ?? "--");

          return data != null;
        },
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return Container(
            decoration: BoxDecoration(
              color: CustomColors.fillWhiteColor,
              borderRadius:
                  BorderRadius.circular(EdgeExtension.lowEdge.edgeValue),
            ),
            child: Container(
              height: double.infinity,
              decoration: DottedDecoration(
                shape: Shape.box,
                color: CustomColors.primaryColor,
                borderRadius: BorderRadius.circular(EdgeExtension
                    .lowEdge.edgeValue), //remove this to get plane rectange
              ),
              child: Center(
                  child: Text(
                S.current.result_match_name_drag,
                style: ThemeValueExtension.titleTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    color: CustomColors.grey2Color),
              )),
            ),
          );
        },
        onAccept: (data) {
          names.add(data);
        },
      ),
    );
  }

  Container contentDraggable() {
    return Container(
      color: CustomColors.primaryColor,
      child: Row(
        children: [
          Expanded(
              flex: 6, child: DraggableTodo(perTodoModel: widget.perTodoModel)),
          Expanded(flex: 4, child: assignPart()),
        ],
      ),
    );
  }

  Container assignPart() {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: Center(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    S.current.result_match_todo_persons,
                    style: ThemeValueExtension.titleTextStyle,
                  ),
                )),
            Expanded(
              flex: 17,
              child: assignList(),
            ),
          ],
        ),
      ),
    );
  }

  ListView assignList() {
    final targetTodo = ref
        .watch(tempTodoListState)
        .where((element) => element.todoTitle == widget.perTodoModel.todoTitle);
    final assignedPersons =
        targetTodo.isNotEmpty ? targetTodo.first.assignedPersons ?? [] : [];

    return ListView.builder(
      itemExtent: 8.h,
      itemCount: assignedPersons.length,
      itemBuilder: (context, index) => assignCard(index),
    );
  }

  Card assignCard(int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(left: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                ref
                    .watch(tempTodoListState)
                    .where((element) =>
                        element.todoTitle == widget.perTodoModel.todoTitle)
                    .first
                    .assignedPersons![index],
                style: ThemeValueExtension.primary,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              flex: 3,
              child: removeCase(index),
            )
          ],
        ),
      ),
    );
  }

  IconButton removeCase(int index) {
    return IconButton(
        onPressed: () {
          final data = ref
              .watch(tempTodoListState)
              .where((element) =>
                  element.todoTitle == widget.perTodoModel.todoTitle)
              .first
              .assignedPersons![index];

          final currentPerTodoModel = ref
              .watch(tempTodoListState)
              .where((element) =>
                  element.todoTitle == widget.perTodoModel.todoTitle)
              .toList()
              .first;

          final updatedPerTodoModel = currentPerTodoModel.copyWith(
              assignedPersons: currentPerTodoModel.assignedPersons
                      ?.where((element) => element != data)
                      .toList() ??
                  []);

          ref.read(tempTodoListState.notifier).update(ref, updatedPerTodoModel);
        },
        icon: Icon(
          Icons.remove_circle,
          size: 3.h,
          color: CustomColors.accentColor,
        ));
  }
}
