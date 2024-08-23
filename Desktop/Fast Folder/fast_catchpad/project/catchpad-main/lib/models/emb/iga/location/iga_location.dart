import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_location.freezed.dart';
part 'iga_location.g.dart';

@freezed
class IgaLocation with _$IgaLocation {
  const factory IgaLocation({
    @JsonKey(name: 'igaLocationId') String? igaLocationId,
    @JsonKey(name: 'igaLocationName') String? igaLocationName,
    @JsonKey(name: 'periodFiveBatteryInfo') int? periodFiveBatteryInfo,
    @JsonKey(name: 'allPadOk') bool? allPadOk,
    @JsonKey(name: 'igaLocationGameCount') int? igaLocationGameCount,
    @JsonKey(name: 'igaLocationPhoneId') String? igaLocationPhoneId,
    @JsonKey(name: 'igaLastGameId') String? igaLastGameId,
    @JsonKey(name: 'igaLastGameInfoId') String? igaLastGameInfoId,
    @JsonKey(name: 'igaChatBotClickCounter') int? igaChatBotClickCounter,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
  }) = _IgaLocation;

  factory IgaLocation.fromJson(Map<String, Object?> json) =>
      _$IgaLocationFromJson(json);
}
