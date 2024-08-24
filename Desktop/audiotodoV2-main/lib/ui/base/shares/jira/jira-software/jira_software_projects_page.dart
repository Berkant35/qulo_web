import 'package:audiotodo/models/third_app/jira/jira-software/jira_software_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../line/viewmodel/global_providers.dart';
import '../../../../../utilities/components/bars/app_bars/basic_back_app_bar.dart';
import '../../../../../utilities/components/icon/todo_match_icon_button.dart';
import '../../../../../utilities/constants/extensions/context_extension.dart';
import '../../../../../utilities/constants/extensions/icon_size_extensions.dart';

class JiraSoftwareProjectsPage extends ConsumerStatefulWidget {
  const JiraSoftwareProjectsPage({
    super.key,
  });

  @override
  ConsumerState createState() => _JiraSoftwareProjectsPageState();
}

class _JiraSoftwareProjectsPageState
    extends ConsumerState<JiraSoftwareProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle:
            S.current.jira_software_add_task_first_screen_app_bar_text,
      ),
      body: FutureBuilder<List<JiraSoftwareProject>>(
        future: ref
            .read(currentJiraSoftwareProjectState.notifier)
            .getJiraSoftwareProjects(ref),
        builder: (BuildContext context,
            AsyncSnapshot<List<JiraSoftwareProject>> snapshot) {
          final jiraSoftwareProjectList = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done ||
              jiraSoftwareProjectList == null ||
              jiraSoftwareProjectList.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            itemCount: jiraSoftwareProjectList!.length,
            itemBuilder: (context, index) {
              final currentJiraSoftwareProject = jiraSoftwareProjectList[index];
              return SizedBox(
                child: ListTile(
                  onTap: () => ref
                      .read(currentJiraSoftwareProjectState.notifier)
                      .selectProjectToState(currentJiraSoftwareProject),
                  title: Text(
                    currentJiraSoftwareProject.name ?? "-",
                    style: ThemeValueExtension.headline6,
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.task_rounded,
                        size: IconSizeExtension.normal.sizeValue,
                      ),
                      GapSizedBox.miniGapW,
                      Text(
                        currentJiraSoftwareProject.key.toString() ?? "-",
                        style: ThemeValueExtension.subtitle,
                      ),
                    ],
                  ),
                  trailing: getPlatformSpecificArrowIcon(),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
