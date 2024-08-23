import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/enums/game/game_end_type.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game/round_prov.dart';
import 'package:catchpad/prov/game_result_prov.dart';

import 'package:catchpad/ui/emb/iga/get_ready.dart';
import 'package:catchpad/ui/emb/iga/iga_res/iga_register.dart';
import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/cp_extensions.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/utils/util_widgets/util_information_cards.dart';
import 'package:catchpad/utils/util_widgets/util_texts.dart';
import 'package:catchpad/utils/widgets/cp_counter.dart';
import 'package:catchpad/utils/widgets/cp_headline_with_icon.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'card/cp_custom_popup.dart';
import 'card/information_card.dart';

class IgaSandbox extends ConsumerStatefulWidget {
  const IgaSandbox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IgaSandboxState();
}

class _IgaSandboxState extends ConsumerState<IgaSandbox> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final result = GameResultModel(
        type: GameEndType.duration,
        gameId: 's',
        accountHolderId: '  ',
        scoreTypeParam1: GameScoreType.catchCount,
        scoreTypeParam2: GameScoreType.averageDistance);

    return Scaffold(
      backgroundColor: const Color.fromARGB(108, 45, 43, 43),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/iga/background.png'),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (result.gameId != 's1')
                  CustomCpInfoTexts.seeLeaderboardToCompare(
                      inst.iga_see_leaderboard_to_compare, context),
                Gap(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1.3.h),
                          decoration: const BoxDecoration(
                              color: CpColors.cpDavysGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Image.asset(
                            IgaAssets.qr_get_discount.getPath,
                            height: 9.h,
                          ),
                        ),
                        Text(
                          inst.iga_share_performance_video,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white, fontSize: 12.sp),
                        ),
                        Text(
                          inst.iga_get_discount_code,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: CpColors.cpPrimary, fontSize: 12.sp),
                        ),
                      ],
                    ),
                    CustomCatchpadButtons.buildBorderButton(
                        width: 25.w,
                        height: 10.h,
                        borderRadius: 24.px,
                        borderThickness: 0.3.w,
                        ref: ref,
                        onPressed: () {},
                        text: inst.form_back_to_home.capitalizeSentence(),
                        borderColor: Colors.white),
                    if (result.gameId != 's1') Gap(4.w),
                    if (result.gameId != 's1')
                      CustomCatchpadButtons.buildGradientAccentButton(
                        width: 25.w,
                        height: 10.h,
                        borderThickness: 0.3.w,
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
            ),
          )
        ],
      ),
    );
  }
}
