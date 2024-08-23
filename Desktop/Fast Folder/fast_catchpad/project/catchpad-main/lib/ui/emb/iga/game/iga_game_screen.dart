import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/ui/emb/iga/game/iga_game_content_screen.dart';
import 'package:catchpad/ui/game/widgets/in_game_score_widgets/game_timer_widget.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../managers/asset_manager.dart';
import '../../../../prov/emb/emb_global_providers.dart';
import '../../../../utils/cp_colors.dart';

class IgaGameScreen extends ConsumerStatefulWidget {
  const IgaGameScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaGameScreenState();
}

class _IgaGameScreenState extends ConsumerState<IgaGameScreen> {
  @override
  Widget build(BuildContext context) {
    final game = ref.read(currentGameProv);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Stack(
          children: [
            Image.asset(
              ref.watch(currentIgaPlayerModeManager) ==
                  IGAPlayerModes.singlePlayer
                  ? IgaAssets.background.getPath
                  : IgaAssets.iga_in_game_background.getPath,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 5,
                    child: Center(
                      child: Transform.scale(
                          scale: 1.55, child: const TimerWidget()),
                    )),
                // if (ref.read(currentGameProv)?.metaData.id == '84' ||
                //     game?.metaData.id == 's4' ||
                //     game?.metaData.id == 's35')
                //   Text(
                //     game?.metaData.inGameIgaHeader ?? "-",
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleLarge!
                //         .copyWith(color: CpColors.cpPrimary),
                //   ),
                    () {
                  if (game?.metaData.id != 's4') {
                    return Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                              flex: 6, child: IgaGameContentScreen()),
                          Expanded(
                              flex: 2,
                              child: TextLogoWidgetV2(
                                size: 16.h,
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 6,
                              child:
                              Image.asset(IgaAssets.iga_left_hand.getPath)),
                          Expanded(
                            flex: 12,
                            child: Column(
                              children: [
                                const Expanded(
                                    flex: 6, child: IgaGameContentScreen()),
                                Expanded(
                                    flex: 2,
                                    child: TextLogoWidgetV2(
                                      size: 16.h,
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Image.asset(
                                  IgaAssets.iga_right_hand.getPath)),
                        ],
                      ),
                    );
                  }
                }()
              ],
            ),
          ],
        ),
      ),
    );
  }
}