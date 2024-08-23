import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:catchpad/models/beep_model.dart';
import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad/models/enums/utility/loading_status.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streamer/streamer.dart';

import '../../../managers/audio_manager.dart';
import '../../../models/device/device_shuffler.dart';
import '../../../prov/audio/audio_dev_prov.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/utils.dart';
import '../../widgets/buttons/cp_button_1.dart';
import '../../widgets/buttons/cp_button_2.dart';
import '../device_li.dart';
import 'dev_admin_debug_options.dart';
import 'hold_steady_game_model.dart';
import 'pad_motion_widgets/ball_in_middle_game.dart';
import 'pad_motion_widgets/hold_steady_game.dart';
import 'pad_motion_widgets/pad_3d.dart';



class CustomDevDebugOperations {
  static Future<bool> playAudio(
    String deviceId,
    WidgetRef ref, {
    required String val,
    BuzzerModes? buzzerModes,
    bool standartPitch = true,
  }) async {


    var deviceLocId = ref.read(currentDevicesManagerProvider)[deviceId];

    logger.i("Pad Play!!!");

    if (deviceLocId?.variantId == "1" || deviceLocId?.variantId == "3") {
      return await PadManager.playMusic(deviceId, ref: ref);
    } else {
      logger.i("Play Buzzer");
      return BleManager.writeCharacteristic(
        ref: ref,
        c: audioCharacteristic.qualCharacteristic(deviceId),
        data: !standartPitch ? BuzzerModes.longHighPitch.modeString.codeUnits : BuzzerModes.customHighPitchFor.modeString.codeUnits,
        withResponse: false,
      );
      // return BleManager.writeCharacteristic(
      //   ref: ref,
      //   c: audioCharacteristic.qualCharacteristic(deviceId),
      //   data: deviceLocId != null
      //       ? (deviceLocId.variantId == "0" || deviceLocId.variantId == "2" ||  deviceLocId.variantId == "4")
      //           ? (ref.read(currentEmbModeManager) == 1 ? BuzzerModes.longHighPitch.modeString.codeUnits : BuzzerModes.highPitch.modeString.codeUnits)
      //           : val.codeUnits
      //       : val.codeUnits,
      //   withResponse: false,
      // );
    }
  }

  static Future<void> uploadBip(WidgetRef ref, String deviceId) async {

    logger.i("Upload Bip");

   await PadManager.sendPartMusicFile(deviceId,
      byteList: [1], ref: ref, withResponse: false);

    ByteData byteData = await rootBundle.load(SandboxMusic.sandboxBipPath);

    Uint8List byteList2 = byteData.buffer.asUint8List();

    List<int> perList = [];

    bool okResponse = false;

    final startTimer = DateTime.now().millisecondsSinceEpoch;

    final deadTime = startTimer + const Duration(seconds: 10).inMilliseconds;

   PadManager.listenToResponseForUploadMusicFile(deviceId, ref: ref)
        .listen((event) {
      // logger.i("Event: $deviceId $event");
      if (event.toString().contains("OK")) {
        okResponse = true;
        // logger.i("Ok: $deviceId");
      }
    });

    for (int i = 0; i < byteList2.length; i) {

      bool exitFromLoop = true;

      while (exitFromLoop) {
        if (byteList2.length > i && perList.length < 509) {
          perList.add(byteList2[i]);
          i++;
        } else {
          exitFromLoop = false;
        }
      }

      Uint8List list = Uint8List.fromList(perList);

      try {
        await Future.delayed(const Duration(milliseconds: 30));

        await PadManager.sendPartMusicFile(deviceId,
            byteList: list, ref: ref, withResponse: false);

        if (list.length < 509) {

          ref
              .read(currentAudioProvManager.notifier)
              .setPathOfAudioOnPad(deviceId, SandboxMusic.sandboxBipPath);
        }
        perList.clear();
      } catch (e) {
        throw Exception("$e sendPart512");
      }
    }

  }
}

/// this is a more limited and prettier version on
/// DevAdminDebugScreen, will be used in presentations.
class DevDebugScreen extends StatelessWidget {
  final DeviceModel? device;
  final bool? isConnected;

