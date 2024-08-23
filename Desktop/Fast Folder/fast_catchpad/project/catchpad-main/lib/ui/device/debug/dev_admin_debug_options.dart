import 'dart:async';

import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/device/device_shuffler.dart';
import '../../../models/enums/product/ble_fab_names.dart';
import '../../../utils/utils.dart';
import '../device_li.dart';
import 'listeners_screen.dart';

bool toggleDebugState = false;

class AdminSpecificOperations {
  static Future<void> catchpadShow(
    String deviceId,
    WidgetRef ref, {
    bool disableAdmin = false,
  }) async {
    if (disableAdmin) {
      await PadManager.toggleDebug(
        deviceId,
        enable: false,
        ref: ref,
      );
    }

    final sw = Stopwatch();

    int sum = 0;
    Future<void> cb(int j) async {
      await Future.delayed(const Duration(milliseconds: 2));
      final clr = SidesColorsColor(0, 0, j);
      final clr2 = SidesColorsColor(j, 0, 0);
      final clr3 = SidesColorsColor(0, j, 0);
      final clr4 = SidesColorsColor(j, j, 0);
      final mdl = SidesColorsModel.from100Colors(
        bl: clr,
        br: clr2,
        tl: clr3,
        tr: clr4,
      );

      sw.start();
      await PadManager.ledColor(deviceId, mdl, ref: ref);
      sw.stop();
      sum += sw.elapsedMilliseconds;
      sw.reset();
    }

    // await PadManager.toggleDebug(
    //   deviceId,
    //   enable: false,
    //   ref: ref,
    // );

    const lowerB = 0, upperB = 70, roundCount = 5;

    for (var i = 0; i < roundCount; i++) {
      for (var j = lowerB; j < upperB; j += 1) {
        await cb(j);
      }
      for (var j = upperB; j >= lowerB; j -= 1) {
        await cb(j);
      }
    }

    logger.d('CP show took $sum ms');
    logger.d('CP show average ${sum / 1000} ms');
  }

  static Future<void> colorShow(String deviceId, WidgetRef ref) async {
    final sw = Stopwatch();

    int sum = 0;
    Future<void> cb(int j) async {
      final clr = SidesColorsColor(j, j, j);
      final mdl = SidesColorsModel.all100(clr);

      sw.start();
      await PadManager.ledColor(deviceId, mdl, ref: ref);
      sw.stop();
      sum += sw.elapsedMicroseconds;
      sw.reset();
    }

    await PadManager.toggleDebug(
      deviceId,
      enable: false,
      ref: ref,
    );

    const lowerB = 0, upperB = 70, roundCount = 5;

    for (var i = 0; i < roundCount; i++) {
      for (var j = lowerB; j < upperB; j += 1) {
        await cb(j);
      }
      for (var j = upperB; j >= lowerB; j -= 1) {
        await cb(j);
      }
    }
    logger.d('Color show took $sum ms');
    logger.d('Color show average ${sum / 1000} ms');
  }

  static Future<MapEntry<int, int>> colorSpeedTestShow(
      String deviceId, WidgetRef ref) async {
    final sw = Stopwatch();

    int sum = 0;
    Future<void> cb(int j) async {
      if (j % 5 == 0) {
        await Future.delayed(
          const Duration(
            milliseconds: 20,
          ),
        );
      }
      final clr = SidesColorsColor(j, j, j);
      final mdl = SidesColorsModel.all100(clr);

      sw.start();
      await PadManager.ledColor(deviceId, mdl, ref: ref);
      sw.stop();
      sum += sw.elapsedMicroseconds;
      sw.reset();
    }

    // await PadManager.toggleDebug(
    //   deviceId,
    //   enable: true,
    //   ref: ref,
    // );

    const lowerB = 0, upperB = 100, roundCount = 1;

    for (var i = 0; i < roundCount; i++) {
      for (var j = lowerB; j < upperB; j += 1) {
        await cb(j);
      }
      for (var j = upperB; j >= lowerB; j -= 1) {
        await cb(j);
      }
    }

    return MapEntry(sum, (upperB - lowerB) * 2 * roundCount);
  }
}

/// this is supposed to be used internally for the team.
class DevAdminDebugScreen extends StatelessWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const DevAdminDebugScreen({
    required this.device,
    required this.connectionState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(defPaddingSize),
            child: _DevAdminDebugOptions(
                device: device, connectionState: connectionState),
          ),
        ),
      ),
    );
  }
}

