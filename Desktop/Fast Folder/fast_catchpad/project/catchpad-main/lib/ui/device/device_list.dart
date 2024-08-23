import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:catchpad/models/event/catchpad_event_result.dart';
import 'package:catchpad/models/feedback/traces/play/play_trace.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/dialogs/show_case_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/notification_set_screen.dart';
import 'package:catchpad/ui/watchos_screen.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad/ui/widgets/set_fabric_config_fab.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/device/device_group_model.dart';
import '../../models/enums/firebase/collenction_enums.dart';
import '../../models/enums/utility/show_case_enum.dart';
import '../../models/product/product.dart';
import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';
import '../widgets/cp_logo.dart';
import '../widgets/default_bg.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'device_group.dart';

class DeviceList extends ConsumerWidget {
  const DeviceList({super.key});

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      List.generate(
          length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
    
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
        children: [
          (kDebugMode || adminIdList.contains(ref.read(currentUserProv)?.uid))
              ? FloatingActionButton(
            onPressed: () async {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WatchosScreen()));
            },
            child: const Icon(Icons.refresh),
          )
              : const SizedBox(),
          (kDebugMode || adminIdList.contains(ref.read(currentUserProv)?.uid))
              ? const SetFabricConfigFab()
              : const SizedBox(),
          (kDebugMode || adminIdList.contains(ref.read(currentUserProv)?.uid))
              ? FloatingActionButton(
                  onPressed: () async {
                    // final data = await FirebaseFirestore.instance
                    //     .collection(FirebaseCollectionEnums.main_traces.name)
                    //     .doc(FirebaseCollectionEnumsWithDocuments.admin_traces.name)
                    //     .collection(FirebaseCollectionEnums.traces.name)
                    //     .doc("HMWkGjE0apfnXmvAC8u5q78h")
                    //     .get();
                    // final playTrace = PlayTrace.fromJson(data.data()!);
                    //
                    // logger.i("Play Trace: ${playTrace.toJson()}");
                    /*Timer.periodic(const Duration(seconds: 2), (timer) async {

                       await Future.delayed(Duration(seconds: Random().nextInt(60)));

                       final catchpadEventRes = CatchpadEventResult(
                         userId: generateRandomString(4),
                         eventId: "TjuToa6erPgmx4KXFYNsp80j",
                         userFullName: generateRandomString(4),
                         gameId: "s16",
                         userPrimaryScore: Random().nextDouble() * 100*0.01,
                         userSecondaryScore: Random().nextInt(50),
                       );
                       ref
                           .read(catchPadEventManager.notifier)
                           .addResultUser(ref, result: catchpadEventRes);
                     });*/
                  },
                  child: const Icon(Icons.refresh),
                )
              : const SizedBox(),
        ],
      ),
      body: SafeArea(
        child: DefaultBg(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  expandedHeight: 220,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        color: CpColors.defBgColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defPaddingSize * 2),
                          child: CustomShowCaseWidget(
                              showCaseInfo: ref
                                  .read(currentAllShowCases)
                                  .firstWhere((element) =>
                                      element.key == Tips.padWakeUp.name),
                              showCaseContentWidget: const CpLogo()),
                        )),
                  )),
              const SliverFillRemaining(child: _DevList()),
            ],
          ),
        ),
      ),
      /* bottomNavigationBar: IntrinsicHeight(
        child: Container(
          color: CpColors.bgGC2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Consumer(
                  builder: (context, ref, child) {
                    return CpButton1(
                      onPressed: () {
                        final conMap = ref.read(bleConPr);
                        final connectedDevices = conMap.entries
                            .where((e) =>
                                e.value.connectionState ==
                                DeviceConnectionState.connected)
                            .map((e) => e.key);
                        ref.read(bleScannerProv).stopScan();
                        ref.read(bleScannerProv).refreshScan(
                            connectedDevices: connectedDevices.toList());
                        ref.read(bleScannerProv).resumeScan();
                      },
                      child: Text(L10n.inst(context).scan),
                      fullWidth: true,
                    );
                  },
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ), */
    );
  }

  void refreshScan(WidgetRef ref) {
    final conMap = ref.read(bleConPr);
    final connectedDevices = conMap.entries
        .where(
            (e) => e.value.connectionState == DeviceConnectionState.connected)
        .map((e) => e.key);
    ref.read(bleScannerProv).stopScan();
    ref
        .read(bleScannerProv)
        .hardRefreshScan(connectedDevices: connectedDevices.toList());
    ref.read(bleScannerProv).resumeScan();
  }
}

