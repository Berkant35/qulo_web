import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/line/viewmodel/third_party/clickup/current_select_task_manager.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/third_app/clickup/per_list_of_folder.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/todos/per_draggable_widget.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/components/buttons/neu_text_button.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ClickUpCreateTask extends ConsumerStatefulWidget {
  const ClickUpCreateTask({
    super.key,
  });

  @override
  ConsumerState createState() => _ClickUpCreateTaskState();
}

class _ClickUpCreateTaskState extends ConsumerState<ClickUpCreateTask> {
  final controller = PageController(viewportFraction: 1, keepPage: false);

  @override
  Widget build(BuildContext context) {
    final repsonseTodo = ref.watch(currentMeetControllerManager)!.responseTodo;
    // logger.i(controller.page.toString());
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.choose_todos,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.click_up_create_task,
                      style: ThemeValueExtension.subtitle,
                    ),
                    Text(
                      (ref
                                      .read(currentSelectsClickUpState.notifier)
                                      .clickUpSelectObject[
                                  ClickUpSelectableKeys
                                      .list.name] as PerListOfFolder)
                              .name ??
                          "-",
                      style: ThemeValueExtension.subtitle
                          .copyWith(color: CustomColors.grey2Color),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 14,
            child: Column(
              children: [
                Expanded(flex: 2, child: chips()),
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: repsonseTodo!.todos!.length,
                    itemBuilder: (_, index) {
                      final responsePerTodo = repsonseTodo.todos![index];

                      if (!mounted) {
                        ref
                            .read(currentPerTodoEditControlState.notifier)
                            .setCurrentResponseTodoModel(ref, responsePerTodo);
                      }

                      return PerDraggableWidget(responsePerTodo,index);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: repsonseTodo.todos!.isNotEmpty
                ? Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: repsonseTodo.todos!.length,
                      effect: ExpandingDotsEffect(
                        dotColor: CustomColors.grey2Color,
                        radius: 25.0.w,
                        dotHeight: 1.14.h,
                        dotWidth: 2.14.w,
                        activeDotColor: CustomColors.primaryColor,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          Expanded(
              flex: 4,
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: NeuTextButton(
                    text: S.current.click_up_create_task_button_text,
                    onPressed: () => ref.read(currentSelectsClickUpState.notifier).sendTasksToClickUp(ref),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget chips() {
    final repsonseTodo = ref.watch(currentMeetControllerManager)!.responseTodo;

    return SingleChildScrollView(
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            repsonseTodo!.recognizePersonNames!.isNotEmpty
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
                      style: ThemeValueExtension.subtitle2.copyWith(
                        overflow: TextOverflow.clip,
                        color: CustomColors.errorColor,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
