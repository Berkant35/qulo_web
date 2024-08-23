


import 'package:catchpad/ui/device/device_li.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/global_providers.dart';

class BatteryInfo extends ConsumerStatefulWidget {
  final BatteryModel batteryModel;
  final String deviceId;
  const BatteryInfo({
    Key? key,
    required this.batteryModel,
    required this.deviceId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends ConsumerState<BatteryInfo> {
  @override
  Widget build(BuildContext context) {
    final battery = widget.batteryModel;

    String currentBatteryLevel =
    (battery.percentage ~/ 10 * 10).toString();

    currentBatteryLevel =
    currentBatteryLevel == '0' ? '10' : currentBatteryLevel;

    currentBatteryLevel =
    battery.isCompleted ? '100' : currentBatteryLevel;

    ref
        .read(currentBatteryOfPadsManager.notifier)
        .updateBatteryVoltage(
        ref, widget.deviceId, battery.voltage!);

    ref.read(currentChargingStatusManager.notifier).update(
        ref, widget.deviceId,
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
        Text('%' + currentBatteryLevel + ' '),
        BatteryIcon(battery: battery),
      ],
    );
  }
}