class _DevList extends ConsumerStatefulWidget {
  const _DevList({super.key});

  @override
  ConsumerState<_DevList> createState() => _DevListState();
}

class _DevListState extends ConsumerState<_DevList> {
  late final Timer _timer;
  bool scanon = true;

  bool onceTimeToggleGame = false;

  //late bool showWarning;
  @override
  void didChangeDependencies() {
    ref.watch(bleScannerProv).startScan();
    super.didChangeDependencies();
  }

  List<DiscoveredDevice> connectedDevs = [];

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (scanon) {
        final forceConnectedDevice = ref
            .read(currentDevicesManagerProvider.notifier)
            .connectedDevice
            .values
            .toList();

        ref
            .read(bleScannerProv)
            .refreshScan(connectedDevices: forceConnectedDevice);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scan = ref.watch(bleScanStreamProv);
    return scan.when(
      loading: LoadingWidget.new,
      error: ErrWidget.new,
      skipLoadingOnRefresh: false,
      data: (state) {
        // important to watch this to keep
        // it running
        ref
            .read(currentAllShowCases.notifier)
            .showCaseIn(context: context, ref: ref);

        ref.watch(bleConenctionStateProv);
        ref.watch(bleScannerProv);

        /* for (var device in state.deviceModels) {
          if (mounted) {
            PadManager.getDeviceInfo(
              device.id,
              ref: ref,
            ).then((info) {
              print(info);
              if (info != null) {
                print(info);
                ref
                    .read(bleConPr.notifier)
                    .updateDevice(device, DeviceConnectionState.connected);
              }
            });
          }
        } */

        final devs = List<DeviceModel>.from(state.deviceModels);

        devs.removeWhere(
          (element) {
            return element.deviceNameId == null;
          },
        );

        devs.sort((a, b) {
          return a.deviceNumber!.compareTo(b.deviceNumber!);
        });

        final conMap = ref.watch(bleConPr);

        //This loop help when we want send  sleep  to pads, removing ui device.

        final connectedIds = conMap.entries
            .where((e) =>
                e.value.connectionState == DeviceConnectionState.connected)
            .map((e) => e.key);

        final connectedDevices =
            devs.where((d) => connectedIds.any((e) => e.id == d.id));

        connectedDevs = connectedDevices.toList();
        final batteryKeys = ref.watch(currentBatteryOfPadsManager).keys;

        for (var discoveredDevice in connectedDevs) {
          ref
              .read(currentDevicesManagerProvider.notifier)
              .setConnectedDevice(discoveredDevice, ref);
        }

        for (var device in connectedDevs) {
          ref.read(currentDevLedManager.notifier).add(ref, device.id);
          ref
              .read(currentDevicesManagerProvider.notifier)
              .addAlreadyDisconnectedDevice(device, ref);

          if (!ref
                  .read(currentDevicesManagerProvider)
                  .keys
                  .contains(device.id) &&
              !ref
                  .read(currentDevicesManagerProvider.notifier)
                  .anyAskedForDevice
                  .contains(device.id)) {
            try {
              PadManager.getDeviceInfo(device.id, ref: ref)
                  .then((deviceInfo) async {
                var refDb = FirebaseCollectionEnums.products.reference;
                final product = await FirebaseCollectionEnums.products.reference
                    .withConverter<Product>(
                        fromFirestore: (snapshot, options) =>
                            Product.fromJson(snapshot.data()!),
                        toFirestore: (value, options) => value.toJson())
                    .doc(deviceInfo?.macId)
                    .get();

                if (product.data()?.swVersion != deviceInfo?.swVersion) {
                  final setData = <String, dynamic>{
                    "swVersion": deviceInfo?.swVersion,
                    "updatedAt": DateTime.now().toString().substring(0, 18)
                  };

                  if (product.data()?.createdAt == null) {
                    setData.addAll({
                      "createdAt": DateTime.now().toString().substring(0, 18),
                      "hasDelayForCreatedAt": true
                    });
                  }

                  refDb
                      .doc(deviceInfo!.macId)
                      .set(setData, SetOptions(merge: true));
                }

                if (deviceInfo != null && ref.context.mounted) {
                  ref
                      .read(currentDevicesManagerProvider.notifier)
                      .setDevice(deviceInfo, device.id, ref);
                  ref
                      .read(currentDevicesManagerProvider.notifier)
                      .setConnectedDevice(device, ref);
                  if (ref.read(currentEmbModeManager) != 1) {
                    ref
                        .read(currentAutoDisposeTimerManager.notifier)
                        .startTimer(device.id, ref, device);
                  }
                }
              });
            } catch (e) {
              logger.e("Error:$e");
            }
          }
        }

        final unconnectedDevices =
            devs.where((d) => !connectedIds.any((e) => (e.id == d.id)));

        for (var unConnectedDevice in unconnectedDevices) {
          if (ref
              .read(currentBatteryOfPadsManager)
              .keys
              .contains(unConnectedDevice.id)) {
            ref
                .read(currentBatteryOfPadsManager.notifier)
                .remove(ref, unConnectedDevice.id);
            ref
                .watch(currentBatteryOfPadsManager.notifier)
                .remove(ref, unConnectedDevice.id);
          }
        }

        for (var device in unconnectedDevices) {
          if (ref
              .read(currentDevicesManagerProvider)
              .keys
              .contains(device.id)) {
            ref
                .read(currentDevicesManagerProvider.notifier)
                .addAlreadyDisconnectedDevice(device, ref);

            ref
                .read(currentDevicesManagerProvider.notifier)
                .removeDevice(device.id, ref);
            ref
                .watch(currentBatteryOfPadsManager.notifier)
                .remove(ref, device.id);
          }
        }
        if (!onceTimeToggleGame) {
          for (var perDevice in connectedDevs) {
            if (ref.read(currentDevicesManagerProvider)[perDevice.id] != null &&
                !ref
                    .read(currentDevicesManagerProvider)[perDevice.id]!
                    .isCp04) {
              PadManager.toggleInGame(perDevice.id,
                  ref: ref, inGame: false, withResponse: Platform.isIOS);
              logger.w("Toggle Game False Funtion worked! $onceTimeToggleGame");
            }
          }
          onceTimeToggleGame = true;
        }

        /* if (showWarning) {
          showWarning = false;
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Future.delayed(const Duration(seconds: 4)).then((value) {
              if (devs.length < 8) {
                Alert(
                  context: context,
                  closeIcon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  style: AlertStyle(
                      backgroundColor: CpColors.bgGC2,
                      descStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: defPaddingSize)),
                  buttons: [
                    DialogButton(
                      color: CpColors.button1Color,
                      width: defPaddingSize * 10,
                      height: defPaddingSize * 3,
                      child: const Text(
                        "Tamam",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: defPaddingSize * 1.5),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                  desc:
                      'Uykuda olan Pad\'ler var.😴Uyandırmak için hafifçe vurun.',
                ).show();
              }
            });
          });
        } */
        return Stack(
          children: [
            ListView(
                children: [
              DeviceGroupModel(
                title: L10n.inst(context).connected_pods,
                connected: true,
                devices: connectedDevices,
              ),
              DeviceGroupModel(
                title: L10n.inst(context).available_pods,
                connected: false,
                devices: unconnectedDevices,
              ),
            ].map(DeviceGroup.new).toList()),

            /* if ((ref.watch(appSettingsToggleProvider).isDebuggingByDeveloper ||
                kDebugMode))
              Align(
                alignment: Alignment.bottomRight,
                child: CpButton1(
                    onPressed: () async {
                      EasyLoading.show();
                      scanon = false;
                      ref.read(bleScannerProv).pauseScan();
                      for (final dev in devs) {
                        await deviceConnector.disconnect(dev);
                      }
                      ref.read(bleScannerProv).startScan();
                      ref.read(bleScannerProv).refreshScan(
                          connectedDevices: connectedDevices.toList());
                      EasyLoading.dismiss();
                      await Future.delayed(const Duration(seconds: 3));
                      scanon = true;
                    },
                    child: const Text("Reset")),
              ), */
          ],
        );
      },
    );
  }
}
