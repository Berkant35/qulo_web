import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/line/viewmodel/third_party/clickup/current_select_task_manager.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/gpt/response_per_todo_model.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_folder.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_space.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_task.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/models/third_app/clickup/per_list_of_folder.dart';
import 'package:audiotodo/utilities/constants/app/application_constants.dart';
import 'package:audiotodo/utilities/constants/app/config.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:audiotodo/utilities/constants/exceptions/dio_exceptions.dart';
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/util_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClickUpApiManager extends ClickUpBase {
  static ClickUpApiManager? _instance;

  static ClickUpApiManager? get instance {
    _instance ??= ClickUpApiManager._();
    return _instance;
  }

  ClickUpApiManager._();

  @override
  Future<List<ClickUpTeam>> getTeamsFromClickUp(WidgetRef ref) async {
    try {
      final headers =
          RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);
      List<ClickUpTeam> clickUpTeams = [];
      final response = await customDio.get('${customDio.options.baseUrl}team/',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final basicDynamicList = response.data['teams'] as List<dynamic>;

        for (var perClickUpDynamicJson in basicDynamicList) {
          final perClickUpTeamModel =
              ClickUpTeam.fromJson(perClickUpDynamicJson);
          clickUpTeams.add(perClickUpTeamModel);
        }
      } else {
        CustomDioExceptions.handleDioExceptions(
            ErrorTexts.statusCodeFailed, ref);
      }

      return clickUpTeams;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return [];
    }
  }

  @override
  Future<List<ClickUpSpace>?> getSpacesFromClickUp(WidgetRef ref) async {
    try {
      final headers =
          RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);

      List<ClickUpSpace> clickUpSpaces = [];

      final response = await customDio.get(
          '${customDio.options.baseUrl}team/${ref.read(currentSelectsClickUpState)[ClickUpSelectableKeys.team.name]}/space',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final basicDynamicList = response.data['spaces'] as List<dynamic>;

        for (var perClickUpDynamicJson in basicDynamicList) {
          final perClickUpSpaceModel =
              ClickUpSpace.fromJson(perClickUpDynamicJson);
          clickUpSpaces.add(perClickUpSpaceModel);
        }
      } else {
        CustomDioExceptions.handleDioExceptions(
            ErrorTexts.statusCodeFailed, ref);
      }

      return clickUpSpaces;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return [];
    }
  }

  @override
  Future<List<ClickUpFolder>?> getFoldersFromClickUp(WidgetRef ref) async {
    try {
      final headers =
          RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);

      List<ClickUpFolder> clickUpFolders = [];

      final response = await customDio.get(
          '${customDio.options.baseUrl}space/${ref.read(currentSelectsClickUpState)[ClickUpSelectableKeys.space.name]}/folder',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final basicDynamicList = response.data['folders'] as List<dynamic>;

        for (var perClickUpDynamicJson in basicDynamicList) {
          final perClickUpFolderModel =
              ClickUpFolder.fromJson(perClickUpDynamicJson);
          clickUpFolders.add(perClickUpFolderModel);
        }
      } else {
        CustomDioExceptions.handleDioExceptions(
            ErrorTexts.statusCodeFailed, ref);
      }

      return clickUpFolders;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return [];
    }
  }

  @override
  Future<List<PerListOfFolder>?> getListOfFolderFromClickUp(
      WidgetRef ref) async {
    try {
      List<PerListOfFolder> clickUpFolders = [];
      final headers =
          RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);

      final response = await customDio.get(
          '${customDio.options.baseUrl}folder/${ref.read(currentSelectsClickUpState)[ClickUpSelectableKeys.folder.name]}/list',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final basicDynamicList = response.data['lists'] as List<dynamic>;

        for (var perClickUpDynamicJson in basicDynamicList) {
          final perClickUpListOfFolderModel =
              PerListOfFolder.fromJson(perClickUpDynamicJson);
          clickUpFolders.add(perClickUpListOfFolderModel);
        }
      } else {
        CustomDioExceptions.handleDioExceptions(
            ErrorTexts.statusCodeFailed, ref);
      }

      return clickUpFolders;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return [];
    }
  }

  @override
  Future<bool> sendTasksToClickUp(WidgetRef ref) async {
    try {
      List<Future> listRequest = [];

      List<ResponsePerTodoModel> appTodoList = ref.watch(tempTodoListState.notifier).state;


      logger.i(appTodoList.length);


      final headers =
          RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);

      final options = Options(headers: headers);

      final path =
          '${customDio.options.baseUrl}list/${ref.read(currentSelectsClickUpState)[ClickUpSelectableKeys.list.name]}/task';

      appTodoList = appTodoList.distinct(by: (per) => per.todoTitle);

      for (var perAppTodo in appTodoList) {

        final createTempClickUpTask = ClickUpTask(
            name: perAppTodo.todoTitle,
            description: perAppTodo.todoContent,
            assignees: [],
            tags: (perAppTodo.tags ?? []) + (perAppTodo.assignedPersons ?? []),
            priority: 1,
            dueDateTime: perAppTodo.deadlineTime != null &&
                perAppTodo.deadlineTime!.isNotEmpty,
            dueDate: perAppTodo.deadlineTime != null &&
                    perAppTodo.deadlineTime!.isNotEmpty
                ? perAppTodo.deadlineTime?.fromddMMyyyy(perAppTodo.deadlineTime.toString()).millisecondsSinceEpoch
                : null,
            startDate: DateTime.now().millisecondsSinceEpoch,
            startDateTime: true);

        listRequest.add(customDio.post(path,
            options: options, data: createTempClickUpTask.toJson()));
      }

      await Future.value(listRequest)
          .then((value) => debugPrint("Per Response: $value"));

      return true;
    } on Exception catch (e) {
      logger.e(e.toString());
      CustomDioExceptions.handleDioExceptions(e.toString(), ref);
      return false;
    }
  }
}
