import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/repository/api_repository/third_party_repos/jira_software_repository.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utilities/constants/exceptions/api_exceptions.dart';


class JiraSoftwareSelectTaskManagerNotifier
    extends StateNotifier<JiraSoftwareProject?> {
  JiraSoftwareSelectTaskManagerNotifier(JiraSoftwareProject? state)
      : super(null);

  void selectProjectToState(JiraSoftwareProject? jsProject) {
    state = jsProject;
    NavigationService.instance.navigateToPage(
        path: NavigationConstants.jiraSoftwareCreateTaskPage);
  }

  final _jiraSoftwareRepository = JiraSoftwareRepository.instance;

  Future<List<JiraSoftwareProject>> getJiraSoftwareProjects(
      WidgetRef ref) async {
    try {
      final list = await _jiraSoftwareRepository!.getJiraSoftwareProjects(ref);
      return list;
    } catch (e) {
      ThirdPartyAppExceptions.handleRecordException(e.toString(), ref);
      return [];
    }
  }

}
