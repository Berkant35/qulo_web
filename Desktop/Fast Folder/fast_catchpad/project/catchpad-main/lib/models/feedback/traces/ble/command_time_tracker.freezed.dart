// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'command_time_tracker.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommandTimeTracker _$CommandTimeTrackerFromJson(Map<String, dynamic> json) {
  return _CommandTimeTracker.fromJson(json);
}

/// @nodoc
mixin _$CommandTimeTracker {
  /// sendTime is the time when the command is sent.
  @JsonKey(name: 'senTime')
  int get senTime => throw _privateConstructorUsedError;

  /// receiveTime is the time when the command is received.
  @JsonKey(name: 'actionOfReceiverTime')
  int? get actionOfReceiverTime => throw _privateConstructorUsedError;

  /// elapsedTime is actionOfReceiverTime - senTime.
  @JsonKey(name: 'elapsedTime')
  int? get elapsedTime => throw _privateConstructorUsedError;

  /// turnCount is the number of turns that the command has been sent.
  @JsonKey(name: 'turnCount')
  int get turnCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommandTimeTrackerCopyWith<CommandTimeTracker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommandTimeTrackerCopyWith<$Res> {
  factory $CommandTimeTrackerCopyWith(
          CommandTimeTracker value, $Res Function(CommandTimeTracker) then) =
      _$CommandTimeTrackerCopyWithImpl<$Res, CommandTimeTracker>;
  @useResult
  $Res call(
      {@JsonKey(name: 'senTime') int senTime,
      @JsonKey(name: 'actionOfReceiverTime') int? actionOfReceiverTime,
      @JsonKey(name: 'elapsedTime') int? elapsedTime,
      @JsonKey(name: 'turnCount') int turnCount});
}

/// @nodoc
class _$CommandTimeTrackerCopyWithImpl<$Res, $Val extends CommandTimeTracker>
    implements $CommandTimeTrackerCopyWith<$Res> {
  _$CommandTimeTrackerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senTime = null,
    Object? actionOfReceiverTime = freezed,
    Object? elapsedTime = freezed,
    Object? turnCount = null,
  }) {
    return _then(_value.copyWith(
      senTime: null == senTime
          ? _value.senTime
          : senTime // ignore: cast_nullable_to_non_nullable
              as int,
      actionOfReceiverTime: freezed == actionOfReceiverTime
          ? _value.actionOfReceiverTime
          : actionOfReceiverTime // ignore: cast_nullable_to_non_nullable
              as int?,
      elapsedTime: freezed == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommandTimeTrackerCopyWith<$Res>
    implements $CommandTimeTrackerCopyWith<$Res> {
  factory _$$_CommandTimeTrackerCopyWith(_$_CommandTimeTracker value,
          $Res Function(_$_CommandTimeTracker) then) =
      __$$_CommandTimeTrackerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'senTime') int senTime,
      @JsonKey(name: 'actionOfReceiverTime') int? actionOfReceiverTime,
      @JsonKey(name: 'elapsedTime') int? elapsedTime,
      @JsonKey(name: 'turnCount') int turnCount});
}

/// @nodoc
class __$$_CommandTimeTrackerCopyWithImpl<$Res>
    extends _$CommandTimeTrackerCopyWithImpl<$Res, _$_CommandTimeTracker>
    implements _$$_CommandTimeTrackerCopyWith<$Res> {
  __$$_CommandTimeTrackerCopyWithImpl(
      _$_CommandTimeTracker _value, $Res Function(_$_CommandTimeTracker) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senTime = null,
    Object? actionOfReceiverTime = freezed,
    Object? elapsedTime = freezed,
    Object? turnCount = null,
  }) {
    return _then(_$_CommandTimeTracker(
      senTime: null == senTime
          ? _value.senTime
          : senTime // ignore: cast_nullable_to_non_nullable
              as int,
      actionOfReceiverTime: freezed == actionOfReceiverTime
          ? _value.actionOfReceiverTime
          : actionOfReceiverTime // ignore: cast_nullable_to_non_nullable
              as int?,
      elapsedTime: freezed == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommandTimeTracker implements _CommandTimeTracker {
  const _$_CommandTimeTracker(
      {@JsonKey(name: 'senTime') this.senTime = 0,
      @JsonKey(name: 'actionOfReceiverTime') this.actionOfReceiverTime,
      @JsonKey(name: 'elapsedTime') this.elapsedTime,
      @JsonKey(name: 'turnCount') this.turnCount = 0});

  factory _$_CommandTimeTracker.fromJson(Map<String, dynamic> json) =>
      _$$_CommandTimeTrackerFromJson(json);

  /// sendTime is the time when the command is sent.
  @override
  @JsonKey(name: 'senTime')
  final int senTime;

  /// receiveTime is the time when the command is received.
  @override
  @JsonKey(name: 'actionOfReceiverTime')
  final int? actionOfReceiverTime;

  /// elapsedTime is actionOfReceiverTime - senTime.
  @override
  @JsonKey(name: 'elapsedTime')
  final int? elapsedTime;

  /// turnCount is the number of turns that the command has been sent.
  @override
  @JsonKey(name: 'turnCount')
  final int turnCount;

  @override
  String toString() {
    return 'CommandTimeTracker(senTime: $senTime, actionOfReceiverTime: $actionOfReceiverTime, elapsedTime: $elapsedTime, turnCount: $turnCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommandTimeTracker &&
            (identical(other.senTime, senTime) || other.senTime == senTime) &&
            (identical(other.actionOfReceiverTime, actionOfReceiverTime) ||
                other.actionOfReceiverTime == actionOfReceiverTime) &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime) &&
            (identical(other.turnCount, turnCount) ||
                other.turnCount == turnCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, senTime, actionOfReceiverTime, elapsedTime, turnCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommandTimeTrackerCopyWith<_$_CommandTimeTracker> get copyWith =>
      __$$_CommandTimeTrackerCopyWithImpl<_$_CommandTimeTracker>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommandTimeTrackerToJson(
      this,
    );
  }
}

abstract class _CommandTimeTracker implements CommandTimeTracker {
  const factory _CommandTimeTracker(
      {@JsonKey(name: 'senTime') final int senTime,
      @JsonKey(name: 'actionOfReceiverTime') final int? actionOfReceiverTime,
      @JsonKey(name: 'elapsedTime') final int? elapsedTime,
      @JsonKey(name: 'turnCount') final int turnCount}) = _$_CommandTimeTracker;

  factory _CommandTimeTracker.fromJson(Map<String, dynamic> json) =
      _$_CommandTimeTracker.fromJson;

  @override

  /// sendTime is the time when the command is sent.
  @JsonKey(name: 'senTime')
  int get senTime;
  @override

  /// receiveTime is the time when the command is received.
  @JsonKey(name: 'actionOfReceiverTime')
  int? get actionOfReceiverTime;
  @override

  /// elapsedTime is actionOfReceiverTime - senTime.
  @JsonKey(name: 'elapsedTime')
  int? get elapsedTime;
  @override

  /// turnCount is the number of turns that the command has been sent.
  @JsonKey(name: 'turnCount')
  int get turnCount;
  @override
  @JsonKey(ignore: true)
  _$$_CommandTimeTrackerCopyWith<_$_CommandTimeTracker> get copyWith =>
      throw _privateConstructorUsedError;
}
