import 'package:catchpad/models/game/game_model.dart';

import 'package:catchpad/ui/analysis/group_analysis.dart';
import 'package:catchpad/ui/analysis/performance_analysis_main.dart';
import 'package:catchpad/ui/analysis/personality_analysis.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'personality_or_group_tab_bar.dart';

class PersonalityOrGroupBody extends ConsumerStatefulWidget {
  final GameModel gameModel;

  const PersonalityOrGroupBody({Key? key, required this.gameModel})
      : super(key: key);

  @override
  ConsumerState createState() => _PersonalityOrGroupBodyState();
}

class _PersonalityOrGroupBodyState
    extends ConsumerState<PersonalityOrGroupBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currentPersonalityGroupTabController);
    final gameModel = ref.watch(selectedGame);

    final dynamicallyWidget = switch (state) {
      TypesOfGroupOrPersonality.personality => const PersonalityAnalysis(),
      TypesOfGroupOrPersonality.group => const GroupAnalysis(),
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GameHeader(gameModel: gameModel!),
          dynamicallyWidget,
        ],
      ),
    );
  }
}

class GameHeader extends ConsumerStatefulWidget {
  final GameModel gameModel;

  const GameHeader({
    Key? key,
    required this.gameModel,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GameHeaderState();
}

class _GameHeaderState extends ConsumerState<GameHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTitleWithExplain(L10n.inst(context).game_ui_explain,
            widget.gameModel.metaData.description),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.gameModel.metaData.earnings
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(e.name),
                        backgroundColor: CpColors.button1Color,
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Column commonTitleWithExplain(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
