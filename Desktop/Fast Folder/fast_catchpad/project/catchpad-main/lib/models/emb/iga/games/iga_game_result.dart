import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_game_result.freezed.dart';
part 'iga_game_result.g.dart';

@freezed
class IgaGameResult with _$IgaGameResult {
  const factory IgaGameResult(
      {
      // These parameters represents result of played game in iga.

      @JsonKey(name: 'igaGameResultId') String? igaGameResultId,

      // primary score mean option of catching pad time
      @JsonKey(name: 'primaryScore') double? primaryScore,
      // secondary score mean count of catched pad
      @JsonKey(name: 'secondaryScore') double? secondaryScore,

      // These parameters represents infos taken from IGA Register screen.
      @JsonKey(name: 'igaUsername') String? igaUsername,
      @JsonKey(name: 'igaUserCountry') String? igaUserCountry,
      @JsonKey(name: 'igaUserCountryCode') String? igaUserCountryCode,
      @JsonKey(name: 'igaUserId') String? igaUserId,
      @JsonKey(name: 'igaGameId') String? igaGameId,
      // location mean the pier where the pad is located
      @JsonKey(name: 'igaLocationId') String? igaLocationId,
      // time of document creating
      @JsonKey(name: 'createdAt') String? createdAt}) = _IgaGameResult;

  factory IgaGameResult.fromJson(Map<String, Object?> json) =>
      _$IgaGameResultFromJson(json);
}
