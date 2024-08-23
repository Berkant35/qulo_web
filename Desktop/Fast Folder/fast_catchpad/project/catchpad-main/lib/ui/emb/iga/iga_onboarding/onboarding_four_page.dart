import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../managers/static_games_list.dart';
import '../../../../prov/game/detail_game_prov.dart';
import '../../../../prov/global_providers.dart';
import '../../../../utils/widgets/emb/iga/icons/iga_basic_back_icon.dart';
import '../../../../utils/widgets/text_logo_widget.dart';
import 'onboarding_four_helper_parts/onboarding_four_how_play_part.dart';
import 'onboarding_four_helper_parts/onboarding_four_select_game_page_view.dart';

// This part consists of two main components:
// OnBoardingFourHowPlayPart: This section provides information
//  about how to play the game, including game
//  descriptions, color selection, and earnings.
// OnboardingFourSelectGamePageView: This section displays selectable
//  game videos. Users can choose from different games presented in video format.

/// This page represents the IGA select game page.
class OnboardingFourPage extends ConsumerStatefulWidget {
  const OnboardingFourPage({
    super.key,
  });

  @override
  ConsumerState createState() => _OnboardingFourPageState();
}

class _OnboardingFourPageState extends ConsumerState<OnboardingFourPage> {
  @override
  void initState() {
    super.initState();
    // Hides system overlays and enables manual system UI mode.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    // Disables safe in-game toggle if enabled.
    Future((){
      ref.read(currentIgaResultManager.notifier).backFirstPlayerRegisterWorkStatus();
    });


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: body(),
    );
  }

  // Widget for the main body of the page.
  Column body() {
    return Column(
      children: [
        // Custom app bar.
        customBar(),
        // Content area containing how-to-play part and game selection.
        content(),
      ],
    );
  }

  // Expanded widget for the content area.
  Expanded content() {
    return const Expanded(
      flex: 19,
      child: Row(
        children: [
          // How to play part.
          OnBoardingFourHowPlayPart(),
          // Game selection page view.
          OnboardingFourSelectGamePageView(),
        ],
      ),
    );
  }

  // Expanded widget for the custom app bar.
  Expanded customBar() => Expanded(
        flex: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button.
            backButton(),
            // Logo widget.
            const Expanded(
              flex: 6,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextLogoWidget(),
              ),
            ),
          ],
        ),
      );

  // Expanded widget for the back button.
  Expanded backButton() {
    return Expanded(
      flex: 4,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 1.5.w, bottom: 2.2.h, top: 2.2.h),
            child: GestureDetector(
              onTap: () {
                // Sets game state based on player mode.
                ref.read(detailGameProv.notifier).setState(
                      ref.watch(currentIgaPlayerModeManager) ==
                              IGAPlayerModes.singlePlayer
                          ? StaticGamesList.formula(ref)
                          : StaticGamesList.formulaYarisiSecond(ref),
                    );
                // Navigates to the previous onboarding screen.
                ref.read(currentIgaPageManager.notifier).changState(IGAStates.onBoardingThree, ref: ref);
              },
              child: SizedBox(
                width: 10.w,
                height: 10.h,
                child: IgaBasicBackIcon(
                  onPressed: () {
                    // Navigates to the previous onboarding screen.
                    ref.read(currentIgaPageManager.notifier).changState(IGAStates.onBoardingThree, ref: ref);
                    // Sets game state based on player mode.
                    ref.read(detailGameProv.notifier).setState(
                          ref.watch(currentIgaPlayerModeManager) ==
                                  IGAPlayerModes.singlePlayer
                              ? StaticGamesList.formula(ref)
                              : StaticGamesList.formulaYarisiSecond(ref),
                        );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
