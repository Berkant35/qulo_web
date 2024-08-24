import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/line/viewmodel/third_party/clickup/current_select_task_manager.dart';
import 'package:audiotodo/models/third_app/clickup/click_up_team.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:audiotodo/utilities/components/icon/todo_match_icon_button.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/custom_colors.dart';

class ClickUpSelectTeamPage extends ConsumerStatefulWidget {
  const ClickUpSelectTeamPage({
    super.key,
  });

  @override
  ConsumerState createState() => _ClickUpSelectTeamPageState();
}

class _ClickUpSelectTeamPageState extends ConsumerState<ClickUpSelectTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle: S.current.click_up_add_task_first_screen_app_bar_text,
      ),
      body: FutureBuilder<List<ClickUpTeam>>(
        future: ref
            .read(currentSelectsClickUpState.notifier)
            .getClickUpTeamList(ref),
        builder:
            (BuildContext context, AsyncSnapshot<List<ClickUpTeam>> snapshot) {
          final clickUpTeamList = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            itemCount: clickUpTeamList!.length,
            itemBuilder: (context, index) {
              final currentClickUpTeam = clickUpTeamList[index];
              return SizedBox(
                child: ListTile(
                  onTap: () => ref
                      .read(currentSelectsClickUpState.notifier)
                      .setCurrentSelects(
                          ClickUpSelectableKeys.team, currentClickUpTeam.id!,currentClickUpTeam),
                  leading: SizedBox(
                    width: 15.w,
                    height: 15.w,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(EdgeExtension.hugeEdge.edgeValue)),
                        color: Color(
                          int.parse(currentClickUpTeam.color!
                              .replaceAll("#", "0xff")),
                        ),
                      ),
                      child: Image.network(
                        currentClickUpTeam.avatar!,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    currentClickUpTeam.name ?? "-",
                    style: ThemeValueExtension.headline6,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentClickUpTeam.id ?? "-",
                        style: ThemeValueExtension.subtitle,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.people_alt_sharp,
                            color: CustomColors.accentColor,
                            size: IconSizeExtension.small.sizeValue,
                          ),
                          GapSizedBox.miniGapW,
                          Text(
                            currentClickUpTeam.members?.length.toString() ??
                                "-",
                            style: ThemeValueExtension.subtitle2,
                          )
                        ],
                      )
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
