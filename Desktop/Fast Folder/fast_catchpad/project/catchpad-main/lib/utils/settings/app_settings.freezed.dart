// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  bool get firstEntering => throw _privateConstructorUsedError;
  bool get registered => throw _privateConstructorUsedError;
  LanguageModel? get language => throw _privateConstructorUsedError;
  AudioSettings get audioSettings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {bool firstEntering,
      bool registered,
      LanguageModel? language,
      AudioSettings audioSettings});

  $LanguageModelCopyWith<$Res>? get language;
  $AudioSettingsCopyWith<$Res> get audioSettings;
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstEntering = null,
    Object? registered = null,
    Object? language = freezed,
    Object? audioSettings = null,
  }) {
    return _then(_value.copyWith(
      firstEntering: null == firstEntering
          ? _value.firstEntering
          : firstEntering // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as LanguageModel?,
      audioSettings: null == audioSettings
          ? _value.audioSettings
          : audioSettings // ignore: cast_nullable_to_non_nullable
              as AudioSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LanguageModelCopyWith<$Res>? get language {
    if (_value.language == null) {
      return null;
    }

    return $LanguageModelCopyWith<$Res>(_value.language!, (value) {
      return _then(_value.copyWith(language: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AudioSettingsCopyWith<$Res> get audioSettings {
    return $AudioSettingsCopyWith<$Res>(_value.audioSettings, (value) {
      return _then(_value.copyWith(audioSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AppSettingsCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$_AppSettingsCopyWith(
          _$_AppSettings value, $Res Function(_$_AppSettings) then) =
      __$$_AppSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool firstEntering,
      bool registered,
      LanguageModel? language,
      AudioSettings audioSettings});

  @override
  $LanguageModelCopyWith<$Res>? get language;
  @override
  $AudioSettingsCopyWith<$Res> get audioSettings;
}

/// @nodoc
class __$$_AppSettingsCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$_AppSettings>
    implements _$$_AppSettingsCopyWith<$Res> {
  __$$_AppSettingsCopyWithImpl(
      _$_AppSettings _value, $Res Function(_$_AppSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstEntering = null,
    Object? registered = null,
    Object? language = freezed,
    Object? audioSettings = null,
  }) {
    return _then(_$_AppSettings(
      firstEntering: null == firstEntering
          ? _value.firstEntering
          : firstEntering // ignore: cast_nullable_to_non_nullable
              as bool,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as LanguageModel?,
      audioSettings: null == audioSettings
          ? _value.audioSettings
          : audioSettings // ignore: cast_nullable_to_non_nullable
              as AudioSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppSettings extends _AppSettings with DiagnosticableTreeMixin {
  const _$_AppSettings(
      {this.firstEntering = true,
      this.registered = false,
      this.language,
      this.audioSettings = const AudioSettings(
          isMusicEnabled: true, isSoundEffectsEnabled: true)})
      : super._();

  factory _$_AppSettings.fromJson(Map<String, dynamic> json) =>
      _$$_AppSettingsFromJson(json);

  @override
  @JsonKey()
  final bool firstEntering;
  @override
  @JsonKey()
  final bool registered;
  @override
  final LanguageModel? language;
  @override
  @JsonKey()
  final AudioSettings audioSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppSettings(firstEntering: $firstEntering, registered: $registered, language: $language, audioSettings: $audioSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppSettings'))
      ..add(DiagnosticsProperty('firstEntering', firstEntering))
      ..add(DiagnosticsProperty('registered', registered))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('audioSettings', audioSettings));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppSettings &&
            (identical(other.firstEntering, firstEntering) ||
                other.firstEntering == firstEntering) &&
            (identical(other.registered, registered) ||
                other.registered == registered) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.audioSettings, audioSettings) ||
                other.audioSettings == audioSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, firstEntering, registered, language, audioSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppSettingsCopyWith<_$_AppSettings> get copyWith =>
      __$$_AppSettingsCopyWithImpl<_$_AppSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppSettingsToJson(
      this,
    );
  }
}

abstract class _AppSettings extends AppSettings {
  const factory _AppSettings(
      {final bool firstEntering,
      final bool registered,
      final LanguageModel? language,
      final AudioSettings audioSettings}) = _$_AppSettings;
  const _AppSettings._() : super._();

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$_AppSettings.fromJson;

  @override
  bool get firstEntering;
  @override
  bool get registered;
  @override
  LanguageModel? get language;
  @override
  AudioSettings get audioSettings;
  @override
  @JsonKey(ignore: true)
  _$$_AppSettingsCopyWith<_$_AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
