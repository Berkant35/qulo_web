import 'package:catchpad/models/sticker_match_model.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

export '../models/permission/permission_manager.dart';

final stickerProvider =
    StateNotifierProvider<StickerProvider, StickerMatchModel>(
  (_) => StickerProvider(const StickerMatchModel(stickers: {})),
);

class StickerProvider extends StateNotifier<StickerMatchModel> {
  StickerProvider(super.state);

  void addNew(Map<String, String?> sticker, WidgetRef ref) {
    Map<String, String?> newStickers = Map.from(state.stickers);
    newStickers.addAll(sticker);
    state = StickerMatchModel(stickers: newStickers);
    saveToSharedPref(ref);
  }

  void update(StickerMatchModel stickersModel, WidgetRef ref) {
    state = stickersModel;
    saveToSharedPref(ref);
  }

  void reset() {
    state = const StickerMatchModel(stickers: {});
  }

  void setStickerToDevice(String key, String color) {
    Map<String, String?> newStickers = Map.from(state.stickers);

    if (!newStickers.values.contains(color)) {
      newStickers[key] = color;
      state = StickerMatchModel(stickers: newStickers);
    }

  }

  void removeStickerFromDevice(String key,WidgetRef ref) {


    Map<String, String?> newStickers = Map.from(state.stickers);

    newStickers[key] = null;
    newStickers.removeWhere((key, value) => value == null);

    state = StickerMatchModel(stickers: newStickers);
    logger.i(state.stickers.toString());
  }

  saveToSharedPref(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    /*
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(stickersModel: state); */
    sharedPreferences.setStringList('stickers', state.stickers.keys.toList());
  }

  Future<bool> loadMoves(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? stickers =
        sharedPreferences.getStringList('stickers');
    if (stickers != null) {
      Map<String, String?> stickerMap = {};
      for (var sticker in stickers) {
        stickerMap[sticker] = null;
      }
      state = StickerMatchModel(stickers: stickerMap);
    }/* 
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(stickersModel: state); */
    return true;
  }
}
