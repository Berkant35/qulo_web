import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/l10n/json_l10n.dart';

abstract class StickerManager {
  static Future<void> setStickerName({
    required WidgetRef ref,
    required String deviceId,
    required String stickerKey,
  }) async {
    await PadManager.setDeviceBleName(
      deviceId,
      ref: ref,
      name: stickerKey,
    );
  }

  static String? idToStickerLetterTranslation(
      {required String val, required WidgetRef ref, bool isForGame = false}) {
    final stName = StickerManager.idToStickerLetterAudioNamePad(
        val: val, ref: ref, isForGame: isForGame);

    if (stName != null) {
      final stId = stName.split('/').join('_');

      try {
        final trans = getStickerTitleStr('sticker_title_$stId');
        return trans;
      } catch (e) {
        logger.e(e);
        return null;
      }
    }

    return null;
  }

  static String? idToStickerAnimalTranslation({
    required String val,
    required WidgetRef ref,
  }) {
    final stName = StickerManager.idToStickerAnimalAudioNamePad(
        val: val, ref: ref, isForGame: false);

    if (stName != null) {
      final stId = stName.split('/').join('_');

      try {
        final trans = getStickerTitleStr('sticker_title_$stId');
        return trans;
      } catch (e) {
        logger.e(e);
        return null;
      }
    }

    return null;
  }


  static String? idToStickerAudioSoundPath({
    required String val,
    required WidgetRef ref,
    bool isForGame = false,
  }){


    switch (val) {
      case 'Bee':
      case 'Arı':
        return 'assets/audio/animals_game/animals_bee.mp3';
      case 'Bird':
      case 'Kuş':
        return 'assets/audio/animals_game/animals_bird.mp3';
      case 'Dog':
      case 'Köpek':
        return 'assets/audio/animals_game/animals_dog.mp3';
      case 'Cow':
      case 'İnek':
        return 'assets/audio/animals_game/animals_cow.mp3';
      case 'Donkey':
      case 'Eşek':
        return 'assets/audio/animals_game/animals_donkey.mp3';
      case 'Elephant':
      case 'Fil':
        return 'assets/audio/animals_game/animals_elephant.mp3';
      case 'Lion':
      case 'Aslan':
        return 'assets/audio/animals_game/animals_lion.mp3';
      case 'Cat':
      case 'Kedi':
        return 'assets/audio/animals_game/animals_cat.mp3';
      case 'Rooster':
      case 'Horoz':
        return 'assets/audio/animals_game/animals_rooster.mp3';
      case 'Ambulans':
      case 'Ambulance':
        return 'assets/audio/vehicles_game/Ambulance.mp3';
      case 'Car':
      case 'Araba':
        return 'assets/audio/vehicles_game/Car.mp3';
      case 'Polis':
      case 'Police':
        return 'assets/audio/vehicles_game/Police.mp3';
      case 'Uçak':
      case 'Plane':
        return 'assets/audio/vehicles_game/Plane.mp3';
      case 'Tren':
      case 'Train':
        return 'assets/audio/vehicles_game/Train.mp3';
      case 'Gemi':
      case 'Ferry':
        return 'assets/audio/vehicles_game/Ferry.mp3';
      case 'Kamyon':
      case 'Truck':
        return 'assets/audio/vehicles_game/Truck.mp3';
      case 'Motor':
      case 'Motorcycle':
        return 'assets/audio/vehicles_game/motorcycle.mp3';
      case 'A':
        return 'assets/audio/letters_game/letters_a.mp3';
      case 'B':
        return 'assets/audio/letters_game/letters_b.mp3';
      case 'C':
        return 'assets/audio/letters_game/letters_c.mp3';
      case 'D':
        return 'assets/audio/letters_game/letters_d.mp3';
      case 'E':
        return 'assets/audio/letters_game/letters_e.mp3';
      case 'K':
        return 'assets/audio/letters_game/letters_k.mp3';
      case 'DO':
        return 'assets/audio/music_game/Do.mp3';
      case 'SOL':
        return 'assets/audio/music_game/Sol.mp3';
      case 'FA':
        return 'assets/audio/music_game/Fa.mp3';
      case 'RE':
        return 'assets/audio/music_game/Re.mp3';
      case 'Mİ':
      case 'MI':
        return 'assets/audio/music_game/Mi.mp3';
      case 'LA':
        return 'assets/audio/music_game/La.mp3';
      case 'Sİ':
      case 'SI':
        return 'assets/audio/music_game/Si.mp3';
      case "1":
      case "ONE":
        return 'assets/audio/language_game/cardinal_1.mp3';
      case "2":
      case "TWO":
        return 'assets/audio/language_game/cardinal_2.mp3';
      case "3":
      case "THREE":
        return 'assets/audio/language_game/cardinal_3.mp3';
      case "4":
      case "FOUR":
        return 'assets/audio/language_game/cardinal_4.mp3';
      case "5":
      case "FIVE":
        return 'assets/audio/language_game/cardinal_5.mp3';
      case "6":
      case "SIX":
        return 'assets/audio/language_game/cardinal_6.mp3';
      case "7":
      case "SEVEN":
        return 'assets/audio/language_game/cardinal_7.mp3';
      case "8":
      case "EIGHT":
        return 'assets/audio/language_game/cardinal_8.mp3';
      case "9":
      case "NINE":
        return 'assets/audio/language_game/cardinal_9.mp3';
      case "10":
      case "TEN":
        return 'assets/audio/language_game/cardinal_10.mp3';
      case "11":
      case "ELEVEN":
        return 'assets/audio/language_game/cardinal_11.mp3';
      case "12":
      case "TWELVE":
        return 'assets/audio/language_game/cardinal_12.mp3';
      default:
        return 'assets/audio/sandbox/bip.mp3';
    }
  }


