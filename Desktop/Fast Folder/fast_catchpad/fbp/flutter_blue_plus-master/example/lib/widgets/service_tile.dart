import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_example/models/cp_characteristic.dart';
import 'package:flutter_blue_plus_example/screen2/led_service_screen.dart';

import "characteristic_tile.dart";

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  //const String ledServiceId = '55cb9fe8-b2ab-11ec-b909-000000000000';
  Widget buildUuid(BuildContext context) {
    String uuid = detailOfService[service.uuid.str.toLowerCase()] ??
        service.uuid.str.toLowerCase();

    return Row(
      children: [
        // Icon(Icons.arrow_right_alt_outlined, color: Colors.blue),
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => LedServiceScreen(
            characteristicTiles: characteristicTiles,
          ))),
          iconAlignment: IconAlignment.end,
          label: Text(uuid,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return characteristicTiles.isNotEmpty
        ? ExpansionTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildUuid(context),
              ],
            ),
            children: characteristicTiles,
          )
        : ListTile(
            title: const Text('Service'),
            subtitle: buildUuid(context),
          );
  }
}
