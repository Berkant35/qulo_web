import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../catch_pad_icons.dart';
import '../../../../managers/sticker_manager.dart';
import '../../../../models/device/device_shuffler.dart';
import '../../../../prov/game/curr_game_prov.dart';
import '../../../../prov/game/selected_players_prov.dart';
import '../../../../utils/cp_colors.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/multi_chip_selector.dart';

class PlayerPadSelector extends ConsumerWidget {

  final void Function(DeviceSet) onChange;

  final bool oldSystem;
  final int? min;
  final int max;

  /// these are the devices selected by other players
  final DeviceSet disabledDevs;
  final DeviceSet selectedDevs;

  const PlayerPadSelector({
    required this.onChange,
    this.min,
    this.oldSystem = true,
    required this.max,
    required this.disabledDevs,
    required this.selectedDevs,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var orderedDevices = DeviceShuffler.readDevices(ref);
    orderedDevices.sort((a, b) => a.deviceNameId!.compareTo(b.deviceNameId!));

    final stickers = ref.watch(stickerProvider).stickers;
    return oldSystem
        ? oldMultiChipSelector(orderedDevices, ref, stickers, context)
        : newMultiChipSelector(orderedDevices, ref, stickers, context);
  }

  MultiChipSelector<DeviceModel> newMultiChipSelector(
      List<DeviceModel> orderedDevices,
      WidgetRef ref,
      Map<String, String?> stickers,
      BuildContext context) {
    return MultiChipSelector<DeviceModel>(
      onChange: onChange,
      min: min,
      max: max,
      allElements: orderedDevices.toSet(),
      selectedElements: selectedDevs,
      disabledElements: disabledDevs,
      getId: (e) => e.id,
      getLabel: (e) => (e.deviceNameId ?? e.name),
      builder: (device, isSelected, onSelected) {
        final currentGame = ref.watch(currentGameProv);
        final gameId = currentGame?.id;

        final isAnimalGame = gameId == 's25' || gameId == '43';
        final isLetterGame =
            gameId == 's23' || gameId == '41' || gameId == '42';
        final isNotesGame = gameId == 's19';
        //final isColorsGame = gameId == 's33';
        final isVehiclesGame = gameId == 's34';

        final isEmojisGame = gameId == 's27';

        final isMeyveGame = gameId == 's28';

        final isShapeGame = gameId == 's36';

        var lbl = (device.deviceNameId ?? device.name);

        if (device.deviceNumber != null) {
          String? st;
          if (isAnimalGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerAnimalTranslation(
                val: device.deviceNumber!.toString(), ref: ref); */
            }
          }
          if (isLetterGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerLetterTranslation(
              ref: ref,
              val: device.deviceNumber!.toString(),
            ); */
            }
          }
          if (isNotesGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerNotesTranslation(
                val: device.deviceNumber!.toString()); */
            }
          }

          if (isVehiclesGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerVehiclesTranslation(
                    ref: ref,
                    isForGame: false,
                    context: context,
                    val: device.deviceNumber!.toString())!
                .capitalize(); */
            }
          }

          if (isEmojisGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerEmojisTranslation(
                    context: context, val: device.deviceNumber!.toString())!
                .capitalize(); */
            }
          }

