import 'package:audiotodo/line/db/local/locale_base.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LocaleClickUpDataManager extends ILocaleClickUpData {

  static LocaleClickUpDataManager? _instance;

  static LocaleClickUpDataManager? get instance {
    _instance ??= LocaleClickUpDataManager._();
    return _instance;
  }

  LocaleClickUpDataManager._();
  
  @override
  Future<List<ClickUpTeam>?> getTeamsFromClickUp(String collectionKey) {
    // TODO: implement getTeamsFromClickUp
    throw UnimplementedError();
  }
}