class _DevAdminDebugOptions extends ConsumerStatefulWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const _DevAdminDebugOptions({
    required this.device,
    required this.connectionState,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DevAdminDebugOptionsState();
}

class __DevAdminDebugOptionsState extends ConsumerState<_DevAdminDebugOptions> {
  @override
  Widget build(BuildContext context) {
    final isConnected = widget.connectionState.isConnected;
    final device = widget.device;
    if (!ref.watch(appSettingsToggleProvider).enableDeviceAdminOptions ||
        !isConnected) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AudioPlayerWid(device: device),
        _BatteryWidget(device: device),
        _RgbSetter(
          device: device,
          connectionState: widget.connectionState,
        ),
        _CommandsGroup(
          'Admin',
          commands: [
            ElevatedButton(
              onPressed: () async {
                await PadManager.toggleDebug(
                  device.id,
                  enable: false,
                  ref: ref,
                );
              },
              child: const Text('turn debug off'),
            ),
            ElevatedButton(
              onPressed: () async {
                await PadManager.toggleDebug(
                  device.id,
                  enable: true,
                  type: AdminMonitorType.serial,
                  ref: ref,
                );
              },
              child: const Text('turn serial debug on'),
            ),
            ElevatedButton(
              onPressed: () async {
                await PadManager.toggleDebug(
                  device.id,
                  enable: true,
                  type: AdminMonitorType.ble,
                  ref: ref,
                );
              },
              child: const Text('turn Bluetooth debug on'),
            ),
            ElevatedButton(
              onPressed: () async {
                await PadManager.resetDevice(device.id, ref: ref);
              },
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () async {
                await PadManager.resetDeviceSettings(device.id, ref: ref);
              },
              child: const Text('Reset to factory'),
            ),
          ],
        ),
        _Activations(device: device),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListenersScreen(device: device),
                ),
              );
            },
            child: const Text('Go To Listeners'),
          ),
        ),
        _Configs(device: device),
        _InfoReader(device: device),
        Row(
          children: [
            Text('Debug Mode: Current State=${toggleDebugState ? '1' : '0'}'),
            const Spacer(),
            Switch(
              value: toggleDebugState,
              onChanged: (value) async {
                toggleDebugState = value;
                var devices = DeviceShuffler.readDevices(ref);
                for (var dev in devices) {
                  AdminMonitorType type = AdminMonitorType.serial;
                  final dt = [
                    BigGuy.boolToInt(value),
                    type.index,
                  ].join(defaultSeperator);
                  await PadManager.toggleDebug(
                    dev.id,
                    enable: value,
                    ref: ref,
                  );
                }
                setState(() {});
              },
            ),
          ],
        )
      ],
    );
  }
}

class _CommandsGroup extends StatelessWidget {
  final String title;
  final List<Widget> commands;

  const _CommandsGroup(
    this.title, {
    required this.commands,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: [
        ...commands,
      ],
    );
  }
}

enum _ActivationType { accGravity, accTap, dst }

