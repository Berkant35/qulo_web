import '../../../../utils/util_methods/util_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../prov/exercise_provider.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/l10n/l10n.dart';

class DeviceCatchCountByColorsWidget extends ConsumerWidget {
  const DeviceCatchCountByColorsWidget(
      {Key? key, required this.catchedDevicesByColor})
      : super(key: key);
  final String catchedDevicesByColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final exercises = ref.read(exerciseProvider).exercises;
    List<String> colorsandvalues = catchedDevicesByColor.split('|');
    Map<String, String> colorsandvaluesmap = {};
    colorsandvalues.removeLast();
    for (var i = 0; i < colorsandvalues.length; i = i + 2) {
      colorsandvaluesmap[colorsandvalues[i]] = colorsandvalues[i + 1];
    }
    List<Widget> myWidgetList = [];
    colorsandvaluesmap.forEach((key, value) {
      Color color = Color(int.parse(key, radix: 16));
      color = fakeColorGenerator(color);
      myWidgetList.add(Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.aspectRatio * 75,
                  minWidth: MediaQuery.of(context).size.aspectRatio * 75),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color),
              alignment: Alignment.center,
              child: Text(
                value,
                style: (blackTextInLightColor(Color(int.parse(key, radix: 16)))
                    ? const TextStyle(color: Colors.black)
                    : null),
              ),
            ),
            if (exercises.values.isNotEmpty && exercises.values.contains(key))
              Text(exercises.entries
                  .firstWhere((element) => element.value == key)
                  .key)
          ],
        ),
      )
          // Catch counts are not in the circle but under them in this code
          /* Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse(key, radix: 16))),
                ),
              ),
              Flexible(child: Text(value))
            ].joinWidgetList(
              (e) => const SizedBox(
                width: defPaddingSize,
              ),
            ),
          ),
        ), */
          );
    });
    List<Widget> myFirstList = [];
    List<Widget> mySecondList = [];
    if (myWidgetList.length > 5) {
      myFirstList = myWidgetList.sublist(0, 5);
      mySecondList = myWidgetList.sublist(5);
    } else {
      myFirstList = myWidgetList;
    }

    return Container(
      padding: const EdgeInsets.all(defPaddingSize),
      decoration: BoxDecoration(
          color: const Color(0xFF333846).withOpacity(0.8),
          borderRadius: BorderRadius.circular(defPaddingSize)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(inst.game_ui_device_catch_types),
          Padding(
            padding: const EdgeInsets.all(defPaddingSize),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: myFirstList),
          ),
          if (mySecondList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(defPaddingSize),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: mySecondList),
            ),
        ],
      ),
    );
  }
}

