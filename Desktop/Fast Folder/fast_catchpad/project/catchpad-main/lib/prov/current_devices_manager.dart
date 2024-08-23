import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/data/api/telegram/telegram_manager.dart';
import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/prov/app_settings_prov.dart';
import 'package:catchpad/prov/auth/auth_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/ota/need_ota_pads.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enums/utility/pad_error_enums.dart';
import 'auth/current_user_prov.dart';

typedef AllPadsErrorConfigList = Map<String, PadErrorConfigList>;

class CurrentDeviceManagerProvider
    extends StateNotifier<Map<String, DevInfoModel>> {
  CurrentDeviceManagerProvider(Map<String, DevInfoModel> state) : super({});
  bool openDialog = false;

  bool isOpened = false;

  Map<String, DiscoveredDevice> alreadyDisconnecting = {};

  Map<String, DiscoveredDevice> connectedDevice = {};

  Set<String> anyAskedForDevice = {};

  Set<String> queueOtaDeviceId = {};

  ///You can handle for games if any error on pad.
  ///So that you must restrict to enter game
  AllPadsErrorConfigList allPadsErrorConfigList = {};

  Future<void> setDevice(
      DevInfoModel deviceModel, String deviceId, WidgetRef ref) async {
    //For performance on release!

    await PadManager.toggleDebug(deviceId,
        enable: (kDebugMode ||
            ref.read(currentUserProv)!.email == "fatih@catchpad.com" &&
                ref.read(currentUserProv) != null),
        ref: ref);
    // PadManager.setSleepMode(deviceId,
    //     ref: ref,
    //     sleepModeOnCustom: ref.watch(appSettingsToggleProvider).enableToForce);

    Map<String, DevInfoModel> tempMap = Map<String, DevInfoModel>.from(state);

    if (tempMap.keys.contains(deviceId)) {
      tempMap.update(deviceId, (value) => deviceModel);
    } else {
      tempMap.addAll({deviceId: deviceModel});
    }
    state = tempMap;

    final listOfFuture = <Future>[];

    if (!ref.context.mounted) return;
    if(ref.read(currentEmbModeManager) != 1){
      listOfFuture.add(
        ref
            .read(currentPadErrorProvManager.notifier)
            .getConfigList(deviceId, ref),
      );

      listOfFuture.add(checkPadVersion(ref, deviceModel, deviceId));

      Future.wait(listOfFuture);
    }

  }

  // TODO You can check error logs on pads and match with deviceId!
  void checkPadErrorLogsAndSaveForDevices(String deviceId) {}

  ///You can check any must update on pads.
  ///If this your answer yes,
  ///go ahead for start download!

  Future<void> checkPadVersion(
      WidgetRef ref, DevInfoModel deviceModel, String deviceId) async {
    AwesomeDialog awesomeDialog = AwesomeDialog(
        context: ref.context,
        dialogType: DialogType.warning,
        dismissOnTouchOutside: false,
        animType: AnimType.bottomSlide,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: defPaddingSize,
              ),
              Text(L10n.inst(ref.context).content_please_wait),
              const SizedBox(
                height: defPaddingSize,
              ),
              const CircularProgressIndicator.adaptive(),
              const SizedBox(
                height: defPaddingSize,
              )
            ],
          ),
        ));
     /// TODO
    if ((deviceModel.isCp04 || adminIdList.contains(ref.read(currentUserProv)?.uid)) &&
        ref.read(currentEmbModeManager) == 0 && (ref.read(currentNeedOtaManager).contains(deviceModel.macId?.toUpperCase()) ||
        deviceModel.swVersion != '9999999' && deviceModel.swVersion != "-1" &&
            deviceModel.swVersion !=
                ref.read(currentPadOtaConfigManager).version &&
            !ref
                .read(currentAllDeviceUploadingManager)
                .values
                .any((element) => element == LoadingStates.loading) &&
            !queueOtaDeviceId.contains(deviceId))) {


      anyAskedForDevice.add(deviceId);

      setStartLoadingAndPercentProcess(ref, deviceId);

      await chooseOtaStyleOldOrNewSystemOta(
          deviceModel, deviceId, ref, awesomeDialog);

    } else if ((deviceModel.isCp04 || adminIdList.contains(ref.read(currentUserProv)?.uid)) && ref.read(currentEmbModeManager) == 0 && (ref.read(currentNeedOtaManager).contains(deviceModel.macId) ||
        deviceModel.swVersion != ref.read(currentPadOtaConfigManager).version && deviceModel.swVersion != "-1" &&
        ref
                .read(currentAllDeviceUploadingManager)
                .values
                .any((element) => element == LoadingStates.loading))) {
      await addQueueOTADevice(deviceId, ref, deviceModel, awesomeDialog);
    }
  }

  Future<void> addQueueOTADevice(String deviceId, WidgetRef ref,
      DevInfoModel deviceModel, AwesomeDialog awesomeDialog) async {
    queueOtaDeviceId.add(deviceId);

    while (queueOtaDeviceId.isNotEmpty) {
      if (!ref
          .read(currentAllDeviceUploadingManager)
          .values
          .any((loadingState) => loadingState == LoadingStates.loading)) {
        setStartLoadingAndPercentProcess(ref, queueOtaDeviceId.first);
        await chooseOtaStyleOldOrNewSystemOta(
            deviceModel, queueOtaDeviceId.first, ref, awesomeDialog);
      } else {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<void> chooseOtaStyleOldOrNewSystemOta(DevInfoModel deviceModel,
      String deviceId, WidgetRef ref, AwesomeDialog awesomeDialog) async {
    int? result = int.tryParse(
        deviceModel.swVersion!.replaceAll("v", "").replaceAll(".", ""));

    final curUserId = ref.read(currentUserProv)!.uid;

    if (result != null && result > 19) {
      setStartLoadingAndPercentProcess(ref, deviceId);
      await AwesomeDialog(
          context: ref.context,
          dismissOnTouchOutside: false,
          dialogType: DialogType.info,
          animType: AnimType.bottomSlide,
          title: L10n.inst(ref.context).ota_dialog_need_update,
          desc: L10n.inst(ref.context).ota_dialog_need_update_content,
          btnOkText: L10n.inst(ref.context).start_process,
          btnOkOnPress: () async {
            awesomeDialog.show();
            await PadManager.otaContiuneFlag(deviceId,
                    ref: ref, withResponse: true)
                .then((value) {
              ref
                  .read(currentAutoDisposeTimerManager.notifier)
                  .changeAtGame(false);
              ref
                  .read(bleDeviceConnectorProv)
                  .disconnect(connectedDevice[deviceId]!)
                  .then((value) async {
                await Future.delayed(const Duration(milliseconds: 1000));

                ref
                    .read(currentAutoDisposeTimerManager.notifier)
                    .changeAtGame(true);

                ref
                    .read(bleDeviceConnectorProv)
                    .connect(connectedDevice[deviceId]!);

                int i = 0;
                //TODO LOOK TO CHARACTERİSTİC
                while (!ref
                        .read(currentDevicesManagerProvider)
                        .keys
                        .contains(deviceId) &&
                    i < 15) {
                  await Future.delayed(const Duration(seconds: 1));
                  i++;
                  logger.i("Waiting....");
                }

                if (i > 15) {
                  awesomeDialog.dismiss();

                  AwesomeDialog(
                          context: ref.context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: L10n.inst(ref.context)
                              .ota_dialog_again_connection_failed_title,
                          desc: L10n.inst(ref.context)
                              .ota_dialog_again_connection_failed_content,
                          btnOkText: L10n.inst(ref.context).ok)
                      .show();
                  Navigator.pop(ref.context);
                } else {
                  PadManager.toggleInGame(deviceId, ref: ref, inGame: true);
                  setStartLoadingAndPercentProcess(ref, deviceId);
                  await ref
                      .read(currentOtaLoadingManager.notifier)
                      .downloadFileWithHttpUrl(ref.read(currentUserProv)!.uid!)
                      .then((value) async {
                    awesomeDialog.dismiss();
                    await ref
                        .read(currentOtaLoadingManager.notifier)
                        .startPerOta(ref, deviceId)
                        .then((value) {
                      ref
                          .read(currentAllDeviceUploadingManager.notifier)
                          .updateStatus(deviceId, LoadingStates.loaded, ref);

                      ref
                          .read(currentNeedOtaManager.notifier)
                          .delete(ref, deviceModel.macId!);
                      PadManager.toggleInGame(deviceId,
                          ref: ref, inGame: false);
                    });
                  });
                }
              });
            });
          }).show();
      /**/
    } else {

      await ref
          .read(currentOtaLoadingManager.notifier)
          .downloadFileWithHttpUrl(ref.read(currentUserProv)!.uid!);

      ref.read(currentOtaLoadingManager.notifier).startPerOta(ref, deviceId);

    }
  }

  void setStartLoadingAndPercentProcess(WidgetRef ref, String deviceId) {
    ref
        .read(currentUpdatePercentManager.notifier)
        .addNewUpdateFilePercentStatus(deviceId, ref);
    ref
        .read(currentAllDeviceUploadingManager.notifier)
        .updateStatus(deviceId, LoadingStates.loading, ref);
    ref
        .read(currentOtaLoadingManager.notifier)
        .listenCurrentUpdatingPad(deviceId, ref);
  }

  Future<void> setConnectedDevice(
      DiscoveredDevice discoveredDevice, WidgetRef ref) async {
    connectedDevice.addAll({discoveredDevice.id: discoveredDevice});
  }

  ///You can change name of pad! Good luck!
  void setName(String deviceId, String newName, WidgetRef ref) {
    DevInfoModel infoModel = state[deviceId]!;
    infoModel.bleName = newName;
    setDevice(infoModel, deviceId, ref);
  }

  ///You can change variant type of pad!
  void setVariant(String deviceId, String variant, WidgetRef ref) {
    DevInfoModel infoModel = state[deviceId]!;
    infoModel.variantId = variant;
    setDevice(infoModel, deviceId, ref);
  }

  ///Remove Current Device!
  void removeDevice(String deviceId, WidgetRef ref) {
    ref.read(currentAutoDisposeTimerManager.notifier).stopTimer(deviceId);
    state.remove(deviceId);
  }

  void addAlreadyDisconnectedDevice(
      DiscoveredDevice discoveredDevice, WidgetRef ref) {
    ref
        .read(currentAutoDisposeTimerManager.notifier)
        .stopTimer(discoveredDevice.id);
    alreadyDisconnecting.addAll({discoveredDevice.id: discoveredDevice});
  }
}
