import 'dart:convert';

import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../prov/game/curr_game_prov.dart';
import '../../utils/utils.dart';
import '../enums/game/game_end_type.dart';
import '../enums/game/game_score_type.dart';
import 'game_model.dart';

part 'game_result_model.freezed.dart';
part 'game_result_model.g.dart';

String primaryScoreString = '';

_playersToJson(List<PlayerModel> players) =>
    List<Map<String, dynamic>>.from(players.map((x) => x.toJson()));

_playersFromJson(List json) {
  return List<PlayerModel>.from(
    json.map(
      (x) => PlayerModel.fromJson(x as Map<String, dynamic>),
    ),
  );
}

_playerResultsToJson(List<PlayerResultModel> playerResults) =>
    List<Map<String, dynamic>>.from(playerResults.map((x) => x.toJson()));

_playerResultsFromJson(List json) {
  return List<PlayerResultModel>.from(
    json.map(
      (x) => PlayerResultModel.fromJson(x as Map<String,
          dynamic>), // TODO Does this type change based on each game ??? Fix this
    ),
  );
}

DateTime date() => DateTime.now();

// we want to override
// toJson and fromJson,
// so we need to mute
// the freezed json annotations
// and rely on JsonSerializable
@Freezed(
  toJson: false,
  fromJson: false,
)
@JsonSerializable()
class GameResultModel with _$GameResultModel {
  GameResultModel._();

  factory GameResultModel({
    @JsonKey(required: true) required GameEndType type,
    @JsonKey(
      toJson: _playersToJson,
      fromJson: _playersFromJson,
    )
    @Default([])
    List<PlayerModel> players,
    @JsonKey(
      toJson: _playerResultsToJson,
      fromJson: _playerResultsFromJson,
    )
    @Default([])
    List<PlayerResultModel> playerResults,
    @JsonKey(required: true) required String gameId,
    @JsonKey(
      nullable: true,
      defaultValue: '',
    )
    required String? accountHolderId,

    // TODO: this should have a default constructor
    // DateTime.now(). there is a SO question about this
    // https://stackoverflow.com/questions/67866162/the-constructor-being-called-isnt-a-const-constructor-try-removing-const-fro
    // investigate and open an issue if necessary
    @JsonKey(nullable: true, name: 'createdAt') DateTime? createdAt,
    @JsonKey(
      required: true,
      nullable: false,
    )
    required GameScoreType scoreTypeParam1,
    @JsonKey(nullable: true) required GameScoreType? scoreTypeParam2,

    /// this will be calculated before converting
    /// to json, and read from json
    int? indexValue,

    /// this will be calculated before converting
    /// to json, and read from json
    String? winnerPlayerId,
  }) = _GameResultModel;

  String? indexValueStr(BuildContext context, {required bool convertMsToSec}) {
    if (indexValue == null) {
      return null;
    }

    if (scoreTypeParam1 == GameScoreType.averageDuration ||
        scoreTypeParam1 == GameScoreType.teamHarmony) {
      String zerostr = '';
      int inSec = (indexValue! / 1000).floor();
      int inMs = (indexValue! % 1000);
      if (inMs.toString().length == 2) {
        zerostr = '0';
      } else if (inMs.toString().length == 1) {
        zerostr = '00';
      }
      return '$inSec.$zerostr$inMs s';
    }
    if (scoreTypeParam1.isDescending) {
      if (convertMsToSec) {
        final indexV = indexValue!.msToSec;
        return indexV.sStr(context);
      } else {
        final indexVX = indexValue!;
        return indexVX.msTommssSSS(context);
      }
    }

    return '$indexValue';
  }

  static String? indexValueStrForHistory(
      BuildContext context, int? indexValue, GameScoreType scoreTypeParam1) {
    if (indexValue == null) {
      return '';
    }
    if (scoreTypeParam1 == GameScoreType.averageDuration) {
      int inSec = (indexValue / 1000).floor();
      int inMs = (indexValue % 1000);
      return '$inSec.$inMs s';
    }
    if (scoreTypeParam1.isDescending) {
      final indexV = indexValue.msToSec;

      return indexV.sStr(context);
    }

    return '$indexValue';
  }

