import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/fields.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_project.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_todo_model.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/project.dart';
import 'package:audiotodo/utilities/constants/extensions/util_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../main.dart';
import '../../../../../models/gpt/response_per_todo_model.dart';
import '../../../../../utilities/constants/app/application_constants.dart';
import '../../../../../utilities/constants/exceptions/dio_exceptions.dart';
import '../../../../viewmodel/global_providers.dart';

class JiraSoftwareApiManager extends JiraSoftwareBase {
  static JiraSoftwareApiManager? _instance;

  static JiraSoftwareApiManager? get instance {
    _instance ??= JiraSoftwareApiManager._();
    return _instance;
  }

  JiraSoftwareApiManager._();

  @override
  Future<List<JiraSoftwareProject>> getJiraSoftwareProjects(
      WidgetRef ref) async {
    try {

      String manipulateBaseUrl = customDio.options.baseUrl;

      if(!customDio.options.baseUrl.endsWith("/")){
        manipulateBaseUrl = "$manipulateBaseUrl/";
      }

      final response = await customDio.get(
          '${manipulateBaseUrl}rest/api/3/project',
          options: Options(headers: customDio.options.headers));

      List<JiraSoftwareProject> jiraSoftwareProjects = [];

      if (response.statusCode == 200) {

        final basicDynamicList = response.data as List<dynamic>;

        for (var perJiraSoftwareProjectJson in basicDynamicList) {

          final perJiraSoftwareProjectModel =
              JiraSoftwareProject.fromJson(perJiraSoftwareProjectJson);
          jiraSoftwareProjects.add(perJiraSoftwareProjectModel);

        }
      } else {
        CustomDioExceptions.handleDioExceptions(
            ErrorTexts.statusCodeFailed, ref);
      }
      return jiraSoftwareProjects;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return [];
    }
  }

  @override
  Future<bool> createJiraSoftwareTodo(WidgetRef ref,
      {required JiraSoftwareToDoModel jsTodoModel})  async {
    try{
      String manipulateBaseUrl = customDio.options.baseUrl;

      if(!customDio.options.baseUrl.endsWith("/")){
        manipulateBaseUrl = "$manipulateBaseUrl/";
      }


      List<Future> listRequest = [];

      List<ResponsePerTodoModel> appTodoList = ref.watch(tempTodoListState);

      appTodoList = appTodoList.distinct(by: (per)=>per.todoTitle);

      JiraSoftwareToDoModel jsTodoModel = JiraSoftwareToDoModel(
        fields: Fields(
          project: Project(
              key:  ref.read(currentJiraSoftwareProjectState)!.projectTypeKey
          ),

      ));

      for (var perAppTodo in appTodoList) {
        // jsTodoModel.fields =
        //
        // listRequest.add(customDio.post(path,
        //     options: options, data: createTempClickUpTask.toJson()));
      }


      final response = await customDio.post(
          '${manipulateBaseUrl}rest/api/3/issue',
          options: Options(headers: customDio.options.headers),

      );

      return true;
    }on Exception catch(e){
      logger.e("Error: $e");
      return false;
    }
  }
}
