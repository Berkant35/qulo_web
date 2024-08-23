// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_trace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameTrace _$GameTraceFromJson(Map<String, dynamic> json) {
  return _GameTrace.fromJson(json);
}

/// @nodoc
mixin _$GameTrace {
  /// [clickToScreenCount]: Represents the number of clicks made to the
  /// screen during the game. It is an optional parameter and its default
  /// value is 0.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount => throw _privateConstructorUsedError;

  ///isEnterToResult: Indicates whether the player has entered the result
  ///screen or not. It is a boolean parameter and its default value is false.
  @JsonKey(name: 'isEnterToResult', defaultValue: false)
  bool? get isEnterToResult => throw _privateConstructorUsedError;

  ///Represents the amount of time passed during the game, measured
  ///in some unit (e.g., seconds). It is an optional parameter and its
  ///default value is 0.
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime => throw _privateConstructorUsedError;

  ///createdTime: Represents the timestamp when the game trace was created.
  ///It is a string parameter that holds the date and time information.
  @JsonKey(name: 'createdTime')
  String? get createdTime => throw _privateConstructorUsedError;
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch => throw _privateConstructorUsedError;

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameTraceCopyWith<GameTrace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameTraceCopyWith<$Res> {
  factory $GameTraceCopyWith(GameTrace value, $Res Function(GameTrace) then) =
      _$GameTraceCopyWithImpl<$Res, GameTrace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'isEnterToResult', defaultValue: false)
      bool? isEnterToResult,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,
      @JsonKey(name: 'endTime') String? endTime});
}

/// @nodoc
class _$GameTraceCopyWithImpl<$Res, $Val extends GameTrace>
    implements $GameTraceCopyWith<$Res> {
  _$GameTraceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? isEnterToResult = freezed,
    Object? passedTime = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_value.copyWith(
      clickToScreenCount: freezed == clickToScreenCount
          ? _value.clickToScreenCount
          : clickToScreenCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnterToResult: freezed == isEnterToResult
          ? _value.isEnterToResult
          : isEnterToResult // ignore: cast_nullable_to_non_nullable
              as bool?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameTraceCopyWith<$Res> implements $GameTraceCopyWith<$Res> {
  factory _$$_GameTraceCopyWith(
          _$_GameTrace value, $Res Function(_$_GameTrace) then) =
      __$$_GameTraceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      int? clickToScreenCount,
      @JsonKey(name: 'isEnterToResult', defaultValue: false)
      bool? isEnterToResult,
      @JsonKey(name: 'passedTime', defaultValue: 0) int? passedTime,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch") String? createdMillisecondEpoch,
      @JsonKey(name: 'endTime') String? endTime});
}