          if (isMeyveGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              st = StickerManager.idToStickerFruitsTranslation(
                      context: context, val: device.deviceNumber!.toString())!
                  .capitalize();
            }
          }

          if (isShapeGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              st = StickerManager.idToStickerShapesTranslation(
                      context: context, val: device.deviceNumber!.toString())!
                  .capitalize();
            }
          }

          lbl = st ?? lbl;
        }

        final clr = isSelected ? Colors.black : CpColors.cpPhilippineSilver;

        logger.e("@@@ ${currentGame!.setup.isContainMainBase}");

        return Container(
          margin: const EdgeInsets.all(halfDefPaddingSize),
          child: Column(
            children: [
              InkWell(
                onTap: onSelected,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      CatchPadIcons.cpCircle,
                      color: clr,
                      size: Theme.of(context).textTheme.headlineLarge!.fontSize,
                    ),
                    Text(
                      lbl,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: clr),
                    ),
                  ],
                ),
              ),
              if (currentGame.setup.isContainMainBase)
                Checkbox(
                    value: ref.watch(currentMainBaseDiscoveredState) == device,
                    onChanged: (val) => ref
                        .read(currentMainBaseDiscoveredState.notifier)
                        .changState(device,ref: ref))
            ],
          ),
        );
      },
    );
  }

  MultiChipSelector<DeviceModel> oldMultiChipSelector(
      List<DeviceModel> orderedDevices,
      WidgetRef ref,
      Map<String, String?> stickers,
      BuildContext context) {
    return MultiChipSelector<DeviceModel>(
      onChange: onChange,
      min: min,
      max: max,
      allElements: orderedDevices.toSet(),
      selectedElements: selectedDevs,
      disabledElements: disabledDevs,
      getId: (e) => e.id,
      getLabel: (e) => (e.deviceNameId ?? e.name),
      builder: (device, isSelected, onSelected) {
        final currentGame = ref.watch(currentGameProv);
        final gameId = currentGame?.id;

        final isAnimalGame = gameId == 's25' || gameId == '43';
        final isLetterGame =
            gameId == 's23' || gameId == '41' || gameId == '42';
        final isNotesGame = gameId == 's19';
        //final isColorsGame = gameId == 's33';
        final isVehiclesGame = gameId == 's34';

        final isEmojisGame = gameId == 's27';

        final isMeyveGame = gameId == 's28';

        final isShapeGame = gameId == 's36';

        var lbl = (device.deviceNameId ?? device.name);

        if (device.deviceNumber != null) {
          String? st;
          if (isAnimalGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerAnimalTranslation(
                val: device.deviceNumber!.toString(), ref: ref); */
            }
          }
          if (isLetterGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerLetterTranslation(
              ref: ref,
              val: device.deviceNumber!.toString(),
            ); */
            }
          }
          if (isNotesGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerNotesTranslation(
                val: device.deviceNumber!.toString()); */
            }
          }

          if (isVehiclesGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerVehiclesTranslation(
                    ref: ref,
                    isForGame: false,
                    context: context,
                    val: device.deviceNumber!.toString())!
                .capitalize(); */
            }
          }

          if (isEmojisGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              e;
              /* st = StickerManager.idToStickerEmojisTranslation(
                    context: context, val: device.deviceNumber!.toString())!
                .capitalize(); */
            }
          }

          if (isMeyveGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              st = StickerManager.idToStickerFruitsTranslation(
                      context: context, val: device.deviceNumber!.toString())!
                  .capitalize();
            }
          }

          if (isShapeGame) {
            try {
              st = stickers.entries
                  .firstWhere(
                      (pair) => pair.value == device.deviceNumber.toString())
                  .key;
            } catch (e) {
              st = StickerManager.idToStickerShapesTranslation(
                      context: context, val: device.deviceNumber!.toString())!
                  .capitalize();
            }
          }

          lbl = st ?? lbl;
        }
        if (currentGame!.setup.isContainMainBase &&
            ref.watch(currentMainBaseDiscoveredState) == null &&
            device.name == mainCatchpadName) {
          Future(() {
            ref
                .read(currentMainBaseDiscoveredState.notifier)
                .changState(device,ref: ref);
          });
        }
        final clr =
            isSelected ? CpColors.defTextColor : CpColors.defDisabledColor;

        return Container(
          margin: const EdgeInsets.all(halfDefPaddingSize),
          child: Column(
            children: [
              InkWell(
                onTap: onSelected,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      CatchPadIcons.cpCircle,
                      color: clr,
                      size: Theme.of(context).textTheme.headline3?.fontSize,
                    ),
                    Text(
                      lbl,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: clr),
                    ),
                  ],
                ),
              ),
              if (currentGame.setup.isContainMainBase)
                Column(
                  children: [
                    Checkbox(
                        value:
                            ref.watch(currentMainBaseDiscoveredState) == device,
                        onChanged: (val) async {

                          // not available devices are not allowed to be main base
                          if(!selectedDevs.contains(device)) return;

                          ref
                              .read(currentMainBaseDiscoveredState.notifier)
                              .changState(device,ref: ref);
                          if (val ?? false) {
                            ref
                                .read(currentMainBaseDiscoveredState.notifier)
                                .selectedPadShow(ref);
                          }
                        }),
                    if (ref.watch(currentMainBaseDiscoveredState) == device)
                      Text(
                        L10n.inst(context).main_base_title,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: CpColors.green),
                      )
                  ],
                )
            ],
          ),
        );
      },
    );
  }
}
