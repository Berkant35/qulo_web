import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

enum GameCategory {
  sports,
  test,
  edu,
  entertainment,
  favorites,
  multiplayer;

  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case sports:
        return inst.game_category_sports;
      case edu:
        return inst.game_category_edu;
      case test:
        return inst.game_category_test;
      case entertainment:
        return inst.game_category_entertainment;
      case multiplayer:
        return inst.game_category_multiplayer;
      case favorites:
        return inst.game_category_favorites;
    }
  }
}
