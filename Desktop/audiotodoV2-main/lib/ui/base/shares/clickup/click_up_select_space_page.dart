import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/line/viewmodel/third_party/clickup/current_select_task_manager.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_space.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/components/icon/todo_match_icon_button.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ClickUpSelectSpacePage extends ConsumerStatefulWidget {
  const ClickUpSelectSpacePage({
    super.key,
  });

  @override
  ConsumerState createState() => _ClickUpSelectSpacePageState();
}

class _ClickUpSelectSpacePageState
    extends ConsumerState<ClickUpSelectSpacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.click_up_add_task_second_screen_app_bar_text,
      ),
      body: FutureBuilder<List<ClickUpSpace>>(
        future: ref
            .read(currentSelectsClickUpState.notifier)
            .getClickUpSpaceList(ref),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClickUpSpace>> snapshot) {
          final clickUpTeamList = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            itemCount: clickUpTeamList!.length,
            itemBuilder: (context, index) {
              final currentClickUpSpace = clickUpTeamList[index];
              return SizedBox(
                child: ListTile(
                  onTap: () => ref
                      .read(currentSelectsClickUpState.notifier)
                      .setCurrentSelects(
                          ClickUpSelectableKeys.space, currentClickUpSpace.id!,currentClickUpSpace),

                  title: Text(
                    currentClickUpSpace.name ?? "-",
                    style: ThemeValueExtension.headline6,
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