  const DevDebugScreen({
    this.device,
    this.isConnected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DevDebugOptions(
      device: device,
      isConnected: isConnected,
    );
  }
}

class _DevDebugOptions extends ConsumerStatefulWidget {
  final DeviceModel? device;
  final bool? isConnected;

  const _DevDebugOptions({
    this.device,
    this.isConnected,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_DevDebugOptions> createState() => _DevDebugOptionsState();
}

class _DevDebugOptionsState extends ConsumerState<_DevDebugOptions>
    with SingleTickerProviderStateMixin {
  DeviceModel? get device => widget.device;

  bool get isForAllDevices => device == null;

  final wids = <Widget>[];
  final titles = <String>[];
  late TabController controller;

  @override
  void initState() {
    final devs = DeviceShuffler.readDevices(ref);
    if (isForAllDevices) {
      for (final device in devs) {
        PadManager.toggleDebug(device.id, enable: true, ref: ref);
      }
    } else {
      PadManager.toggleDebug(device!.id, enable: true, ref: ref);
    }

    wids.addAll(
      [
        if (isForAllDevices) ...[
          const _AllDevicesWidget(),
        ] else ...[
          SingleChildScrollView(
            child: _AlignedColumn(
              children: [
                _SettingsWidget(device: device!),
                _AudioPlayerWidget(device: device!),
                _BatteryWidget(device: device!),
                _ColorWidget(device: device!),
              ],
            ),
          ),
          _SensorsWidget(device: device!),
        ],
      ],
    );

    titles.addAll(
      [
        if (isForAllDevices) ...[
          'Tüm Cihazlar',
        ] else ...[
          'Genel',
          'Sensörler',
        ],
      ],
    );

    controller = TabController(
      length: wids.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: titles
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: defPaddingSize),
                  child: Text(e),
                ),
              )
              .toList(),
          controller: controller,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: wids
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(defPaddingSize),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

// #region TEMPLATES
class _AlignedColumn extends StatelessWidget {
  final List<Widget> children;

  const _AlignedColumn({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: children,
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.icon,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defPaddingSize),
      child: _AlignedColumn(
        children: [
          Row(
            children: [
              // if (icon != null)
              Icon(
                icon,
                size: 20,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ].joinWidgetList(
              (index) => const SizedBox(width: defPaddingSize),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: defPaddingSize),
            child: _AlignedColumn(
              children: children.joinWidgetList(
                (index) => const SizedBox(height: defPaddingSize),
              ),
            ),
          ),
        ].joinWidgetList(
          (index) => const SizedBox(height: defPaddingSize),
        ),
      ),
    );
  }
}
// #endregion

// #region AUDIO
class _AudioPlayerWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _AudioPlayerWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AudioPlayerWidget> createState() => __AudioPlayerWidgetState();
}

class __AudioPlayerWidgetState extends ConsumerState<_AudioPlayerWidget> {
  DeviceModel get device => widget.device;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Ses',
      icon: FontAwesomeIcons.volumeHigh,
      children: [
        Wrap(
          children: {
            'CatchPad': 'C',
            'True': 'T',
            'False': 'F',
            'One': 'O',
          }.entries.map(
            (entry) {
              return CpButton1(
                onPressed: () {
                  CustomDevDebugOperations.playAudio(
                    device.id,
                    ref,
                    val: entry.value,
                  );
                },
                child: Text(entry.key),
              );
            },
          ).joinWidgetList(
            (index) => const SizedBox(width: halfDefPaddingSize),
          ),
        ),
      ],
    );
  }
}
// #endregion

