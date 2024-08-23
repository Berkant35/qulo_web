import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_game_info.freezed.dart';
part 'iga_game_info.g.dart';

@freezed
class IgaGameInfo with _$IgaGameInfo {
  const factory IgaGameInfo({
    @JsonKey(name: 'igaGameId') String? igaGameId,
    
    // primary score mean option of catching pad time
    @JsonKey(name: 'primaryAverage') double? primaryAverage,
    @JsonKey(name: "igaLastGameId") String? igaLastGameId,
    
    // secondary score mean count of catched pad
    @JsonKey(name: 'secondaryAverage') double? secondaryAverage,
    @JsonKey(name: 'gameCount') int? gameCount,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _IgaGameInfo;

  factory IgaGameInfo.fromJson(Map<String, Object?> json) =>
      _$IgaGameInfoFromJson(json);
}
