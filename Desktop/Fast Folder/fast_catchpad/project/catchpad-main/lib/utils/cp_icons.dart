import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class CpIcons {
  static const IconData light = Icons.flashlight_on;
  static const IconData lightOff = Icons.flashlight_off;
  static const IconData home = Icons.home;
  static const IconData bluetoothScan = Icons.bluetooth_searching;
  static const IconData leaderboard = Icons.leaderboard;
  static const IconData profile = Icons.person;
  static const IconData createGame = Icons.add_circle;
  static const IconData search = Icons.search;

  static const IconData ledCP = Icons.light_mode;

  static const IconData
      //
      battery0 = FontAwesomeIcons.batteryEmpty,
      battery25 = FontAwesomeIcons.batteryQuarter,
      battery50 = FontAwesomeIcons.batteryHalf,
      battery75 = FontAwesomeIcons.batteryThreeQuarters,
      battery100 = FontAwesomeIcons.batteryFull,
      // TODO: fontAwesome does not have charging icon,
      // create your own and add as svg
      batteryCharging = FontAwesomeIcons.batteryFull
      //
      ;
}
