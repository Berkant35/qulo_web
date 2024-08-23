import 'dart:io';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/models/pad_ota_config.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../global_providers.dart';

typedef AllDevicesWaitingByteLists = Map<String, int>;
typedef ResponseFromBleCounter = Map<String, int>;
typedef CanSendNewByte = Map<String, bool>;

class UpdateOtaFileNotifier extends StateNotifier<LoadingStates> {
  UpdateOtaFileNotifier(LoadingStates loaded) : super(LoadingStates.loaded);

  static const debugOTALink =
      "https://github.com/Berkant35/cp04v1.0.11/raw/main/CPHW05_SesAnindaDokunma.bin";

  static const responseCode = "[1, 2, 3, 4, 5]";

  var connecting = false;

  var waitResponseCode = false;

  var lastSendByteLength = 0;

  //{Device ID: []}
  AllDevicesWaitingByteLists allDevicesWaitingByteLists = {};

  //{Device ID: 45}
  ResponseFromBleCounter responseFromBleCounter = {};

  //{Device ID: false}
  CanSendNewByte canSendNewByte = {};

  //All devices when starting to upload any device firstly look at the this parameter
  //if this parameter empty you must firstly download to static url and then fill
  //this byte list.
  List<int> startPointAllBytes = [];

  String? uploadingDeviceId;

  // TODO: YOU MUST ADD FIREBASE VERSION CONTROL SYSTEM FOR FIRMWARE UPDATE

  Future<void> connectDevice(
      DiscoveredDevice discoveredDevice, WidgetRef ref) async {
    final deviceConnector = ref.read(bleDeviceConnectorProv);
    connecting = true;
    await deviceConnector.connect(discoveredDevice).then((value) {
      connecting = false;
    });
    return;
  }

  void changeStatus(LoadingStates value) {
    state = value;
  }

  bool addNewUpdateToDevice(String deviceId, WidgetRef ref) {
    if (startPointAllBytes.isNotEmpty) {
      allDevicesWaitingByteLists.addAll({deviceId: 0});
      ref
          .read(currentAllDeviceUploadingManager.notifier)
          .addNewUpdateFilePercentStatus(deviceId, ref);
      ref
          .read(currentUpdatePercentManager.notifier)
          .addNewUpdateFilePercentStatus(deviceId, ref);
      canSendNewByte.addAll({deviceId: true});
      return true;
    } else {
      return false;
    }
  }

  Future<void> calculateUpdateOTAFile(String deviceId, WidgetRef ref) async {
    //howMuchUploadedFilePercent.update(deviceId, (value) => percentage);

    double percentage =
        (responseFromBleCounter[deviceId]! / startPointAllBytes.length) * 100;

    ref
        .read(currentUpdatePercentManager.notifier)
        .updateFilePercentStatus(deviceId, ref, percentage);
  }

  void listenCurrentUpdatingPad(String deviceId, WidgetRef ref) {
    PadManager.listenToResponseForOTAUpdate(deviceId, ref: ref).listen((event) {
      waitResponseCode = false;

      if (responseFromBleCounter.keys.contains(deviceId)) {
        responseFromBleCounter[deviceId] =
            responseFromBleCounter[deviceId]! + lastSendByteLength;
      } else {
        responseFromBleCounter.addAll({deviceId: 1});
      }

      calculateUpdateOTAFile(deviceId, ref);

      ///TO:DO İŞLEM BİTİNCE 0 LA HERŞEYİ!!
    });
  }

