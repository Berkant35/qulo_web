import 'dart:async';

import 'package:catchpad/data/api/telegram/telegram_manager.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global_providers.dart';

final igaBackGroundManager = StateNotifierProvider<
    IGABackgroundBleConnectionsNotifier, Map<String, DiscoveredDevice>>(
  (ref) => IGABackgroundBleConnectionsNotifier({}),
);

final currentAreUOkCounter =
    StateNotifierProvider<AreUOkNotifierControlNotifier, Map<String, int>>(
  (ref) => AreUOkNotifierControlNotifier({}),
);

class AreUOkNotifierControlNotifier extends StateNotifier<Map<String, int>> {
  AreUOkNotifierControlNotifier(Map<String, int> state) : super({});

  void changState(val) => state = val;

  increment(String id) {
    final increment = state[id]!;
    final setIncrement = increment + 1;
    state[id] = setIncrement;
    logger.w(state[id]);
  }

  clear() => state.clear();

  add(String id) => state.addAll({id: 2});
}

class IGABackgroundBleConnectionsNotifier
    extends StateNotifier<Map<String, DiscoveredDevice>> {
  IGABackgroundBleConnectionsNotifier(Map<String, DiscoveredDevice> state)
      : super({});
  int zeroCounter = 0;
  Set<DiscoveredDevice> easyDiscoveredDevices = {};
  Set<DiscoveredDevice> firstPlayerDiscoveredDevices = {};
  Set<DiscoveredDevice> secondPlayerDiscoveredDevices = {};
  List<String> enableDevices = [];
  String? igaTableDeviceId = "default";
  static const bool _enableAttribute = false;
  bool _firstTime = true;

  void selectIgaTablets(String id) => igaTableDeviceId = id;

  Future<void> deadLoopForFlagTrue(
      DiscoveredDevice perDevice, WidgetRef ref) async {
    PadManager.setConnectionFlagTrue(perDevice.id, ref: ref);
    await Future.delayed(const Duration(milliseconds: 40));

    final list = await PadManager.readAreUOkTimer(perDevice.id, ref: ref);
    final counterFromByteList = String.fromCharCodes(list ?? []);

    logger.i(
        "Counter From Byte List: $counterFromByteList\nMy Locale: ${ref.read(currentAreUOkCounter)[perDevice.id]}");

    if (ref.read(currentAreUOkCounter)[perDevice.id] ==
        int.parse(counterFromByteList)) {
      deadLoopForFlagTrue(perDevice, ref);
    } else {
      ref.read(currentAreUOkCounter.notifier).increment(perDevice.id);
    }
  }

  Future<void> flagTrueAllPad(WidgetRef ref) async {
    if (!_enableAttribute) return;
    Timer.periodic(const Duration(seconds: 15), (timer) async {
      final allCurrentDevices = ref.read(bleConPr);
      allCurrentDevices.forEach((perDevice, value) async {
        PadManager.setConnectionFlagTrue(perDevice.id, ref: ref);
        await Future.delayed(const Duration(milliseconds: 40));

        final list = await PadManager.readAreUOkTimer(perDevice.id, ref: ref);
        final counterFromByteList = String.fromCharCodes(list ?? []);

        if (ref.read(currentAreUOkCounter)[perDevice.id] ==
            int.parse(counterFromByteList)) {
          deadLoopForFlagTrue(perDevice, ref);
        } else {
          ref.read(currentAreUOkCounter.notifier).increment(perDevice.id);
        }
        if (_firstTime) {
          deadLoopForFlagTrue(perDevice, ref);
          _firstTime = false;
        }
      });
    });
  }

  Future<void> initializeScanAndConnect(WidgetRef ref) async {
    ref.watch(bleScannerProv).startScan();

    ref.watch(bleConenctionStateProv);
    ref.watch(bleScannerProv);

    final scan = ref.watch(bleScanStreamProv);
    final allConStates = ref.watch(bleConPr);
    final connectionManager = ref.watch(bleDeviceConnectorProv);

    if (IgaConsts.igaTabletDevices[igaTableDeviceId] == null) return;

    final forceConnectDevices =
        IgaConsts.igaTabletDevices[igaTableDeviceId]!.toList();

    return scan.when(data: (d) async {
      final count = allConStates.keys.length;

      Set<DiscoveredDevice> tempeasyDiscoveredDevices = {};
      Set<DiscoveredDevice> tempfirstPlayerDiscoveredDevices = {};
      Set<DiscoveredDevice> tempsecondPlayerDiscoveredDevices = {};

      for (var pereasyDiscoveredDevice in easyDiscoveredDevices) {
        if (!tempeasyDiscoveredDevices
            .any((element) => element.id == pereasyDiscoveredDevice.id)) {
          tempeasyDiscoveredDevices.add(pereasyDiscoveredDevice);
        }
      }
      for (var perfirstPlayerDiscoveredDevice in firstPlayerDiscoveredDevices) {
        if (!tempfirstPlayerDiscoveredDevices.any(
            (element) => element.id == perfirstPlayerDiscoveredDevice.id)) {
          tempfirstPlayerDiscoveredDevices.add(perfirstPlayerDiscoveredDevice);
        }
      }
      for (var element in secondPlayerDiscoveredDevices) {
        if (!tempsecondPlayerDiscoveredDevices.any(
            (pertempeasyDiscoveredDevice) =>
                element.id == pertempeasyDiscoveredDevice.id)) {
          tempsecondPlayerDiscoveredDevices.add(element);
        }
      }

      easyDiscoveredDevices = tempeasyDiscoveredDevices;
      firstPlayerDiscoveredDevices = tempfirstPlayerDiscoveredDevices;
      secondPlayerDiscoveredDevices = tempsecondPlayerDiscoveredDevices;

      allConStates.forEach((perDevice, value) {
        if (value.connectionState != DeviceConnectionState.connected) {
          if (easyDiscoveredDevices.contains(perDevice)) {
            easyDiscoveredDevices.remove(perDevice);
          }
          if (firstPlayerDiscoveredDevices.contains(perDevice)) {
            firstPlayerDiscoveredDevices.remove(perDevice);
          }
          if (secondPlayerDiscoveredDevices.contains(perDevice)) {
            secondPlayerDiscoveredDevices.remove(perDevice);
          }
        }
      });

      for (var perDevice in d.deviceModels) {
        // logger.i("Per Device Name:${perDevice.name}");
        // logger.i("Per Device id:${perDevice.id}");
        // logger.i(
        //     "Iga Tablet Device Id:${IgaConsts.igaTabletDevices['$igaTableDeviceId']!.contains(perDevice.id)} ${IgaConsts.igaTabletDevices['$igaTableDeviceId']!.toString()}");
        // logger.i("Per Device deviceNumber:${perDevice.deviceNumber}");
        // logger.i("Per Device manufacturerData:${perDevice.manufacturerData}");

        final conStatePerDevice = allConStates[perDevice];

        if (IgaConsts.igaTabletDevices['$igaTableDeviceId/F']!
                .contains(perDevice.id.toUpperCase()) &&
            !firstPlayerDiscoveredDevices.contains(perDevice)) {
          firstPlayerDiscoveredDevices.add(perDevice);
          ref.read(currentAreUOkCounter.notifier).add(perDevice.id);
        }

        if (IgaConsts.igaTabletDevices['$igaTableDeviceId/S']!
                .contains(perDevice.id.toUpperCase()) &&
            !secondPlayerDiscoveredDevices.contains(perDevice)) {
          secondPlayerDiscoveredDevices.add(perDevice);
          ref.read(currentAreUOkCounter.notifier).add(perDevice.id);
        }

        if (IgaConsts.igaTabletDevices['$igaTableDeviceId/E']!
                .contains(perDevice.id.toUpperCase().toUpperCase()) &&
            !easyDiscoveredDevices.contains(perDevice)) {
          easyDiscoveredDevices.add(perDevice);
          ref.read(currentAreUOkCounter.notifier).add(perDevice.id);
        }

        if (conStatePerDevice != null &&
            conStatePerDevice.connectionState ==
                DeviceConnectionState.connected) {
          try {
            if (!enableDevices.contains(perDevice.id)) {
              PadManager.iCanSeeYouStillControl(perDevice.id,
                  ref: ref, enableAttribute: _enableAttribute);
              enableDevices.add(perDevice.id);
            }
          } catch (e) {
            logger.e("Error:$e");
          }
        }

        ///Again connection
        if (forceConnectDevices.contains(perDevice.id) &&
            (conStatePerDevice == null ||
                conStatePerDevice.connectionState ==
                    DeviceConnectionState.disconnected)) {
          connectionManager.connect(perDevice);
        }

        if (conStatePerDevice?.connectionState ==
                DeviceConnectionState.connected &&
            !ref
                .read(currentDevicesManagerProvider)
                .keys
                .contains(perDevice.id)) {
          await getInfoAboutConnectedPadAndSet(perDevice, ref);
        }
      }
    }, error: (err, _) {
      logger.i(_);
      logger.i(err.toString());
    }, loading: () {
      logger.i("Searching IGA Catchpad Devices");
    });
  }

  Future<void> getInfoAboutConnectedPadAndSet(
      DeviceModel perDevice, WidgetRef ref) async {
    PadManager.getDeviceInfo(perDevice.id, ref: ref).then((deviceInfo) async {
      if (deviceInfo != null) {
        ref
            .read(currentDevicesManagerProvider.notifier)
            .setDevice(deviceInfo, perDevice.id, ref);
      }

      ref
          .read(currentDevicesManagerProvider.notifier)
          .setConnectedDevice(perDevice, ref);
    });
  }

  List<DiscoveredDevice> getConnectedDevices(WidgetRef ref) {
    return [];
  }

  Future<void> disconnectedPadToTelegram(
      WidgetRef ref, List<DiscoveredDevice> discoveredDevices) async {
    StringBuffer macIdBuffers = StringBuffer();

    List<String> macIds = IgaConsts.igaTabletDevices[
            "${ref.read(currentDeviceInformationManager)?.deviceId}"]!
        .toList()!;

    for (var perDiscover in discoveredDevices) {
      if (macIds.contains(perDiscover.id.toUpperCase())) {
        macIds.remove(perDiscover.id.toUpperCase());
      }
    }

    macIdBuffers.write(macIds.toList().toString());

    await TelegramManager.instance!.sendMobileReportMessage(
        "Disconnect Device: \n\n${macIdBuffers.toString()}", ref);

    macIdBuffers.clear();
  }

  Future<void> telegramReport(WidgetRef ref) async {
    StringBuffer buffer = StringBuffer();

    final phoneInformation = ref.read(currentDeviceInformationManager);

    buffer.write("Tablet Is Ready!\n\n\n");
    buffer.write("Tablet Info\n");
    buffer.write("Tablet Name: ${phoneInformation?.deviceName}\n");
    buffer.write("Tablet Id: ${phoneInformation?.deviceId}\n");

    if (ref.read(currentIgaResultManager.notifier).currentLocation != null) {
      buffer.write(
          "Tablet Location Id: ${ref.read(currentIgaResultManager.notifier).currentLocation?.igaLocationId}\n");
      buffer.write(
          "Tablet Location Name: ${ref.read(currentIgaResultManager.notifier).currentLocation?.igaLocationName}\n");
      buffer.write(
          "Game Count: ${ref.read(currentIgaResultManager.notifier).currentLocation?.igaLocationGameCount}\n");
    }

    buffer.write("--------------------\n\n\n");
    buffer.write(
        "Current Total Connected Device: ${ref.read(bleConPr).keys.length}\n");
    buffer.write("--------------------\n\n\n");
    buffer.write("Time: ${DateTime.now().toIso8601String()}\n");
    buffer.write("--------------------\n\n\n");

    await TelegramManager.instance!
        .sendMobileReportMessage(buffer.toString(), ref);
  }
}
