import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum GameBadgeTypes {
  beta,
  newGame,
  none;

  Color get getBadgeColor {
    switch (this) {
      case GameBadgeTypes.beta:
        return CpColors.blue;
      case GameBadgeTypes.newGame:
        return CpColors.red;
      case GameBadgeTypes.none:
        return Colors.transparent;
    }
  }

  // get name with localization
  String getNameLocalization(AppLocalizations l10n) {
    switch (this) {
      case GameBadgeTypes.beta:
        return l10n.game_badge_types_beta;
      case GameBadgeTypes.newGame:
        return l10n.game_badge_types_new_game;
      case GameBadgeTypes.none:
        return '';
    }
  }
}
