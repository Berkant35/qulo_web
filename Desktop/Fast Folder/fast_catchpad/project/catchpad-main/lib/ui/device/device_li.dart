import 'dart:async';

import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/models/feedback/traces/connections/connection_log.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/device/debug/debug_log_screen.dart';
import 'package:catchpad/ui/device/debug/press_show_screen.dart';
import 'package:catchpad/ui/home_screen.dart';
import 'package:catchpad/utils/audio_files.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../managers/cp_audio_player.dart';
import '../../managers/sticker_manager.dart';
import '../../utils/cp_colors.dart';
import '../../utils/cp_icons.dart';
import '../../utils/l10n/json_l10n.dart';
import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_2.dart';
import 'debug/dev_admin_debug_options.dart';
import 'debug/dev_debug_options.dart';

extension Booolleannn on DeviceConnectionState {
  bool get isConnected => this == DeviceConnectionState.connected;

  bool get isConnecting => this == DeviceConnectionState.connecting;

  bool get isDisconnected => this == DeviceConnectionState.disconnected;
}

class DeviceLi extends ConsumerStatefulWidget {
  final DeviceModel device;

  const DeviceLi(this.device, {super.key});

  @override
  ConsumerState<DeviceLi> createState() => _DeviceLiState();
}

class _DeviceLiState extends ConsumerState<DeviceLi> {
  DeviceModel get device => widget.device;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final con = ref.watch(bleConPr);

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          ListTile(
            title: DevLIName(
              device: device,
            ),
            trailing: DevLITrailing(device: device),
            onTap: () {
              isExpanded ^= true;
              setState(() {});
            },
          ),
          if (ref.watch(appSettingsToggleProvider).enableDeviceAdminOptions &&
              isExpanded)
            DevLIAdminControls(device: device),
        ],
      ),
    );
  }
}

extension on DeviceConnectionState {
  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case DeviceConnectionState.connected:
        return inst.connected;
      case DeviceConnectionState.connecting:
        return inst.connecting;
      case DeviceConnectionState.disconnected:
        return inst.disconnected;
      case DeviceConnectionState.disconnecting:
        return inst.disconnecting;
    }
  }
}

class DevLIAdminControls extends ConsumerWidget {
  final DeviceModel device;

