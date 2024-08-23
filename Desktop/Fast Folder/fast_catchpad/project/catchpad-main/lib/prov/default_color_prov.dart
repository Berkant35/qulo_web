import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentDefaultColorManager =
StateNotifierProvider<DefaultColorControlNotifier, Map<Color, bool>?>(
        (_) => DefaultColorControlNotifier(defState()));

Map<Color, bool> defState() {
  return {
    CpColors.red : true,
    CpColors.green : true,
    CpColors.blue : true,
    CpColors.yellow : true,
    const Color.fromARGB(255, 255, 102, 0) : true,
    const Color.fromARGB(255, 0, 255, 255) : true,
    const Color.fromARGB(255, 255, 0, 42) : true,
    const Color.fromARGB(255, 255, 27, 0) : true,
    const Color.fromARGB(255, 255, 0, 255) : true
  };
}

class DefaultColorControlNotifier extends StateNotifier<Map<Color, bool>> {
  DefaultColorControlNotifier(Map<Color, bool> state) : super(defState());


  void refresh() => state = defState();

  Color? getOneAvailableColor() {
    Color? defaultColor;

    for (var entry in state.entries) {

      var key = entry.key;
      var value = entry.value;

      if (value) {
        final temp = state;
        temp[key] = false;
        state = temp;
        defaultColor = key;
        break; // Döngüyü burada sonlandırabilirsiniz.
      }
    }
    return defaultColor;
  }
}
