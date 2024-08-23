import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/utility/loading_status.dart';
import 'global_providers.dart';

typedef RemainingTime = Map<String, Timer>;

/*
* Bu manager sayfası padlere komut gönderilmediğinde tüm padleri
* uykuya geçirme aksiyonlarının kontrol edildiği kısımdır.
* The manager page for this pad controls the actions of putting all
* pads to sleep when no commands are sent.
* */

class AutoBleDisconnectProvNotifier extends StateNotifier<RemainingTime> {
  AutoBleDisconnectProvNotifier(RemainingTime state) : super({});
  Set<String> firstConnectedIds = {};
  Set<String> deviceIdList = {};

  bool atGame = false;

  late WidgetRef lRef;
  late FlutterReactiveBle flutterReactBle;
  int? dueDateMs;
  int min = 5;
  Timer? timer;

  void changeAtGame(bool onGameValue) => atGame = onGameValue;

  Future<void> sleep(WidgetRef ref) async {
    if (ref.read(currentEmbModeManager) == 1) return;
    logger.i("SLEEP!");

    if (!ref.context.mounted) return;

    final currentChargingStatus = ref.read(currentChargingStatusManager);
    bool isActionRealized = false;
    ref.read(currentDevicesManagerProvider).keys.forEach((deviceId) {
      if (currentChargingStatus[deviceId] != null &&
          currentChargingStatus[deviceId]!) {

        return;
      }
      if (ref
              .read(currentDevicesManagerProvider.notifier)
              .connectedDevice
              .containsKey(deviceId) &&
          currentChargingStatus[deviceId] != null &&
          !currentChargingStatus[deviceId]! &&
          !atGame) {
        //Auto Connect Enable
        ref.read(bleAutoConnectStateNotifierProv.notifier).changState(false);
        const dt = 'S';
        ref.read(currentBatteryOfPadsManager.notifier).remove(ref, deviceId);
        flutterReactBle.writeCharacteristicWithResponse(
            sleepCharacteristicAdminInfo.qualCharacteristic(deviceId),
            value: utf8.encode(dt));
        if (Platform.isAndroid) {
          flutterReactBle.clearGattCache(deviceId);
          ref.read(bleDeviceConnectorProv).disconnect(ref
              .read(currentDevicesManagerProvider.notifier)
              .connectedDevice[deviceId]!);
        }
        if (!isActionRealized) isActionRealized = true;

        ref.read(currentDeadListManager.notifier).deleteFromDeadList(deviceId);

        ref
            .read(currentDeadListManager.notifier)
            .addDeadListOfPad(deviceId, ref);
        Future.delayed(
            const Duration(seconds: 5),
            () => ref
                .read(bleAutoConnectStateNotifierProv.notifier)
                .changState(true));
      }
    });
    if (isActionRealized) timer?.cancel();
  }

  void startTimer(
      String deviceId, WidgetRef ref, DiscoveredDevice discoveredDevice) {
    dueDateMs = DateTime.now().millisecondsSinceEpoch + 300000; //5 min

    lRef = ref;

    deviceIdList.add(discoveredDevice.id);

    flutterReactBle = lRef.read(bleProv);

    Future.delayed(const Duration(seconds: 1), () {
      Timer.periodic(
        Duration(minutes: min),
        (event) async {
          if (!lRef.context.mounted ||
              lRef.read(currentGameTraceManager) != null) {
            return;
          }

          final currentTime = DateTime.now().millisecondsSinceEpoch;

          if (!lRef
                  .read(currentAllDeviceUploadingManager)
                  .values
                  .any((element) => element == LoadingStates.loading) &&
              currentTime >=
                  (dueDateMs ??
                      DateTime.now().millisecondsSinceEpoch + 300000)) {
            await Future.delayed(
                const Duration(seconds: 1)); // kısa bir gecikme ekleyin
            sleep(lRef);
          }
        },
      );
    });
  }

  void stopTimer(String deviceId) {
    if (state.containsKey(deviceId)) {
      state[deviceId]?.cancel();
      state.remove(deviceId);
    }
  }

  void restartTimer(String deviceId, WidgetRef ref) {
    if (state.containsKey(deviceId)) {
      stopTimer(deviceId);
    }

    if (dueDateMs != null) {
      dueDateMs = DateTime.now().millisecondsSinceEpoch;
    }

    final discoveredDevice = ref
        .read(currentDevicesManagerProvider.notifier)
        .connectedDevice[deviceId];

    if (discoveredDevice != null) {
      if (ref.read(currentEmbModeManager) != 1) {
        startTimer(deviceId, ref, discoveredDevice);
      }
    }
  }
}
