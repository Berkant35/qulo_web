// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'play_trace.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayTrace _$PlayTraceFromJson(Map<String, dynamic> json) {
  return _PlayTrace.fromJson(json);
}

/// @nodoc
mixin _$PlayTrace {
  ///This parameter fills when start a game.This parameters show
  ///about which set conditions by user for this game.
  @JsonKey(name: 'gameControlSetup', defaultValue: {})
  Map<String, dynamic> get gameControlSetup =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'createdTime')
  String? get createdTime => throw _privateConstructorUsedError;

  /// [GameTrace] help us about user actions for  when playing game
  @JsonKey(name: 'gameTrace')
  GameTrace? get gameTrace => throw _privateConstructorUsedError;

  /// [MetaTrace] helps us track which game was entered by the user.
  @JsonKey(name: 'metaTrace')
  MetaTrace? get metaTrace => throw _privateConstructorUsedError;

  /// [ResultTrace] assists us in tracking user actions when the game
  /// is finished.
  @JsonKey(name: 'resultTrace')
  ResultTrace? get resultTrace => throw _privateConstructorUsedError;

  /// [PreTrace] assists us in tracking user actions before entering the game.
  @JsonKey(name: 'preTrace')
  PreTrace? get preTrace => throw _privateConstructorUsedError;
  @JsonKey(name: "millisecondEpoch")
  String? get createdMillisecondEpoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayTraceCopyWith<PlayTrace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayTraceCopyWith<$Res> {
  factory $PlayTraceCopyWith(PlayTrace value, $Res Function(PlayTrace) then) =
      _$PlayTraceCopyWithImpl<$Res, PlayTrace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'gameControlSetup', defaultValue: {})
      Map<String, dynamic> gameControlSetup,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: 'gameTrace') GameTrace? gameTrace,
      @JsonKey(name: 'metaTrace') MetaTrace? metaTrace,
      @JsonKey(name: 'resultTrace') ResultTrace? resultTrace,
      @JsonKey(name: 'preTrace') PreTrace? preTrace,
      @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch});

  $GameTraceCopyWith<$Res>? get gameTrace;
  $MetaTraceCopyWith<$Res>? get metaTrace;
  $ResultTraceCopyWith<$Res>? get resultTrace;
  $PreTraceCopyWith<$Res>? get preTrace;
}