  PlayerModel? get winnerPlayer {
    try {
      return players.firstWhere((x) => x.user?.uid == winnerPlayerId);
    } catch (e) {
      for (var x in players) {
        logger.d('player: $x');
        logger.d(x.user?.uid);
        logger.d(winnerPlayerId);
      }

      return null;
    }
  }

  //    players.firstWhere((element) => element.id == winnerPlayerId);

  /// if does not have results or players,
  /// or none of the players has a uid,
  /// then we will not store the game result
  bool get isValid {
    return players.isNotEmpty && playerResults.isNotEmpty;
  }

  factory GameResultModel.fromJson(Map<String, dynamic> json) {
    // initially, this field's name used to be 'scoreType',
    // but we changed it to 'scoreTypeParam1' and we already
    // have data in the database with the old name.
    json['scoreTypeParam1'] ??= json['scoreType'];
    json['scoreTypeParam2'] ??= json['scoreType'];

    var model = _$GameResultModelFromJson(json);

    model = model.copyWith(
      indexValue:
          Index._parseIndexValue(model.indexValue, model.scoreTypeParam1),
    );

    return model;
  }

  Future<pw.Page> toPdfPage(WidgetRef ref,
      {required AppLocalizations inst,
      required Map<String, Map<String, String?>> resultMaps,
      required String reviewText}) async {
    //Create Pdf Page From These results
    final game = ref.read(currentGameProv);
    final textCatchpadLogo =
        await rootBundle.load("assets/app_icon/text_logo_v2.png");
    final imageBytes = textCatchpadLogo.buffer.asUint8List();

    final screenShotOfImage = await ref
        .read(currentShareController.notifier)
        .capturedScreenShot(ref, ref.context);

    pw.Image? image1;

    if (screenShotOfImage != null && screenShotOfImage.isNotEmpty) {
      image1 = pw.Image(pw.MemoryImage(screenShotOfImage));
    }

    return pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              L10n.inst(ref.context).pdf_game_results_report,
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Divider(),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Screenshot image with conditional visibility
                if (screenShotOfImage != null && screenShotOfImage.isNotEmpty)
                  pw.Container(
                    height: 650,
                    child: image1,
                  ),
                pw.SizedBox(width: 10),
                // Notes column with padding for better layout
                pw.Expanded(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          L10n.inst(ref.context).pdf_notes,
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        // Adding space between title and text
                        pw.Text(
                          reviewText,
                          overflow: pw.TextOverflow.clip,
                          style: const pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<Excel?> toExcel(WidgetRef ref,
      {required AppLocalizations inst,
      required Map<String, Map<String, String?>> resultMaps,
      required String reviewText}) async {
    final excel = Excel.createExcel();
    final l10n = L10n.inst(ref.context);

    final dateTime = DateTime.now().nowTimeddMMyyyyHHmmss;

    excel.setDefaultSheet(dateTime);

    Sheet currentSheet = excel.sheets[excel.getDefaultSheet()]!;
    currentSheet.setDefaultColumnWidth(30);
    currentSheet.setDefaultRowHeight(30);




    int rowIndex = 0;

    // Title Bold
    currentSheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)
    ).value = TextCellValue(l10n.office_excel_title);

    rowIndex++;

    //Set Time
    currentSheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)
    ).value = TextCellValue(inst.util_time);

