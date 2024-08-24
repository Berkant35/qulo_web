


import 'package:audiotodo/line/db/api/gpt/gpt_manager.dart';
import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/models/gpt/response_todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GPTRepository extends GptBase {
  static GPTRepository? _instance;

  static GPTRepository? get instance {
    _instance ??= GPTRepository._();
    return _instance;
  }

  GPTRepository._();


  final _gptManager = GPTManager.instance;

  @override
  Future<ResponseTodoModel?> getResponseTodoModel(String prompt,WidgetRef ref,String soundFileLink) async {
    return await _gptManager!.getResponseTodoModel(prompt,ref,soundFileLink);
  }

  @override
  Future<List<ResponsePerTodoModel>> getPeriodicResponseModel(String prompt,WidgetRef ref) async {
    return await _gptManager!.getPeriodicResponseModel(prompt,ref);
  }

}