  Future<void> startAllDeviceUpdate(WidgetRef ref) async {
    for (var deviceId in allDevicesWaitingByteLists.keys) {
      listenCurrentUpdatingPad(deviceId, ref);
    }

    for (int i = 0; i < allDevicesWaitingByteLists.keys.length; i) {
      //final deviceId = allDevicesWaitingByteLists.keys.toList()[i];
      try {
        ref.read(currentAllDeviceUploadingManager.notifier).updateStatus(
            allDevicesWaitingByteLists.keys.toList()[i],
            LoadingStates.loading,
            ref);
        await startPerOta(ref, allDevicesWaitingByteLists.keys.toList()[i])
            .then((value) {
          ref.read(currentAllDeviceUploadingManager.notifier).updateStatus(
              allDevicesWaitingByteLists.keys.toList()[i],
              LoadingStates.loaded,
              ref);

          i++;
        });
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future<void> startPerOta(WidgetRef ref, String deviceId) async {
    if (ref.read(currentAllDeviceUploadingManager)[deviceId] !=
        LoadingStates.loading) {
      ref
          .read(currentAllDeviceUploadingManager.notifier)
          .updateStatus(deviceId, LoadingStates.loading, ref);
    }

    logger.i("Start Per Ota : ${startPointAllBytes.length}");

    for (int i = 0; i < startPointAllBytes.length; i) {
      bool exitFromLoop = true;

      List<int> perList = [];

      while (exitFromLoop) {
        if (startPointAllBytes.length > i && perList.length < 509) {
          perList.add(startPointAllBytes[i]);
          i++;
        } else {
          exitFromLoop = false;
          continue;
        }
      }

      Uint8List list = Uint8List.fromList(perList);

      try {
        final discoveredDevice = ref
            .read(bleConPr)
            .keys
            .firstWhere((element) => element.id == deviceId);
        if (ref.read(bleConPr)[discoveredDevice]!.connectionState ==
            DeviceConnectionState.disconnected) {
          logger.i(
              "Failed!!! ${ref.read(bleConPr)[discoveredDevice]!.connectionState}");
          i = startPointAllBytes.length + 1;
        } else {
          //Safely cover for ios delay
          //when you remove this delay
          //crush app on ios.

          if (Platform.isIOS) {
            await Future.delayed(const Duration(milliseconds: 30));
          } else {
            await Future.delayed(const Duration(milliseconds: 10));
          }

          lastSendByteLength = list.length;

          int timeOut = 0;

          final curUserDevId = ref.read(currentUserProv)!.uid;

          while (waitResponseCode && timeOut < 100
              /*&& !adminIdList.contains(curUserDevId)*/
              ) {
            await Future.delayed(const Duration(milliseconds: 1));
            timeOut++;
          }

          await PadManager.sendPart512(deviceId,
              byteList: list, ref: ref, withResponse: Platform.isAndroid);

          if (!adminIdList.contains(curUserDevId)) waitResponseCode = true;

          if (list.length < 509) allByteSend(ref, deviceId);
        }

        perList.clear();
      } catch (e) {
        throw Exception("$e sendPart512");
      }
    }
  }

  Future<void> allByteSend(WidgetRef ref, String deviceId) async {
    if (ref
        .read(currentDevicesManagerProvider.notifier)
        .queueOtaDeviceId
        .contains(deviceId)) {
      ref
          .read(currentDevicesManagerProvider.notifier)
          .queueOtaDeviceId
          .remove(deviceId);
    }

    ref
        .read(currentUpdatePercentManager.notifier)
        .updateFilePercentStatus(deviceId, ref, 0.0);

    ref
        .read(currentAllDeviceUploadingManager.notifier)
        .updateStatus(deviceId, LoadingStates.loaded, ref);
  }

  Future<void> downloadFileWithHttpUrl(String userId) async {
    try {
      final padOtaConfig = await FirebaseCollectionEnums.pad_config.reference
          .withConverter<PadOtaConfig>(
              fromFirestore: (snapshot, options) =>
                  PadOtaConfig.fromJson(snapshot.data()!),
              toFirestore: (value, options) => value.toJson())
          .doc("configs")
          .get();

      PadOtaConfig currentPadOtaConfig = padOtaConfig.data()!;
      //kDebugMode
      //           ? debugOTALink
      //           : currentPadOtaConfig.currentVersionGithubLink ?? ""
      final uri = Uri.parse(debugOTALink);

      var response = await http.get(uri);

      startPointAllBytes = response.bodyBytes.buffer.asUint8List();
      return;
    } catch (e) {
      throw FirebaseException(
          plugin: "downloadFileWithHttpUrl", message: "Null Check Invalid!");
    }

    return;
  }
}
