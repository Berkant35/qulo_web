// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_game_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaGameResult _$IgaGameResultFromJson(Map<String, dynamic> json) {
  return _IgaGameResult.fromJson(json);
}

/// @nodoc
mixin _$IgaGameResult {
// These parameters represents result of played game in iga.
  @JsonKey(name: 'igaGameResultId')
  String? get igaGameResultId =>
      throw _privateConstructorUsedError; // primary score mean option of catching pad time
  @JsonKey(name: 'primaryScore')
  double? get primaryScore =>
      throw _privateConstructorUsedError; // secondary score mean count of catched pad
  @JsonKey(name: 'secondaryScore')
  double? get secondaryScore =>
      throw _privateConstructorUsedError; // These parameters represents infos taken from IGA Register screen.
  @JsonKey(name: 'igaUsername')
  String? get igaUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaUserCountry')
  String? get igaUserCountry => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaUserCountryCode')
  String? get igaUserCountryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaUserId')
  String? get igaUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaGameId')
  String? get igaGameId =>
      throw _privateConstructorUsedError; // location mean the pier where the pad is located
  @JsonKey(name: 'igaLocationId')
  String? get igaLocationId =>
      throw _privateConstructorUsedError; // time of document creating
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaGameResultCopyWith<IgaGameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaGameResultCopyWith<$Res> {
  factory $IgaGameResultCopyWith(
          IgaGameResult value, $Res Function(IgaGameResult) then) =
      _$IgaGameResultCopyWithImpl<$Res, IgaGameResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'igaGameResultId') String? igaGameResultId,
      @JsonKey(name: 'primaryScore') double? primaryScore,
      @JsonKey(name: 'secondaryScore') double? secondaryScore,
      @JsonKey(name: 'igaUsername') String? igaUsername,
      @JsonKey(name: 'igaUserCountry') String? igaUserCountry,
      @JsonKey(name: 'igaUserCountryCode') String? igaUserCountryCode,
      @JsonKey(name: 'igaUserId') String? igaUserId,
      @JsonKey(name: 'igaGameId') String? igaGameId,
      @JsonKey(name: 'igaLocationId') String? igaLocationId,
      @JsonKey(name: 'createdAt') String? createdAt});
}

/// @nodoc
class _$IgaGameResultCopyWithImpl<$Res, $Val extends IgaGameResult>
    implements $IgaGameResultCopyWith<$Res> {
  _$IgaGameResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igaGameResultId = freezed,
    Object? primaryScore = freezed,
    Object? secondaryScore = freezed,
    Object? igaUsername = freezed,
    Object? igaUserCountry = freezed,
    Object? igaUserCountryCode = freezed,
    Object? igaUserId = freezed,
    Object? igaGameId = freezed,
    Object? igaLocationId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      igaGameResultId: freezed == igaGameResultId
          ? _value.igaGameResultId
          : igaGameResultId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryScore: freezed == primaryScore
          ? _value.primaryScore
          : primaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      secondaryScore: freezed == secondaryScore
          ? _value.secondaryScore
          : secondaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      igaUsername: freezed == igaUsername
          ? _value.igaUsername
          : igaUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserCountry: freezed == igaUserCountry
          ? _value.igaUserCountry
          : igaUserCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserCountryCode: freezed == igaUserCountryCode
          ? _value.igaUserCountryCode
          : igaUserCountryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserId: freezed == igaUserId
          ? _value.igaUserId
          : igaUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      igaGameId: freezed == igaGameId
          ? _value.igaGameId
          : igaGameId // ignore: cast_nullable_to_non_nullable
              as String?,
      igaLocationId: freezed == igaLocationId
          ? _value.igaLocationId
          : igaLocationId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IgaGameResultCopyWith<$Res>
    implements $IgaGameResultCopyWith<$Res> {
  factory _$$_IgaGameResultCopyWith(
          _$_IgaGameResult value, $Res Function(_$_IgaGameResult) then) =
      __$$_IgaGameResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'igaGameResultId') String? igaGameResultId,
      @JsonKey(name: 'primaryScore') double? primaryScore,
      @JsonKey(name: 'secondaryScore') double? secondaryScore,
      @JsonKey(name: 'igaUsername') String? igaUsername,
      @JsonKey(name: 'igaUserCountry') String? igaUserCountry,
      @JsonKey(name: 'igaUserCountryCode') String? igaUserCountryCode,
      @JsonKey(name: 'igaUserId') String? igaUserId,
      @JsonKey(name: 'igaGameId') String? igaGameId,
      @JsonKey(name: 'igaLocationId') String? igaLocationId,
      @JsonKey(name: 'createdAt') String? createdAt});
}

