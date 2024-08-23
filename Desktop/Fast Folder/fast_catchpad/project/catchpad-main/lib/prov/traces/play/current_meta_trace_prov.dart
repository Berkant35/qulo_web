import 'dart:io';

import 'package:catchpad/models/feedback/traces/play/meta_trace.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';
import 'package:platform_device_id/platform_device_id.dart';

class CurrentMetaTraceNotifier extends StateNotifier<MetaTrace?> {
  CurrentMetaTraceNotifier(MetaTrace? state) : super(null);

  Future<void> createMetaTrace(WidgetRef ref) async {
    final traceId = await nanoid(24);
    final deviceId = await PlatformDeviceId.getDeviceId;
    final platformVersion = await DeviceInformation.platformVersion;
    //final imeiNo = await DeviceInformation.deviceIMEINumber;
    final modelName = await DeviceInformation.deviceModel;
    final manufacturer = await DeviceInformation.deviceManufacturer;
    final cpuType = await DeviceInformation.cpuName;
    final hardware = await DeviceInformation.hardware;
    final apiLevel = await DeviceInformation.apiLevel;
    final deviceName = await DeviceInformation.deviceName;
    final productName = await DeviceInformation.productName;

    final date = DateTime.now();

    final createdAt = date.toString().substring(0, 18);

    final metaTrace = MetaTrace(
        traceID: traceId,
        userID: ref.read(currentUserProv)?.uid,
        gameID: ref.read(currentGameProv)?.id,
        os: Platform.operatingSystem,
        phoneMacID: deviceId,
        phoneModel: modelName,
        manufacturer: manufacturer,
        cpuType: cpuType,
        platformVersion: platformVersion,
        apiLevel: apiLevel.toString(),
        createdTime: date.toIso8601String(),
        deviceName: deviceName,
        productName: productName,
        hardware: hardware,
        createdAt: createdAt,
        createdMillisecondEpoch: date.millisecondsSinceEpoch.toString());

    state = metaTrace;

    ref.read(currentPlayTraceManager.notifier).updateCurrentPlayTrace(ref);
  }

  void disposeCurrentTrace() => state = null;
}