    currentSheet.cell(
      CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)
    ).value = TextCellValue(dateTime);


    resultMaps.forEach((key, value) {
      value.forEach((perKey, value) {
        if (value == null ||
            perKey == l10n.game_ui_graph ||
            perKey.contains("raw")) {
          return;
        }

        if (perKey == l10n.player_model) {
          final plResModel = PlayerResultModel.fromRawJson(value);
          rowIndex++;
          currentSheet
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: 0, rowIndex: rowIndex))
              .value = TextCellValue(inst.game_ui_chart_left_title);
          int scoreIndex = 0;
          for (var perScrPoint in plResModel.scorePoints!) {
            rowIndex++;
            scoreIndex++;
            currentSheet
                .cell(CellIndex.indexByColumnRow(
                    columnIndex: 0, rowIndex: rowIndex))
                .value = TextCellValue(scoreIndex.toString());

            currentSheet
                    .cell(CellIndex.indexByColumnRow(
                        columnIndex: 1, rowIndex: rowIndex))
                    .value =
                TextCellValue('${perScrPoint.duration.inMilliseconds}ms');
          }

          return;
        }

        rowIndex++;
        currentSheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex))
            .value = TextCellValue(perKey.toString());
        currentSheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
            .value = TextCellValue(value.replaceAll("s", "ms") ?? "-");
      });
    });

    // resultMaps.entries.map((e) {
    //   final result = e.value;
    //   logger.w("Per Entrie For Res $result");
    //   for (int i = 0; i < result.entries.length; i++) {
    //     final perMap = result.entries.elementAt(i);
    //     if(perMap.value != null){
    //       rowIndex++;
    //       currentSheet
    //           .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
    //           .value = TextCellValue(perMap.key.toString());
    //       currentSheet
    //           .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex))
    //           .value = TextCellValue(perMap.value!.toString());
    //     }
    //   }
    // });

    return excel;
  }

  pw.Row basicPdfInfo({required String title, required String content}) {
    return pw.Row(
      children: [
        pw.Paragraph(text: title),
        pw.Text(":"),
        pw.Paragraph(text: content),
      ],
    );
  }

  Map<String, dynamic> toJson() {
    final List<PlayerResultModel> newpresmodellist = [];
    for (var pres in playerResults) {
      newpresmodellist.add(pres);
    }
    if (scoreTypeParam1 != GameScoreType.teamHarmony) {
      for (var pres in players) {
        final scoreforplayer = _getIndexValueByPlayer(pres);
        final int index = newpresmodellist
            .indexOf(newpresmodellist.firstWhere((x) => x.playerId == pres.id));
        final newplayerres = newpresmodellist
            .firstWhere((element) => element.playerId == pres.id)
            .copyWith(
              indexValue: scoreforplayer,
            );
        newpresmodellist.removeAt(index);
        newpresmodellist.insert(index, newplayerres);
      }
    }

    /*  String? winnerplayerid;
    PlayerResultModel? winnerplayerres;
    PlayerModel? winnerplayer;

    if (scoreTypeParam1 == GameScoreType.averageDuration ||
        scoreTypeParam1 == GameScoreType.catchCount ||
        scoreTypeParam1 == GameScoreType.score) {
      scoreTypeParam1.isDescending
          ? newpresmodellist
              .sort((a, b) => a.indexValue!.compareTo(b.indexValue!))
          : newpresmodellist
              .sort((a, b) => b.indexValue!.compareTo(a.indexValue!));
      try {
        winnerplayerres = newpresmodellist.first;
        winnerplayerid = newpresmodellist.first.playerId;
        winnerplayer = players.firstWhere((x) => x.id == winnerplayerid);
      } catch (e) {
        logger.d(e.toString());
      }
    } */

    final e = copyWith(
      indexValue: /* winnerplayerres?.indexValue ??  */ getIndexValue,
      accountHolderId: accountHolderId,
      playerResults:
          newpresmodellist.isEmpty ? playerResults : newpresmodellist,
      winnerPlayerId: /* winnerplayer?.user?.uid ?? */
          calculateWinnerPlayer
              ?.user?.uid /* ??
          winnerplayer?.user?.userName */
      ,
    );

    final res = _$GameResultModelToJson(e);

    return res;
  }
}

extension Index on GameResultModel {
  /// here we're determining which
  /// player owns the indexScore,
  /// so we can show it in the leaderboard
  /// accordingly.
  /// e.g. the score of a competition game
  /// is 9 to 1, so we take the 9 and make
  /// the winnerPlayer the one with the 9
  PlayerModel? get calculateWinnerPlayer {
    PlayerModel? winner;

    int? best;

    for (var player in players) {
      final val = _getIndexValueByPlayer(player);

      if (val == null) {
        continue;
      }

      if (
          //
          (
                  //
                  best == null ||
                      // our default index type is ascending
                      val < best)
              //
              // we don't wanna reward player
              // that is not registered
              &&
              player.user?.uid != null
          //
          ) {
        best = val;
        winner = player;
      }
    }

    return winner;
  }

