import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DraggableTodo extends ConsumerStatefulWidget {
  final ResponsePerTodoModel perTodoModel;

  const DraggableTodo({super.key, required this.perTodoModel});

  @override
  ConsumerState createState() => _DraggableTodoState();
}

class _DraggableTodoState extends ConsumerState<DraggableTodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: EdgeExtension.lowEdge.edgeValue),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Text(widget.perTodoModel.todoTitle ?? "-",
                      style: ThemeValueExtension.titleTextStyle
                          .copyWith(color: Colors.white)),
                  const Divider(),
                  Text(widget.perTodoModel.todoContent ?? "-",
                      style: ThemeValueExtension.subtitle
                          .copyWith(color: Colors.white)),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(EdgeExtension.lowEdge.edgeValue),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: CustomColors.fillWhiteColor,
                      onPressed: () {
                        if (ref.watch(tempTodoListState).any((element) =>
                        element.todoTitle ==
                            widget.perTodoModel.todoTitle)) {
                          ref
                              .read(tempTodoListState.notifier)
                              .delete(ref, widget.perTodoModel);
                        } else {
                          ref
                              .read(tempTodoListState.notifier)
                              .add(ref, widget.perTodoModel);
                        }
                      },
                      child: Icon(
                        ref.watch(tempTodoListState).any((element) =>
                                element.todoTitle ==
                                widget.perTodoModel.todoTitle)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: widget.perTodoModel.tags!.map((name) {
                            return Chip(
                              backgroundColor: CustomColors.accentColor,
                              label: Text(
                                name,
                                style: ThemeValueExtension.chip.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
