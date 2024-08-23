import 'package:flutter/material.dart';

import '../../models/device/device_group_model.dart';
import 'device_group_title.dart';
import 'device_li.dart';


class DeviceGroup extends StatelessWidget {
  final DeviceGroupModel model;

  const DeviceGroup(this.model, {super.key});

  @override
  Widget build(BuildContext context) {

    if (model.devices.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        DeviceGroupTitle(model),
        ...model.devices.map(
          (dev) {
            return DeviceLi(dev);
          },
        )
      ],
    );
  }
}