  /// our default index type is ascending
  /// (the lower the better, so values will be
  /// indexed from lowest to highest),
  /// so some of our values will have
  /// the system of descending (the higher the better).
  /// so what we gonna do here is simple x * -1 for
  /// the descending ones BEFORE toJson, and then
  /// x * -1 after fromJson
  static int? _parseIndexValue(int? val, GameScoreType type) {
    if (val == null) {
      return null;
    }

    const descendingTypes = [
      GameScoreType.score,
      GameScoreType.correctCount,
      GameScoreType.totalDistance,
      GameScoreType.averageDistance,
      GameScoreType.maxDistance,
      GameScoreType.minDistance,
      GameScoreType.level,
      GameScoreType.deviceCatchCount,
      GameScoreType.percentage
    ];

    if (descendingTypes.contains(type)) {
      return val * -1;
    }

    return val;
  }

  static int? parseIndexValue(int? val, GameScoreType type) {
    if (val == null) {
      return null;
    }

    const descendingTypes = [
      GameScoreType.score,
      GameScoreType.correctCount,
      GameScoreType.totalDistance,
      GameScoreType.averageDistance,
      GameScoreType.maxDistance,
      GameScoreType.minDistance,
      GameScoreType.level,
      GameScoreType.deviceCatchCount,
      GameScoreType.percentage
    ];

    if (descendingTypes.contains(type)) {
      return val * -1;
    }

    return val;
  }

  int? _indexValue(PlayerModel player) {
    if (playerResults.isEmpty) {
      return null;
    }
    PlayerResultModel pl;
    try {
      pl = playerResults.firstWhere((e) => e.playerId == player.id);
    } catch (e) {
      return null;
    }

    switch (scoreTypeParam1) {
      case GameScoreType.score:
        return pl.score;
      case GameScoreType.correctCount:
        return pl.correctCount;
      case GameScoreType.incorrectCount:
        return pl.incorrectCount;
      //
      case GameScoreType.totalDuration:
        return pl.totalDuration?.inMilliseconds;
      case GameScoreType.averageDuration:
        return pl.averageDuration?.inMilliseconds;
      case GameScoreType.maxDuration:
        return pl.maxDuration?.inMilliseconds;
      case GameScoreType.minDuration:
        return pl.minDuration?.inMilliseconds;
      //
      case GameScoreType.averageDistance:
        return pl.averageDistance;
      case GameScoreType.maxDistance:
        return pl.maxDistance;
      case GameScoreType.minDistance:
        return pl.minDistance;
      //
      case GameScoreType.level:
        return pl.level;
      case GameScoreType.teamHarmony:
        return pl.averageTeamHarmonyDuration?.inMilliseconds;
      case GameScoreType
            .deviceCatchCount: // TODO Fix it later or change the whole system for returning index value
        return int.tryParse(pl.deviceCatchCountforColors!);

      default:
        return null;
    }
  }

  int? _getIndexValueByPlayer(PlayerModel player) =>
      _parseIndexValue(_indexValue(player), scoreTypeParam1);

  int? get getIndexValue {
    PlayerModel? w = calculateWinnerPlayer;

    logger.i("Player Count: ${players.length.toString()}");

    if (w == null && players.isNotEmpty && players.length == 1) {
      w = players.first;
    }

    if (players.length > 1) {
      w = winnerPlayer;
    }

    if (w == null) {
      return null;
    }

    return _getIndexValueByPlayer(w);
  }
}

/// key val
typedef GameSinglePlayerResult = Map<String, String?>;

/// [
///  MapEntry(playerId, (playerResult => GameSinglePlayerResult))
/// ]
typedef GamePlayersResultsIterable
    = Iterable<MapEntry<String, GameSinglePlayerResult>>;

