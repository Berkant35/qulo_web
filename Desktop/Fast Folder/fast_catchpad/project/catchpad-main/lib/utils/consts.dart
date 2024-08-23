import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:json_annotation/json_annotation.dart';

import '../prov/game/curr_game_prov.dart';

const String
//
    usersCollection = 'users',
    gameResultsCollection = 'game_results',
    adminsCollection = 'admins',
    usernamesCollection = 'usernamepool',
    userAssetsCollection = 'usersData',
    mainCatchpadName = "1 CatchPad",
    undefinedGameSetupForJson = 'Not Includes';


const String cp04V107VLink = "https://github.com/Berkant35/cp04v1.0.11/raw/main/v0.1.11.bin";

const double defPaddingSize = 15.0,
    halfDefPaddingSize = defPaddingSize / 2,
    quarterDefPaddingSize = defPaddingSize / 4,
//
    formsPaddingSize = 16.0;

const bool isPresentationApp = true;

const FieldRename defaultFieldRename = FieldRename.snake;

const audiosCodec = Codec.mp3;
const audiosCodecWav = Codec.pcm16WAV;

const gameCountDownDuration = Duration(seconds: 3); //Countdown
const igaCountDownDuration = Duration(seconds: 4); //Countdown

const batteryChargingColor = Color.fromARGB(255, 255, 165, 0);

const gameSuccessColor = Color.fromARGB(255, 0, 255, 0);
const gameErrorColor = Color.fromARGB(255, 255, 0, 0);
const _defaultConstColors = [
  gameErrorColor,
  gameSuccessColor,
  Color.fromARGB(255, 0, 0, 255), // MAVİ
  Color.fromARGB(255, 255, 102, 0), // SARI
  Color.fromARGB(255, 0, 255, 255), // TURKUAZ
  //Color.fromARGB(255, 159, 255, 0), // AÇIK YEŞİL
  Color.fromARGB(255, 255, 0, 42), // PEMBE
  Color.fromARGB(255, 255, 27, 0), // TURUNCU
  Color.fromARGB(255, 255, 0, 255), // MAGENTA
  Color.fromARGB(255, 255, 255, 255),
  //Color.fromARGB(255, 75, 40, 0),
  //Color.fromARGB(255, 75, 18, 25),
  //Color.fromARGB(255, 18, 23, 75),
];

const _defaultIgaConstColors = [
  gameErrorColor,
  gameSuccessColor,
  Color.fromARGB(255, 0, 0, 254), // MAVİ
  Color.fromARGB(255, 247, 254, 0), // SARI
  Color.fromARGB(255, 0, 255, 255), // TURKUAZ
  //Color.fromARGB(255, 159, 255, 0), // AÇIK YEŞİL

  Color.fromARGB(255, 254, 0, 212), // PEMBE
  Color.fromARGB(255, 255, 123, 0), // Turuncu
  //Color.fromARGB(255, 159, 255, 0),
  Color.fromARGB(255, 255, 0, 255), // MAGENTA
  Color.fromARGB(255, 255, 255, 255),
  //Color.fromARGB(255, 255, 0, 42), // PEMBE
  //Color.fromARGB(255, 255, 27, 0), // TURUNCU
  //Color.fromARGB(255, 75, 40, 0),
  //Color.fromARGB(255, 75, 18, 25),
  //Color.fromARGB(255, 18, 23, 75),
];

const needColorFour = [
  Color.fromARGB(255, 0, 25, 200),
  Color.fromARGB(255, 0, 50, 150),
  Color.fromARGB(255, 0, 75, 100),
  Color.fromARGB(255, 100, 200, 0),
  Color.fromARGB(255, 250, 200, 0),
  Color.fromARGB(255, 250, 100, 250),
  Color.fromARGB(255, 255, 27, 0),
  Color.fromARGB(255, 255, 0, 255),
  Color.fromARGB(255, 18, 23, 75),
];

const _defaultConstColorsAsMap = {
  'Red': gameErrorColor,
  'Green': gameSuccessColor,
  'Blue': Color.fromARGB(255, 0, 0, 255), // MAVİ
  'Yellow': Color.fromARGB(255, 255, 102, 0), // SARI
  'Turquise': Color.fromARGB(255, 0, 255, 255), // TURKUAZ
  //'Light Green': Color.fromARGB(255, 159, 255, 0), // AÇIK YEŞİL
  'Pink': Color.fromARGB(255, 255, 0, 42), // PEMBE
  'Orange': Color.fromARGB(255, 255, 27, 0), // TURUNCU
  'Purple': Color.fromARGB(255, 255, 0, 255) // MAGENTA
  //Color.fromARGB(255, 75, 40, 0),
  //Color.fromARGB(255, 75, 18, 25),
  //Color.fromARGB(255, 18, 23, 75),
};

