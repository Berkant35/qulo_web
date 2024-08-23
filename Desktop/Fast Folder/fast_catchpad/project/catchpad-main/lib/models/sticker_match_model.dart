import 'package:catchpad/managers/sticker_manager.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StickerMatchModel {
  const StickerMatchModel({required this.stickers});
   final Map<String, String?> stickers;

  List<String?> getStickers() {
    return stickers.values.toList();
  }

  List<String?> getStickerSet(
    String gameId,
    List<String> deviceNameIds,
    BuildContext context,
    WidgetRef ref,
  ) {
    List<String> stickerlist = [];
    final isAnimalGame = gameId == 's25' || gameId == '43';
    final isLetterGame = gameId == 's23' || gameId == '41' || gameId == '42';
    final isNotesGame = gameId == 's19';
    //final isColorsGame = gameId == 's33';
    final isVehiclesGame = gameId == 's34';

    final isEmojisGame = gameId == 's27';

    final isNumbersGame = gameId == 's24';

    final isMeyveGame = gameId == 's28';

    final isShapeGame = gameId == 's36';

    // TODO: this is a temp structure, fix rename and make this into one
    String? st;

    if(isNumbersGame)
    {
      for (var i = 1; i < 13; i++) {
        st = StickerManager.idToStickerAudioNameWithoutText(
            val: i.toString());
        stickerlist.add(st!);
      }
    }


    if (isAnimalGame) {
      for (var i = 0; i < 9; i++) {
        st = StickerManager.idToStickerAnimalTranslation(
            val: i.toString(), ref: ref);
        stickerlist.add(st!);
      }
    }

    if (isLetterGame) {
      for (var i = 0; i < 6; i++) {
        st = StickerManager.idToStickerLetterTranslation(
          ref: ref,
          val: i.toString(),
        );
        stickerlist.add(st!);
      }
    }
    if (isNotesGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerNotesTranslation(val: i.toString());
        stickerlist.add(st!);
      }
    }

    if (isVehiclesGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerVehiclesTranslation(
                isForGame: false,
                ref: ref,
                context: context,
                val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isEmojisGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerEmojisTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isMeyveGame) {
      for (var i = 1; i < 11; i++) {
        st = StickerManager.idToStickerFruitsTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isShapeGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerShapesTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    /* if (isColorsGame) {
            st = StickerManager.idToStickerColorsTranslation(
                val: device.deviceNumber!.toString());
          } */

    return stickerlist;
  }

  List<String?> getStickerIds(
    String gameId,
    List<String> deviceNameIds,
    BuildContext context,
    WidgetRef ref,
  ) {
    List<String> stickerlist = [];
    final isAnimalGame = gameId == 's25' || gameId == '43';
    final isLetterGame = gameId == 's23' || gameId == '41' || gameId == '42';
    final isNotesGame = gameId == 's19';
    //final isColorsGame = gameId == 's33';
    final isVehiclesGame = gameId == 's34';

    final isEmojisGame = gameId == 's27';

    final isMeyveGame = gameId == 's28';

    final isShapeGame = gameId == 's36';

    // TODO: this is a temp structure, fix rename and make this into one
    String? st;


    if (isAnimalGame) {
      for (var i = 0; i < 6; i++) {
        st = StickerManager.idToStickerAnimalAudioNameApp(
            val: i.toString(), ref: ref);
        stickerlist.add(st!);
      }
    }

    if (isLetterGame) {
      for (var i = 0; i < 6; i++) {
        st = StickerManager.idToStickerLetterTranslation(
          ref: ref,
          val: i.toString(),
        );
        stickerlist.add(st!);
      }
    }
    if (isNotesGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerNotesTranslation(val: i.toString());
        stickerlist.add(st!);
      }
    }

    if (isVehiclesGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerVehiclesTranslation(
                isForGame: false,
                ref: ref,
                context: context,
                val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isEmojisGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerEmojisTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isMeyveGame) {
      for (var i = 1; i < 11; i++) {
        st = StickerManager.idToStickerFruitsTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    if (isShapeGame) {
      for (var i = 1; i < 9; i++) {
        st = StickerManager.idToStickerShapesTranslation(
                context: context, val: i.toString())!
            .capitalize();
        stickerlist.add(st);
      }
    }

    /* if (isColorsGame) {
            st = StickerManager.idToStickerColorsTranslation(
                val: device.deviceNumber!.toString());
          } */

    return stickerlist;
  }

  List<String> getDevices() {
    return stickers.keys.toList();
  }

  List<MapEntry<String, String?>> getStickersAsPaired() {
    return stickers.entries.toList();
  }

  Map<String, String?> toJson() {
    return stickers;
  }

  factory StickerMatchModel.fromJson(Map<String, dynamic> json) {
    try {
      return StickerMatchModel(
        stickers: Map<String, String?>.from(json),
      );
    } catch (e) {
      return const StickerMatchModel(stickers: {});
    }
  }
}