// #region Activation
class _Activations extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _Activations({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_Activations> createState() => _ActivationsState();
}

class _ActivationsState extends ConsumerState<_Activations> {
  DeviceModel get device => widget.device;

  _ActivationType? type;

  void setType(_ActivationType? t) {
    type = t;
    setState(() {});
  }

  _btn(String title, _ActivationType t, void Function() onP) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          t == type ? Colors.green : Colors.red,
        ),
      ),
      onPressed: () async {
        await _deactivate(t);
        onP();
      },
      child: Text(title),
    );
  }

  Future<void> _deactivate(
      [_ActivationType? t, AccSensorType? sensorType]) async {
    await PadSensorManager.deactivateAll(ref: ref, deviceId: device.id);

    setType(t);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Activation'),
      children: [
        _btn(
          'Activate ACC Gravity',
          _ActivationType.accGravity,
          () {
            PadSensorManager.activateAccGravity(
              ref: ref,
              deviceId: device.id,
            );
          },
        ),
        _btn(
          'Activate ACC Tap',
          _ActivationType.accTap,
          () {
            PadSensorManager.activateAccTap(
              ref: ref,
              deviceId: device.id,
            );
          },
        ),
        _btn(
          'Activate DST',
          _ActivationType.dst,
          () {
            PadSensorManager.activateDst(
              ref: ref,
              deviceId: device.id,
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _deactivate(
                    _ActivationType.accGravity, AccSensorType.gravity);
                await PadSensorManager.lockAccGravityThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('Lock ACC Gravity Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(
                    _ActivationType.accGravity, AccSensorType.gravity);
                await PadSensorManager.unlockAccGravityThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('UnLock ACC Gravity Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(
                    _ActivationType.accGravity, AccSensorType.force);
                await PadSensorManager.lockAccForceThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('Lock ACC Force Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(
                    _ActivationType.accGravity, AccSensorType.force);
                await PadSensorManager.unlockAccForceThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('UnLock ACC Force Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(_ActivationType.accTap, AccSensorType.tap);
                await PadSensorManager.lockAccTapThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('Lock ACC Tap Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(_ActivationType.accTap, AccSensorType.tap);
                await PadSensorManager.unlockAccTapThreshold(
                  ref: ref,
                  deviceId: device.id,
                );
              },
              child: const Text('UnLock ACC Tap Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(_ActivationType.dst, null);
                await PadSensorManager.lockDstThreshold(
                    ref: ref, deviceId: device.id);
              },
              child: const Text('Lock DST Threshold'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deactivate(_ActivationType.dst, null);
                await PadSensorManager.unlockDstThreshold(
                    ref: ref, deviceId: device.id);
              },
              child: const Text('UnLock DST Threshold'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async => await _deactivate(),
          child: const Text('Deactivate'),
        ),
      ],
    );
  }
}
// #endregion

// #region config
class _Configs extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _Configs({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_Configs> createState() => __ConfigsState();
}

class __ConfigsState extends ConsumerState<_Configs> {
  DeviceModel get device => widget.device;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Configs'),
      children: [
        _DSTConfig(device: device),
        _ACCConfig(device: device),
        _ACCIntConfig(device: device),
      ],
    );
  }
}

class _DSTConfig extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _DSTConfig({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_DSTConfig> createState() => __DSTConfigState();
}

class __DSTConfigState extends ConsumerState<_DSTConfig> {
  DeviceModel get device => widget.device;

  int threshold = defDstThreshold, timeout = defDstTimeOut;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('DST Config'),
      children: [
        Row(
          children: [
            const Text('Threshold: $minDstThreshold - $maxDstThreshold'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  threshold = int.tryParse(val) ?? threshold;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Timeout: $minDstTimeOut - $maxDstTimeOut'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  timeout = int.tryParse(val) ?? timeout;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            PadSensorManager.configDstSensor(
              deviceId: device.id,
              ref: ref,
              model: DstConfigModel(
                  threshold: threshold, timeout: timeout, limitValue: 3),
            );
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}

class _ACCConfig extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _ACCConfig({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_ACCConfig> createState() => __ACCConfigState();
}

class __ACCConfigState extends ConsumerState<_ACCConfig> {
  DeviceModel get device => widget.device;

  int threshold = defAccThreshold, timeout = defAccTimeOut;

  ConfigScale scale = defConfigScale;
  ConfigMode mode = defConfigMode;
  DataRate dataRate = defDataRate;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('ACC Config'),
      children: [
        DropdownButton<ConfigScale>(
          items: ConfigScale.values
              .map(
                (e) => DropdownMenuItem<ConfigScale>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: scale,
          onChanged: (s) {
            if (s != null) {
              scale = s;
              setState(() {});
            }
          },
        ),
        DropdownButton<ConfigMode>(
          items: ConfigMode.values
              .map(
                (e) => DropdownMenuItem<ConfigMode>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: mode,
          onChanged: (s) {
            if (s != null) {
              mode = s;
              setState(() {});
            }
          },
        ),
        DropdownButton<DataRate>(
          items: DataRate.values
              .map(
                (e) => DropdownMenuItem<DataRate>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: dataRate,
          onChanged: (s) {
            if (s != null) {
              dataRate = s;
              setState(() {});
            }
          },
        ),
        Row(
          children: [
            const Text('Threshold: $minAccThreshold - $maxAccThreshold'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  threshold = int.tryParse(val) ?? threshold;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Timeout: $minAccTimeOut - $maxAccTimeOut'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  timeout = int.tryParse(val) ?? timeout;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            PadSensorManager.configAccSensor(
              deviceId: device.id,
              ref: ref,
              model: AccConfigModel(
                scale: scale,
                mode: mode,
                dataRate: dataRate,
                threshold: threshold,
                timeout: timeout,
              ),
            );
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}

class _ACCIntConfig extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _ACCIntConfig({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_ACCIntConfig> createState() => __ACCIntConfigState();
}

class __ACCIntConfigState extends ConsumerState<_ACCIntConfig> {
  DeviceModel get device => widget.device;

  int threshold = defAccIntThreshold,
      timeout = defAccIntTimeOut,
      duration = defAccIntDuration;

  ConfigScale scale = defConfigIntScale;
  ConfigMode mode = defConfigIntMode;
  DataRate dataRate = defIntDataRate;

  bool sleepEnable = defSleepEnable;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('ACC Int Config'),
      children: [
        DropdownButton<ConfigScale>(
          items: ConfigScale.values
              .map(
                (e) => DropdownMenuItem<ConfigScale>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: scale,
          onChanged: (s) {
            if (s != null) {
              scale = s;
              setState(() {});
            }
          },
        ),
        DropdownButton<ConfigMode>(
          items: ConfigMode.values
              .map(
                (e) => DropdownMenuItem<ConfigMode>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: mode,
          onChanged: (s) {
            if (s != null) {
              mode = s;
              setState(() {});
            }
          },
        ),
        DropdownButton<DataRate>(
          items: DataRate.values
              .map(
                (e) => DropdownMenuItem<DataRate>(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      e.toString(),
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          value: dataRate,
          onChanged: (s) {
            if (s != null) {
              dataRate = s;
              setState(() {});
            }
          },
        ),
        Row(
          children: [
            const Text('Threshold: $minAccIntThreshold - $maxAccIntThreshold'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  threshold = int.tryParse(val) ?? threshold;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Timeout: $minAccIntTimeOut - $maxAccIntTimeOut'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  timeout = int.tryParse(val) ?? timeout;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Duration: $minAccIntDuration - $maxAccIntDuration'),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  duration = int.tryParse(val) ?? duration;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Sleep Enabled'),
          value: sleepEnable,
          onChanged: (v) {
            sleepEnable = v == true;
            setState(() {});
          },
        ),
        ElevatedButton(
          onPressed: () {
            PadSensorManager.configAccSensor(
              deviceId: device.id,
              ref: ref,
              intModel: AccInterruptConfigModel(
                scale: scale,
                mode: mode,
                dataRate: dataRate,
                threshold: threshold,
                timeout: timeout,
                duration: duration,
                sleepEnable: sleepEnable,
              ),
            );
          },
          child: const Text('Set'),
        ),
      ],
    );
  }
}
// #endregion

// #region RGB

class _ColorSpeedShow extends ConsumerStatefulWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const _ColorSpeedShow({
    required this.device,
    required this.connectionState,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_ColorSpeedShow> createState() => __ColorSpeedShowState();
}

class __ColorSpeedShowState extends ConsumerState<_ColorSpeedShow> {
  DeviceModel get device => widget.device;

  bool get isConnected => widget.connectionState.isConnected;

  int? responseSum;
  int? responseCount;

  @override
  Widget build(BuildContext context) {
    return _CommandsGroup(
      'Color Speed Show',
      commands: [
        ElevatedButton(
          onPressed: () async {
            responseSum = null;
            responseCount = null;
            setState(() {});

            final result = await AdminSpecificOperations.colorSpeedTestShow(
                device.id, ref);
            responseSum = result.key;
            responseCount = result.value;
            setState(() {});
          },
          child: const Text('Color Speed show'),
        ),
        if (responseSum != null && responseCount != null)
          Text(
            'Response sum: ${responseSum! ~/ 1000}ms, '
            'count: $responseCount, '
            'average: ${responseSum! ~/ responseCount! / 1000}ms',
          ),
      ],
    );
  }
}

class _RgbSetter extends ConsumerStatefulWidget {
  final DeviceModel device;
  final DeviceConnectionState connectionState;

  const _RgbSetter({
    required this.device,
    required this.connectionState,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_RgbSetter> createState() => __RgbSetterState();
}

class __RgbSetterState extends ConsumerState<_RgbSetter> {
  DeviceModel get device => widget.device;

  DeviceConnectionState get connectionState => widget.connectionState;

  SidesColorsModel model = const SidesColorsModel();

  bool allSame = false;
  bool isCommand = false;

  Widget _singleSetter(String title, Color? color, Function(Color) setColor) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: Text(title),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ColorPicker(
                          pickerColor: color ?? Colors.white,
                          onColorChanged: (c) {
                            color = c;
                            setColor(c);
                            setState(() {});
                          },
                          hexInputBar: true,
                        ),
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  Color? get defaultAllColor => model.tl;

  void setAll(Color? c) {
    model = model.copyWith(tl: c, tr: c, bl: c, br: c);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DevLITrailing(device: device),
        _CommandsGroup(
          'Color show',
          commands: [
            ElevatedButton(
              onPressed: () =>
                  AdminSpecificOperations.catchpadShow(device.id, ref),
              child: const Text('Catchpad show'),
            ),
            ElevatedButton(
              onPressed: () =>
                  AdminSpecificOperations.colorShow(device.id, ref),
              child: const Text('color show'),
            ),
            _ColorSpeedShow(
              device: device,
              connectionState: connectionState,
            ),
          ],
        ),
        ExpansionTile(
          title: const Text('RGB'),
          children: [
            CheckboxListTile(
              value: allSame,
              onChanged: (e) {
                allSame = e == true;
                setAll(defaultAllColor);
                setState(() {});
              },
              title: const Text('All same'),
            ),
            CheckboxListTile(
              value: isCommand,
              onChanged: (e) {
                isCommand = e == true;
                setState(() {});
              },
              title: const Text('Is Command'),
            ),
            if (allSame)
              _singleSetter(
                'all',
                defaultAllColor,
                setAll,
              )
            else
              Column(
                children: [
                  _singleSetter(
                    'top left',
                    model.tl,
                    (c) => setState(
                      () => model = model.copyWith(tl: c),
                    ),
                  ),
                  _singleSetter(
                    'top right',
                    model.tr,
                    (c) => setState(
                      () => model = model.copyWith(tr: c),
                    ),
                  ),
                  _singleSetter(
                    'bottom left',
                    model.bl,
                    (c) => setState(
                      () => model = model.copyWith(bl: c),
                    ),
                  ),
                  _singleSetter(
                    'bottom right',
                    model.br,
                    (c) => setState(
                      () => model = model.copyWith(br: c),
                    ),
                  ),
                ].joinWidgetList(
                  (e) => const SizedBox(
                    height: 10,
                  ),
                ),
              ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    PadManager.ledColor(
                      device.id,
                      model,
                      ref: ref,
                      isCommand: isCommand,
                    );
                  },
                  child: const Text('Set'),
                ),
                ElevatedButton(
                  onPressed: () {
                    PadManager.ledColor(
                      device.id,
                      SidesColorsModel.same(),
                      ref: ref,
                      isCommand: isCommand,
                    );
                  },
                  child: const Text('Set Only IsCommand'),
                ),
              ]
                  .map(
                    (e) => Expanded(child: e),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

// #endregion

// #region Info
class _InfoReader extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _InfoReader({required this.device, Key? key}) : super(key: key);

  @override
  ConsumerState<_InfoReader> createState() => __InfoReaderState();
}

class __InfoReaderState extends ConsumerState<_InfoReader> {
  DeviceModel get device => widget.device;

  DevInfoModel? _info;
  TextEditingController controller = TextEditingController(text: "***");

  String? name = BleFabNames.ONE.getModeString(),
      cpSN,
      noTM,
      stickerID = "No name sticker";

  VariantsType variantsType = VariantsType.SPORT;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('info'),
      children: [
        ElevatedButton(
          onPressed: () async {
            logger.d(device.id);
            _info = await PadManager.getDeviceInfo(
              device.id,
              ref: ref,
            );
            setState(() {});
          },
          child: const Text('Get'),
        ),
        if (_info != null) Text(_info.toString()),
        // get info
        Row(
          children: [
            Expanded(
              child: DropdownButton<VariantsType>(
                value: variantsType,
                iconEnabledColor: Theme.of(context).primaryColor,
                hint: Text(variantsType.getModeString()),
                isDense: false,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                elevation: 0,
                style: Theme.of(context).textTheme.subtitle1,
                onChanged: onChangedVariantDrop,
                items: variantsListDropDownMenu(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: name ?? BleFabNames.ONE.getModeString(),
                iconEnabledColor: Theme.of(context).primaryColor,
                hint: Text(name ?? BleFabNames.ONE.getModeString()),
                isDense: false,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                elevation: 0,
                style: Theme.of(context).textTheme.subtitle1,
                onChanged: onChangedFabNameDrop,
                items: fabNameListDropDownMenu(),
              ),
            ),
          ],
        ),

        // get info
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'No TM',
                ),
                onChanged: (val) {
                  noTM = val;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefix:
                        Text("${variantsType.getModeNumber().toString()}03230"),
                    hintText: 'Set Cp ID',
                    suffix: Text("-${name.toString().substring(0, 1)}")),
                maxLength: 3,
                onChanged: (val) {
                  cpSN = val;

                  setState(() {});
                },
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Sticker Id',
                ),
                onChanged: (val) {
                  stickerID = val;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            await PadManager.setDeviceBleName(device.id,
                    ref: ref,
                    name: name ?? "-1",
                    cpSN: "${variantsType.getModeNumber().toString()}03230" +
                        (cpSN ?? "") +
                        "-" +
                        name.toString().substring(0, 1),
                    noTM: noTM,
                    variantId: variantsType.getModeNumber().toString(),
                    stickerId: stickerID)
                .then((value) {
              if (value) {
                ref
                    .read(currentDevicesManagerProvider.notifier)
                    .setName(device.id, name ?? "-1", ref);
              }
            });
          },
          child: const Text('SET INFO'),
        ),
      ],
    );
  }

  void onChangedVariantDrop(VariantsType? value) {
    variantsType = value!;
    setState(() {});
  }

  List<DropdownMenuItem<String>> fabNameListDropDownMenu() {
    return BleFabNames.values
        .map<DropdownMenuItem<String>>((BleFabNames value) {
      return DropdownMenuItem<String>(
        value: value.getModeString(),
        child: Text(
          value.getModeString(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      );
    }).toList();
  }

  void onChangedFabNameDrop(String? value) {
    name = value!;
    setState(() {});
  }

  List<DropdownMenuItem<VariantsType>> variantsListDropDownMenu() {
    return VariantsType.values
        .map<DropdownMenuItem<VariantsType>>((VariantsType value) {
      return DropdownMenuItem<VariantsType>(
        value: value,
        child: Text(
          value.getModeString(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      );
    }).toList();
  }
}

// #region battery
class _BatteryWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _BatteryWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_BatteryWidget> createState() => __BatteryWidgetState();
}

class __BatteryWidgetState extends ConsumerState<_BatteryWidget> {
  DeviceModel get device => widget.device;

  @override
  Widget build(BuildContext context) {
    //TODO HATA VAR Bad state: Stream has already been listened to. ERROR
    return ExpansionTile(
      title: const Text('Battery'),
      children: [
        _BatteryReaderWidget(device: device),
        StreamBuilder(
          stream: PadManager.listenToBattery(
            device.id,
            ref: ref
          ),
          builder: (context, snp) {
            if (!snp.hasData) {
              return const SizedBox();
            }

            final battery = snp.data as BatteryModel;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('stream val:',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(battery.toString()),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BatteryReaderWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _BatteryReaderWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_BatteryReaderWidget> createState() =>
      __BatteryReaderWidgetState();
}

class __BatteryReaderWidgetState extends ConsumerState<_BatteryReaderWidget> {
  DeviceModel get device => widget.device;

  BatteryModel? _battery;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            _battery = await PadManager.readBattery(
              device.id,
              ref: ref,
            );
            setState(() {});
          },
          child: const Text('Read Battery'),
        ),
        if (_battery != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('current val:',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(_battery.toString()),
            ],
          ),
      ],
    );
  }
}

// #endregion

// #endregion

// #region Audio
class _AudioPlayerWid extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _AudioPlayerWid({required this.device, Key? key}) : super(key: key);

  @override
  ConsumerState<_AudioPlayerWid> createState() => __AudioPlayerStateWid();
}

class __AudioPlayerStateWid extends ConsumerState<_AudioPlayerWid> {
  DeviceModel get device => widget.device;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Audio'),
      children: [
        ElevatedButton(
          onPressed: () {
            PadManager.playAudio(
              device.id,
              ref: ref,
              level: .15,
            );
          },
          child: const Text('Play AUDIO'),
        ),
      ],
    );
  }
}
// #endregion