class ColorsAll {
  static Color blue = const Color.fromARGB(255, 0, 0, 255);
  static Color yellow = const Color.fromARGB(255, 255, 102, 0);
  static Color turque = const Color.fromARGB(255, 0, 255, 255);
  static Color lightgreen = const Color.fromARGB(255, 159, 255, 0);
  static Color red = gameErrorColor;
  static Color green = gameSuccessColor;
  static Color pink = const Color.fromARGB(255, 255, 0, 42);
  static Color brown = const Color.fromARGB(255, 255, 27, 0);
  static Color magenta = const Color.fromARGB(255, 255, 0, 255);
  static String blueSound = 'blue';
  static String greenSound = 'green';
  static String orangeSound = 'orange';
  static String purpleSound = 'purple';
  static String redSound = 'red';
  static String yellowSound = 'yellow';
}

// WE'RE PROVIDING A COPY OF THISABCZ THE
// DART COMPILER WONT ALLOW SHUFFLING IT,
// WHICH IS A CORRECT THING BUT IT DOES NOT
// WARN YOU AT ANALYZE OR COMPILE TIME!!!!
List<Color> defaultConstColors(dynamic ref, {bool isIga = false}) {
  /// apparently riverpod does not have its
  /// `Ref` and `WidgetRef` implement the same
  /// class, so we have to use this hacky way
  ///
  /// because this method can be called from
  /// a Widget, which will pass a `WidgetRef`,
  /// or from a notifier, which will pass a `Ref`.
  if (ref is! WidgetRef && ref is! Ref) {
    assert(false);

    return [];
  }
  final currentGameSetup = ref.read(currentGameSetupProv);

  final unavaiColors =
      currentGameSetup?.generalStagedPlayerModel?.unavailableColors;

  final ret =
      List<Color>.from(isIga ? _defaultIgaConstColors : _defaultConstColors);

  if (unavaiColors != null) {
    ret.removeWhere((c) => unavaiColors.contains(c));
  }

  return ret;
}

Map<String, Color> defaultConstColorsAsMap(dynamic ref) {
  /// apparently riverpod does not have its
  /// `Ref` and `WidgetRef` implement the same
  /// class, so we have to use this hacky way
  ///
  /// because this method can be called from
  /// a Widget, which will pass a `WidgetRef`,
  /// or from a notifier, which will pass a `Ref`.
  if (ref is! WidgetRef && ref is! Ref) {
    assert(false);

    return {};
  }
  final currentGameSetup = ref.read(currentGameSetupProv);

  final unavaiColors = currentGameSetup
      ?.generalStagedPlayerModel?.unavailableColors as List<Color>?;

  final ret = Map<String, Color>.from(_defaultConstColorsAsMap);

  if (unavaiColors != null) {
    ret.removeWhere(
        (key, value) => unavaiColors.any((element) => element == value));
  }

  return ret;
}

const colorSounds = [
  'blue',
  'brown',
  'green',
  'orange',
  'purple',
  'red',
  'yellow'
];

const adminIdList = [
  "wojxk16paRQUscUdLgXgC9lxXLS2",
  "1syo1YA1mDNxZ4KHrmHUWT9O6EJ3",
  "oXQP2VzvOshfhwhReTtR0zp4Njm2",
  "L5nWoKEGNZXomlngP97fUmrwByu2",
  "xsSXi99HSEaTnfOIoRUK8GMONYi2",
  "dDipAXJtfZPiJ4iFAYNX0A3O5LO2",
  "9drr8Z0GD0VMnitYMpo5Npvms5n1",
  "tVqkd6A8s1hjrFWL0B3Zmy2T5II3",
  "YcrCDa3OiyWiGtAy2ECSO0rAfpW2",
  "Pmu65hU5OJa2wOzMJ1Gkh15cldj2"
];

const assignColorGames = ["67", "69", "71", "72"];

const sequenceGames = ["68"];

const vehicleSounds = [
  'ambulance',
  'car',
  'police',
  'plane',
  'train',
  'ferry',
  'truck',
  'motorcycle'
];

const animalSounds = [];

const notesCp = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'w'];

const emotions = [
  'lovely',
  'sad',
  'angry',
  'sleepy',
  'confused',
  'cool',
  'happy',
  'scared'
];

const googlePlayLink = "https://play.google.com/store/search?q=Catchpad&c=apps";
const appStoreLink =
    "https://apps.apple.com/tr/app/catchpad-i-nteraktif-egzersiz/id1625783946";

const allFruits = [
  "banana",
  "apple",
  "cherry",
  "lemon",
  "grape",
  "strawberry",
  "watermelon",
  "orange",
  "avocado",
  "kiwi"
];

const allShapes = [
  "triangle",
  "square",
  "star",
  "rectangle",
  "circle",
  "ellipse",
  "heart",
  "pentagon"
];

class PrefKeys {
  static const distanceSensorMayNotEffective = 'sensor_may_dialog_key';
  static const showCase = 'show_case';
}
