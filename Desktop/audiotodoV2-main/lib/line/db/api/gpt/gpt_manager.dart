import 'dart:convert';

import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/models/gpt/response_todo_model.dart';
import 'package:audiotodo/utilities/constants/exceptions/dio_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class GPTManager extends GptBase {
  static GPTManager? _instance;

  static GPTManager? get instance {
    _instance ??= GPTManager._();
    return _instance;
  }

  GPTManager._();

  @override
  final headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': dotenv.env['GPT_API_KEY'],
    'X-RapidAPI-Host': dotenv.env['GPT_API_HOST_VALUE'],
  };

  @override
  Future<ResponseTodoModel?> getResponseTodoModel(
      String meetContent, WidgetRef ref, String soundFileLink) async {
    try {
      final firstEnter = ref.read(authManager)!.firstEnter ?? false;

      // logger.i("First Enter: $firstEnter");

      final response = await customDio.post(
        '${customDio.options.baseUrl}api/release',
        options: Options(headers: headers),
        data: {
          "text": meetContent.isEmpty && !firstEnter
              ? ""
              : (meetContent.isEmpty && firstEnter)
                  ? "No recognized words."
                  : meetContent,
          "soundFileLink": soundFileLink,
          "plan": ref.read(authManager)!.planType.label,
          "firstEnter": firstEnter,
          "recognitionLanguage": ref.read(currentLanguageManager)!.localeId
        },
      );

      var responseJsonString = response.data['result']['content'];
      // logger.d("Response: $responseJsonString");

      if (response.statusCode == 200) {
        ResponseTodoModel responseTodoModel = ResponseTodoModel.fromJson(
            responseJsonString.runtimeType == String
                ? jsonDecode(responseJsonString)
                : responseJsonString);

        // logger.w("Response Todo Model: ${responseTodoModel.toJson()}");

        //We add created ResponseTodoModel x model until last meet content
        final createdUntilForNow = ref
            .read(currentPeriodicPromptManagerState.notifier)
            .responseTodoModelList;

        final modifiedResponseTodoModel =
            responseTodoModel.copyWith(recognizePersonNames: [
          ...responseTodoModel.recognizePersonNames ?? [],
          ref.read(authManager)!.userName ?? ""
        ], todos: [
          ...createdUntilForNow,
          ...responseTodoModel.todos ?? []
        ]);

        return modifiedResponseTodoModel;
      } else {
        return null;
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  @Deprecated("This method is not used anymore.")
  @override
  Future<List<ResponsePerTodoModel>> getPeriodicResponseModel(
      String meetContent, WidgetRef ref) async {
    try {
      final responseTodoModelList = <ResponsePerTodoModel>[];

      final response = await customDio.post(
        '${customDio.options.baseUrl}/api/periodically',
        options: Options(headers: headers),
        data: {"text": meetContent},
      );

      // logger.w(response.data['todos']);

      final jsonData = jsonDecode(response.data['todos']);
      final list = jsonData as List<dynamic>;
      logger.w(list);
      for (var jsonResponseTodo in list) {
        responseTodoModelList.add(
            ResponsePerTodoModel.fromJson(jsonResponseTodo)
                .copyWith(id: const Uuid().v4()));
      }

      // logger.i("Response:${response.data} ");

      return responseTodoModelList;
    } on DioException catch (e) {
      CustomDioExceptions.handleDioExceptions(e.message ?? "-", ref);
      return [];
    }
  }
}
