import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/third_party/clickup/current_select_task_manager.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_folder.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../line/viewmodel/global_providers.dart';
import '../../../../utilities/components/icon/todo_match_icon_button.dart';


class ClickUpSelectFolderPage extends ConsumerStatefulWidget {
  const ClickUpSelectFolderPage({
    super.key,
  });

  @override
  ConsumerState createState() => _ClickUpSelectFolderPageState();
}

class _ClickUpSelectFolderPageState
    extends ConsumerState<ClickUpSelectFolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.click_up_add_task_third_screen_app_bar_text,
      ),
      body: FutureBuilder<List<ClickUpFolder>>(
        future: ref
            .read(currentSelectsClickUpState.notifier)
            .getClickUpFolderList(ref),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClickUpFolder>> snapshot) {
          final clickUpTeamList = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            itemCount: clickUpTeamList!.length,
            itemBuilder: (context, index) {
              final currentClickUpFolder = clickUpTeamList[index];
              return SizedBox(
                child: ListTile(
                  onTap: () => ref
                      .read(currentSelectsClickUpState.notifier)
                      .setCurrentSelects(
                      ClickUpSelectableKeys.folder, currentClickUpFolder.id!,currentClickUpFolder),
                  title: Text(
                    currentClickUpFolder.name ?? "-",
                    style: ThemeValueExtension.headline6,
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.task_rounded,size: IconSizeExtension.normal.sizeValue,),
                      GapSizedBox.miniGapW,
                      Text(
                        currentClickUpFolder.taskCount.toString() ?? "-",
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
