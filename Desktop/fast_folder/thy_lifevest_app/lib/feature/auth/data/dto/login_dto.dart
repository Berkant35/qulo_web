


import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_dto.freezed.dart';
part 'login_dto.g.dart';


@freezed
abstract class LoginDto with _$LoginDto {
  const factory LoginDto({
    @JsonKey(name: 'thy_token')
    String? thyToken,
    @JsonKey(name: 'access_token')
    String? accessToken,
    @JsonKey(name: 'app_version')
    String? appVersion,
    @JsonKey(name: 'server_version')
    String? serverVersion,
  }) = _LoginDto;

  factory LoginDto.fromJson(Map<String, Object?> json) =>
      _$LoginDtoFromJson(json);
}
