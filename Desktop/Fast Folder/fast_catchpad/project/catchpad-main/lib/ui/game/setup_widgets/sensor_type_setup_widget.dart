import 'package:catchpad/models/enums/icon_paths.dart';
import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import '../../../models/game/static_game_model.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../utils/l10n/l10n.dart';

class SensorTypeSetupWidget extends ConsumerStatefulWidget {
  const SensorTypeSetupWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SensorTypeSetupWidgetState();
}

class _SensorTypeSetupWidgetState extends ConsumerState<SensorTypeSetupWidget> {
  final GlobalKey ctkey = GlobalKey();
  UsedSensorsType? selected;
  late String gameId;
  final key = CacheSetupKeys.sensor.name;
  bool onceTime = false;
  List<UsedSensorsType> list = [];

  setSensorType(int value, WidgetRef ref, {StaticGameSetupModel? setup}) {
    final setup = ref.watch(currentGameSetupProv)!;
    final newSetup = setup.copyWith(chosedSensorIndex: value);
    ref.read(currentGameProv.notifier).setSetup(newSetup);
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final setup = ref.watch(currentGameSetupProv)!;
    gameId = ref.read(currentGameMetaDataProv)!.id;
    list = setup.sensorTypes.entries.map((e) => e.key).toList();
    final UsedSensorsType userSensorType =
        setup.sensorTypes.keys.elementAt(setup.chosedSensorIndex);

    selected ??= userSensorType;

    const double iconNormalSize = 28;

    // it returns icon and name according sensore type
    List getIconAndNameAccordingCatchType(UsedSensorsType? sensorsType) {
      switch (sensorsType) {
        case UsedSensorsType.tap:
          return [
            _CatchTypeIcons(IconPaths.tap.path),
            inst.game_ui_device_sensor_tap
          ];

        case UsedSensorsType.motion:
          return [
            _CatchTypeIcons(IconPaths.motion.path),
            inst.game_ui_device_sensor_motion
          ];

        case UsedSensorsType.distance:
          return [
            _CatchTypeIcons(IconPaths.distance.path),
            inst.game_ui_device_sensor_distance
          ];

        case UsedSensorsType.force:
          return [
            _CatchTypeIcons(IconPaths.force.path),
            inst.game_ui_device_sensor_force
          ];

        case UsedSensorsType.none:
          return [
            _CatchTypeIcons(IconPaths.none.path),
            inst.game_ui_device_sensor_none
          ];

        default:
          return [
            _CatchTypeIcons(IconPaths.none.path),
            inst.game_ui_device_sensor_none
          ];
      }
    }

    return DropdownButtonFormField<UsedSensorsType>(
      dropdownColor: CpColors.appbarColor,
      key: ctkey,
      value: selected,
      items: list
          .map(
            (e) => DropdownMenuItem<UsedSensorsType>(
              value: e,
              child: Row(
                children: [
                  getIconAndNameAccordingCatchType(e)[0],
                  Padding(
                    padding: context.padding.onlyLeftLow,
                    child: Text(getIconAndNameAccordingCatchType(e)[1]),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selected = value;
        });
        logger.i("Selected!! $selected");

        Future(() {
          setSensorType(list.indexOf(value), ref);

          ref.read(currentCacheSetupManager.notifier).setSensorCache(ref,
              whichSetupKey: key, gameId: gameId, val: selected!);
        });
      },
      borderRadius: BorderRadius.circular(10),
    );
  }

  Image _CatchTypeIcons(String path) {
    const double iconNormalSize = 28;
    return Image.asset(
      path,
      color: Colors.white,
      height: iconNormalSize,
      width: iconNormalSize,
    );
  }
}

// class SensorTypeSetupWidget extends ConsumerWidget {
//   SensorTypeSetupWidget({Key? key}) : super(key: key);
//   final GlobalKey ctkey = GlobalKey();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final inst = L10n.inst(context);
//     final setup = ref.watch(currentGameSetupProv)!;
//     final list = setup.sensorTypes.entries.map((e) => e.key).toList();
//     UsedSensorsType selected = UsedSensorsType.tap;
//     setSensorType(int value) async {
//       await Future.delayed(const Duration(milliseconds: 400));
//       final newSetup = setup.copyWith(chosedSensorIndex: value);
//       ref.read(currentGameProv.notifier).setSetup(newSetup);
//     }

//     int? getIndexOfSensoreType(UsedSensorsType? sensorsType) {
//       int value = 5;
//       switch (sensorsType) {
//         case UsedSensorsType.tap:
//           return value = 0;
//         case UsedSensorsType.motion:
//           return value = 1;
//         case UsedSensorsType.distance:
//           return value = 2;
//         case UsedSensorsType.force:
//           return value = 3;

//         case UsedSensorsType.none:
//           return value = 0;
//         default:
//       }
//       return value;
//     }

//     final selectedValue = setup.chosedSensorIndex;

//     return DropdownButtonFormField<UsedSensorsType>(
//       value: selected,
//       key: ctkey,
//       validator: (value) => value == null ? 'Cant empty' : null,
//       items: list
//           .map(
//             (e) => DropdownMenuItem(
//               value: e,
//               child: Text(e.name),
//             ),
//           )
//           .toList(),
//       onChanged: (value) {
//         if (value == null) return;
//         selected = value;
//         final indexOfType = getIndexOfSensoreType(value);
//         setSensorType(indexOfType ?? 0);
//       },
//     );

// DropdownButtonHideUnderline(
//   child: DropdownButton2<UsedSensorsType>(
//     value: selected,
//     hint: Text(selected.index.toString()),
//     items: list
//         .map(
//           (e) => DropdownMenuItem(
//             value: e,
//             child: Row(
//               children: [
//                 const Icon(Icons.tap_and_play),
//                 Text(e.name),
//               ],
//             ),
//           ),
//         )
//         .toList(),
//     key: ctkey,
//     onChanged: (value) {
//       if (value == null) return;
//       switch (value as UsedSensorsType) {
//         case UsedSensorsType.distance:
//           selected = UsedSensorsType.distance;
//           break;
//         default:
//       }
//     },
//     dropdownStyleData: DropdownStyleData(
//       width: 160,
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: CpColors.body1Color,
//       ),
//       offset: const Offset(0, 8),
//     ),
//   ),
// );

// GestureDetector(
//   onTapDown: (details) {
//     try {
//       var widthOfParent = ctkey.currentContext?.size?.width;
//       widthOfParent = widthOfParent! / 3;
//       if (details.localPosition.dx < widthOfParent) {
//         if (selectedValue == 0) return;
//         //setSensorType(selectedValue - 1);
//       } else if (details.localPosition.dx > widthOfParent * 2) {
//         if (selectedValue == setup.sensorTypes.length - 1) {
//           setSensorType(selectedValue - 1);
//         } else {
//           setSensorType(selectedValue + 1);
//         }
//       }
//     } catch (e) {
//       logger.d(e.toString());
//     }
//   },
//   child: NumberPicker(
//     minValue: 0,
//     maxValue: setup.sensorTypes.length - 1,
//     axis: Axis.horizontal,
//     value: selectedValue,
//     itemWidth: (MediaQuery.of(context).size.width > 600)
//         ? MediaQuery.of(context).size.width * 0.1
//         : MediaQuery.of(context).size.width * 0.12,
//     textStyle: Theme.of(context)
//         .textTheme
//         .bodySmall!
//         .copyWith(fontSize: MediaQuery.of(context).size.aspectRatio * 20),
//     selectedTextStyle: Theme.of(context)
//         .textTheme
//         .bodyMedium!
//         .copyWith(fontSize: MediaQuery.of(context).size.aspectRatio * 22),
//     itemHeight: 20,
//     onChanged: setSensorType,
//     haptics: true,
//     infiniteLoop: true,
//     itemCount: setup.sensorTypes.length,
//     textMapper: (numberText) {
//       final typeEquilivance =
//           setup.sensorTypes.keys.elementAt(int.parse(numberText));
//       switch (typeEquilivance) {
//         case UsedSensorsType.distance:
//           return inst.game_ui_device_sensor_distance;
//         case UsedSensorsType.force:
//           return inst.game_ui_device_sensor_force;
//         case UsedSensorsType.motion:
//           return inst.game_ui_device_sensor_motion;
//         case UsedSensorsType.tap:
//           return inst.game_ui_device_sensor_tap;
//         case UsedSensorsType.none:
//           return inst.game_ui_device_sensor_none;
//       }
//     },
//   )
//     //   ,
//   }
// }
