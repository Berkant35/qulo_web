// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'audio_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AudioSettings _$AudioSettingsFromJson(Map<String, dynamic> json) {
  return _AudioSettings.fromJson(json);
}

/// @nodoc
mixin _$AudioSettings {
  bool? get isMusicEnabled => throw _privateConstructorUsedError;
  bool? get isSoundEffectsEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioSettingsCopyWith<AudioSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioSettingsCopyWith<$Res> {
  factory $AudioSettingsCopyWith(
          AudioSettings value, $Res Function(AudioSettings) then) =
      _$AudioSettingsCopyWithImpl<$Res, AudioSettings>;
  @useResult
  $Res call({bool? isMusicEnabled, bool? isSoundEffectsEnabled});
}

/// @nodoc
class _$AudioSettingsCopyWithImpl<$Res, $Val extends AudioSettings>
    implements $AudioSettingsCopyWith<$Res> {
  _$AudioSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMusicEnabled = freezed,
    Object? isSoundEffectsEnabled = freezed,
  }) {
    return _then(_value.copyWith(
      isMusicEnabled: freezed == isMusicEnabled
          ? _value.isMusicEnabled
          : isMusicEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSoundEffectsEnabled: freezed == isSoundEffectsEnabled
          ? _value.isSoundEffectsEnabled
          : isSoundEffectsEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioSettingsCopyWith<$Res>
    implements $AudioSettingsCopyWith<$Res> {
  factory _$$_AudioSettingsCopyWith(
          _$_AudioSettings value, $Res Function(_$_AudioSettings) then) =
      __$$_AudioSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? isMusicEnabled, bool? isSoundEffectsEnabled});
}

/// @nodoc
class __$$_AudioSettingsCopyWithImpl<$Res>
    extends _$AudioSettingsCopyWithImpl<$Res, _$_AudioSettings>
    implements _$$_AudioSettingsCopyWith<$Res> {
  __$$_AudioSettingsCopyWithImpl(
      _$_AudioSettings _value, $Res Function(_$_AudioSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isMusicEnabled = freezed,
    Object? isSoundEffectsEnabled = freezed,
  }) {
    return _then(_$_AudioSettings(
      isMusicEnabled: freezed == isMusicEnabled
          ? _value.isMusicEnabled
          : isMusicEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSoundEffectsEnabled: freezed == isSoundEffectsEnabled
          ? _value.isSoundEffectsEnabled
          : isSoundEffectsEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioSettings extends _AudioSettings {
  const _$_AudioSettings({this.isMusicEnabled, this.isSoundEffectsEnabled})
      : super._();

  factory _$_AudioSettings.fromJson(Map<String, dynamic> json) =>
      _$$_AudioSettingsFromJson(json);

  @override
  final bool? isMusicEnabled;
  @override
  final bool? isSoundEffectsEnabled;

  @override
  String toString() {
    return 'AudioSettings(isMusicEnabled: $isMusicEnabled, isSoundEffectsEnabled: $isSoundEffectsEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioSettings &&
            (identical(other.isMusicEnabled, isMusicEnabled) ||
                other.isMusicEnabled == isMusicEnabled) &&
            (identical(other.isSoundEffectsEnabled, isSoundEffectsEnabled) ||
                other.isSoundEffectsEnabled == isSoundEffectsEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isMusicEnabled, isSoundEffectsEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioSettingsCopyWith<_$_AudioSettings> get copyWith =>
      __$$_AudioSettingsCopyWithImpl<_$_AudioSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AudioSettingsToJson(
      this,
    );
  }
}

abstract class _AudioSettings extends AudioSettings {
  const factory _AudioSettings(
      {final bool? isMusicEnabled,
      final bool? isSoundEffectsEnabled}) = _$_AudioSettings;
  const _AudioSettings._() : super._();

  factory _AudioSettings.fromJson(Map<String, dynamic> json) =
      _$_AudioSettings.fromJson;

  @override
  bool? get isMusicEnabled;
  @override
  bool? get isSoundEffectsEnabled;
  @override
  @JsonKey(ignore: true)
  _$$_AudioSettingsCopyWith<_$_AudioSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