  const DevLIAdminControls({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final con = ref.watch(bleConPr);
    final connectionState =
        con[device]?.connectionState ?? DeviceConnectionState.disconnected;
    final isConnected = connectionState.isConnected;
    final isDisconnected = connectionState.isDisconnected;

    final deviceInfo = ref.watch(currentDevicesManagerProvider)[device.id];

    final currentProductInfo = ref
        .watch(currentDevicesProductManager)[deviceInfo?.macId]
        ?.productOwnerUserName;

    return Container(
      margin: const EdgeInsets.all(defPaddingSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ChangeDeviceNameWidget(device: device),
          Text("${device.id}\nRSSI2: ${device.rssi}"),
          ref.read(currentDevicesManagerProvider)[device.id] != null

              ? SelectionArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ownership: ${currentProductInfo ?? "Undefined"}"),
                      Text(
                          "Voltage: ${ref.watch(currentBatteryOfPadsManager)[device.id] ?? "Unknown"}"),
                      Text(
                          "Mode: ${deviceInfo != null ? VariantsType.getName(int.parse(deviceInfo.variantId!)) : 'Unknown'}"),
                      Text(
                        "Serial Number:${ref.read(currentDevicesManagerProvider)[device.id]!.cpId!}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Software Version:${ref.read(currentDevicesManagerProvider)[device.id]!.swVersion!}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Mac ID:${ref.read(currentDevicesManagerProvider)[device.id]!.macId!}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Hardware Version:${ref.read(currentDevicesManagerProvider)[device.id]!.hwVersion!}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),


                )
              : const SizedBox(),
          if (!isConnected && !isDisconnected)
            Text(connectionState.textNotation(context)),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DevAdminDebugScreen(
                        device: device,
                        connectionState: connectionState,
                      ),
                    ),
                  );
                },
                child: const Text('Show Debug Admin Screen'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DevDebugScreen(
                        device: device,
                        isConnected: isConnected,
                      ),
                    ),
                  );
                },
                child: const Text('Show Debug Screen'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () {
                  final connectionState = con[device]?.connectionState ??
                      DeviceConnectionState.disconnected;
                  if (connectionState == DeviceConnectionState.connected) {}
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DebugLogScreen(device: device)));
                },
                child: const Text('LVT Test'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () {
                  PadManager.toggleMultiConnection(device.id,
                      enable: true, ref: ref);
                },
                child: const Text('Multi Connection On'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () {
                  PadManager.toggleMultiConnection(device.id,
                      enable: false, ref: ref);
                },
                child: const Text('Multi Connection Off'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () {
                  PadManager.toggleFSR(device.id, ref: ref, fsrOn: true);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PressShowScreen(device: device)));
                },
                child: const Text('FSR'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () async {
                  await PadManager.circularPadShow(device.id,
                      ref: ref,
                      circularColor: gameErrorColor,
                      totalDuration: const Duration(milliseconds: 3000),
                      timeOutLedOff: const Duration(milliseconds: 1000));
                },
                child: const Text('Circular'),
              ),
              SizedBox(
                width: 2.w,
              ),
              ElevatedButton(
                onPressed: () async {
                  const upBeatSeconds =  AudioFiles.demoTimeHitMicroSeconds;
                  int counter = 0;
                  final audioPlayer = ref.watch(cpAudioPlayerProv);
                  runTimer(upBeatSeconds, ref);
                  audioPlayer.playDemo();
                },
                child: const Text('Led Show'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> runTimer(List<int> upBeatSeconds, WidgetRef ref) async {
    int i = 0;
    int counter = 0;

    Timer.periodic(const Duration(milliseconds: 1), (timer) async {
      i++;

      if (counter > upBeatSeconds.length) {
        timer.cancel();
      }

      if (upBeatSeconds.contains(i)) {




        counter++;
        final index = upBeatSeconds.indexOf(i);

        if (index + 1 > upBeatSeconds.length - 1) return;
        final nextToDiff = upBeatSeconds[index + 1] - upBeatSeconds[index];

        PadManager.ledColor(device.id, SidesColorsModel.all(CpColors.red),
            ref: ref);

        // PadManager.circularPadShow(device.id,
        //     ref: ref,
        //     circularColor: CpColors.red,
        //     totalDuration: const Duration(milliseconds: 160));

        Future.delayed(Duration(milliseconds: nextToDiff - nextToDiff ~/ 3.80),
            () {
          PadManager.ledOff(device.id, ref: ref);
        });
      }
    });
  }
}

class DevLIName extends ConsumerWidget {
  final DeviceModel device;

  const DevLIName({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (device.deviceNumber != null) {
      return Text(
          "Pad ${getStringSubstring(ref.watch(currentDevicesManagerProvider)[device.id]?.bleName ?? device.name)}");
    }
    return Text('${getStickerTitleStr(device.deviceNameId!)} CatchPad');
  }

  String getStringSubstring(String str) {
    int startIndex = 0;
    int endIndex = str.indexOf(" ");
    if (endIndex == -1) {
      endIndex = str.length;
    }
    String result = str.substring(startIndex, endIndex);
    return result;
  }
}

class DevLITrailing extends ConsumerStatefulWidget {
  final DeviceModel device;

  const DevLITrailing({
    required this.device,
    super.key,
  });

  @override
  ConsumerState createState() => _DevLITrailingState();
}

class _DevLITrailingState extends ConsumerState<DevLITrailing> {
  @override
  Widget build(BuildContext context) {
    final con = ref.watch(bleConPr);

    final connectionState = con[widget.device]?.connectionState ??
        DeviceConnectionState.disconnected;
    BatteryModel? batteryModelForCheck;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (connectionState.isConnected &&
              //check mounted
              mounted &&
              ref.watch(currentAllDeviceUploadingManager)[widget.device.id] !=
                  LoadingStates.loading) ...[
            StreamBuilder(
              stream: PadManager.listenToBattery(widget.device.id,
                  ref: ref, needRead: true),
              builder: (context, snp) {
                if (!snp.hasData) {
                  return const SizedBox();
                }
                final battery = snp.data as BatteryModel;

                batteryModelForCheck = battery;

                String currentBatteryLevel =
                    (battery.percentage ~/ 10 * 10).toString();

                currentBatteryLevel =
                    currentBatteryLevel == '0' ? '10' : currentBatteryLevel;

                currentBatteryLevel =
                    battery.isCompleted ? '100' : currentBatteryLevel;

                ref
                    .read(currentBatteryOfPadsManager.notifier)
                    .updateBatteryVoltage(
                        ref, widget.device.id, battery.voltage!);

                ref.read(currentChargingStatusManager.notifier).update(
                    ref, widget.device.id,
                    forceValue: (battery.isCharging || battery.isCompleted));

                if (currentBatteryLevel == '110') {
                  if (battery.isCompleted) {
                    currentBatteryLevel = '100';
                  } else {
                    currentBatteryLevel = '90';
                  }
                } else if (currentBatteryLevel == '100' && battery.isCharging) {
                  currentBatteryLevel = '90';
                } else {
                  currentBatteryLevel = currentBatteryLevel;
                }

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('%$currentBatteryLevel '),
                    BatteryIcon(battery: battery),
                  ],
                );
              },
            ),
            IconButton(
              onPressed: () {
                if (batteryModelForCheck != null && !batteryModelForCheck!.isCharging) {
                  ref
                      .read(currentDevLedManager.notifier)
                      .onOff(ref, widget.device.id);
                }
              },
              icon: ref.watch(currentDevLedManager)[widget.device.id] != null ? Icon(ref.watch(currentDevLedManager)[widget.device.id]!
                  ? CpIcons.light
                  : CpIcons.lightOff) : const Icon(Icons.error_outline),
            ),
            /*IconButton(
              onPressed: () {
                if (batteryModelForCheck != null) {
                  if (!batteryModelForCheck!.isCharging) {
                    PadManager.toggleLight(
                      device.id,
                      ref: ref,
                    );
                  }
                }
              },
              icon: const Icon(CpIcons.ledCP),
            ),*/
          ],
          (ref.watch(currentAllDeviceUploadingManager)[widget.device.id] !=
                  LoadingStates.loading)
              ? ConnectButton(
                  device: widget.device,
                  connectionState: connectionState,
                )
              : SizedBox(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LinearPercentIndicator(
                      width: 280.0,
                      lineHeight: 18.0,
                      percent: ref.watch(
                              currentUpdatePercentManager)[widget.device.id]! /
                          100,
                      backgroundColor: CpColors.cpBasicWhite,
                      center: Center(
                        child: Text(
                          "Güncelleniyor. Lütfen bekleyin",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                      progressColor: Colors.blue,
                    ),
                  ),
                ),
          if (kDebugMode &&
              !connectionState.isConnected &&
              ref.watch(currentAllDeviceUploadingManager)[widget.device.id] !=
                  LoadingStates.loading)
            DisconnectButton(
              device: widget.device,
              connectionState: connectionState,
            ),
        ],
      ),
    );
  }
}

