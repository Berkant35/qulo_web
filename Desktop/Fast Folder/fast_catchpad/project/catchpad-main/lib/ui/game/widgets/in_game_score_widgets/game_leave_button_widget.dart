
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../models/enums/traces/play_traces_enum.dart';
import '../../../../prov/end_game_prov.dart';
import '../../../../prov/game/curr_game_prov.dart';
import '../../../../prov/game/round_prov.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/l10n/l10n.dart';
import '../../../widgets/buttons/cp_button_2.dart';

class GameLeaveButton extends ConsumerWidget {
  final double? borderRadius;
  final double? elevation;
  final Color? backColor;

  final String? customText;

  final FontWeight? customFontWeight;
  const GameLeaveButton({super.key,this.borderRadius,this.elevation,this.backColor,this.customText,this.customFontWeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final g = ref.read(currentGameProv);
    final chosenSensor =
        g?.setup.sensorTypes.entries.elementAt(g.setup.chosedSensorIndex).key;
    final AccSensorType? deactivatedAccSensor;
    switch (chosenSensor) {
      case UsedSensorsType.tap:
        deactivatedAccSensor = AccSensorType.tap;
        break;
      case UsedSensorsType.force:
        deactivatedAccSensor = AccSensorType.force;
        break;
      case UsedSensorsType.motion:
        deactivatedAccSensor = AccSensorType.gravity;
        break;
      case UsedSensorsType.distance:
        deactivatedAccSensor = null;
        break;
      default:
        deactivatedAccSensor = null;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: defPaddingSize),
          child: ref.read(currentNewVersionState)
              ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: elevation ?? 0,
                      backgroundColor: backColor ?? CpColors.cpChineseBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius ?? 0), // 12 is the radius you want
                      ),
                      // İstediğiniz rengi burada ayarlayın
                    ),
                  onPressed: () async {
                    try {
                      ref.read(gameRoundProv.notifier).setPaused();
                    } catch (e) {
                      logger.d(e.toString());
                    }
                    try {

                      ref.read(gameEndingProvider.notifier).end();

                      Future((){
                        ref.read(gameEndingProvider.notifier).chronometerStop();
                      });

                      await ref
                          .read(currentPlayTraceManager.notifier)
                          .changePlayTraceState(PlayTraceStates.idle, ref);
                      await ref
                          .read(currentPlayTraceManager.notifier)
                          .initializePlayTrace(ref);

                      ref.read(forceEndProvider.notifier).changState(true);
                    } catch (e) {
                      logger.d(e.toString());
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/leave.png',
                        height: 4.h,
                        width: 5.w,
                      ),
                      SizedBox(width: 2.w,),
                      Text(
                        customText ?? L10n.inst(context).leave,
                        style:  TextStyle(color: Colors.white,fontWeight: customFontWeight),
                      ),
                    ],
                  ),
          )
              : CpButtonWithIcon2(
                  onPressed: () async {
                    try {
                      ref.read(gameRoundProv.notifier).setPaused();
                    } catch (e) {
                      logger.d(e.toString());
                    }
                    try {
                      ref.read(gameEndingProvider.notifier).end();
                      await ref
                          .read(currentPlayTraceManager.notifier)
                          .changePlayTraceState(PlayTraceStates.idle, ref);
                      await ref
                          .read(currentPlayTraceManager.notifier)
                          .initializePlayTrace(ref);

                      ref.read(forceEndProvider.notifier).changState(true);
                    } catch (e) {
                      logger.d(e.toString());
                    }

                    //Navigator.pop(context);
                  },

                  iconWidget: const Icon(Icons.exit_to_app),
                  child: Text(L10n.inst(context).leave)),
        ),
      ],
    );
  }
}
