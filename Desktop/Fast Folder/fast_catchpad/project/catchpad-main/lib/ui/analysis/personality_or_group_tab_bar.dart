import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/cp_colors.dart';

class PersonalityOrGroupTabBar extends ConsumerStatefulWidget {
  final TabController tabController;
  const PersonalityOrGroupTabBar({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalityOrGroupTabBarState();
}

class _PersonalityOrGroupTabBarState
    extends ConsumerState<PersonalityOrGroupTabBar>
     {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TabBar(
        tabs: tabs(),
        controller: widget.tabController,
        onTap: (val) {
          if (val == 0) {
            ref
                .read(currentPersonalityGroupTabController.notifier)
                .changState(TypesOfGroupOrPersonality.personality);
          } else {
            ref
                .read(currentPersonalityGroupTabController.notifier)
                .changState(TypesOfGroupOrPersonality.group);
          }
        },
        indicatorColor: CpColors.cpYellow,
      ),
    );
  }

  List<Widget> tabs() {
    return  [
      Tab(
        text: L10n.inst(context).performance_analysis_tab_title1,
      ),
      Tab(
        text: L10n.inst(context).performance_analysis_tab_title2,
      ),
    ];
  }
}

enum TypesOfGroupOrPersonality { personality, group }

class PersonalityOrGroupTabBarControlNotifier
    extends StateNotifier<TypesOfGroupOrPersonality> {
  PersonalityOrGroupTabBarControlNotifier(TypesOfGroupOrPersonality state)
      : super(TypesOfGroupOrPersonality.personality);

  void changState(TypesOfGroupOrPersonality val) => state = val;


}

final currentPersonalityGroupTabController = StateNotifierProvider<
        PersonalityOrGroupTabBarControlNotifier, TypesOfGroupOrPersonality>(
    (ref) => PersonalityOrGroupTabBarControlNotifier(
        TypesOfGroupOrPersonality.personality));