/// @nodoc
class __$$_GameTraceCopyWithImpl<$Res>
    extends _$GameTraceCopyWithImpl<$Res, _$_GameTrace>
    implements _$$_GameTraceCopyWith<$Res> {
  __$$_GameTraceCopyWithImpl(
      _$_GameTrace _value, $Res Function(_$_GameTrace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickToScreenCount = freezed,
    Object? isEnterToResult = freezed,
    Object? passedTime = freezed,
    Object? createdTime = freezed,
    Object? createdMillisecondEpoch = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_$_GameTrace(
      clickToScreenCount: freezed == clickToScreenCount
          ? _value.clickToScreenCount
          : clickToScreenCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnterToResult: freezed == isEnterToResult
          ? _value.isEnterToResult
          : isEnterToResult // ignore: cast_nullable_to_non_nullable
              as bool?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameTrace with DiagnosticableTreeMixin implements _GameTrace {
  const _$_GameTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      this.clickToScreenCount = 0,
      @JsonKey(name: 'isEnterToResult', defaultValue: false)
      this.isEnterToResult = false,
      @JsonKey(name: 'passedTime', defaultValue: 0) this.passedTime = 0,
      @JsonKey(name: 'createdTime') this.createdTime,
      @JsonKey(name: "createdMillisecondEpoch") this.createdMillisecondEpoch,
      @JsonKey(name: 'endTime') this.endTime});

  factory _$_GameTrace.fromJson(Map<String, dynamic> json) =>
      _$$_GameTraceFromJson(json);

  /// [clickToScreenCount]: Represents the number of clicks made to the
  /// screen during the game. It is an optional parameter and its default
  /// value is 0.
  @override
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  final int? clickToScreenCount;

  ///isEnterToResult: Indicates whether the player has entered the result
  ///screen or not. It is a boolean parameter and its default value is false.
  @override
  @JsonKey(name: 'isEnterToResult', defaultValue: false)
  final bool? isEnterToResult;

  ///Represents the amount of time passed during the game, measured
  ///in some unit (e.g., seconds). It is an optional parameter and its
  ///default value is 0.
  @override
  @JsonKey(name: 'passedTime', defaultValue: 0)
  final int? passedTime;

  ///createdTime: Represents the timestamp when the game trace was created.
  ///It is a string parameter that holds the date and time information.
  @override
  @JsonKey(name: 'createdTime')
  final String? createdTime;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  final String? createdMillisecondEpoch;

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameTrace(clickToScreenCount: $clickToScreenCount, isEnterToResult: $isEnterToResult, passedTime: $passedTime, createdTime: $createdTime, createdMillisecondEpoch: $createdMillisecondEpoch, endTime: $endTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameTrace'))
      ..add(DiagnosticsProperty('clickToScreenCount', clickToScreenCount))
      ..add(DiagnosticsProperty('isEnterToResult', isEnterToResult))
      ..add(DiagnosticsProperty('passedTime', passedTime))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty(
          'createdMillisecondEpoch', createdMillisecondEpoch))
      ..add(DiagnosticsProperty('endTime', endTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameTrace &&
            (identical(other.clickToScreenCount, clickToScreenCount) ||
                other.clickToScreenCount == clickToScreenCount) &&
            (identical(other.isEnterToResult, isEnterToResult) ||
                other.isEnterToResult == isEnterToResult) &&
            (identical(other.passedTime, passedTime) ||
                other.passedTime == passedTime) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(
                    other.createdMillisecondEpoch, createdMillisecondEpoch) ||
                other.createdMillisecondEpoch == createdMillisecondEpoch) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      clickToScreenCount,
      isEnterToResult,
      passedTime,
      createdTime,
      createdMillisecondEpoch,
      endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameTraceCopyWith<_$_GameTrace> get copyWith =>
      __$$_GameTraceCopyWithImpl<_$_GameTrace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameTraceToJson(
      this,
    );
  }
}

abstract class _GameTrace implements GameTrace {
  const factory _GameTrace(
      {@JsonKey(name: 'clickToScreenCount', defaultValue: 0)
      final int? clickToScreenCount,
      @JsonKey(name: 'isEnterToResult', defaultValue: false)
      final bool? isEnterToResult,
      @JsonKey(name: 'passedTime', defaultValue: 0) final int? passedTime,
      @JsonKey(name: 'createdTime') final String? createdTime,
      @JsonKey(name: "createdMillisecondEpoch")
      final String? createdMillisecondEpoch,
      @JsonKey(name: 'endTime') final String? endTime}) = _$_GameTrace;

  factory _GameTrace.fromJson(Map<String, dynamic> json) =
      _$_GameTrace.fromJson;

  @override

  /// [clickToScreenCount]: Represents the number of clicks made to the
  /// screen during the game. It is an optional parameter and its default
  /// value is 0.
  @JsonKey(name: 'clickToScreenCount', defaultValue: 0)
  int? get clickToScreenCount;
  @override

  ///isEnterToResult: Indicates whether the player has entered the result
  ///screen or not. It is a boolean parameter and its default value is false.
  @JsonKey(name: 'isEnterToResult', defaultValue: false)
  bool? get isEnterToResult;
  @override

  ///Represents the amount of time passed during the game, measured
  ///in some unit (e.g., seconds). It is an optional parameter and its
  ///default value is 0.
  @JsonKey(name: 'passedTime', defaultValue: 0)
  int? get passedTime;
  @override

  ///createdTime: Represents the timestamp when the game trace was created.
  ///It is a string parameter that holds the date and time information.
  @JsonKey(name: 'createdTime')
  String? get createdTime;
  @override
  @JsonKey(name: "createdMillisecondEpoch")
  String? get createdMillisecondEpoch;
  @override

  ///Represents the timestamp when the game trace ended. It is a string
  ///parameter that holds the date and time information.
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(ignore: true)
  _$$_GameTraceCopyWith<_$_GameTrace> get copyWith =>
      throw _privateConstructorUsedError;
}
