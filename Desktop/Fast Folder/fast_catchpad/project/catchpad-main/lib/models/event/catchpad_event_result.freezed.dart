// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'catchpad_event_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CatchpadEventResult _$CatchpadEventResultFromJson(Map<String, dynamic> json) {
  return _CatchpadEventResult.fromJson(json);
}

/// @nodoc
mixin _$CatchpadEventResult {
  @JsonKey(name: 'eventId')
  String? get eventId => throw _privateConstructorUsedError;
  @JsonKey(name: 'gameId')
  String? get gameId => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'userFullName')
  String? get userFullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'userPrimaryScore')
  double? get userPrimaryScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'userSecondaryScore')
  int? get userSecondaryScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatchpadEventResultCopyWith<CatchpadEventResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatchpadEventResultCopyWith<$Res> {
  factory $CatchpadEventResultCopyWith(
          CatchpadEventResult value, $Res Function(CatchpadEventResult) then) =
      _$CatchpadEventResultCopyWithImpl<$Res, CatchpadEventResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'eventId') String? eventId,
      @JsonKey(name: 'gameId') String? gameId,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'userFullName') String? userFullName,
      @JsonKey(name: 'userPrimaryScore') double? userPrimaryScore,
      @JsonKey(name: 'userSecondaryScore') int? userSecondaryScore});
}

/// @nodoc
class _$CatchpadEventResultCopyWithImpl<$Res, $Val extends CatchpadEventResult>
    implements $CatchpadEventResultCopyWith<$Res> {
  _$CatchpadEventResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? gameId = freezed,
    Object? userId = freezed,
    Object? userFullName = freezed,
    Object? userPrimaryScore = freezed,
    Object? userSecondaryScore = freezed,
  }) {
    return _then(_value.copyWith(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userFullName: freezed == userFullName
          ? _value.userFullName
          : userFullName // ignore: cast_nullable_to_non_nullable
              as String?,
      userPrimaryScore: freezed == userPrimaryScore
          ? _value.userPrimaryScore
          : userPrimaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      userSecondaryScore: freezed == userSecondaryScore
          ? _value.userSecondaryScore
          : userSecondaryScore // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CatchpadEventResultCopyWith<$Res>
    implements $CatchpadEventResultCopyWith<$Res> {
  factory _$$_CatchpadEventResultCopyWith(_$_CatchpadEventResult value,
          $Res Function(_$_CatchpadEventResult) then) =
      __$$_CatchpadEventResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'eventId') String? eventId,
      @JsonKey(name: 'gameId') String? gameId,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'userFullName') String? userFullName,
      @JsonKey(name: 'userPrimaryScore') double? userPrimaryScore,
      @JsonKey(name: 'userSecondaryScore') int? userSecondaryScore});
}

/// @nodoc
class __$$_CatchpadEventResultCopyWithImpl<$Res>
    extends _$CatchpadEventResultCopyWithImpl<$Res, _$_CatchpadEventResult>
    implements _$$_CatchpadEventResultCopyWith<$Res> {
  __$$_CatchpadEventResultCopyWithImpl(_$_CatchpadEventResult _value,
      $Res Function(_$_CatchpadEventResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? gameId = freezed,
    Object? userId = freezed,
    Object? userFullName = freezed,
    Object? userPrimaryScore = freezed,
    Object? userSecondaryScore = freezed,
  }) {
    return _then(_$_CatchpadEventResult(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userFullName: freezed == userFullName
          ? _value.userFullName
          : userFullName // ignore: cast_nullable_to_non_nullable
              as String?,
      userPrimaryScore: freezed == userPrimaryScore
          ? _value.userPrimaryScore
          : userPrimaryScore // ignore: cast_nullable_to_non_nullable
              as double?,
      userSecondaryScore: freezed == userSecondaryScore
          ? _value.userSecondaryScore
          : userSecondaryScore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CatchpadEventResult
    with DiagnosticableTreeMixin
    implements _CatchpadEventResult {
  const _$_CatchpadEventResult(
      {@JsonKey(name: 'eventId') this.eventId,
      @JsonKey(name: 'gameId') this.gameId,
      @JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'userFullName') this.userFullName,
      @JsonKey(name: 'userPrimaryScore') this.userPrimaryScore,
      @JsonKey(name: 'userSecondaryScore') this.userSecondaryScore});

  factory _$_CatchpadEventResult.fromJson(Map<String, dynamic> json) =>
      _$$_CatchpadEventResultFromJson(json);

  @override
  @JsonKey(name: 'eventId')
  final String? eventId;
  @override
  @JsonKey(name: 'gameId')
  final String? gameId;
  @override
  @JsonKey(name: 'userId')
  final String? userId;
  @override
  @JsonKey(name: 'userFullName')
  final String? userFullName;
  @override
  @JsonKey(name: 'userPrimaryScore')
  final double? userPrimaryScore;
  @override
  @JsonKey(name: 'userSecondaryScore')
  final int? userSecondaryScore;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CatchpadEventResult(eventId: $eventId, gameId: $gameId, userId: $userId, userFullName: $userFullName, userPrimaryScore: $userPrimaryScore, userSecondaryScore: $userSecondaryScore)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CatchpadEventResult'))
      ..add(DiagnosticsProperty('eventId', eventId))
      ..add(DiagnosticsProperty('gameId', gameId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('userFullName', userFullName))
      ..add(DiagnosticsProperty('userPrimaryScore', userPrimaryScore))
      ..add(DiagnosticsProperty('userSecondaryScore', userSecondaryScore));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CatchpadEventResult &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userFullName, userFullName) ||
                other.userFullName == userFullName) &&
            (identical(other.userPrimaryScore, userPrimaryScore) ||
                other.userPrimaryScore == userPrimaryScore) &&
            (identical(other.userSecondaryScore, userSecondaryScore) ||
                other.userSecondaryScore == userSecondaryScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, eventId, gameId, userId,
      userFullName, userPrimaryScore, userSecondaryScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CatchpadEventResultCopyWith<_$_CatchpadEventResult> get copyWith =>
      __$$_CatchpadEventResultCopyWithImpl<_$_CatchpadEventResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CatchpadEventResultToJson(
      this,
    );
  }
}

abstract class _CatchpadEventResult implements CatchpadEventResult {
  const factory _CatchpadEventResult(
          {@JsonKey(name: 'eventId') final String? eventId,
          @JsonKey(name: 'gameId') final String? gameId,
          @JsonKey(name: 'userId') final String? userId,
          @JsonKey(name: 'userFullName') final String? userFullName,
          @JsonKey(name: 'userPrimaryScore') final double? userPrimaryScore,
          @JsonKey(name: 'userSecondaryScore') final int? userSecondaryScore}) =
      _$_CatchpadEventResult;

  factory _CatchpadEventResult.fromJson(Map<String, dynamic> json) =
      _$_CatchpadEventResult.fromJson;

  @override
  @JsonKey(name: 'eventId')
  String? get eventId;
  @override
  @JsonKey(name: 'gameId')
  String? get gameId;
  @override
  @JsonKey(name: 'userId')
  String? get userId;
  @override
  @JsonKey(name: 'userFullName')
  String? get userFullName;
  @override
  @JsonKey(name: 'userPrimaryScore')
  double? get userPrimaryScore;
  @override
  @JsonKey(name: 'userSecondaryScore')
  int? get userSecondaryScore;
  @override
  @JsonKey(ignore: true)
  _$$_CatchpadEventResultCopyWith<_$_CatchpadEventResult> get copyWith =>
      throw _privateConstructorUsedError;
}
