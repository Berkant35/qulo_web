import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/todos/detail_of_todo_result.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/todos/pre_view_result.dart';
import 'package:audiotodo/utilities/constants/enums/meet/result_view_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../generated/l10n.dart';
import '../../../../utilities/components/bars/app_bars/custom_with_back_app_bar.dart';

final class ResponseTodoList extends ConsumerStatefulWidget {
  final WidgetRef parentRef;
  final bool createForDetail;

  const ResponseTodoList(
      {super.key, required this.parentRef, required this.createForDetail});

  @override
  ConsumerState createState() => _ResponseTodoListState();
}

class _ResponseTodoListState extends ConsumerState<ResponseTodoList> {




  @override
  Widget build(BuildContext context) {
    final currentResultViewState =
    ref.watch(currentResultViewControlState);

    ref
        .watch(currentResultViewControlState.notifier)
        .setCreateForDetail(widget.createForDetail);

    return SafeArea(
      top: false,
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Center(
                  child: CustomWithBackAppBar(
                barText: S.current.result,
                showLeadingIcon:
                    currentResultViewState == ResultViewStates.todoMatch || widget.createForDetail,
                onPressed: () =>  handleStateChange(context,currentResultViewState),
              ))),
          Expanded(
            flex: 13,
            child: Consumer(builder: (context, customRef, child) {
              switch (currentResultViewState) {
                case ResultViewStates.summary:
                case ResultViewStates.cloudResult:
                  return ref
                      .read(currentMeetControllerManager) != null ?
                  DetailOfTodoResult(parentRef: widget.parentRef) : const SizedBox();
                case ResultViewStates.todoMatch:
                  return const PreViewResult();
                case ResultViewStates.details:
                  return Container();
                default:
                  return Container();
              }
            }),
          ),
        ],
      ),
    );
  }

  Future<void> handleStateChange(BuildContext context,ResultViewStates currentResultViewState) async {
    // Koşulları anlamlı değişkenlere ayır
    bool isTodoMatch = currentResultViewState == ResultViewStates.todoMatch;
    bool createForDetail = widget.createForDetail;

    // ResultViewStates değiştiricisini bir değişkene ayır
    final resultViewStateNotifier = ref.read(currentResultViewControlState.notifier);

    // logger.i("Is Todo Match: $isTodoMatch - Create For Detail: $createForDetail");


    if (isTodoMatch) {
      // Durum todoMatch ise summary'e değiştir
      resultViewStateNotifier.changState(ResultViewStates.summary);
    } else if (createForDetail) {
      // Detay oluşturma durumu varsa navigasyonu geri götür
      ref
          .read(currentMeetControllerManager.notifier).changeCurrentMeetState(null);
      await NavigationService.instance.navigatePopUp();
    } else {
      // Diğer tüm durumlar için summary'e değiştir
      resultViewStateNotifier.changState(ResultViewStates.summary);
    }
  }

}