/// @nodoc
class __$$_IgaGameResultCopyWithImpl<$Res>
    extends _$IgaGameResultCopyWithImpl<$Res, _$_IgaGameResult>
    implements _$$_IgaGameResultCopyWith<$Res> {
  __$$_IgaGameResultCopyWithImpl(
      _$_IgaGameResult _value, $Res Function(_$_IgaGameResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? igaGameResultId = freezed,
    Object? primaryScore = freezed,
    Object? secondaryScore = freezed,
    Object? igaUsername = freezed,
    Object? igaUserCountry = freezed,
    Object? igaUserCountryCode = freezed,
    Object? igaUserId = freezed,
    Object? igaGameId = freezed,
    Object? igaLocationId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_IgaGameResult(
      igaGameResultId: freezed == igaGameResultId
          ? _value.igaGameResultId
          : igaGameResultId // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryScore: freezed == primaryScore
          ? _value.primaryScore
          : primaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      secondaryScore: freezed == secondaryScore
          ? _value.secondaryScore
          : secondaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      igaUsername: freezed == igaUsername
          ? _value.igaUsername
          : igaUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserCountry: freezed == igaUserCountry
          ? _value.igaUserCountry
          : igaUserCountry // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserCountryCode: freezed == igaUserCountryCode
          ? _value.igaUserCountryCode
          : igaUserCountryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      igaUserId: freezed == igaUserId
          ? _value.igaUserId
          : igaUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      igaGameId: freezed == igaGameId
          ? _value.igaGameId
          : igaGameId // ignore: cast_nullable_to_non_nullable
              as String?,
      igaLocationId: freezed == igaLocationId
          ? _value.igaLocationId
          : igaLocationId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaGameResult with DiagnosticableTreeMixin implements _IgaGameResult {
  const _$_IgaGameResult(
      {@JsonKey(name: 'igaGameResultId') this.igaGameResultId,
      @JsonKey(name: 'primaryScore') this.primaryScore,
      @JsonKey(name: 'secondaryScore') this.secondaryScore,
      @JsonKey(name: 'igaUsername') this.igaUsername,
      @JsonKey(name: 'igaUserCountry') this.igaUserCountry,
      @JsonKey(name: 'igaUserCountryCode') this.igaUserCountryCode,
      @JsonKey(name: 'igaUserId') this.igaUserId,
      @JsonKey(name: 'igaGameId') this.igaGameId,
      @JsonKey(name: 'igaLocationId') this.igaLocationId,
      @JsonKey(name: 'createdAt') this.createdAt});

  factory _$_IgaGameResult.fromJson(Map<String, dynamic> json) =>
      _$$_IgaGameResultFromJson(json);

// These parameters represents result of played game in iga.
  @override
  @JsonKey(name: 'igaGameResultId')
  final String? igaGameResultId;
// primary score mean option of catching pad time
  @override
  @JsonKey(name: 'primaryScore')
  final double? primaryScore;
// secondary score mean count of catched pad
  @override
  @JsonKey(name: 'secondaryScore')
  final double? secondaryScore;
// These parameters represents infos taken from IGA Register screen.
  @override
  @JsonKey(name: 'igaUsername')
  final String? igaUsername;
  @override
  @JsonKey(name: 'igaUserCountry')
  final String? igaUserCountry;
  @override
  @JsonKey(name: 'igaUserCountryCode')
  final String? igaUserCountryCode;
  @override
  @JsonKey(name: 'igaUserId')
  final String? igaUserId;
  @override
  @JsonKey(name: 'igaGameId')
  final String? igaGameId;
// location mean the pier where the pad is located
  @override
  @JsonKey(name: 'igaLocationId')
  final String? igaLocationId;
// time of document creating
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IgaGameResult(igaGameResultId: $igaGameResultId, primaryScore: $primaryScore, secondaryScore: $secondaryScore, igaUsername: $igaUsername, igaUserCountry: $igaUserCountry, igaUserCountryCode: $igaUserCountryCode, igaUserId: $igaUserId, igaGameId: $igaGameId, igaLocationId: $igaLocationId, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IgaGameResult'))
      ..add(DiagnosticsProperty('igaGameResultId', igaGameResultId))
      ..add(DiagnosticsProperty('primaryScore', primaryScore))
      ..add(DiagnosticsProperty('secondaryScore', secondaryScore))
      ..add(DiagnosticsProperty('igaUsername', igaUsername))
      ..add(DiagnosticsProperty('igaUserCountry', igaUserCountry))
      ..add(DiagnosticsProperty('igaUserCountryCode', igaUserCountryCode))
      ..add(DiagnosticsProperty('igaUserId', igaUserId))
      ..add(DiagnosticsProperty('igaGameId', igaGameId))
      ..add(DiagnosticsProperty('igaLocationId', igaLocationId))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaGameResult &&
            (identical(other.igaGameResultId, igaGameResultId) ||
                other.igaGameResultId == igaGameResultId) &&
            (identical(other.primaryScore, primaryScore) ||
                other.primaryScore == primaryScore) &&
            (identical(other.secondaryScore, secondaryScore) ||
                other.secondaryScore == secondaryScore) &&
            (identical(other.igaUsername, igaUsername) ||
                other.igaUsername == igaUsername) &&
            (identical(other.igaUserCountry, igaUserCountry) ||
                other.igaUserCountry == igaUserCountry) &&
            (identical(other.igaUserCountryCode, igaUserCountryCode) ||
                other.igaUserCountryCode == igaUserCountryCode) &&
            (identical(other.igaUserId, igaUserId) ||
                other.igaUserId == igaUserId) &&
            (identical(other.igaGameId, igaGameId) ||
                other.igaGameId == igaGameId) &&
            (identical(other.igaLocationId, igaLocationId) ||
                other.igaLocationId == igaLocationId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      igaGameResultId,
      primaryScore,
      secondaryScore,
      igaUsername,
      igaUserCountry,
      igaUserCountryCode,
      igaUserId,
      igaGameId,
      igaLocationId,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaGameResultCopyWith<_$_IgaGameResult> get copyWith =>
      __$$_IgaGameResultCopyWithImpl<_$_IgaGameResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaGameResultToJson(
      this,
    );
  }
}

abstract class _IgaGameResult implements IgaGameResult {
  const factory _IgaGameResult(
      {@JsonKey(name: 'igaGameResultId') final String? igaGameResultId,
      @JsonKey(name: 'primaryScore') final double? primaryScore,
      @JsonKey(name: 'secondaryScore') final double? secondaryScore,
      @JsonKey(name: 'igaUsername') final String? igaUsername,
      @JsonKey(name: 'igaUserCountry') final String? igaUserCountry,
      @JsonKey(name: 'igaUserCountryCode') final String? igaUserCountryCode,
      @JsonKey(name: 'igaUserId') final String? igaUserId,
      @JsonKey(name: 'igaGameId') final String? igaGameId,
      @JsonKey(name: 'igaLocationId') final String? igaLocationId,
      @JsonKey(name: 'createdAt') final String? createdAt}) = _$_IgaGameResult;

  factory _IgaGameResult.fromJson(Map<String, dynamic> json) =
      _$_IgaGameResult.fromJson;

  @override // These parameters represents result of played game in iga.
  @JsonKey(name: 'igaGameResultId')
  String? get igaGameResultId;
  @override // primary score mean option of catching pad time
  @JsonKey(name: 'primaryScore')
  double? get primaryScore;
  @override // secondary score mean count of catched pad
  @JsonKey(name: 'secondaryScore')
  double? get secondaryScore;
  @override // These parameters represents infos taken from IGA Register screen.
  @JsonKey(name: 'igaUsername')
  String? get igaUsername;
  @override
  @JsonKey(name: 'igaUserCountry')
  String? get igaUserCountry;
  @override
  @JsonKey(name: 'igaUserCountryCode')
  String? get igaUserCountryCode;
  @override
  @JsonKey(name: 'igaUserId')
  String? get igaUserId;
  @override
  @JsonKey(name: 'igaGameId')
  String? get igaGameId;
  @override // location mean the pier where the pad is located
  @JsonKey(name: 'igaLocationId')
  String? get igaLocationId;
  @override // time of document creating
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_IgaGameResultCopyWith<_$_IgaGameResult> get copyWith =>
      throw _privateConstructorUsedError;
}
