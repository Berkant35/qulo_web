import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTodoManager extends StateNotifier<ResponsePerTodoModel?> {
  EditTodoManager(ResponsePerTodoModel? state) : super(null);

  //When you click to per result card or slid list trigger this function
  void setCurrentResponseTodoModel(
      WidgetRef ref, ResponsePerTodoModel perTodoModel) {
    state = perTodoModel;
  }

  Future<void> updateToCloud(WidgetRef ref) async {
    final currentMeet = ref.read(currentMeetControllerManager);

    currentMeet!.responseTodo!.todos!.firstWhere(
            (perTodo) => perTodo.id == state!.id);
  }
}
