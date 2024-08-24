import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/utilities/constants/extensions/util_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef TempConfirmTodoList = List<ResponsePerTodoModel>;

/// This provider is used to manage before updload any current meeting model to cloud.
/// TempConfirmTodoList will equal to current meeting model's todo list.

class TempConfirmTodoNotifier extends StateNotifier<TempConfirmTodoList> {
  TempConfirmTodoNotifier(TempConfirmTodoList state) : super([]);

  void initialize(WidgetRef ref) {
    if(ref.read(currentMeetControllerManager)?.responseTodo != null){
      state = ref.read(currentMeetControllerManager)!.responseTodo!.todos!;
    }else{
      state = [];
    }
  }

  void add(WidgetRef ref, ResponsePerTodoModel todoModel) =>
      state = [...state, todoModel];

  void delete(WidgetRef ref, ResponsePerTodoModel todoModel) {
    state = state.where((element) => element.todoTitle != todoModel.todoTitle).toList();

    // logger.i("Deleting...:${state.toSet()}");
  }


  void update(WidgetRef ref, ResponsePerTodoModel todoModel) {
    // logger.w("Update...");
    List<ResponsePerTodoModel> list = state.toList();
    //update the todo model
    var index = list.indexWhere((element) => element.todoTitle == todoModel.todoTitle);
    // logger.i(index);
    if(index.isFinite && index >= 0){
      list[index] = todoModel;
      state = list;
    }



  }

  void clear() => state.clear();
}
