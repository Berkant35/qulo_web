// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginDto {

@JsonKey(name: 'thy_token') String? get thyToken;@JsonKey(name: 'access_token') String? get accessToken;@JsonKey(name: 'app_version') String? get appVersion;@JsonKey(name: 'server_version') String? get serverVersion;
/// Create a copy of LoginDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginDtoCopyWith<LoginDto> get copyWith => _$LoginDtoCopyWithImpl<LoginDto>(this as LoginDto, _$identity);

  /// Serializes this LoginDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginDto&&(identical(other.thyToken, thyToken) || other.thyToken == thyToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.serverVersion, serverVersion) || other.serverVersion == serverVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thyToken,accessToken,appVersion,serverVersion);

@override
String toString() {
  return 'LoginDto(thyToken: $thyToken, accessToken: $accessToken, appVersion: $appVersion, serverVersion: $serverVersion)';
}


}

/// @nodoc
abstract mixin class $LoginDtoCopyWith<$Res>  {
  factory $LoginDtoCopyWith(LoginDto value, $Res Function(LoginDto) _then) = _$LoginDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'thy_token') String? thyToken,@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'app_version') String? appVersion,@JsonKey(name: 'server_version') String? serverVersion
});




}
/// @nodoc
class _$LoginDtoCopyWithImpl<$Res>
    implements $LoginDtoCopyWith<$Res> {
  _$LoginDtoCopyWithImpl(this._self, this._then);

  final LoginDto _self;
  final $Res Function(LoginDto) _then;

/// Create a copy of LoginDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? thyToken = freezed,Object? accessToken = freezed,Object? appVersion = freezed,Object? serverVersion = freezed,}) {
  return _then(_self.copyWith(
thyToken: freezed == thyToken ? _self.thyToken : thyToken // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LoginDto implements LoginDto {
  const _LoginDto({@JsonKey(name: 'thy_token') this.thyToken, @JsonKey(name: 'access_token') this.accessToken, @JsonKey(name: 'app_version') this.appVersion, @JsonKey(name: 'server_version') this.serverVersion});
  factory _LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);

@override@JsonKey(name: 'thy_token') final  String? thyToken;
@override@JsonKey(name: 'access_token') final  String? accessToken;
@override@JsonKey(name: 'app_version') final  String? appVersion;
@override@JsonKey(name: 'server_version') final  String? serverVersion;

/// Create a copy of LoginDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginDtoCopyWith<_LoginDto> get copyWith => __$LoginDtoCopyWithImpl<_LoginDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginDto&&(identical(other.thyToken, thyToken) || other.thyToken == thyToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.serverVersion, serverVersion) || other.serverVersion == serverVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thyToken,accessToken,appVersion,serverVersion);

@override
String toString() {
  return 'LoginDto(thyToken: $thyToken, accessToken: $accessToken, appVersion: $appVersion, serverVersion: $serverVersion)';
}


}

/// @nodoc
abstract mixin class _$LoginDtoCopyWith<$Res> implements $LoginDtoCopyWith<$Res> {
  factory _$LoginDtoCopyWith(_LoginDto value, $Res Function(_LoginDto) _then) = __$LoginDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'thy_token') String? thyToken,@JsonKey(name: 'access_token') String? accessToken,@JsonKey(name: 'app_version') String? appVersion,@JsonKey(name: 'server_version') String? serverVersion
});




}
/// @nodoc
class __$LoginDtoCopyWithImpl<$Res>
    implements _$LoginDtoCopyWith<$Res> {
  __$LoginDtoCopyWithImpl(this._self, this._then);

  final _LoginDto _self;
  final $Res Function(_LoginDto) _then;

/// Create a copy of LoginDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? thyToken = freezed,Object? accessToken = freezed,Object? appVersion = freezed,Object? serverVersion = freezed,}) {
  return _then(_LoginDto(
thyToken: freezed == thyToken ? _self.thyToken : thyToken // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
