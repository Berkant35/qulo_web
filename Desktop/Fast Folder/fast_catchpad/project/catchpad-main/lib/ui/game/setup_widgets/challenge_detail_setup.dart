import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../catch_pad_icons.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../widgets/inline_color_selector.dart';

class ChallengeDetailSetup extends ConsumerWidget {
  const ChallengeDetailSetup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final setup = ref.watch(currentGameSetupProv)!;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.24,
      child: setup.choosedChallengeTypeIndex == 0
          ? const SetSequential()
          : const SetRandomly(),
    );
  }
}

class SetSequential extends ConsumerWidget {

  const SetSequential({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollController controller = ScrollController();
    final listOfDevices =
        ref.watch(currentDevicesManagerProvider).values.toList();

    return listOfDevices.isNotEmpty
        ? Column(
            children: [
              Expanded(
                  child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < listOfDevices.length; i++)
                        PerDraggableCatchPadIcon(
                            lbl: listOfDevices[i].bleName!.substring(
                                0,
                                listOfDevices[i].bleName!.substring(1, 2) != " "
                                    ? 2
                                    : 2),deviceId: listOfDevices[i].deviceId!,index: i.toString(),),
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          ///Spaghetti code alert!

                          Map<int, String> tempMap = {};

                          final sequenceMap =
                              ref.read(currentGameSetupProv)!.sequenceMap;

                          sequenceMap!.forEach((key, value) {
                            if (sequenceMap.keys.last != key) {
                              tempMap.addAll({key: value});
                            }
                          });

                          final newSetup = ref
                              .read(currentGameSetupProv)!
                              .copyWith(sequenceMap: tempMap);

                          ref.read(currentGameProv.notifier).setSetup(newSetup);
                        },
                        icon: const Icon(Icons.remove)),
                  ),
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.2),
                        child: Row(
                          children: [
                            for (int i = 0;
                                i <
                                    ref
                                        .watch(currentGameSetupProv)!
                                        .sequenceMap!
                                        .keys
                                        .length;
                                i++)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.16,
                                decoration:
                                    BoxDecoration(border: Border.all(width: 1)),
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          color: CpColors.bottomBarColor,
                                          child: Center(
                                              child: Text((i + 1).toString())),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: DragTarget(
                                          onAccept: (String data) {
                                            Map<int, String> tempMap = {};

                                            final sequenceMap = ref
                                                .read(currentGameSetupProv)!
                                                .sequenceMap;

                                            sequenceMap!.forEach((key, value) {
                                              if (sequenceMap.keys.last !=
                                                  key) {
                                                tempMap.addAll({key: value});
                                              }
                                            });
                                            tempMap.addAll({i: data});

                                            final newSetup = ref
                                                .read(currentGameSetupProv)!
                                                .copyWith(sequenceMap: tempMap);

                                            ref
                                                .read(currentGameProv.notifier)
                                                .setSetup(newSetup);
                                          },
                                          builder: (BuildContext context,
                                              List<Object?> candidateData,
                                              List<dynamic> rejectedData) {

                                            logger.w(ref
                                                .watch(
                                                currentGameSetupProv)!
                                                .sequenceMap!.toString());

                                            return candidateData.isEmpty
                                                ? ref
                                                        .watch(
                                                            currentGameSetupProv)!
                                                        .sequenceMap!
                                                        .isNotEmpty
                                                    ? PerDraggableCatchPadIcon(
                                                        lbl: ref
                                                            .watch(
                                                                currentGameSetupProv)!
                                                            .sequenceMap![i]!,deviceId: null,index: i.toString(),)
                                                    : Container(
                                                        color: CpColors.bgGC2)
                                                : PerDraggableCatchPadIcon(
                                                    lbl: ref
                                                        .watch(
                                                            currentGameSetupProv)!
                                                        .sequenceMap![i]!,deviceId: null,index: i.toString(),);
                                          },
                                        )),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {
                          Map<int, String> tempMap = {};

                          final sequenceMap =
                              ref.read(currentGameSetupProv)!.sequenceMap;

                          sequenceMap!.forEach((key, value) {
                            tempMap.addAll({key: value});
                          });

                          tempMap.addAll({sequenceMap.keys.length: ""});

                          final newSetup = ref
                              .read(currentGameSetupProv)!
                              .copyWith(sequenceMap: tempMap);

                          ref.read(currentGameProv.notifier).setSetup(newSetup);

                          if (newSetup.sequenceMap!.length > 2) {
                            controller.animateTo(
                              controller.position.maxScrollExtent + 80,
                              duration: const Duration(
                                milliseconds: 800,
                              ),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        icon: const Icon(Icons.add_circle_outline)),
                  ),
                ],
              )),
            ],
          )
        : const Center(
            child: Text("Appellant yok!"),
          );
  }
}

class SetRandomly extends ConsumerWidget {
  const SetRandomly({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
            child: Container(
          color: CpColors.blue,
        )),
        Expanded(
            child: Container(
          color: CpColors.padGroupTitleColor,
        )),
      ],
    );
  }
}
/* InlineColorSelectorV2(
              onChange: (Set<Color> color) {  },
              selectedColors: {},
              disabledColors: {},
              isOrdered: true,)*/
class PerDraggableCatchPadIcon extends ConsumerWidget {
  final String lbl;
  final String? index;
  final String? deviceId;
  const PerDraggableCatchPadIcon({super.key, required this.lbl,this.index, this.deviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Draggable(
      feedback: Container(
        margin: const EdgeInsets.all(halfDefPaddingSize),
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildIcon(context,"$deviceId$index",ref),
            Align(
              alignment: Alignment.center,
              child: Text(
                lbl,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: CpColors.defTextColor),
              ),
            ),


          ],
        ),
      ),
      data: lbl,
      child: Container(
        margin: const EdgeInsets.all(halfDefPaddingSize),
        height: MediaQuery.of(context).size.height * 0.08,

        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                lbl.isNotEmpty ? buildIcon(context,"$deviceId$index",ref) : const SizedBox(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    lbl,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: CpColors.defTextColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon buildIcon(BuildContext context,String? deviceId,WidgetRef ref) {


    return Icon(
      CatchPadIcons.cpCircle,
      color: CpColors.cpLightWhiteIGA,
      size: Theme.of(context).textTheme.headline3?.fontSize,
    );
  }
}
