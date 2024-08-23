import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/cp_extensions.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/enums/firebase/collenction_enums.dart';
import '../../../../../models/game/player_result_model.dart';
import '../../../../../prov/emb/emb_global_providers.dart';
import '../../../../../prov/game/detail_game_prov.dart';
import '../../../../../prov/game/round_prov.dart';
import '../../../../../prov/game_result_prov.dart';
import '../../../../../utils/util_widgets/util_texts.dart';
import 'iga_content_of_result.dart';

class IGAResult extends ConsumerStatefulWidget {
  const IGAResult({
    super.key,
  });

  @override
  ConsumerState createState() => _IGAResultState();
}

class _IGAResultState extends ConsumerState<IGAResult> {
  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final result = ref.watch(gameResultProv);

    Future(() {

      ref.read(currentSafeInGameToggleState.notifier).changState(false, ref);

      FirebaseIgaCollectionEnumsWithField.iga_locations.reference
          .doc(ref.read(currentIgaResultManager)!.igaLocationId)
          .update(
        ref
            .read(currentIgaResultManager.notifier)
            .currentLocation!
            .copyWith(
          igaLocationGameCount: (ref
              .read(currentIgaResultManager.notifier)
              .currentLocation!
              .igaLocationGameCount ??
              0) +
              1,
          updatedAt: DateTime.now().toString().substring(0, 19),
          igaLastGameInfoId: ref.read(currentGameProv)?.id,
        )
            .toJson(),
      );
      ref.read(currentIgaResultManager.notifier).incrementCurrentLocation();
    });

    List<PlayerResultModel> results =
    List<PlayerResultModel>.from(result?.playerResults ?? []);

    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          backgroundOfResult(),
          Column(
            children: [
              Expanded(flex: 4, child: _header()),
              const Expanded(flex: 10, child: IgaContentOfResult()),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      standartOptionButtons(inst, result),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }


  Widget standartOptionButtons(
      AppLocalizations inst, GameResultModel? result) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCpInfoTexts.seeLeaderboardToCompare(
              inst.iga_see_leaderboard_to_compare_type1, context,
              type1: true),
          Gap(2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCatchpadButtons.buildBorderButton(
                  width: 25.w,
                  height: 10.h,
                  borderRadius: 24.px,
                  borderThickness: resultBorderThickness(),
                  ref: ref,
                  onPressed: () {
                    Future(() async {
                      ref
                          .read(currentIgaTraceStateManager.notifier)
                          .changState(IgaPlayTraceStates.pre, ref: ref);

                      ref.read(gameRoundProv.notifier).setDisabled();

                      ref.read(detailGameProv.notifier).setState(
                          ref.watch(currentIgaPlayerModeManager) ==
                              IGAPlayerModes.singlePlayer
                              ? StaticGamesList.formula(ref)
                              : StaticGamesList.formulaYarisiSecond(ref));

                      ref
                          .read(currentIgaPageManager.notifier)
                          .changState(IGAStates.onBoardingFour, ref: ref);
                    });
                  },
                  text: inst.form_back_to_home.capitalizeSentence(),
                  borderColor: Colors.white),
              Gap(4.w),
              CustomCatchpadButtons.buildGradientAccentButton(
                width: 25.w,
                height: 10.h,
                borderThickness: resultBorderThickness(),
                color: Colors.white,
                customGradientColor: [
                  CpColors.cpPrimary.withOpacity(0.4),
                  CpColors.cpPrimary.withOpacity(0.4),
                ],
                onPressed: () {
                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.lastRegister, ref: ref);
                },
                text: inst.iga_see_leaderboard,
              ),
            ],
          ),
        ],
      );

  double resultBorderThickness() => 0.3.w;

  Widget _header() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const TextLogoWidget(),
      Text(
        ref.read(currentGameProv)!.title,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontWeight: FontWeight.w600),
      )
    ],
  );

  Widget backgroundOfResult() {
    return Image.asset(
      ref.watch(currentIgaPlayerModeManager) == IGAPlayerModes.multiPlayer
          ? IgaAssets.iga_in_game_background.getPath
          : IgaAssets.background.getPath,
      width: 100.w,
      height: 100.h,
      fit: BoxFit.fill,
    );
  }
}