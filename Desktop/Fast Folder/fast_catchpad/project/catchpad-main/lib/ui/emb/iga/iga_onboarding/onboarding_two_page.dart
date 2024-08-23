import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/emb/iga/icons/iga_navigator_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../prov/game/detail_game_prov.dart';
import '../../../../prov/global_providers.dart';
import '../buttons/select_player_count.dart';

class OnboardingTwoPage extends ConsumerStatefulWidget {
  const OnboardingTwoPage({
    super.key,
  });

  @override
  ConsumerState createState() => _OnboardingTwoPageState();
}

class _OnboardingTwoPageState extends ConsumerState<OnboardingTwoPage> {
  @override
  void initState() {
    super.initState();
    // Hides system overlays and enables manual system UI mode.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.inst(context);

    // Asynchronous task to update game state based on player mode.
    Future(() {

      final igaPlayerMode = ref.read(currentIgaPlayerModeManager);

      ref.read(detailGameProv.notifier).setState(
          igaPlayerMode == IGAPlayerModes.singlePlayer
              ? StaticGamesList.formula(ref)
              : StaticGamesList.formulaYarisiSecond(ref));
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Text indicating selection of player number.
          Text(instForGameScreen.iga_choose_player_number,
              style: Theme.of(context).textTheme.displayMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Navigator icon for navigating to previous screen.
              IgaNavigatorIconWidget(
                isRight: false,
                onTap: () => ref
                    .read(currentIgaPageManager.notifier)
                    .changState(IGAStates.onBoardingOne, ref: ref),
              ),
              // Button for selecting single player mode.
              SelectPlayerCount(
                cardTitle: l10n.iga_single_player,
                isSelected: ref.watch(currentIgaPlayerModeManager) ==
                    IGAPlayerModes.singlePlayer,
                onPressed: () {
                  // Provides haptic feedback.
                  HapticFeedback.lightImpact();

                  // Sets player mode to single player.
                  ref
                      .read(currentIgaPlayerModeManager.notifier)
                      .changState(IGAPlayerModes.singlePlayer);
                  // Updates game state based on selected mode.
                  ref
                      .read(detailGameProv.notifier)
                      .setState(StaticGamesList.formula(ref));
                  // Navigates to next onboarding screen.
                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.onBoardingThree, ref: ref);
                },
                cardImagePath: IgaAssets.single_player.getPath,
              ),
              Gap(2.w),
              // Button for selecting multiplayer mode.
              SelectPlayerCount(
                cardTitle: l10n.iga_multi_player,
                isSelected: ref.watch(currentIgaPlayerModeManager) ==
                    IGAPlayerModes.multiPlayer,
                onPressed: () {
                  // Provides haptic feedback.
                  HapticFeedback.lightImpact();

                  // Sets player mode to multiplayer.
                  ref
                      .read(currentIgaPlayerModeManager.notifier)
                      .changState(IGAPlayerModes.multiPlayer);
                  // Updates game state based on selected mode.
                  ref
                      .read(detailGameProv.notifier)
                      .setState(StaticGamesList.formulaYarisiSecond(ref));
                  // Navigates to next onboarding screen.
                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.onBoardingThree, ref: ref);
                },
                cardImagePath: IgaAssets.multiplayer.getPath,
              ),
              // Navigator icon for navigating to next screen.
              IgaNavigatorIconWidget(
                onTap: () => ref
                    .read(currentIgaPageManager.notifier)
                    .changState(IGAStates.onBoardingThree, ref: ref),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
