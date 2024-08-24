import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/repository/api_repository/third_party_repos/clickup_repository.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_folder.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_space.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/models/third_app/clickup/per_list_of_folder.dart';
import 'package:audiotodo/utilities/components/dialogs/basic_dialogs.dart';
import 'package:audiotodo/utilities/constants/exceptions/api_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ClickUpSelect = Map<String, dynamic>;
typedef ClickUpSelectObject = Map<String, Object>;

enum ClickUpSelectableKeys { team, space, list, folder }

class CurrentSelectTaskManagerNotifier extends StateNotifier<ClickUpSelect> {
  CurrentSelectTaskManagerNotifier(ClickUpSelect state) : super({});
  ClickUpSelectObject clickUpSelectObject = {};

  final _clickUpRepository = ClickUpRepository.instance;

  void setCurrentSelects(
      ClickUpSelectableKeys key, String value, Object giveObject) {
    var tempMap = state;
    tempMap.addAll({key.name: value});
    clickUpSelectObject.addAll({key.name: giveObject});
    state = tempMap;

    switch (key) {
      case ClickUpSelectableKeys.team:
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.clickUpSelectSpacePage);
      case ClickUpSelectableKeys.space:
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.clickUpSelectFolderPage);
      case ClickUpSelectableKeys.folder:
        NavigationService.instance.navigateToPage(
            path: NavigationConstants.clickUpSelectListOfFolderPage);
      case ClickUpSelectableKeys.list:
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.clickUpCreateTaskPage);
    }
  }

  Future<List<ClickUpTeam>> getClickUpTeamList(WidgetRef ref) async {
    try {
      final list = await _clickUpRepository!.getTeamsFromClickUp(ref);
      return list;
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

  Future<List<ClickUpSpace>> getClickUpSpaceList(WidgetRef ref) async {
    try {
      final list = await _clickUpRepository!.getSpacesFromClickUp(ref);
      return list ?? [];
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

  Future<List<ClickUpFolder>> getClickUpFolderList(WidgetRef ref) async {
    try {
      final list = await _clickUpRepository!.getFoldersFromClickUp(ref);
      return list ?? [];
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

  Future<List<PerListOfFolder>> getClickUpListOfFolderList(
      WidgetRef ref) async {
    try {
      final list = await _clickUpRepository!.getListOfFolderFromClickUp(ref);
      return list ?? [];
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

  Future<void> sendTasksToClickUp(WidgetRef ref) async {
    try {
      final res = await _clickUpRepository!.sendTasksToClickUp(ref);

      logger.i("Res:$res");
      if (res) {
        BasicDialogs.successfullySavedDialog(ref);
      } else {
        BasicDialogs.failSaveDialog(ref);
      }
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
    }
  }
}