/// @nodoc
class _$PlayTraceCopyWithImpl<$Res, $Val extends PlayTrace>
    implements $PlayTraceCopyWith<$Res> {
  _$PlayTraceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameControlSetup = null,
    Object? createdTime = freezed,
    Object? gameTrace = freezed,
    Object? metaTrace = freezed,
    Object? resultTrace = freezed,
    Object? preTrace = freezed,
    Object? createdMillisecondEpoch = freezed,
  }) {
    return _then(_value.copyWith(
      gameControlSetup: null == gameControlSetup
          ? _value.gameControlSetup
          : gameControlSetup // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameTrace: freezed == gameTrace
          ? _value.gameTrace
          : gameTrace // ignore: cast_nullable_to_non_nullable
              as GameTrace?,
      metaTrace: freezed == metaTrace
          ? _value.metaTrace
          : metaTrace // ignore: cast_nullable_to_non_nullable
              as MetaTrace?,
      resultTrace: freezed == resultTrace
          ? _value.resultTrace
          : resultTrace // ignore: cast_nullable_to_non_nullable
              as ResultTrace?,
      preTrace: freezed == preTrace
          ? _value.preTrace
          : preTrace // ignore: cast_nullable_to_non_nullable
              as PreTrace?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameTraceCopyWith<$Res>? get gameTrace {
    if (_value.gameTrace == null) {
      return null;
    }

    return $GameTraceCopyWith<$Res>(_value.gameTrace!, (value) {
      return _then(_value.copyWith(gameTrace: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MetaTraceCopyWith<$Res>? get metaTrace {
    if (_value.metaTrace == null) {
      return null;
    }

    return $MetaTraceCopyWith<$Res>(_value.metaTrace!, (value) {
      return _then(_value.copyWith(metaTrace: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ResultTraceCopyWith<$Res>? get resultTrace {
    if (_value.resultTrace == null) {
      return null;
    }

    return $ResultTraceCopyWith<$Res>(_value.resultTrace!, (value) {
      return _then(_value.copyWith(resultTrace: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PreTraceCopyWith<$Res>? get preTrace {
    if (_value.preTrace == null) {
      return null;
    }

    return $PreTraceCopyWith<$Res>(_value.preTrace!, (value) {
      return _then(_value.copyWith(preTrace: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlayTraceCopyWith<$Res> implements $PlayTraceCopyWith<$Res> {
  factory _$$_PlayTraceCopyWith(
          _$_PlayTrace value, $Res Function(_$_PlayTrace) then) =
      __$$_PlayTraceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'gameControlSetup', defaultValue: {})
      Map<String, dynamic> gameControlSetup,
      @JsonKey(name: 'createdTime') String? createdTime,
      @JsonKey(name: 'gameTrace') GameTrace? gameTrace,
      @JsonKey(name: 'metaTrace') MetaTrace? metaTrace,
      @JsonKey(name: 'resultTrace') ResultTrace? resultTrace,
      @JsonKey(name: 'preTrace') PreTrace? preTrace,
      @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch});

  @override
  $GameTraceCopyWith<$Res>? get gameTrace;
  @override
  $MetaTraceCopyWith<$Res>? get metaTrace;
  @override
  $ResultTraceCopyWith<$Res>? get resultTrace;
  @override
  $PreTraceCopyWith<$Res>? get preTrace;
}

/// @nodoc
class __$$_PlayTraceCopyWithImpl<$Res>
    extends _$PlayTraceCopyWithImpl<$Res, _$_PlayTrace>
    implements _$$_PlayTraceCopyWith<$Res> {
  __$$_PlayTraceCopyWithImpl(
      _$_PlayTrace _value, $Res Function(_$_PlayTrace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameControlSetup = null,
    Object? createdTime = freezed,
    Object? gameTrace = freezed,
    Object? metaTrace = freezed,
    Object? resultTrace = freezed,
    Object? preTrace = freezed,
    Object? createdMillisecondEpoch = freezed,
  }) {
    return _then(_$_PlayTrace(
      gameControlSetup: null == gameControlSetup
          ? _value._gameControlSetup
          : gameControlSetup // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdTime: freezed == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameTrace: freezed == gameTrace
          ? _value.gameTrace
          : gameTrace // ignore: cast_nullable_to_non_nullable
              as GameTrace?,
      metaTrace: freezed == metaTrace
          ? _value.metaTrace
          : metaTrace // ignore: cast_nullable_to_non_nullable
              as MetaTrace?,
      resultTrace: freezed == resultTrace
          ? _value.resultTrace
          : resultTrace // ignore: cast_nullable_to_non_nullable
              as ResultTrace?,
      preTrace: freezed == preTrace
          ? _value.preTrace
          : preTrace // ignore: cast_nullable_to_non_nullable
              as PreTrace?,
      createdMillisecondEpoch: freezed == createdMillisecondEpoch
          ? _value.createdMillisecondEpoch
          : createdMillisecondEpoch // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayTrace implements _PlayTrace {
  const _$_PlayTrace(
      {@JsonKey(name: 'gameControlSetup', defaultValue: {})
      final Map<String, dynamic> gameControlSetup = const {},
      @JsonKey(name: 'createdTime') this.createdTime,
      @JsonKey(name: 'gameTrace') this.gameTrace = const GameTrace(),
      @JsonKey(name: 'metaTrace') this.metaTrace = const MetaTrace(),
      @JsonKey(name: 'resultTrace') this.resultTrace = const ResultTrace(),
      @JsonKey(name: 'preTrace') this.preTrace = const PreTrace(),
      @JsonKey(name: "millisecondEpoch") this.createdMillisecondEpoch})
      : _gameControlSetup = gameControlSetup;

  factory _$_PlayTrace.fromJson(Map<String, dynamic> json) =>
      _$$_PlayTraceFromJson(json);

  ///This parameter fills when start a game.This parameters show
  ///about which set conditions by user for this game.
  final Map<String, dynamic> _gameControlSetup;

  ///This parameter fills when start a game.This parameters show
  ///about which set conditions by user for this game.
  @override
  @JsonKey(name: 'gameControlSetup', defaultValue: {})
  Map<String, dynamic> get gameControlSetup {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_gameControlSetup);
  }

  @override
  @JsonKey(name: 'createdTime')
  final String? createdTime;

  /// [GameTrace] help us about user actions for  when playing game
  @override
  @JsonKey(name: 'gameTrace')
  final GameTrace? gameTrace;

  /// [MetaTrace] helps us track which game was entered by the user.
  @override
  @JsonKey(name: 'metaTrace')
  final MetaTrace? metaTrace;

  /// [ResultTrace] assists us in tracking user actions when the game
  /// is finished.
  @override
  @JsonKey(name: 'resultTrace')
  final ResultTrace? resultTrace;

  /// [PreTrace] assists us in tracking user actions before entering the game.
  @override
  @JsonKey(name: 'preTrace')
  final PreTrace? preTrace;
  @override
  @JsonKey(name: "millisecondEpoch")
  final String? createdMillisecondEpoch;

  @override
  String toString() {
    return 'PlayTrace(gameControlSetup: $gameControlSetup, createdTime: $createdTime, gameTrace: $gameTrace, metaTrace: $metaTrace, resultTrace: $resultTrace, preTrace: $preTrace, createdMillisecondEpoch: $createdMillisecondEpoch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayTrace &&
            const DeepCollectionEquality()
                .equals(other._gameControlSetup, _gameControlSetup) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.gameTrace, gameTrace) ||
                other.gameTrace == gameTrace) &&
            (identical(other.metaTrace, metaTrace) ||
                other.metaTrace == metaTrace) &&
            (identical(other.resultTrace, resultTrace) ||
                other.resultTrace == resultTrace) &&
            (identical(other.preTrace, preTrace) ||
                other.preTrace == preTrace) &&
            (identical(
                    other.createdMillisecondEpoch, createdMillisecondEpoch) ||
                other.createdMillisecondEpoch == createdMillisecondEpoch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_gameControlSetup),
      createdTime,
      gameTrace,
      metaTrace,
      resultTrace,
      preTrace,
      createdMillisecondEpoch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayTraceCopyWith<_$_PlayTrace> get copyWith =>
      __$$_PlayTraceCopyWithImpl<_$_PlayTrace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayTraceToJson(
      this,
    );
  }
}

abstract class _PlayTrace implements PlayTrace {
  const factory _PlayTrace(
      {@JsonKey(name: 'gameControlSetup', defaultValue: {})
      final Map<String, dynamic> gameControlSetup,
      @JsonKey(name: 'createdTime') final String? createdTime,
      @JsonKey(name: 'gameTrace') final GameTrace? gameTrace,
      @JsonKey(name: 'metaTrace') final MetaTrace? metaTrace,
      @JsonKey(name: 'resultTrace') final ResultTrace? resultTrace,
      @JsonKey(name: 'preTrace') final PreTrace? preTrace,
      @JsonKey(name: "millisecondEpoch")
      final String? createdMillisecondEpoch}) = _$_PlayTrace;

  factory _PlayTrace.fromJson(Map<String, dynamic> json) =
      _$_PlayTrace.fromJson;

  @override

  ///This parameter fills when start a game.This parameters show
  ///about which set conditions by user for this game.
  @JsonKey(name: 'gameControlSetup', defaultValue: {})
  Map<String, dynamic> get gameControlSetup;
  @override
  @JsonKey(name: 'createdTime')
  String? get createdTime;
  @override

  /// [GameTrace] help us about user actions for  when playing game
  @JsonKey(name: 'gameTrace')
  GameTrace? get gameTrace;
  @override

  /// [MetaTrace] helps us track which game was entered by the user.
  @JsonKey(name: 'metaTrace')
  MetaTrace? get metaTrace;
  @override

  /// [ResultTrace] assists us in tracking user actions when the game
  /// is finished.
  @JsonKey(name: 'resultTrace')
  ResultTrace? get resultTrace;
  @override

  /// [PreTrace] assists us in tracking user actions before entering the game.
  @JsonKey(name: 'preTrace')
  PreTrace? get preTrace;
  @override
  @JsonKey(name: "millisecondEpoch")
  String? get createdMillisecondEpoch;
  @override
  @JsonKey(ignore: true)
  _$$_PlayTraceCopyWith<_$_PlayTrace> get copyWith =>
      throw _privateConstructorUsedError;
}