/// Map<playerId, (playerResult => GameSinglePlayerResult)>
typedef GameResultMap = Map<String, GameSinglePlayerResult>;

extension ResultMapExtender on GameResultModel {
  SinglePlayerListingCB get defaultSinglePlayerListing =>
      (context, gameResult, playerResult, player, ref) {
        final inst = L10n.inst(context);
        final game = ref.read(currentGameProv);
        int? totalDuration = game?.setup.duration?.def;

        primaryScoreString = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam1, inst,
            isPrimary: true, isTitle: true);
        String? primaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam1, inst,
            isPrimary: true);
        String? primaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam1, inst,
            isPrimary: true, isRaw: true);
        Map<String, String?>? secondaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam2, inst);
        Map<String, String?>? secondaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam2, inst,
            isRaw: true);
        Map<String, String?>? tertiaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam3, inst);
        Map<String, String?>? tertiaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam3, inst,
            isRaw: true);
        Map<String, String?>? quaternaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam4, inst);
        Map<String, String?>? quaternaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam4, inst,
            isRaw: true);
        Map<String, String?>? quinaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam5, inst);
        Map<String, String?>? quinaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam5, inst,
            isRaw: true);
        Map<String, String?>? senaryScore = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam6, inst);
        Map<String, String?>? senaryScoreRaw = valueReturnerForScoreType(
            context, playerResult, game?.setup.scoreTypeParam6, inst,
            isRaw: true);
        Map<String, dynamic>? graphSpots;
        if (playerResult.graphSpots.isNotEmpty) {
          graphSpots = spotToJson(playerResult.graphSpots);
        }
        //game.setup.scoreTypeParam1;
        String? pName =
            (player.user != null) ? player.user?.userName : player.playerName;
        return {
          if (pName != null) inst.player_name: pName,
          if (primaryScore != null)
            inst.activity_default_scores_total_score: primaryScore,
          if (primaryScoreRaw != null)
            inst.activity_default_scores_total_score + 'raw': primaryScoreRaw,
          if (secondaryScore != null)
            secondaryScore.entries.first.key:
                secondaryScore.entries.first.value,
          if (secondaryScoreRaw != null)
            secondaryScoreRaw.entries.first.key:
                secondaryScoreRaw.entries.first.value,
          if (tertiaryScore != null)
            tertiaryScore.entries.first.key: tertiaryScore.entries.first.value,
          if (tertiaryScoreRaw != null)
            tertiaryScoreRaw.entries.first.key:
                tertiaryScoreRaw.entries.first.value,
          if (quaternaryScore != null)
            quaternaryScore.entries.first.key:
                quaternaryScore.entries.first.value,
          if (quaternaryScoreRaw != null)
            quaternaryScoreRaw.entries.first.key:
                quaternaryScoreRaw.entries.first.value,
          if (quinaryScore != null)
            quinaryScore.entries.first.key: quinaryScore.entries.first.value,
          if (quinaryScoreRaw != null)
            quinaryScoreRaw.entries.first.key:
                quinaryScoreRaw.entries.first.value,
          if (senaryScore != null)
            senaryScore.entries.first.key: senaryScore.entries.first.value,
          if (senaryScoreRaw != null)
            senaryScoreRaw.entries.first.key:
                senaryScoreRaw.entries.first.value,
          if (playerResult.graphSpots.isNotEmpty && graphSpots != null)
            inst.game_ui_graph: json.encode(graphSpots),
          if (playerResult.graphSpots.isNotEmpty && graphSpots != null)
            inst.activity_result_screen_total_hits:
                '${(playerResult.correctCount ?? 0) + (playerResult.incorrectCount ?? 0)}',
          if (totalDuration != null)
            inst.activity_default_scores_total_duration:
                totalDuration.toString(),
          inst.player_model: playerResult.toRawJson(),
        };
      };

  dynamic valueReturnerForScoreType(
      BuildContext context,
      PlayerResultModel playerResult,
      GameScoreType? type,
      AppLocalizations inst,
      {bool isPrimary = false,
      bool isRaw = false,
      bool isTitle = false}) {
    switch (type) {
      case GameScoreType.score:
        if (isPrimary) {
          if (isRaw) {
            return ((playerResult.correctCount ?? 0) -
                    (playerResult.incorrectCount ?? 0))
                .toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_catch_count;
          }
          return "${(playerResult.correctCount ?? 0)}-${(playerResult.incorrectCount ?? 0)}";
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_catch_count + 'raw':
                ((playerResult.correctCount ?? 0) -
                        (playerResult.incorrectCount ?? 0))
                    .toString()
          };
        }
        return {
          inst.activity_default_scores_catch_count:
              "${(playerResult.correctCount ?? 0)}-${(playerResult.incorrectCount ?? 0)}"
        };
      case GameScoreType.averageDistance:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.averageDistanceCm?.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_average_distance;
          }
          return playerResult.averageDistanceCm?.cmStr(context);
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_average_distance + 'raw':
                playerResult.averageDistanceCm?.toString()
          };
        }
        return {
          inst.activity_default_scores_average_distance:
              playerResult.averageDistanceCm?.cmStr(context)
        };
      case GameScoreType.maxDistance:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.maxDistanceCm?.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_max_distance;
          }
          return playerResult.maxDistanceCm?.cmStr(context);
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_max_distance + 'raw':
                playerResult.maxDistanceCm?.toString()
          };
        }
        return {
          inst.activity_default_scores_max_distance:
              playerResult.maxDistanceCm?.cmStr(context)
        };
      case GameScoreType.minDistance:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.minDistanceCm?.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_max_distance;
          }
          return playerResult.minDistanceCm?.cmStr(context);
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_max_distance + 'raw':
                playerResult.minDistanceCm?.toString()
          };
        }
        return {
          inst.activity_default_scores_max_distance:
              playerResult.minDistanceCm?.cmStr(context)
        };
      case GameScoreType.totalDuration:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.totalDuration?.inMilliseconds.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_total_duration;
          }
          return playerResult.totalDuration
              ?.formatSecondsMilli(context)
              .toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_total_duration + 'raw':
                playerResult.totalDuration?.inMilliseconds.toString()
          };
        }

        return {
          inst.activity_default_scores_total_duration:
              playerResult.totalDuration?.formatSecondsMilli(context).toString()
        };
      case GameScoreType.averageDuration:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.averageDuration?.inMilliseconds.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_average_duration;
          }
          return playerResult.averageDuration
              ?.formatSecondsMilli(context)
              .toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_average_duration + 'raw':
                playerResult.averageDuration?.inMilliseconds.toString()
          };
        }
        return {
          inst.activity_default_scores_average_duration: playerResult
              .averageDuration
              ?.formatSecondsMilli(context)
              .toString()
        };

      case GameScoreType.maxDuration:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.maxDuration?.inMilliseconds.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_maximum_duration;
          }
          return playerResult.maxDuration
              ?.formatSecondsMilli(context)
              .toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_maximum_duration + 'raw':
                playerResult.maxDuration.toString()
          };
        }
        return {
          inst.activity_default_scores_maximum_duration:
              playerResult.maxDuration?.formatSecondsMilli(context).toString()
        };
      case GameScoreType.minDuration:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.minDuration?.inMilliseconds.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_minimum_duration;
          }
          return playerResult.minDuration
              ?.formatSecondsMilli(context)
              .toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_minimum_duration + 'raw':
                playerResult.minDuration.toString()
          };
        }
        return {
          inst.activity_default_scores_minimum_duration:
              playerResult.minDuration?.formatSecondsMilli(context).toString()
        };
      case GameScoreType.correctCount:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.correctCount.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_correct_count;
          }
          return playerResult.correctCount.toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_correct_count + 'raw':
                playerResult.correctCount.toString()
          };
        }
        return {
          inst.activity_default_scores_correct_count:
              playerResult.correctCount.toString()
        };
      case GameScoreType.incorrectCount:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.incorrectCount.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_incorrect_count;
          }
          return playerResult.incorrectCount.toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_incorrect_count + 'raw':
                playerResult.incorrectCount.toString()
          };
        }
        return {
          inst.activity_default_scores_incorrect_count:
              playerResult.incorrectCount.toString()
        };
      case GameScoreType.deviceCatchCount:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.deviceCatchCountforColors.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_catch_count_for_every_color;
          }
          return playerResult.deviceCatchCountforColors.toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_catch_count_for_every_color + 'raw':
                playerResult.deviceCatchCountforColors.toString()
          };
        }
        return {
          inst.activity_default_scores_catch_count_for_every_color:
              playerResult.deviceCatchCountforColors.toString()
        };
      case GameScoreType.level:
        if (isPrimary) {
          if (isRaw) {
            return playerResult.level.toString();
          }
          if (isTitle) {
            return inst.activity_default_scores_level;
          }
          return playerResult.level.toString();
        }
        if (isRaw) {
          return {
            inst.activity_default_scores_level + 'raw':
                playerResult.level.toString()
          };
        }
        return {
          inst.activity_default_scores_level: playerResult.level.toString()
        };
      case GameScoreType.teamHarmony:
        if (isRaw) {
          return playerResult.averageTeamHarmonyDuration?.inMilliseconds
              .toString();
        }
        return playerResult.averageTeamHarmonyDuration
            ?.formatSecondsMilli(context);
      case GameScoreType.none:
        return null;
      default:
        return null;
    }
  }

  /// maps the user id to the result map
  GameResultMap resultsMap(BuildContext context,
      SinglePlayerListingCB singlePlayerListingCb, WidgetRef ref) {
    final inst = L10n.inst(context);
    var ent = playerResults.map(
      (playerResult) {
        if (playerResult.userName != null) {}
        if (playerResult.userName == inst.mentor_controls_state_mentor) {
          final map = singlePlayerListingCb(context, this, playerResult,
              PlayerModel(id: 'mentor', createdAt: DateTime.now()), ref);
          return MapEntry('mentor', map);
        }
        final id = playerResult.playerId;

        final player = players.firstWhere((p) => p.id == id);

        final map =
            singlePlayerListingCb(context, this, playerResult, player, ref);

        return MapEntry(id, map);
      },
    ).toList();
    String? getSecondaryScore(GameScoreType? secondary) {
      switch (secondary) {
        case GameScoreType.averageDuration:
          return inst.activity_default_scores_average_duration;
        case GameScoreType.correctCount:
          return inst.activity_default_scores_catch_count;
        case GameScoreType.score:
          return inst.activity_default_scores_catch_count;

        default:
          return null;
      }
    }

    try {
      final game = ref.read(currentGameProv);
      final secondaryScore = game?.setup.scoreTypeParam2;
      if (game?.getScoreType == GameScoreType.averageDuration) {
        ent.sort((a, b) {
          if (a.value[inst.activity_default_scores_total_score] ==
                  b.value[inst.activity_default_scores_total_score] &&
              getSecondaryScore(secondaryScore) != null) {
            return b.value[inst.activity_default_scores_catch_count]!
                .compareTo(a.value[inst.activity_default_scores_catch_count]!);
          }
          return a.value[inst.activity_default_scores_total_score]!
              .compareTo(b.value[inst.activity_default_scores_total_score]!);
        });
      } else if (game?.getScoreType == GameScoreType.totalDuration) {
        ent.sort((a, b) {
          return b.value[inst.activity_default_scores_total_duration]!
              .compareTo(a.value[inst.activity_default_scores_total_duration]!);
        });
      } else {
        ent.sort((a, b) {
          if (a.value[inst.activity_default_scores_total_score] ==
                  b.value[inst.activity_default_scores_total_score] &&
              getSecondaryScore(secondaryScore) != null) {
            return a.value[inst.activity_default_scores_average_duration]!
                .compareTo(
                    b.value[inst.activity_default_scores_average_duration]!);
          }
          return b.value[inst.activity_default_scores_total_score]!
              .compareTo(a.value[inst.activity_default_scores_total_score]!);
        });
      }
    } catch (e) {
      logger.d(e.toString());
    }
    return Map.fromEntries(ent);
  }
}
