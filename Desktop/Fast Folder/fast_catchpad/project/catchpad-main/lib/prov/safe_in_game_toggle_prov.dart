import 'dart:async';
import 'dart:math';

import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/flags_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/emb/iga/iga_consts.dart';

class SafeInGameToggleControlNotifier extends StateNotifier<bool> {
  SafeInGameToggleControlNotifier(bool state) : super(false);
  Timer? timer;
  bool localPadShowFlag = false;
  bool alreadyShowing = false;

  Future<void> changState(bool val, WidgetRef ref) async {
    state = val;
    if (val &&
        ref.read(currentIgaTraceStateManager) != IgaPlayTraceStates.game) {
      ref
          .read(currentIgaTraceStateManager.notifier)
          .changState(IgaPlayTraceStates.game, ref: ref);
    }

    if (!val && localPadShowFlag) localPadShowFlag = false;
    final connectedDevices = ref
        .read(bleConPr)
        .values
        .where((cState) =>
            cState.connectionState == DeviceConnectionState.connected)
        .toList();

    if (!val && (!localPadShowFlag) || !alreadyShowing) startPadShow(ref, connectedDevices);
  }

  Future<void> startPadShow(
      WidgetRef ref, List<ConnectionStateUpdate> connectedDevices,
      {bool forcedVal = false}) async {
    // logger.w("ref.read(eventIgaController) : ${ref.read(eventIgaController)}");

    if(connectedDevices.isEmpty){
       connectedDevices = ref
          .read(bleConPr)
          .values
          .where((cState) =>
      cState.connectionState == DeviceConnectionState.connected)
          .toList();
    }

    if (ref.read(eventIgaController)) return;
    final colors = defaultConstColors(ref);
    //connected devices equal 12 or more

    if (ref.watch(currentSafeInGameToggleState)) return;

    if (alreadyShowing) return;

    await Future.doWhile(() async {
      if(!ref.context.mounted) return false;
      final devs = ref.read(bleConPr).keys.toList();
      localPadShowFlag = true;
      if (connectedDevices.length == 12) {
        alreadyShowing = true;
        for (var perDevice in devs) {
          final randomColorIndex = Random().nextInt(colors.length);
          PadManager.ledColor(
              perDevice.id, SidesColorsModel.all(colors[randomColorIndex]),
              ref: ref);
        }

        await Future.delayed(
            const Duration(milliseconds: IgaConsts.padShowIntervalMs));

        localPadShowFlag = true;

        return !state;
      }

      return state;
    }).then((value) {
      alreadyShowing = false;
      // if(!state) startPadShow(ref, connectedDevices, forcedVal: true);
      // logger.w("Already Showing: $alreadyShowing");
    });
  }
}
