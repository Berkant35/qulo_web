// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pad_ota_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadOtaConfig _$PadOtaConfigFromJson(Map<String, dynamic> json) {
  return _PadOtaConfig.fromJson(json);
}

/// @nodoc
mixin _$PadOtaConfig {
  @JsonKey(name: 'currentVersionGithubLink')
  String? get currentVersionGithubLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'oldVersionGithubLink')
  String? get oldVersionGithubLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'requireUpdate')
  bool? get requireUpdate => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  String? get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadOtaConfigCopyWith<PadOtaConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadOtaConfigCopyWith<$Res> {
  factory $PadOtaConfigCopyWith(
          PadOtaConfig value, $Res Function(PadOtaConfig) then) =
      _$PadOtaConfigCopyWithImpl<$Res, PadOtaConfig>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currentVersionGithubLink')
      String? currentVersionGithubLink,
      @JsonKey(name: 'oldVersionGithubLink') String? oldVersionGithubLink,
      @JsonKey(name: 'requireUpdate') bool? requireUpdate,
      @JsonKey(name: 'version') String? version});
}

/// @nodoc
class _$PadOtaConfigCopyWithImpl<$Res, $Val extends PadOtaConfig>
    implements $PadOtaConfigCopyWith<$Res> {
  _$PadOtaConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVersionGithubLink = freezed,
    Object? oldVersionGithubLink = freezed,
    Object? requireUpdate = freezed,
    Object? version = freezed,
  }) {
    return _then(_value.copyWith(
      currentVersionGithubLink: freezed == currentVersionGithubLink
          ? _value.currentVersionGithubLink
          : currentVersionGithubLink // ignore: cast_nullable_to_non_nullable
              as String?,
      oldVersionGithubLink: freezed == oldVersionGithubLink
          ? _value.oldVersionGithubLink
          : oldVersionGithubLink // ignore: cast_nullable_to_non_nullable
              as String?,
      requireUpdate: freezed == requireUpdate
          ? _value.requireUpdate
          : requireUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PadOtaConfigCopyWith<$Res>
    implements $PadOtaConfigCopyWith<$Res> {
  factory _$$_PadOtaConfigCopyWith(
          _$_PadOtaConfig value, $Res Function(_$_PadOtaConfig) then) =
      __$$_PadOtaConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currentVersionGithubLink')
      String? currentVersionGithubLink,
      @JsonKey(name: 'oldVersionGithubLink') String? oldVersionGithubLink,
      @JsonKey(name: 'requireUpdate') bool? requireUpdate,
      @JsonKey(name: 'version') String? version});
}

/// @nodoc
class __$$_PadOtaConfigCopyWithImpl<$Res>
    extends _$PadOtaConfigCopyWithImpl<$Res, _$_PadOtaConfig>
    implements _$$_PadOtaConfigCopyWith<$Res> {
  __$$_PadOtaConfigCopyWithImpl(
      _$_PadOtaConfig _value, $Res Function(_$_PadOtaConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentVersionGithubLink = freezed,
    Object? oldVersionGithubLink = freezed,
    Object? requireUpdate = freezed,
    Object? version = freezed,
  }) {
    return _then(_$_PadOtaConfig(
      currentVersionGithubLink: freezed == currentVersionGithubLink
          ? _value.currentVersionGithubLink
          : currentVersionGithubLink // ignore: cast_nullable_to_non_nullable
              as String?,
      oldVersionGithubLink: freezed == oldVersionGithubLink
          ? _value.oldVersionGithubLink
          : oldVersionGithubLink // ignore: cast_nullable_to_non_nullable
              as String?,
      requireUpdate: freezed == requireUpdate
          ? _value.requireUpdate
          : requireUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PadOtaConfig with DiagnosticableTreeMixin implements _PadOtaConfig {
  const _$_PadOtaConfig(
      {@JsonKey(name: 'currentVersionGithubLink') this.currentVersionGithubLink,
      @JsonKey(name: 'oldVersionGithubLink') this.oldVersionGithubLink,
      @JsonKey(name: 'requireUpdate') this.requireUpdate,
      @JsonKey(name: 'version') this.version});

  factory _$_PadOtaConfig.fromJson(Map<String, dynamic> json) =>
      _$$_PadOtaConfigFromJson(json);

  @override
  @JsonKey(name: 'currentVersionGithubLink')
  final String? currentVersionGithubLink;
  @override
  @JsonKey(name: 'oldVersionGithubLink')
  final String? oldVersionGithubLink;
  @override
  @JsonKey(name: 'requireUpdate')
  final bool? requireUpdate;
  @override
  @JsonKey(name: 'version')
  final String? version;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PadOtaConfig(currentVersionGithubLink: $currentVersionGithubLink, oldVersionGithubLink: $oldVersionGithubLink, requireUpdate: $requireUpdate, version: $version)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PadOtaConfig'))
      ..add(DiagnosticsProperty(
          'currentVersionGithubLink', currentVersionGithubLink))
      ..add(DiagnosticsProperty('oldVersionGithubLink', oldVersionGithubLink))
      ..add(DiagnosticsProperty('requireUpdate', requireUpdate))
      ..add(DiagnosticsProperty('version', version));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PadOtaConfig &&
            (identical(
                    other.currentVersionGithubLink, currentVersionGithubLink) ||
                other.currentVersionGithubLink == currentVersionGithubLink) &&
            (identical(other.oldVersionGithubLink, oldVersionGithubLink) ||
                other.oldVersionGithubLink == oldVersionGithubLink) &&
            (identical(other.requireUpdate, requireUpdate) ||
                other.requireUpdate == requireUpdate) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentVersionGithubLink,
      oldVersionGithubLink, requireUpdate, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PadOtaConfigCopyWith<_$_PadOtaConfig> get copyWith =>
      __$$_PadOtaConfigCopyWithImpl<_$_PadOtaConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PadOtaConfigToJson(
      this,
    );
  }
}

abstract class _PadOtaConfig implements PadOtaConfig {
  const factory _PadOtaConfig(
      {@JsonKey(name: 'currentVersionGithubLink')
      final String? currentVersionGithubLink,
      @JsonKey(name: 'oldVersionGithubLink') final String? oldVersionGithubLink,
      @JsonKey(name: 'requireUpdate') final bool? requireUpdate,
      @JsonKey(name: 'version') final String? version}) = _$_PadOtaConfig;

  factory _PadOtaConfig.fromJson(Map<String, dynamic> json) =
      _$_PadOtaConfig.fromJson;

  @override
  @JsonKey(name: 'currentVersionGithubLink')
  String? get currentVersionGithubLink;
  @override
  @JsonKey(name: 'oldVersionGithubLink')
  String? get oldVersionGithubLink;
  @override
  @JsonKey(name: 'requireUpdate')
  bool? get requireUpdate;
  @override
  @JsonKey(name: 'version')
  String? get version;
  @override
  @JsonKey(ignore: true)
  _$$_PadOtaConfigCopyWith<_$_PadOtaConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
