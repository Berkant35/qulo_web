// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return _VersionModel.fromJson(json);
}

/// @nodoc
mixin _$VersionModel {
  @JsonKey(name: 'buildNumber')
  int? get buildNumber =>
      throw _privateConstructorUsedError; // JSON key for build number
  @JsonKey(name: 'forceRequired')
  bool? get forceRequired =>
      throw _privateConstructorUsedError; // JSON key for force requirement
  @JsonKey(name: 'version')
  String? get version =>
      throw _privateConstructorUsedError; // JSON key for version number
  @JsonKey(name: 'link')
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VersionModelCopyWith<VersionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VersionModelCopyWith<$Res> {
  factory $VersionModelCopyWith(
          VersionModel value, $Res Function(VersionModel) then) =
      _$VersionModelCopyWithImpl<$Res, VersionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'buildNumber') int? buildNumber,
      @JsonKey(name: 'forceRequired') bool? forceRequired,
      @JsonKey(name: 'version') String? version,
      @JsonKey(name: 'link') String? link});
}

/// @nodoc
class _$VersionModelCopyWithImpl<$Res, $Val extends VersionModel>
    implements $VersionModelCopyWith<$Res> {
  _$VersionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildNumber = freezed,
    Object? forceRequired = freezed,
    Object? version = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      buildNumber: freezed == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      forceRequired: freezed == forceRequired
          ? _value.forceRequired
          : forceRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VersionModelCopyWith<$Res>
    implements $VersionModelCopyWith<$Res> {
  factory _$$_VersionModelCopyWith(
          _$_VersionModel value, $Res Function(_$_VersionModel) then) =
      __$$_VersionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'buildNumber') int? buildNumber,
      @JsonKey(name: 'forceRequired') bool? forceRequired,
      @JsonKey(name: 'version') String? version,
      @JsonKey(name: 'link') String? link});
}

/// @nodoc
class __$$_VersionModelCopyWithImpl<$Res>
    extends _$VersionModelCopyWithImpl<$Res, _$_VersionModel>
    implements _$$_VersionModelCopyWith<$Res> {
  __$$_VersionModelCopyWithImpl(
      _$_VersionModel _value, $Res Function(_$_VersionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildNumber = freezed,
    Object? forceRequired = freezed,
    Object? version = freezed,
    Object? link = freezed,
  }) {
    return _then(_$_VersionModel(
      buildNumber: freezed == buildNumber
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      forceRequired: freezed == forceRequired
          ? _value.forceRequired
          : forceRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VersionModel with DiagnosticableTreeMixin implements _VersionModel {
  const _$_VersionModel(
      {@JsonKey(name: 'buildNumber') this.buildNumber,
      @JsonKey(name: 'forceRequired') this.forceRequired,
      @JsonKey(name: 'version') this.version,
      @JsonKey(name: 'link') this.link});

  factory _$_VersionModel.fromJson(Map<String, dynamic> json) =>
      _$$_VersionModelFromJson(json);

  @override
  @JsonKey(name: 'buildNumber')
  final int? buildNumber;
// JSON key for build number
  @override
  @JsonKey(name: 'forceRequired')
  final bool? forceRequired;
// JSON key for force requirement
  @override
  @JsonKey(name: 'version')
  final String? version;
// JSON key for version number
  @override
  @JsonKey(name: 'link')
  final String? link;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VersionModel(buildNumber: $buildNumber, forceRequired: $forceRequired, version: $version, link: $link)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VersionModel'))
      ..add(DiagnosticsProperty('buildNumber', buildNumber))
      ..add(DiagnosticsProperty('forceRequired', forceRequired))
      ..add(DiagnosticsProperty('version', version))
      ..add(DiagnosticsProperty('link', link));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VersionModel &&
            (identical(other.buildNumber, buildNumber) ||
                other.buildNumber == buildNumber) &&
            (identical(other.forceRequired, forceRequired) ||
                other.forceRequired == forceRequired) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, buildNumber, forceRequired, version, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VersionModelCopyWith<_$_VersionModel> get copyWith =>
      __$$_VersionModelCopyWithImpl<_$_VersionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VersionModelToJson(
      this,
    );
  }
}

abstract class _VersionModel implements VersionModel {
  const factory _VersionModel(
      {@JsonKey(name: 'buildNumber') final int? buildNumber,
      @JsonKey(name: 'forceRequired') final bool? forceRequired,
      @JsonKey(name: 'version') final String? version,
      @JsonKey(name: 'link') final String? link}) = _$_VersionModel;

  factory _VersionModel.fromJson(Map<String, dynamic> json) =
      _$_VersionModel.fromJson;

  @override
  @JsonKey(name: 'buildNumber')
  int? get buildNumber;
  @override // JSON key for build number
  @JsonKey(name: 'forceRequired')
  bool? get forceRequired;
  @override // JSON key for force requirement
  @JsonKey(name: 'version')
  String? get version;
  @override // JSON key for version number
  @JsonKey(name: 'link')
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$_VersionModelCopyWith<_$_VersionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