class ConnectButton extends ConsumerWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const ConnectButton({
    required this.device,
    required this.connectionState,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final deviceConnector = ref.watch(bleDeviceConnectorProv);
    final isConnecting = connectionState.isConnecting;
    return IconButton(
      onPressed: isConnecting
          ? null
          : () async {
              ref.read(bleScannerProv).pauseScan();
              if (connectionState.isConnected) {
                if (false) {
                  await PadManager.toggleDebug(device.id,
                      enable: ref
                          .read(appSettingsToggleProvider)
                          .enableDeviceAdminOptions,
                      ref: ref,
                      inGame: (isAdmin) ? false : null);
                }
                await deviceConnector.disconnect(device);
              } else {
                await deviceConnector.connect(device);
                ref
                    .read(currentConnectionByCustomerManager.notifier)
                    .addConnectionLog(
                        ConnectionLog(
                          lastConnectionTime:
                              DateTime.now().nowTimeTextddMMyyyyHHmm,
                          macId: device.id,
                        ),
                        ref);

                if (false) {
                  await PadManager.toggleDebug(device.id,
                      enable: ref
                          .read(appSettingsToggleProvider)
                          .enableDeviceAdminOptions,
                      ref: ref,
                      inGame: (isAdmin) ? true : null);
                }
              }
              ref.read(bleScannerProv).resumeScan();
            },
      icon: Icon(
        Icons.bluetooth,
        color: isConnecting ? CpColors.blue : null,
      ),
    );
  }
}

