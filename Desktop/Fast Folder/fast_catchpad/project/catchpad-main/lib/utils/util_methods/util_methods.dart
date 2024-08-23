import 'package:catchpad/ui/game/select_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/game/static_game_model.dart';
import '../../prov/current_loading_error_prov.dart';
import '../../prov/game/curr_game_prov.dart';
import '../utils.dart';

class C {
  static AppLocalizations T(BuildContext context) =>
      AppLocalizations.of(context)!;
  static double w(BuildContext context) => MediaQuery.of(context).size.width;
  static double h(BuildContext context) => MediaQuery.of(context).size.height;
  static double ls(BuildContext context) =>
      MediaQuery.of(context).size.longestSide;
  static double ss(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;
  static double ar(BuildContext context) =>
      MediaQuery.of(context).size.aspectRatio;
}


void saveToLastPlayedGames(StaticGameModel? game, WidgetRef ref) async {
  final games = SelectGameScreen.gamesOnLeaderboard(ref);
  final game = ref.read(currentGameProv);
  final gameIds = [];

  for (var gm in games) {
    gameIds.add(gm.id);
  }

  if (game == null || !gameIds.contains(game.id)) {
    if (game == null) {
      assert(false);
    }

    return;
  }

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var lastPlayedGames = sharedPreferences.getStringList('lastPlayedGames');
  if (lastPlayedGames == null) {
    sharedPreferences.setStringList('lastPlayedGames', [game.id]);
  } else {
    if (lastPlayedGames.contains(game.id)) {
      lastPlayedGames.remove(game.id);
    }
    lastPlayedGames.insert(0, game.id);
    sharedPreferences.setStringList('lastPlayedGames', lastPlayedGames);
  }

}

String colorNameReturner(String key, BuildContext context) {
  final inst = L10n.inst(context);
  if (key == 'Turquise') {
    return inst.colors_teal;
  } else if (key == 'Red') {
    return inst.colors_red;
  } else if (key == 'Green') {
    return inst.colors_green;
  } else if (key == 'Blue') {
    return inst.colors_blue;
  } else if (key == 'Yellow') {
    return inst.colors_yellow;
  } else if (key == 'Light Green') {
    return inst.colors_lightgreen;
  } else if (key == 'Pink') {
    return inst.colors_pink;
  } else if (key == 'Orange') {
    return inst.colors_orange;
  } else if (key == 'Purple') {
    return inst.colors_purple;
  } else {
    return key;
  }
}

Color fakeColorGenerator(Color color) {
  if (color.value == const Color.fromARGB(255, 159, 255, 0).value) {
    // AÇIK YEŞİL
    return const Color.fromARGB(255, 129, 255, 25);
  } else if (color.value == const Color.fromARGB(255, 255, 0, 42).value) {
    // PEMBE
    return const Color.fromARGB(255, 254, 0, 212);
  } else if (color.value == const Color.fromARGB(255, 255, 27, 0).value) {
    return const Color.fromARGB(255, 254, 123, 0);
    // TURUNCU
  } else if (color.value == const Color.fromARGB(255, 255, 102, 0).value) {
    return const Color.fromARGB(255, 246, 254, 0);
    // SARI
  } else if (color.value == const Color.fromARGB(255, 255, 0, 255).value) {
    // MAGENTA - MOR
    return const Color.fromARGB(255, 162, 0, 255);
  } else {
    // ORIGINAL
    return color;
  }
}

String dateFormatter(DateTime date) {
  return '${date.day}.${date.month}.${date.year}';
}

String dateFormatterString(String date) {
  final datetime = DateTime.parse(date);
  return '${datetime.day}.${datetime.month}.${datetime.year}';
}

bool blackTextInLightColor(Color color) {
  if (color == const Color.fromARGB(255, 0, 255, 255) ||
      color == const Color.fromARGB(255, 159, 255, 0) ||
      color == const Color.fromARGB(255, 255, 0, 42) ||
      color == const Color.fromARGB(255, 255, 0, 255) ||
      color == gameSuccessColor) {
    return true;
  }
  return false;
}

String localize(BuildContext context, String text) {
  final inst = L10n.inst(context);
  switch (text) {
    case 'ambulance':
      return inst.vehicles_ambulance;
    case 'car':
      return inst.vehicles_car;
    case 'police':
      return inst.vehicles_police;
    case 'plane':
      return inst.vehicles_plane;
    case 'train':
      return inst.vehicles_train;
    case 'ferry':
      return inst.vehicles_ferry;
    case 'truck':
      return inst.vehicles_truck;
    case 'motorcycle':
      return inst.vehicles_motorcycle;
    case 'lovely':
      return inst.emotions_lovely;
    case 'sad':
      return inst.emotions_sad;
    case 'angry':
      return inst.emotions_angry;
    case 'sleepy':
      return inst.emotions_sleepy;
    case 'confused':
      return inst.emotions_confused;
    case 'cool':
      return inst.emotions_cool;
    case 'happy':
      return inst.emotions_happy;
    case 'scared':
      return inst.emotions_scared;
    case 'banana':
      return inst.fruits_banana;
    case 'apple':
      return inst.fruits_apple;
    case 'cherry':
      return inst.fruits_cherry;
    case 'lemon':
      return inst.fruits_lemon;
    case 'grape':
      return inst.fruits_grape;
    case 'strawberry':
      return inst.fruits_strawberry;
    case 'watermelon':
      return inst.fruits_watermelon;
    case 'orange':
      return inst.fruits_orange;
    case 'avocado':
      return inst.fruits_avocado;
    case 'kiwi':
      return inst.fruits_kiwi;
    case "triangle":
      return inst.shapes_triangle;
    case "square":
      return inst.shapes_square;
    case "star":
      return inst.shapes_star;
    case "rectangle":
      return inst.shapes_rectangle;
    case "circle":
      return inst.shapes_circle;
    case "ellipse":
      return inst.shapes_ellipse;
    case "heart":
      return inst.shapes_heart;
    case "pentagon":
      return inst.shapes_pentagon;
    default:
      return 'emoji';
  }



}

class StandartConfigs {
  static int getConnectionDelayTime = 100;

  static int getConnectionLongDelayTime = 1000;
}
