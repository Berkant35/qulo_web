import 'dart:io';

import 'package:audiotodo/line/viewmodel/app/record/recorder_controller_manager.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_folder.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_space.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/models/third_app/clickup/per_list_of_folder.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_todo_model.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../main.dart';
import '../../../models/gpt/response_todo_model.dart';
import '../../../models/third_app/jira/jira-software/jira_software_project.dart';

abstract class NetworkBase {
  late Dio _dio;

  Dio get customDio => _dio;

  late Map<String, dynamic> _headers;

  Map<String, dynamic> get headers => _headers;

  NetworkBase();

  init(String baseUrl, Map<String, dynamic>? headers) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
    // logger.w("Dio initialized with base url: $baseUrl");
    _dio.interceptors.add(InterceptorsWrapper(onError: (e, handler) {
      logger.e("$baseUrl$headers\n$e\n${e.message ?? ""}\n${e.response}");

      handler.next(e);
    }));
    _headers = headers ?? {};
  }

  Future<String?> downloadFile(
      String url, String meetId, SoundFileTypes soundFileTypes) async {
    // Geçici dizini alın
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    // Kaydedilecek dosya yolunu oluşturun
    String filePath = '$tempPath/$meetId.$soundFileTypes';
    await File(filePath).create(recursive: true);
    // Dosyayı indirin
    await Dio().download(url, filePath);

    return filePath;
  }
}

abstract class UserExperience extends NetworkBase {
  Future<bool> sendContactUsMail(
      WidgetRef ref, String message, ProblemType problemType,String email);
}

// downloadFile için bunu yaptım...
abstract class DioManager extends NetworkBase {
  Future<Response?> get(String path, Map<String, dynamic> queryParameters);

  Future<Response?> post(String path, Map<String, dynamic> data);

  Future<Response?> put(String path, Map<String, dynamic> data);

  Future<Response?> delete(String path, Map<String, dynamic> data);
}

abstract class GptBase extends NetworkBase {
  Future<ResponseTodoModel?> getResponseTodoModel(
      String meetContent, WidgetRef ref, String soundFileLink);

  Future<List<ResponsePerTodoModel>> getPeriodicResponseModel(
      String meetContent, WidgetRef ref);
}

abstract class ClickUpBase extends NetworkBase {
  Future<List<ClickUpTeam>?> getTeamsFromClickUp(WidgetRef ref);

  Future<List<ClickUpSpace>?> getSpacesFromClickUp(WidgetRef ref);

  Future<List<ClickUpFolder>?> getFoldersFromClickUp(WidgetRef ref);

  Future<List<PerListOfFolder>?> getListOfFolderFromClickUp(WidgetRef ref);

  Future<bool> sendTasksToClickUp(WidgetRef ref);
}

abstract class JiraSoftwareBase extends NetworkBase {
  Future<List<JiraSoftwareProject>> getJiraSoftwareProjects(WidgetRef ref);

  Future<bool> createJiraSoftwareTodo(WidgetRef ref,
      {required JiraSoftwareToDoModel jsTodoModel});
}
