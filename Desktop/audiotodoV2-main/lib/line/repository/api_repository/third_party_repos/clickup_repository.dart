import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/line/db/api/third_todos/clickup/clickup_api_base.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_folder.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_space.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/models/third_app/clickup/per_list_of_folder.dart';
import 'package:audiotodo/utilities/constants/app/config.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClickUpRepository extends ClickUpBase {


  static ClickUpRepository? _instance;

  static ClickUpRepository? get instance {
    _instance ??= ClickUpRepository._();
    return _instance;
  }

  ClickUpRepository._();

  // TODO You should think local control after send request

  @override
  Future<List<ClickUpTeam>> getTeamsFromClickUp(WidgetRef ref) async {

    final headers =
        RequestConfigs.getWithTokenHeader(ref, TodoPlatforms.clickUp.name);

    ///Initialize to Click Up
    await ClickUpApiManager.instance!.init(RequestConfigs.clickUpApiBaseUrl, headers);

    final listOfClickUpTeams =
        await ClickUpApiManager.instance!.getTeamsFromClickUp(ref);

    return listOfClickUpTeams;
  }

  @override
  Future<List<ClickUpSpace>?> getSpacesFromClickUp(WidgetRef ref) async {
    final listOfClickUpSpaces =
        await ClickUpApiManager.instance!.getSpacesFromClickUp(ref);

    return listOfClickUpSpaces;
  }

  @override
  Future<List<ClickUpFolder>?> getFoldersFromClickUp(WidgetRef ref) async {
    final listOfClickUpFolders =
        await ClickUpApiManager.instance!.getFoldersFromClickUp(ref);

    return listOfClickUpFolders;
  }

  @override
  Future<List<PerListOfFolder>?> getListOfFolderFromClickUp(WidgetRef ref) async {
    final listOfFolders =
        await ClickUpApiManager.instance!.getListOfFolderFromClickUp(ref);

    return listOfFolders;
  }

  @override
  Future<bool> sendTasksToClickUp(WidgetRef ref) async {
    return await ClickUpApiManager.instance!.sendTasksToClickUp(ref);
  }
}