class DisconnectButton extends ConsumerWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const DisconnectButton({
    required this.device,
    required this.connectionState,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final deviceConnector = ref.watch(bleDeviceConnectorProv);
    return IconButton(
      onPressed: () {
        deviceConnector.disconnect(device);
      },
      icon: Icon(
        Icons.bluetooth_disabled,
        color: Colors.red.shade300,
      ),
    );
  }
}

class BatteryIcon extends StatelessWidget {
  final BatteryModel battery;

  const BatteryIcon({
    required this.battery,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color? clr;

    if (battery.isCharging || battery.isCompleted) {
      icon = CpIcons.batteryCharging;
      clr = (battery.isCompleted) ? gameSuccessColor : batteryChargingColor;
    }

    //
    else if (battery.percentage >= 90) {
      icon = CpIcons.battery100;
    }
    //
    else if (battery.percentage >= 75) {
      icon = CpIcons.battery75;
    }
    //
    else if (battery.percentage >= 50) {
      icon = CpIcons.battery50;
    }
    //
    else if (battery.percentage >= 15) {
      icon = CpIcons.battery25;
    }
    //
    else {
      icon = CpIcons.battery25;
      clr = gameErrorColor;
    }

    return Icon(
      icon,
      color: clr,
    );
  }
}

class _ChangeDeviceNameWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _ChangeDeviceNameWidget({required this.device, super.key});

  @override
  ConsumerState<_ChangeDeviceNameWidget> createState() =>
      __ChangeDeviceNameWidgetState();
}

class __ChangeDeviceNameWidgetState
    extends ConsumerState<_ChangeDeviceNameWidget> {
  DeviceModel get device => widget.device;
  String? val;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ChangeDeviceNameDropdown(
          onChanged: (v) {
            val = v;
            setState(() {});
          },
        ),
        // if (val != null)
        //   CpButton2(
        //     onPressed: () {
        //       final d = device.copyWith(
        //         name: val! + ' CatchPad',
        //       );
        //       ref.read(bleScannerProv.notifier).state.updateDeviceInfo(d);
        //     },
        //     child: const Text('set device name'),
        //   ),
        if (val != null)
          Row(
            children: [
              CpButton2(
                onPressed: () {
                  // from: sticker_title_x_y
                  final sp = val!.split('_');
                  final len = sp.length;
                  // to:   x/y
                  var v = [sp[len - 2], sp[len - 1]].join('/');

                  // from: x/y
                  // to:   X/Y
                  v = v.toUpperCase();
                  logger.i('v: $v');
                  CustomDevDebugOperations.playAudio(
                    device.id,
                    ref,
                    val:
                        v, // TODO BEEP/ {0: DISABLED 1: ENABLED} / BEEP SOUND TYPES {0,1,2}
                  );
                },
                child: const Text('play'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final sp = val!.split('_');
                    final len = sp.length;
                    // to:   x/y
                    var v = [sp[len - 2], sp[len - 1]].join('/');
                    // from: x/y
                    // to:   X/Y
                    v = v.toUpperCase();
                    logger.i('catchpad: catchpad_$v');

                    PadManager.setDeviceBleName(
                      device.id,
                      ref: ref,
                      name: "catchpad_$v",
                    ); /*
                    PadManager.setDeviceCpId(
                    device.id,
                    ref: ref,
                    id: "catchpad_$v",
                  ); */
                  },
                  child:
                      const Text("set name" /* L10n.inst(context).setname */))
            ],
          ),
      ],
    );
  }
}

class _ChangeDeviceNameDropdown extends ConsumerStatefulWidget {
  final ValueChanged<String?> onChanged;

  const _ChangeDeviceNameDropdown({required this.onChanged, super.key});

  @override
  ConsumerState<_ChangeDeviceNameDropdown> createState() =>
      __ChangeDeviceNameDropdownState();
}

class __ChangeDeviceNameDropdownState
    extends ConsumerState<_ChangeDeviceNameDropdown> {
  String? val;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: StickerManager.getStickerNames(ref: ref)
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(getStickerTitleStr(e)),
            ),
          )
          .toList(),
      value: val,
      onChanged: (e) {
        widget.onChanged(e);
        val = e;
        setState(() {});
      },
    );
  }
}
