import 'package:audiotodo/line/repository/api_repository/gpt_repository.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';

import '../../../utilities/helper/gpt/prompts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeriodicPromptManagerNotifier extends StateNotifier<StringBuffer?> {
  PeriodicPromptManagerNotifier(StringBuffer? state) : super(null);
  List<ResponsePerTodoModel> responseTodoModelList = [];
  final _gptRepository = GPTRepository.instance;
  List<String> sentText = [];

  void create(WidgetRef ref) {
    state = StringBuffer();
  }

  void update(WidgetRef ref) {}

  Future<String> getLastMeetContent(WidgetRef ref, String meetContent) async {
    String tempText = meetContent;

    for (var text in sentText) {
      if (tempText.contains(text)) {
        tempText = tempText.replaceAll(text, "");
      }
    }
    return tempText;
  }

  Future<void> add(WidgetRef ref, String meetContent) async {
    String tempText = meetContent;

    for (var text in sentText) {
      if (tempText.contains(text)) {
        tempText = tempText.replaceAll(text, "");
      }
    }

    final wordCount = tempText.toString().split(" ").length;

    if (wordCount > 150) {
      final getList =
      await _gptRepository!.getPeriodicResponseModel(
          Prompts.getPromptPeriodicText(tempText,ref.read(currentLanguageManager)!.localeId), ref);

      responseTodoModelList.addAll(getList);

      sentText.add(tempText);
    }
  }

  void delete(WidgetRef ref) {
    state = null;
  }
}
