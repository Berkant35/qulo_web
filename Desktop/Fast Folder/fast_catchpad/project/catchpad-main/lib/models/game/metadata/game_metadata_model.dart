// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../managers/asset_manager.dart';
import '../../enums/game/game_badge_types.dart';
import '../../num_range.dart';
import '../game_result_model.dart';
import '../player/player_model.dart';
import '../player_result_model.dart';
import 'game_category.dart';
import 'game_earning.dart';
import 'game_tag.dart';

export '../../num_range.dart';
// so the importers can use the
// extensions defined in that file
export '../player_result_model.dart';
export 'game_category.dart';
export 'game_earning.dart';
export 'game_tag.dart';

part 'game_metadata_model.freezed.dart';
part 'game_metadata_model.g.dart';

typedef SinglePlayerListingCB = GameSinglePlayerResult Function(
  BuildContext context,
  GameResultModel gameResult,
  PlayerResultModel playerResult,
  PlayerModel player,
  WidgetRef ref,
);

typedef IgaTextSpans = List<List<TextSpan>>;

@freezed

/// `playerCount` and `padCount` exist in this class and also in
/// the `StaticGameSetupModel` class, as we're gonna copy them from
/// here to the `StaticGameSetupModel` class, as it will use them to
/// determine if enough pads are connected and how many players to force
/// to fill.
class GameMetaDataModel with _$GameMetaDataModel {
  factory GameMetaDataModel({
    required String id,
    required String name,
    required String description,
    required String imagePath,
    String? primaryScoreString,
    //
    required List<GameEarning> earnings,
    required GameTag tag,

    /// [isContainOnIga] if you want active iga conditions you
    /// must look first to this parameter and then of course you must look
    /// [currentEmbModeManager].This state must be 1
    @Default(false) bool isContainOnIga,

    String? inGameIgaHeader,

    /// [igaTextSpans] This parameter created for special explain to customer at IGA.
    /// So you can change by this parameter what you want show on platform screen
    @Default([]) @JsonKey(ignore: true) IgaTextSpans igaTextSpans,
    @Default([]) @JsonKey(ignore: true) IgaTextSpans igaCountDownTextSpans,
    @Default([]) @JsonKey(ignore: true) IgaTextSpans igaIngGameTextSpans,
    @Default(false) @JsonKey(ignore: true) bool igaPickColor,
    @Default(false) @JsonKey(ignore: true) bool igaMultiplePickColor,
    @Default(GameBadgeTypes.none) GameBadgeTypes badgeType,

    /// the int key is the priority index of the category.
    /// so if this game has 2 of [GameCategory.multiplayer]
    /// and other has 1 of [GameCategory.multiplayer],
    /// the other will be the first one in the list.
    /// the value may be null, indicating that this
    /// should be in the last position.
    required Map<GameCategory, int?> categories,
    //
    required NumRange playerCount,


    /// This parameter help to define how many color count per player

    /// this parameter shows how much could add pad count which game
    NumRange? gamePadCount,

    /// the min of this has to be the min for
    /// min player count. e.g. min player count
    /// is 2, and min 2 pads for each player,
    /// then min pad count is 4. and when the
    /// user adds a 3rd player, we'll force them
    /// to have at least 6 pads.
    required NumRange padCount,

    /// the values are in seconds
    NumRange? duration,

    /// Is there any delay between pad leds like games in formula?
    /// default delay value is 2 seconds
    NumRange? delay,

    /// the values are in milliseconds, so we have to use
    /// NumRange.distanceCm on this one as our excel values
    /// are in centimeters.
    NumRange? distance,

    /// the values are in seconds. And sometimes we need define open light time.
    /// So we can help this parameter.
    NumRange? timeout,

    /// Sensitivty for motion games
    /// assign radius value for pads
    NumRange? radius,
    NumRange? vibrationRadius,


    /// this method will give you each result of each player in the
    /// game and let you be responsible to provide key value pairs
    /// for the results of this player.
    /// the output of this will be displayed to the user in a post
    /// game score dialog and in the leaderboard.
    ///
    /// leaving this null will result in the score disaplaying
    /// [GameResultModel.resultsMap]
    ///
    /// if [allResultsListing] is specified, then this will be ignored.
    ///
    /// for now we're making this an unserializable thing, but in the
    /// future when we wanna support fetching metadata from the server,
    /// this can be converted to a map with:
    ///   key: the title of that value localized to the app's language
    ///   value: an enum of the type of the value, and the value should
    ///          be retrieved accordingly.
    ///   example:
    ///   ```dart
    ///   {
    ///     'Player Name': PlayerResultType.playerName,
    ///   }
    ///   ```
    ///
    ///
    /// here is a valid usage example of this:
    /// ```dart
    /// (context, results, result, player) {
    ///   final inst = L10n.inst(context);
    ///
    ///   final map = <String, String?>{
    ///     if (player.playerName != null)
    ///       inst.activity_default_scores_name: player.playerName?.toString(),
    ///     inst.activity_default_scores_total_duration:
    ///         e.totalDuration?.formatSecondsMilli(context).toString(),
    ///   };
    ///
    ///   return map;
    /// };
    /// ```
    ///
    @JsonKey(ignore: true) SinglePlayerListingCB? singlePlayerListing,
    //
  }) = _GameMetaDataModel;

  const GameMetaDataModel._();

  String get fullImgPath => AssetManager.getImgPath(
        'games/$imagePath.jpeg',
      );
  String get verticalFullImgPath => AssetManager.getImgPath(
    'games/vertical_$imagePath.jpeg',
  );

  factory GameMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$GameMetaDataModelFromJson(json);
  // Map<String, dynamic> toJson() => _$GameMetaDataModelToJson(this);
}