  static String? idToStickerLetterAudioNamePad({
    required String val,
    required WidgetRef ref,
    bool isForGame = false,
  }) {
    if (isForGame) {
      final stickers = ref.read(stickerProvider);
      final sticker = stickers.stickers.entries
          .firstWhere((stckr) => stckr.value == val)
          .key;
      switch (sticker) {
        case 'A':
          return 'LETTERS/A';
        case 'B':
          return 'LETTERS/B';
        case 'C':
          return 'LETTERS/C';
        case 'D':
          return 'LETTERS/D';
        case 'E':
          return 'LETTERS/E';
        case 'K':
          return 'LETTERS/K';
        default:
      }
    }
    String? numToStr() {
      var intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      intVal = intVal % 6;

      switch (intVal) {
        case 0:
          return 'LETTERS/A';
        case 1:
          return 'LETTERS/B';
        case 2:
          return 'LETTERS/C';
        case 3:
          return 'LETTERS/D';
        case 4:
          return 'LETTERS/E'; //TODO F G H letters needs to be added
        case 5:
          return 'LETTERS/K';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerLetterAudioNameApp(
      {required String val, required WidgetRef ref}) {
    return idToStickerLetterAudioNamePad(val: val, ref: ref, isForGame: true)
        ?.split('/')
        .join('_');
  }

  static String? idToStickerAnimalAudioNameApp(
      {required String val, required WidgetRef ref}) {
    return idToStickerAnimalAudioNamePad(val: val, ref: ref, isForGame: true)
        ?.split('/')
        .join('_');
  }

  static String? idToStickerAnimalAudioNamePad({
    required String val,
    required WidgetRef ref,
    bool isForGame = false,
  }) {
    if (isForGame) {
      final stickers = ref.read(stickerProvider);
      final sticker = stickers.stickers.entries
          .firstWhere((stckr) => stckr.value == val)
          .key;
      final allkeys = JsonAppLocalizations.instance.getAllKeys();
      final relatedkey = allkeys.firstWhere(
          (key) => JsonAppLocalizations.instance.text(key) == sticker);



      switch (relatedkey) {
        case 'sticker_title_animals_cow':
          return 'ANIMALS/COW';
        case 'sticker_title_animals_dog':
          return 'ANIMALS/DOG';
        case 'sticker_title_animals_donkey':
          return 'ANIMALS/DONKEY';
        case 'sticker_title_animals_elephant':
          return 'ANIMALS/ELEPHANT';
        case 'sticker_title_animals_lion':
          return 'ANIMALS/LION';
        case 'sticker_title_animals_rooster':
          return 'ANIMALS/ROOSTER';
        case 'sticker_title_animals_cat':
          return 'ANIMALS/CAT';
        case 'sticker_title_animals_bee':
          return 'ANIMALS/BEE';
        case 'sticker_title_animals_bird':
          return 'ANIMALS/BIRD';
        default:
      }
    }
    String? numToStr() {
      var intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      intVal = intVal % 9;

      switch (intVal) {
        case 0:
          return 'ANIMALS/COW';
        case 1:
          return 'ANIMALS/DOG';
        case 2:
          return 'ANIMALS/DONKEY';
        case 3:
          return 'ANIMALS/ELEPHANT';
        case 4:
          return 'ANIMALS/LION';
        case 5:
          return 'ANIMALS/ROOSTER';
        case 6:
          return 'ANIMALS/CAT';
        case 7:
          return 'ANIMALS/BEE';
        case 8:
          return 'ANIMALS/BIRD';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerAudioNameWithoutText({
    required String val,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        /*case 0:
          return 'ZERO';*/
        case 1:
          return 'ONE';
        case 2:
          return 'TWO';
        case 3:
          return 'THREE';
        case 4:
          return 'FOUR';
        case 5:
          return 'FIVE';
        case 6:
          return 'SIX';
        case 7:
          return 'SEVEN';
        case 8:
          return 'EIGHT';
        case 9:
          return 'NINE';
        case 10:
          return 'TEN';
        case 11:
          return 'ELEVEN';
        case 12:
          return 'TWELVE';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerAudioNameWithoutText2({
    required String val,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 0:
          return '/ZERO';
        case 1:
          return '/ONE';
        case 2:
          return '/TWO';
        case 3:
          return '/THREE';
        case 4:
          return '/FOUR';
        case 5:
          return '/FIVE';
        case 6:
          return '/SIX';
        case 7:
          return '/SEVEN';
        case 8:
          return '/EIGHT';
        case 9:
          return '/NINE';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerAudioName({
    required String val,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 0:
          return 'NUMBERS/ZERO';
        case 1:
          return 'NUMBERS/ONE';
        case 2:
          return 'NUMBERS/TWO';
        case 3:
          return 'NUMBERS/THREE';
        case 4:
          return 'NUMBERS/FOUR';
        case 5:
          return 'NUMBERS/FIVE';
        case 6:
          return 'NUMBERS/SIX';
        case 7:
          return 'NUMBERS/SEVEN';
        case 8:
          return 'NUMBERS/EIGHT';
        case 9:
          return 'NUMBERS/NINE';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerNotesTranslation({
    required String val,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          return 'DO';
        case 2:
          return 'RE';
        case 3:
          return 'MI';
        case 4:
          return 'FA';
        case 5:
          return 'SOL';
        case 6:
          return 'LA';
        case 7:
          return 'SI';
        case 8:
          return 'DO';
        case 9:
          return 'RE';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToVehicleSoundAudioReturner({required String value}) {
    final inst = instForGameScreen;
    if (value == inst.vehicles_ambulance.capitalize()) {
      return 'ambulance';
    } else if (value == inst.vehicles_car.capitalize()) {
      return 'car';
    } else if (value == inst.vehicles_police.capitalize()) {
      return 'police';
    } else if (value == inst.vehicles_plane.capitalize()) {
      return 'plane';
    } else if (value == inst.vehicles_train.capitalize()) {
      return 'train';
    } else if (value == inst.vehicles_ferry.capitalize()) {
      return 'ferry';
    } else if (value == inst.vehicles_truck.capitalize()) {
      return 'truck';
    } else if (value == inst.vehicles_motorcycle.capitalize()) {
      return 'motorcycle';
    } else {
      return null;
    }
  }

  static String? idToEmojiImageReturner({required String value}) {
    final inst = instForGameScreen;
    if (value == inst.emotions_happy.capitalize()) {
      return 'happy';
    } else if (value == inst.emotions_sad.capitalize()) {
      return 'sad';
    } else if (value == inst.emotions_angry.capitalize()) {
      return 'angry';
    } else if (value == inst.emotions_sleepy.capitalize()) {
      return 'sleepy';
    } else if (value == inst.emotions_confused.capitalize()) {
      return 'confused';
    } else if (value == inst.emotions_cool.capitalize()) {
      return 'cool';
    } else if (value == inst.emotions_scared.capitalize()) {
      return 'scared';
    } else if (value == inst.emotions_lovely.capitalize()) {
      return 'lovely';
    } else {
      return null;
    }
  }

  static String? idToFruitsImageReturner({required String value}) {
    final inst = instForGameScreen;
    if (value == inst.fruits_banana.capitalize()) {
      return 'banana';
    } else if (value == inst.fruits_apple.capitalize()) {
      return 'apple';
    } else if (value == inst.fruits_cherry.capitalize()) {
      return 'cherry';
    } else if (value == inst.fruits_lemon.capitalize()) {
      return 'lemon';
    } else if (value == inst.fruits_grape.capitalize()) {
      return 'grape';
    } else if (value == inst.fruits_strawberry.capitalize()) {
      return 'strawberry';
    } else if (value == inst.fruits_watermelon.capitalize()) {
      return 'watermelon';
    } else if (value == inst.fruits_orange.capitalize()) {
      return 'orange';
    } else if (value == inst.fruits_avocado.capitalize()) {
      return 'avocado';
    } else if (value == inst.fruits_kiwi.capitalize()) {
      return 'kiwi';
    } else {
      return null;
    }
  }

  static String? idToShapesImageReturner({required String value}) {
    final inst = instForGameScreen;
    if (value == inst.shapes_circle.capitalize()) {
      return 'circle';
    } else if (value == inst.shapes_ellipse.capitalize()) {
      return 'ellipse';
    } else if (value == inst.shapes_heart.capitalize()) {
      return 'heart';
    } else if (value == inst.shapes_pentagon.capitalize()) {
      return 'pentagon';
    } else if (value == inst.shapes_rectangle.capitalize()) {
      return 'rectangle';
    } else if (value == inst.shapes_square.capitalize()) {
      return 'square';
    } else if (value == inst.shapes_star.capitalize()) {
      return 'star';
    } else if (value == inst.shapes_triangle.capitalize()) {
      return 'triangle';
    } else {
      return null;
    }
  }

  static String? idToStickerVehiclesTranslation({
    required BuildContext context,
    required String val,
    required WidgetRef ref,
    bool isForGame = false,
  }) {
    final inst = L10n.inst(context);
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }
      switch (intVal) {
        case 1:
          return inst.vehicles_ambulance;
        case 2:
          return inst.vehicles_car;
        case 3:
          return inst.vehicles_police;
        case 4:
          return inst.vehicles_plane;
        case 5:
          return inst.vehicles_train;
        case 6:
          return inst.vehicles_ferry;
        case 7:
          return inst.vehicles_truck;
        case 8:
          return inst.vehicles_motorcycle;
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerEmojisTranslation(
      {required BuildContext? context,
      required String val,
      bool returnRaw = false}) {
    late final AppLocalizations inst;
    if (returnRaw == false) {
      inst = L10n.inst(context!);
    }
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          if (returnRaw) return 'lovely';
          return inst.emotions_lovely;
        case 2:
          if (returnRaw) return 'sad';
          return inst.emotions_sad;
        case 3:
          if (returnRaw) return 'angry';
          return inst.emotions_angry;
        case 4:
          if (returnRaw) return 'sleepy';
          return inst.emotions_sleepy;
        case 5:
          if (returnRaw) return 'confused';
          return inst.emotions_confused;
        case 6:
          if (returnRaw) return 'cool';
          return inst.emotions_cool;
        case 7:
          if (returnRaw) return 'happy';
          return inst.emotions_happy;
        case 8:
          if (returnRaw) return 'scared';
          return inst.emotions_scared;
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerFruitsTranslation(
      {required BuildContext? context,
      required String val,
      bool returnRaw = false}) {
    late final AppLocalizations inst;
    if (returnRaw == false) {
      inst = L10n.inst(context!);
    }
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }
      switch (intVal) {
        case 1:
          if (returnRaw) return 'banana';
          return inst.fruits_banana;
        case 2:
          if (returnRaw) return 'apple';
          return inst.fruits_apple;
        case 3:
          if (returnRaw) return 'cherry';
          return inst.fruits_cherry;
        case 4:
          if (returnRaw) return 'lemon';
          return inst.fruits_lemon;
        case 5:
          if (returnRaw) return 'grape';
          return inst.fruits_grape;
        case 6:
          if (returnRaw) return 'strawberry';
          return inst.fruits_strawberry;
        case 7:
          if (returnRaw) return 'watermelon';
          return inst.fruits_watermelon;
        case 8:
          if (returnRaw) return 'orange';
          return inst.fruits_orange;
        case 9:
          if (returnRaw) return 'avocado';
          return inst.fruits_avocado;
        case 10:
          if (returnRaw) return 'kiwi';
          return inst.fruits_kiwi;
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerShapesTranslation(
      {required BuildContext? context,
      required String val,
      bool returnRaw = false}) {
    late final AppLocalizations inst;
    if (returnRaw == false) {
      inst = L10n.inst(context!);
    }
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }
      switch (intVal) {
        case 1:
          if (returnRaw) return 'triangle';
          return inst.shapes_triangle;
        case 2:
          if (returnRaw) return 'square';
          return inst.shapes_square;
        case 3:
          if (returnRaw) return 'star';
          return inst.shapes_star;
        case 4:
          if (returnRaw) return 'rectangle';
          return inst.shapes_rectangle;
        case 5:
          if (returnRaw) return 'circle';
          return inst.shapes_circle;
        case 6:
          if (returnRaw) return 'ellipse';
          return inst.shapes_ellipse;
        case 7:
          if (returnRaw) return 'heart';
          return inst.shapes_heart;
        case 8:
          if (returnRaw) return 'pentagon';
          return inst.shapes_pentagon;
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerAudioGetter({
    required String val,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          return 'Ambulance';
        case 2:
          return 'Car';
        case 3:
          return 'Police';
        case 4:
          return 'Plane';
        case 5:
          return 'Train';
        case 6:
          return 'Ferry';
        case 7:
          return 'Truck';
        case 8:
          return 'Motorcycle';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerColorsTranslation({
    required String val,
    //required WidgetRef ref,
    //bool isForGame = false
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          return 'Blue';
        case 2:
          return 'Green';
        case 3:
          return 'Orange';
        case 4:
          return 'Purple';
        case 5:
          return 'Red';
        case 6:
          return 'Yellow';
        case 7:
          return 'Brown';
        case 8:
          return 'Blue';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerNotes({
    required String val,
    //required WidgetRef ref,
    //bool isForGame = false,
  }) {
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          return 'NOTES/DO';
        case 2:
          return 'NOTES/RE';
        case 3:
          return 'NOTES/MI';
        case 4:
          return 'NOTES/FA';
        case 5:
          return 'NOTES/SOL';
        case 6:
          return 'NOTES/LA';
        case 7:
          return 'NOTES/SI';
        case 8:
          return 'NOTES/DO';
        case 9:
          return 'NOTES/RE';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static String? idToStickerNotesForMobile({
    required String val,
    required WidgetRef ref,
    bool isForGame = false,
  }) {
    if (isForGame) {
      final stickers = ref.read(stickerProvider);
      final sticker = stickers.stickers.entries
          .firstWhere((stckr) => stckr.value == val)
          .key;
      switch (sticker) {
        case 'DO':
          return 'a';
        case 'RE':
          return 'b';
        case 'MI':
          return 'c';
        case 'FA':
          return 'd';
        case 'SOL':
          return 'e';
        case 'LA':
          return 'f';
        case 'SI':
          return 'g';
        default:
          return 'a';
      }
    }
    String? numToStr() {
      final intVal = int.tryParse(val);

      if (intVal == null) {
        return null;
      }

      switch (intVal) {
        case 1:
          return 'a';
        case 2:
          return 'b';
        case 3:
          return 'c';
        case 4:
          return 'd';
        case 5:
          return 'e';
        case 6:
          return 'f';
        case 7:
          return 'g';
        case 8:
          return 'w';
        case 9:
          return 'a';
        default:
          return null;
      }
    }

    return numToStr();
  }

  static List<String> getStickerNames({
    required WidgetRef ref,
  }) {
    final keys = JsonAppLocalizations.instance.getAllKeys();

    return keys
        .where(
          (element) => element.startsWith('sticker_title'),
        )
        .toList();
  }
}
