import 'dart:convert';

import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/custom_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums/product/variants_type.dart';
import '../../prov/global_providers.dart';

class RepairOfNames extends ConsumerStatefulWidget {
  const RepairOfNames({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RepairOfNamesState();
}

class _RepairOfNamesState extends ConsumerState<RepairOfNames> {
  VariantsType? variantType = VariantsType.SPORT;
  Map<String, String> deviceIdValue = {};
  Map<String, String> matchDeviceIdValue = {};
  List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24'
  ];

  List<Widget> dropDownWidgetList = [];
  bool hardCircular = true;

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(inst.pad_set_names),
      ),
      body: buildRepairBody(context, inst),
    );
  }

  Widget buildRepairBody(BuildContext context, AppLocalizations inst) {
    final currentDevices = ref
        .watch(currentDevicesManagerProvider.notifier)
        .connectedDevice
        .values;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              inst.pad_set_explain,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: ListView(
            children: currentDevices.map((perDevice) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ref
                          .watch(
                          currentDevicesManagerProvider)[perDevice.id]!
                          .bleName ??
                          "-",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    DropdownButton<String>(
                      value: matchDeviceIdValue[perDevice.id],
                      hint: Text(matchDeviceIdValue[perDevice.id] ?? "-"),
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge,
                      items: items.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          matchDeviceIdValue.addAll({perDevice.id: val});
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => setNames(inst),
            child: Text(inst.start_process),
          ),
        ),
      ],
    );
  }

  Future<void> setNames(AppLocalizations inst) async {
    EasyLoading.show();
    final connectedDevs = ref
        .read(currentDevicesManagerProvider.notifier)
        .connectedDevice;
    final alreadyDevs = ref
        .read(currentDevicesManagerProvider.notifier)
        .alreadyDisconnecting;
    final allDevs = [
      ...connectedDevs.values.toList(),
      ...alreadyDevs.values.toList()
    ];



    ref.read(currentDevicesManagerProvider).forEach((deviceId, value) async {

      if (matchDeviceIdValue.containsKey(deviceId)) {
        await PadManager.setDeviceBleName(deviceId,
            ref: ref,
            name: matchDeviceIdValue[deviceId]! + ' CatchPad',
            cpSN: "-1",
            noTM: "-1",
            variantId: variantType!.getModeNumber().toString(),
            stickerId: "-1")
            .then((value) async {
          ref.read(currentDevicesManagerProvider.notifier).setName(
              deviceId,
              matchDeviceIdValue[deviceId] != null
                  ? matchDeviceIdValue[deviceId]! + ' CatchPad'
                  : "-1",
              ref);

          //Default Config Set
          PadSensorManager.configAccSensor(
            deviceId: deviceId,
            ref: ref,
            model: const AccConfigModel(
              scale: ConfigScale.LIS2DH12_8g,
              mode: ConfigMode.LIS2DH12_HR_12bit,
              dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
              threshold: 50,
              timeout: 5,
            ),
            intModel: const AccInterruptConfigModel(
                scale: ConfigScale.LIS2DH12_8g,
                mode: ConfigMode.LIS2DH12_HR_12bit,
                dataRate: DataRate.LIS2DH12_ODR_1kHz620_LP,
                threshold: 50,
                timeout: 5,
                duration: 4,
                sleepEnable: true),
          );

          setState(() {});
        });

        final list = ref
            .read(bleConPr)
            .keys;
        DeviceModel currentDevice =
        list.firstWhere((element) => element.id == deviceId).copyWith(
          name: matchDeviceIdValue[deviceId]! + ' CatchPad',
        );

        ref.read(bleScannerProv).updateDeviceInfo(currentDevice);

        ref
            .read(bleConPr.notifier)
            .update(currentDevice, DeviceConnectionState.connected);
      }
    });

    for (var currentDevice in allDevs) {
      ref
          .read(bleConPr.notifier)
          .update(currentDevice, DeviceConnectionState.disconnected);
    }
    await Future.delayed(const Duration(seconds: 3));
    EasyLoading.dismiss();

    setState(() {});
  }
}