// #region BATTERY
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
    return StreamBuilder(
      stream: PadManager.listenToBattery(device.id, ref: ref),
      builder: (context, snp) {
        final model = snp.data as BatteryModel?;

        return _Section(
          title: 'Batarya',
          icon: FontAwesomeIcons.batteryFull,
          children: [
            if (model == null) ...const [
              Text('Yükleniyor...'),
            ] else ...[
              Row(
                children: [
                  BatteryIcon(battery: model),
                  Text('%${model.percentage}'),
                ].joinWidgetList(
                  (index) => const SizedBox(
                    width: halfDefPaddingSize,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
// #endregion

// #region COLOR
class _ColorBlock extends StatelessWidget {
  final Color? color;
  final Function()? onTap;

  const _ColorBlock({
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(quarterDefPaddingSize),
      decoration: BoxDecoration(
        border: Border.all(
          color: color != null &&
                  (color!.blue + color!.green + color!.red) > 255 * 1.5
              ? Colors.black
              : Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: InkWell(
        onTap: onTap,
      ),
    );
  }
}

final _presentationPickedColorProv =
    StateProvider<SidesColorsModel>((ref) => CpColors.cpSidesColorsModel);

class _ColorWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _ColorWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_ColorWidget> createState() => __ColorWidgetState();
}

class __ColorWidgetState extends ConsumerState<_ColorWidget> {
  DeviceModel get device => widget.device;

  SidesColorsModel model = const SidesColorsModel();

  bool allSame = false;

  Color? get defaultAllColor => model.tl;

  void setAll(Color? c) {
    final m = model.copyWith(tl: c, tr: c, bl: c, br: c);
    ref.read(_presentationPickedColorProv.notifier).state = m;
    _led(m);
  }

  _led([SidesColorsModel? m]) => PadManager.ledColorNoResponse(
        device.id,
        m ?? model,
        ref: ref,
        isCommand: false,
      );

  @override
  Widget build(BuildContext context) {
    model = ref.watch(_presentationPickedColorProv);

    Widget _colorBlock(Color? color, Function() onTap) {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(quarterDefPaddingSize),
        decoration: BoxDecoration(
          border: Border.all(
            color: color != null &&
                    (color.blue + color.green + color.red) > 255 * 1.5
                ? Colors.black
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: InkWell(
          onTap: onTap,
        ),
      );
    }

    Widget _singleSetter(Color? color, Function(Color) setColor) {
      return _colorBlock(
        color,
        () {
          final clrs = defaultConstColors(ref);
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  _setClr(Color c) {
                    color = c;
                    setColor(c);
                    setState(() {});
                  }

                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorPicker(
                            pickerColor: color ?? Colors.white,
                            onColorChanged: _setClr,
                            hexInputBar: true,
                          ),
                          Wrap(
                            children: clrs
                                .map(
                                  (e) => _colorBlock(
                                    e,
                                    () {
                                      _setClr(e);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                          if (color != null)
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
                },
              );
            },
          );
        },
      );
    }

    return _Section(
      title: 'Renk',
      icon: FontAwesomeIcons.palette,
      children: [
        Wrap(
          children: [
            CpButton1(
              onPressed: () => AdminSpecificOperations.catchpadShow(
                device.id,
                ref,
                disableAdmin: true,
              ),
              child: const Text('CatchPad Show'),
            ),
            CpButton1(
              onPressed: () => PadManager.ledOff(
                device.id,
                ref: ref,
              ),
              child: const Text('Işığı Kapat'),
            ),
          ].joinWidgetList(
              (index) => const SizedBox(width: halfDefPaddingSize)),
        ),
        Wrap(
          children: [
            const Text('Tek bir rengi kullan'),
            Switch(
              value: allSame,
              onChanged: (v) {
                allSame = v;
                setAll(ref.read(_presentationPickedColorProv).tl);
                setState(() {});
              },
            ),
            if (allSame)
              _singleSetter(
                defaultAllColor,
                setAll,
              )
            else
              Builder(builder: (context) {
                _setColorTo(SidesColorsModel _mdl) {
                  ref.read(_presentationPickedColorProv.notifier).state = _mdl;
                  _led();
                }

                return Column(
                  children: [
                    [
                      _singleSetter(
                        model.tl,
                        (c) => setState(
                          () => _setColorTo(
                            model.copyWith(tl: c),
                          ),
                        ),
                      ),
                      _singleSetter(
                        model.tr,
                        (c) => setState(
                          () => _setColorTo(
                            model.copyWith(tr: c),
                          ),
                        ),
                      ),
                    ],
                    [
                      _singleSetter(
                        model.bl,
                        (c) => _setColorTo(
                          model.copyWith(bl: c),
                        ),
                      ),
                      _singleSetter(
                        model.br,
                        (c) => _setColorTo(
                          model.copyWith(br: c),
                        ),
                      ),
                    ]
                  ]
                      .map(
                        (e) => Row(
                          children: e,
                        ),
                      )
                      .toList(),
                );
              }),
          ].joinWidgetList(
            (index) => const SizedBox(
              width: defPaddingSize,
            ),
          ),
        ),
      ],
    );
  }
}
// #endregion

// #region ALL DEVICES
class _AllDevicesWidget extends ConsumerStatefulWidget {
  const _AllDevicesWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AllDevicesWidget> createState() => __AllDevicesWidgetState();
}

class __AllDevicesWidgetState extends ConsumerState<_AllDevicesWidget> {
  StreamSubscription<TouchEvent>? _sub;

  @override
  void dispose() {
    stopListener();
    super.dispose();
  }

  void stopListener() {
    _sub?.cancel();
    _sub = null;
  }

  bool get isListening => _sub != null;

  @override
  Widget build(BuildContext context) {
    final allDevs = ref.watch(bleConPr).keys;

    return _Section(
      title: 'Tüm Cihazlar',
      icon: FontAwesomeIcons.gear,
      children: [
        CpButton1(
          onPressed: () {
            if (isListening) {
              stopListener();
              setState(() {});
              return;
            }

            _sub = PadSensorManager.listenToTouchMulti(
              allDevs.map((e) => e.id).toList(),
              ref: ref,
            ).listen(
              (event) async {
                await AudioManager.playDevAudio(
                  ref: ref,
                  deviceId: event.deviceId,
                );
              },
            );

            setState(() {});
          },
          child: Row(
            children: [
              if (isListening)
                const Text('Durdur')
              else
                const Text('Tüm cihazların seslerini dinle')
            ].joinWidgetList(
              (index) => const SizedBox(
                width: halfDefPaddingSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// #endregion
// #region SETTINGS
class _SettingsWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _SettingsWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_SettingsWidget> createState() => __SettingsWidgetState();
}

class __SettingsWidgetState extends ConsumerState<_SettingsWidget> {
  DeviceModel get device => widget.device;

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Ayarlar',
      icon: FontAwesomeIcons.gear,
      children: [
        CpButton1(
          onPressed: () {
            PadManager.resetDevice(
              device.id,
              ref: ref,
            );
          },
          child: Row(
            children: const [
              Icon(FontAwesomeIcons.arrowRotateRight),
              Text('Pad\'i yeniden başlat'),
            ].joinWidgetList(
              (index) => const SizedBox(
                width: halfDefPaddingSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// #endregion

// #region SENSORS
class _SensorsWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _SensorsWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_SensorsWidget> createState() => __SensorsWidgetState();
}

class __SensorsWidgetState extends ConsumerState<_SensorsWidget> {
  DeviceModel get device => widget.device;

  Widget? body;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...{
          'Dokunma sensörü': _AccTapWidget(device: device),
          'Hareket sensörü': _AccMotionWidget(device: device),
          'Mesafe sensörü': _DistanceWidget(device: device),
        }.entries.map(
          (entry) {
            return CpButton2(
              onPressed: () {
                body = entry.value;
                setState(() {});
              },
              child: Text(entry.key),
            );
          },
        ).toList(),
        if (body != null) body!,
      ],
    );
  }
}

class _AccTapWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _AccTapWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AccTapWidget> createState() => __AccTapWidgetState();
}

class __AccTapWidgetState extends ConsumerState<_AccTapWidget> {
  DeviceModel get device => widget.device;

  late StreamSubscription<TouchEvent> listener;

  SidesColorsModel? color;

  TouchEvent? model;

  bool padOn = false;

  Future<void> init() async {
    await PadSensorManager.deactivateAll(ref: ref, deviceId: device.id);

    /* await PadSensorManager.configAccSensor(
      deviceId: device.id,
      ref: ref,
      model: defAccConfigModel,
    ); */
    await PadSensorManager.lockAccTapThreshold(
      ref: ref,
      deviceId: device.id,
    );

    listener = PadSensorManager.listenToTouch(
      device.id,
      ref: ref,
    ).listen(
      (event) async {
        model = event;

        color = ref.read(_presentationPickedColorProv);

        if (!padOn) {
          await PadManager.ledColorNoResponse(
            device.id,
            color!,
            ref: ref,
          );
        } else {
          await PadManager.ledOff(
            device.id,
            ref: ref,
          );
        }
        padOn ^= true;

        if (mounted) setState(() {});
      },
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future disp() async {
    try {
      await listener.cancel();
      await PadSensorManager.deactivateAccTap(ref: ref, deviceId: device.id);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void deactivate() {
    disp();
    super.deactivate();
  }

  @override
  void dispose() {
    disp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (model == null || !padOn)
          const Text('Pad\'e henüz dokunulmadı')
        else
          Column(
            children: [
              [
                _ColorBlock(
                  color: color?.tl,
                  onTap: null,
                ),
                _ColorBlock(
                  color: color?.tr,
                  onTap: null,
                ),
              ],
              [
                _ColorBlock(
                  color: color?.bl,
                  onTap: null,
                ),
                _ColorBlock(
                  color: color?.br,
                  onTap: null,
                ),
              ]
            ]
                .map(
                  (e) => Row(
                    children: e,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _AccMotionWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _AccMotionWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_AccMotionWidget> createState() => __AccMotionWidgetState();
}

class __AccMotionWidgetState extends ConsumerState<_AccMotionWidget> {
  DeviceModel get device => widget.device;

  static const twoPi = 2 * pi;

  late StreamSubscription<MotionEvent> listener;

  Future<void> init() async {
    await PadSensorManager.deactivateAll(ref: ref, deviceId: device.id);

    /* await PadSensorManager.configAccSensor(
      deviceId: device.id,
      ref: ref,
      model: const AccConfigModel(
        dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
        mode: ConfigMode.LIS2DH12_HR_12bit,
        scale: ConfigScale.LIS2DH12_2g,
        threshold: 1,
        timeout: 30,
      ),
    ); */

    await PadSensorManager.lockAccGravityThreshold(
      ref: ref,
      deviceId: device.id,
    );

    listener = PadSensorManager.listenToMotion(
      device.id,
      ref: ref,
    ).listen(
      (event) {
        _model = event;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> disp() async {
    try {
      await listener.cancel();
      await PadSensorManager.deactivateAccGravity(
          ref: ref, deviceId: device.id);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void deactivate() async {
    disp();
    super.deactivate();
  }

  @override
  void dispose() {
    disp();
    super.dispose();
  }

  MotionEvent? _model;

  MotionEvent get model => _model!;

  @override
  Widget build(BuildContext context) {
    if (_model == null) {
      return const Center(child: Text('Henüz hareket yok'));
    }

    final gravityModel = model.motion;

    final holdSteadyModel =
        HoldSteadyGameModel.fromAcceleremetorGravityModel(gravityModel);

    var r = gravityModel.roll;
    // r is between -180 and 180
    // we want it between 0 and twoPi
    r = (r + 180) * twoPi / -360;

    var p = model.motion.pitch;
    // p is between -180 and 180
    // we want it between 0 and twoPi
    p = (p + 180) * twoPi / -360;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        children: [
          Row(
            children: [
              ListTile(
                leading: const Icon(FontAwesomeIcons.arrowsLeftRight),
                title: Text(model.motion.roll.toStringAsFixed(0)),
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.arrowsUpDown),
                title: Text(model.motion.pitch.toStringAsFixed(0)),
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.temperatureLow),
                title: Text(model.motion.temperature.toStringAsFixed(0)),
              ),
            ].map((e) => Expanded(child: e)).toList(),
          ),
          ...{
            'Pad\'in 3 boyutlu görünümü': Pad3D(
              yRotate: -r,
              xRotate: -p,
            ),
            'Topu ortada tutma oyunu': BallInMiddleGame(
              model: holdSteadyModel,
            ),
            'Pad\'i sabit tutma oyunu': HoldSteadyGame(
              model: holdSteadyModel,
              device: device,
            ),
          }.entries.map(
            (entry) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        entry.key,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      entry.value,
                    ].joinWidgetList(
                      (index) => const SizedBox(height: defPaddingSize * 3),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ].joinWidgetList((index) => const SizedBox(
              height: defPaddingSize * 5,
            )),
      ),
    );
  }
}

class _DistanceWidget extends ConsumerStatefulWidget {
  final DeviceModel device;

  const _DistanceWidget({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_DistanceWidget> createState() => __DistanceWidgetState();
}

class __DistanceWidgetState extends ConsumerState<_DistanceWidget> {
  DeviceModel get device => widget.device;

  late StreamSubscription<DistanceEvent> listener;

  static const minThresh = 10, maxThresh = 1000;

  int defThresh = 100;

  Future<void> config() async {
    await PadSensorManager.configDstSensor(
      deviceId: device.id,
      ref: ref,
      model: DstConfigModel(
        threshold: defThresh,
        timeout: 400,
      ),
    );
  }

  Future<void> init() async {
    await PadSensorManager.deactivateAll(ref: ref, deviceId: device.id);

    await config();

    await PadSensorManager.lockDstThreshold(
      ref: ref,
      deviceId: device.id,
    );

    listener = PadSensorManager.listenToDistance(
      device.id,
      ref: ref,
    ).listen((event) async {
      _model = event;

      if (_model?.isValid != true) {
        return;
      }

      color = ref.read(_presentationPickedColorProv);

      if (!padOn) {
        await PadManager.ledColorNoResponse(
          device.id,
          color!,
          ref: ref,
        );
      } else {
        await PadManager.ledOff(
          device.id,
          ref: ref,
        );
      }
      padOn ^= true;

      if (mounted) setState(() {});
    });
  }

  SidesColorsModel? color;

  bool padOn = false;

  @override
  void initState() {
    init();

    super.initState();
  }

  Future<void> disp() async {
    try {
      await listener.cancel();
      await PadSensorManager.deactivateDst(ref: ref, deviceId: device.id);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void deactivate() async {
    disp();
    super.deactivate();
  }

  @override
  void dispose() {
    disp();
    super.dispose();
  }

  DistanceEvent? _model;

  DistanceEvent get model => _model!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider.adaptive(
          value: defThresh + .0,
          min: minThresh + .0,
          max: maxThresh + .0,
          onChanged: (v) {
            defThresh = v.toInt();
            config();
            setState(() {});
          },
          divisions: 100,
          label: (defThresh ~/ 10).toString(),
        ),
        if (_model == null || !padOn)
          const Text('Henüz bir obje algılanamadı')
        else
          Column(
            children: [
              [
                _ColorBlock(
                  color: color?.tl,
                  onTap: null,
                ),
                _ColorBlock(
                  color: color?.tr,
                  onTap: null,
                ),
              ],
              [
                _ColorBlock(
                  color: color?.bl,
                  onTap: null,
                ),
                _ColorBlock(
                  color: color?.br,
                  onTap: null,
                ),
              ]
            ]
                .map(
                  (e) => Row(
                    children: e,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
// #endregion

// #region TEMPLATE
// class _TemplateWidget extends ConsumerStatefulWidget {
//   final DeviceModel device;
//   const _TemplateWidget({
//     required this.device,
//     Key? key,
//   }) : super(key: key);
//   @override
//   ConsumerState<_TemplateWidget> createState() => __TemplateWidgetState();
// }
// class __TemplateWidgetState extends ConsumerState<_TemplateWidget> {
//   DeviceModel get device => widget.device;
//   @override
//   Widget build(BuildContext context) {
//     return _Section();
//   }
// }
// #endregion
