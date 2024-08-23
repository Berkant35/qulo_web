import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/util_widgets/util_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../prov/global_providers.dart';
import '../../../../utils/emb/iga/iga_consts.dart';
import '../../../../utils/emb/iga/iga_enums.dart';
import '../../../../utils/l10n/l10n.dart';
import '../../../../utils/widgets/emb/iga/icons/iga_navigator_icon.dart';
import '../buttons/select_level.dart';

class OnboardingThreePage extends ConsumerStatefulWidget {
  const OnboardingThreePage({
    super.key,
  });

  @override
  ConsumerState createState() => _OnboardingThreePageState();
}

class _OnboardingThreePageState extends ConsumerState<OnboardingThreePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.inst(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(l10n.iga_select_level,
              style: Theme.of(context).textTheme.displayMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IgaNavigatorIconWidget(
                isRight: false,
                onTap: () => ref
                    .read(currentIgaPageManager.notifier)
                    .changState(IGAStates.onBoardingTwo,ref: ref),
              ),
              SelectLevel(
                isSelected: ref.watch(currentIgaChooseLevelManager) ==
                    IGALevelModes.hard,
                onPressed: () async {

                  HapticFeedback.lightImpact();

                  ref
                      .read(currentIgaChooseLevelManager.notifier)
                      .changState(IGALevelModes.hard);

                  final currentDevs = ref
                      .read(bleConPr)
                      .values
                      .where((element) =>
                          element.connectionState ==
                          DeviceConnectionState.connected)
                      .toList()
                      .length;

                  if (currentDevs != IgaConsts.mustDeviceCount) {

                    CustomCatchpadDialogs.connectionWait(context, ref);

                    // FirebaseFirestore.instance.collection("catchpad_points")
                    //     .doc("iga").collection("iga_errors").doc(ref
                    //     .read(currentIgaResultManager.notifier)
                    //     .currentLocation!
                    //     .igaLocationId).update({
                    //
                    //   "connection_wait": FieldValue.increment(1),
                    // });



                    // return;
                  }

                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.onBoardingFour,ref: ref);
                },
                cardImagePath: IgaAssets.pad_many.getPath,
              ),
              SelectLevel(
                isSelected: ref.watch(currentIgaChooseLevelManager) ==
                    IGALevelModes.easy,
                onPressed: () async {

                  HapticFeedback.lightImpact();

                  ref.read(currentIgaChooseLevelManager.notifier).changState(IGALevelModes.easy);

                  final currentDevs = ref
                      .read(bleConPr)
                      .values
                      .where((element) =>
                          element.connectionState ==
                          DeviceConnectionState.connected)
                      .toList()
                      .length;

                   // if (currentDevs == 12) {
                   //   // final _ftr = <Future>[];
                   //   // final _ftr2 = <Future>[];
                   //   ref
                   //       .read(currentIgaChooseLevelManager.notifier)
                   //       .changState(IGALevelModes.easy);
                   //
                   //   //
                   //   // await Future.wait(_ftr).then((value) async {
                   //   //   await Future.delayed(const Duration(seconds: 3),
                   //   //       () async {
                   //   //     await Future.wait(_ftr2);
                   //   //   });
                   //   // });
                   // }


                  // if (currentDevs != 12) {
                  //
                  //   CustomCatchpadDialogs.connectionWait(context, ref);
                  //
                  //   // FirebaseFirestore.instance.collection("catchpad_points")
                  //   //     .doc("iga").collection("iga_errors").doc(ref
                  //   //     .read(currentIgaResultManager.notifier)
                  //   //     .currentLocation!
                  //   //     .igaLocationId).update({
                  //   //
                  //   //   "connection_wait": FieldValue.increment(1),
                  //   // });
                  //
                  //
                  //
                  //   // return;
                  // }
                  // if (currentDevs != 12) {
                  //
                  //   CustomCatchpadDialogs.connectionWait(context, ref);
                  //
                  //   FirebaseFirestore.instance.collection("catchpad_points")
                  //       .doc("iga").collection("iga_errors").doc(ref
                  //       .read(currentIgaResultManager.notifier)
                  //       .currentLocation!
                  //       .igaLocationId).update({
                  //
                  //     "connection_wait": FieldValue.increment(1),
                  //   });
                  //   return;
                  //
                  // }

                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.onBoardingFour,ref: ref);
                },
                cardImagePath: IgaAssets.pad_less.getPath,
              ),
              IgaNavigatorIconWidget(
                isRight: true,
                onTap: () {
                  final currentDevs = ref
                      .read(bleConPr)
                      .values
                      .where((element) =>
                  element.connectionState ==
                      DeviceConnectionState.connected)
                      .toList()
                      .length;

                  if (currentDevs != 12) {
                    CustomCatchpadDialogs.connectionWait(context, ref);

                    FirebaseFirestore.instance.collection("catchpad_points")
                        .doc("iga").collection("iga_errors").doc(ref
                        .read(currentIgaResultManager.notifier)
                        .currentLocation!
                        .igaLocationId).update({

                      "connection_wait": FieldValue.increment(1),
                    });
                    // return;

                  }
                  ref
                      .read(currentIgaPageManager.notifier)
                      .changState(IGAStates.onBoardingFour,ref: ref);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
