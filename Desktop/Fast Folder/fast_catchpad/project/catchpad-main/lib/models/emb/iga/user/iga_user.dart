import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'iga_user.freezed.dart';
part 'iga_user.g.dart';

@freezed
class IgaUser with _$IgaUser {
  const factory IgaUser({
    
    @JsonKey(name: 'igaUserId') String? igaUserId,
    @JsonKey(name: 'igaUserEmail') String? igaUserEmail,
    @JsonKey(name: 'igaUserName') String? igaUserName,
    @JsonKey(name: 'igaGameResultId') String? igaGameResultId,
    @JsonKey(name: 'igaUserCreatedAt') String? igaUserCreatedAt,
    @JsonKey(name: 'igaUserCountry') String? igaUserCountry,
    @JsonKey(name: 'igaUserCountryCode') String? igaUserCountryCode,
    @JsonKey(name: 'isDebugUser') bool? isDebugUser,
    @JsonKey(name: 'isEventUser') bool? isEventUser,
    @JsonKey(name: 'eventName') String? eventName,
  }) = _IgaUser;

  factory IgaUser.fromJson(Map<String, Object?> json) =>
      _$IgaUserFromJson(json);
}
