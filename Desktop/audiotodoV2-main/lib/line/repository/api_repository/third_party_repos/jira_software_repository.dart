import 'package:audiotodo/line/db/api/network_base.dart';
import 'package:audiotodo/line/db/api/third_todos/jira/jira_software_base.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_project.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/constants/app/config.dart';
import '../../../../utilities/constants/enums/integration/todo_platforms.dart';

class JiraSoftwareRepository extends JiraSoftwareBase {
  static JiraSoftwareRepository? _instance;

  static JiraSoftwareRepository? get instance {
    _instance ??= JiraSoftwareRepository._();
    return _instance;
  }

  JiraSoftwareRepository._();

  @override
  Future<bool> createJiraSoftwareTodo(WidgetRef ref,
      {required JiraSoftwareToDoModel jsTodoModel}) async {
    return true;
  }

  @override
  Future<List<JiraSoftwareProject>> getJiraSoftwareProjects(
      WidgetRef ref) async {
    final headers = RequestConfigs.getWithTokenHeaderForJiraSoftware(ref,
        TodoPlatforms.jiraSoftwareDomain.name, TodoPlatforms.jiraSoftware.name);

    ///Initialize to Click Up
    await JiraSoftwareApiManager.instance!.init(
        "https://${ref
            .read(authManager)!
            .todoPlatformTokens![TodoPlatforms.jiraSoftwareDomain.name]!.split("@").first}.atlassian.net/",
        headers);

    final listJiraSoftwareProjects =
        await JiraSoftwareApiManager.instance!.getJiraSoftwareProjects(ref);
    return listJiraSoftwareProjects;
  }
}
