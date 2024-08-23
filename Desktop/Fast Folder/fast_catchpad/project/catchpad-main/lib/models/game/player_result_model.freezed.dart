// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'player_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerResultModel _$PlayerResultModelFromJson(Map<String, dynamic> json) {
  return _PlayerResultModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerResultModel {
  String get playerId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  int? get indexValue => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  Map<String, int>? get playerColorCatchCount =>
      throw _privateConstructorUsedError;
  int? get correctCount => throw _privateConstructorUsedError;
  int? get incorrectCount => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int get incorrectWeight => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: spotFromJson,
      toJson: spotToJson,
      defaultValue: [],
      nullable: true)
  List<FlSpot> get graphSpots => throw _privateConstructorUsedError;

  /// this has not been deleted to be able to parse the previous
  /// results kept on the server. in the future we should transform
  /// those data and convert
// ignore: deprecated_member_use_from_same_package
  ///  [timeSpans]
  ///  to [scorePoints].
  @Deprecated(
      'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
  List<Duration>? get timeSpans => throw _privateConstructorUsedError;
  @JsonKey(toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
  List<GameScorePointModel>? get scorePoints =>
      throw _privateConstructorUsedError;

  /// this will be used to store the harmony between the team members
  /// the sentecnce above this makes 0 sense.
  ///
  /// let me explain:
  /// take the ekipIsi game for example, there what we are (previously)
  /// doing is we're stroing the last (second) player's response time.
  /// an additional thing we want for score is the harmony time, which
  /// means the time difference between the 2 players' responses.
  /// these games in the future should use something like
  /// [TeamResultModel] instead of [PlayerResultModel].
  /// I've not implemented that right now because of the time it will consume as
  /// it would require us to rearchitect the whole game system.
  @JsonKey(
      toJson: _scoreToJson,
      fromJson: _harmonyPointsFromJson,
      includeIfNull: true)
  List<GameScorePointModel>? get teamHarmonyPoints =>
      throw _privateConstructorUsedError; // TODO: this is a temp for displaying
// a result in jumpOverThePad game.
  @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
  List<DistanceModel>? get distances => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerResultModelCopyWith<PlayerResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerResultModelCopyWith<$Res> {
  factory $PlayerResultModelCopyWith(
          PlayerResultModel value, $Res Function(PlayerResultModel) then) =
      _$PlayerResultModelCopyWithImpl<$Res, PlayerResultModel>;
  @useResult
  $Res call(
      {String playerId,
      String userName,
      int? indexValue,
      DateTime? startTime,
      DateTime? endTime,
      Map<String, int>? playerColorCatchCount,
      int? correctCount,
      int? incorrectCount,
      int? level,
      int incorrectWeight,
      @JsonKey(
          fromJson: spotFromJson,
          toJson: spotToJson,
          defaultValue: [],
          nullable: true)
      List<FlSpot> graphSpots,
      @Deprecated(
          'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
      List<Duration>? timeSpans,
      @JsonKey(
          toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
      List<GameScorePointModel>? scorePoints,
      @JsonKey(
          toJson: _scoreToJson,
          fromJson: _harmonyPointsFromJson,
          includeIfNull: true)
      List<GameScorePointModel>? teamHarmonyPoints,
      @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
      List<DistanceModel>? distances});
}

/// @nodoc
class _$PlayerResultModelCopyWithImpl<$Res, $Val extends PlayerResultModel>
    implements $PlayerResultModelCopyWith<$Res> {
  _$PlayerResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? userName = null,
    Object? indexValue = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? playerColorCatchCount = freezed,
    Object? correctCount = freezed,
    Object? incorrectCount = freezed,
    Object? level = freezed,
    Object? incorrectWeight = null,
    Object? graphSpots = null,
    Object? timeSpans = freezed,
    Object? scorePoints = freezed,
    Object? teamHarmonyPoints = freezed,
    Object? distances = freezed,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      indexValue: freezed == indexValue
          ? _value.indexValue
          : indexValue // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playerColorCatchCount: freezed == playerColorCatchCount
          ? _value.playerColorCatchCount
          : playerColorCatchCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      correctCount: freezed == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int?,
      incorrectCount: freezed == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      incorrectWeight: null == incorrectWeight
          ? _value.incorrectWeight
          : incorrectWeight // ignore: cast_nullable_to_non_nullable
              as int,
      graphSpots: null == graphSpots
          ? _value.graphSpots
          : graphSpots // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      timeSpans: freezed == timeSpans
          ? _value.timeSpans
          : timeSpans // ignore: cast_nullable_to_non_nullable
              as List<Duration>?,
      scorePoints: freezed == scorePoints
          ? _value.scorePoints
          : scorePoints // ignore: cast_nullable_to_non_nullable
              as List<GameScorePointModel>?,
      teamHarmonyPoints: freezed == teamHarmonyPoints
          ? _value.teamHarmonyPoints
          : teamHarmonyPoints // ignore: cast_nullable_to_non_nullable
              as List<GameScorePointModel>?,
      distances: freezed == distances
          ? _value.distances
          : distances // ignore: cast_nullable_to_non_nullable
              as List<DistanceModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerResultModelCopyWith<$Res>
    implements $PlayerResultModelCopyWith<$Res> {
  factory _$$_PlayerResultModelCopyWith(_$_PlayerResultModel value,
          $Res Function(_$_PlayerResultModel) then) =
      __$$_PlayerResultModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId,
      String userName,
      int? indexValue,
      DateTime? startTime,
      DateTime? endTime,
      Map<String, int>? playerColorCatchCount,
      int? correctCount,
      int? incorrectCount,
      int? level,
      int incorrectWeight,
      @JsonKey(
          fromJson: spotFromJson,
          toJson: spotToJson,
          defaultValue: [],
          nullable: true)
      List<FlSpot> graphSpots,
      @Deprecated(
          'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
      List<Duration>? timeSpans,
      @JsonKey(
          toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
      List<GameScorePointModel>? scorePoints,
      @JsonKey(
          toJson: _scoreToJson,
          fromJson: _harmonyPointsFromJson,
          includeIfNull: true)
      List<GameScorePointModel>? teamHarmonyPoints,
      @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
      List<DistanceModel>? distances});
}

/// @nodoc
class __$$_PlayerResultModelCopyWithImpl<$Res>
    extends _$PlayerResultModelCopyWithImpl<$Res, _$_PlayerResultModel>
    implements _$$_PlayerResultModelCopyWith<$Res> {
  __$$_PlayerResultModelCopyWithImpl(
      _$_PlayerResultModel _value, $Res Function(_$_PlayerResultModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? userName = null,
    Object? indexValue = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? playerColorCatchCount = freezed,
    Object? correctCount = freezed,
    Object? incorrectCount = freezed,
    Object? level = freezed,
    Object? incorrectWeight = null,
    Object? graphSpots = null,
    Object? timeSpans = freezed,
    Object? scorePoints = freezed,
    Object? teamHarmonyPoints = freezed,
    Object? distances = freezed,
  }) {
    return _then(_$_PlayerResultModel(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      indexValue: freezed == indexValue
          ? _value.indexValue
          : indexValue // ignore: cast_nullable_to_non_nullable
              as int?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      playerColorCatchCount: freezed == playerColorCatchCount
          ? _value._playerColorCatchCount
          : playerColorCatchCount // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      correctCount: freezed == correctCount
          ? _value.correctCount
          : correctCount // ignore: cast_nullable_to_non_nullable
              as int?,
      incorrectCount: freezed == incorrectCount
          ? _value.incorrectCount
          : incorrectCount // ignore: cast_nullable_to_non_nullable
              as int?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      incorrectWeight: null == incorrectWeight
          ? _value.incorrectWeight
          : incorrectWeight // ignore: cast_nullable_to_non_nullable
              as int,
      graphSpots: null == graphSpots
          ? _value._graphSpots
          : graphSpots // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      timeSpans: freezed == timeSpans
          ? _value._timeSpans
          : timeSpans // ignore: cast_nullable_to_non_nullable
              as List<Duration>?,
      scorePoints: freezed == scorePoints
          ? _value._scorePoints
          : scorePoints // ignore: cast_nullable_to_non_nullable
              as List<GameScorePointModel>?,
      teamHarmonyPoints: freezed == teamHarmonyPoints
          ? _value._teamHarmonyPoints
          : teamHarmonyPoints // ignore: cast_nullable_to_non_nullable
              as List<GameScorePointModel>?,
      distances: freezed == distances
          ? _value._distances
          : distances // ignore: cast_nullable_to_non_nullable
              as List<DistanceModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerResultModel extends _PlayerResultModel {
  const _$_PlayerResultModel(
      {required this.playerId,
      this.userName = '',
      this.indexValue = 0,
      this.startTime,
      this.endTime,
      final Map<String, int>? playerColorCatchCount,
      this.correctCount,
      this.incorrectCount,
      this.level,
      this.incorrectWeight = 1,
      @JsonKey(
          fromJson: spotFromJson,
          toJson: spotToJson,
          defaultValue: [],
          nullable: true)
      final List<FlSpot> graphSpots = const [],
      @Deprecated(
          'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
      final List<Duration>? timeSpans,
      @JsonKey(
          toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
      final List<GameScorePointModel>? scorePoints,
      @JsonKey(
          toJson: _scoreToJson,
          fromJson: _harmonyPointsFromJson,
          includeIfNull: true)
      final List<GameScorePointModel>? teamHarmonyPoints,
      @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
      final List<DistanceModel>? distances})
      : _playerColorCatchCount = playerColorCatchCount,
        _graphSpots = graphSpots,
        _timeSpans = timeSpans,
        _scorePoints = scorePoints,
        _teamHarmonyPoints = teamHarmonyPoints,
        _distances = distances,
        super._();

  factory _$_PlayerResultModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerResultModelFromJson(json);

  @override
  final String playerId;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final int? indexValue;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  final Map<String, int>? _playerColorCatchCount;
  @override
  Map<String, int>? get playerColorCatchCount {
    final value = _playerColorCatchCount;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? correctCount;
  @override
  final int? incorrectCount;
  @override
  final int? level;
  @override
  @JsonKey()
  final int incorrectWeight;
  final List<FlSpot> _graphSpots;
  @override
  @JsonKey(
      fromJson: spotFromJson,
      toJson: spotToJson,
      defaultValue: [],
      nullable: true)
  List<FlSpot> get graphSpots {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graphSpots);
  }

  /// this has not been deleted to be able to parse the previous
  /// results kept on the server. in the future we should transform
  /// those data and convert
// ignore: deprecated_member_use_from_same_package
  ///  [timeSpans]
  ///  to [scorePoints].
  final List<Duration>? _timeSpans;

  /// this has not been deleted to be able to parse the previous
  /// results kept on the server. in the future we should transform
  /// those data and convert
// ignore: deprecated_member_use_from_same_package
  ///  [timeSpans]
  ///  to [scorePoints].
  @override
  @Deprecated(
      'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
  List<Duration>? get timeSpans {
    final value = _timeSpans;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GameScorePointModel>? _scorePoints;
  @override
  @JsonKey(toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
  List<GameScorePointModel>? get scorePoints {
    final value = _scorePoints;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// this will be used to store the harmony between the team members
  /// the sentecnce above this makes 0 sense.
  ///
  /// let me explain:
  /// take the ekipIsi game for example, there what we are (previously)
  /// doing is we're stroing the last (second) player's response time.
  /// an additional thing we want for score is the harmony time, which
  /// means the time difference between the 2 players' responses.
  /// these games in the future should use something like
  /// [TeamResultModel] instead of [PlayerResultModel].
  /// I've not implemented that right now because of the time it will consume as
  /// it would require us to rearchitect the whole game system.
  final List<GameScorePointModel>? _teamHarmonyPoints;

  /// this will be used to store the harmony between the team members
  /// the sentecnce above this makes 0 sense.
  ///
  /// let me explain:
  /// take the ekipIsi game for example, there what we are (previously)
  /// doing is we're stroing the last (second) player's response time.
  /// an additional thing we want for score is the harmony time, which
  /// means the time difference between the 2 players' responses.
  /// these games in the future should use something like
  /// [TeamResultModel] instead of [PlayerResultModel].
  /// I've not implemented that right now because of the time it will consume as
  /// it would require us to rearchitect the whole game system.
  @override
  @JsonKey(
      toJson: _scoreToJson,
      fromJson: _harmonyPointsFromJson,
      includeIfNull: true)
  List<GameScorePointModel>? get teamHarmonyPoints {
    final value = _teamHarmonyPoints;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// TODO: this is a temp for displaying
// a result in jumpOverThePad game.
  final List<DistanceModel>? _distances;
// TODO: this is a temp for displaying
// a result in jumpOverThePad game.
  @override
  @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
  List<DistanceModel>? get distances {
    final value = _distances;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PlayerResultModel(playerId: $playerId, userName: $userName, indexValue: $indexValue, startTime: $startTime, endTime: $endTime, playerColorCatchCount: $playerColorCatchCount, correctCount: $correctCount, incorrectCount: $incorrectCount, level: $level, incorrectWeight: $incorrectWeight, graphSpots: $graphSpots, timeSpans: $timeSpans, scorePoints: $scorePoints, teamHarmonyPoints: $teamHarmonyPoints, distances: $distances)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerResultModel &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.indexValue, indexValue) ||
                other.indexValue == indexValue) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other._playerColorCatchCount, _playerColorCatchCount) &&
            (identical(other.correctCount, correctCount) ||
                other.correctCount == correctCount) &&
            (identical(other.incorrectCount, incorrectCount) ||
                other.incorrectCount == incorrectCount) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.incorrectWeight, incorrectWeight) ||
                other.incorrectWeight == incorrectWeight) &&
            const DeepCollectionEquality()
                .equals(other._graphSpots, _graphSpots) &&
            const DeepCollectionEquality()
                .equals(other._timeSpans, _timeSpans) &&
            const DeepCollectionEquality()
                .equals(other._scorePoints, _scorePoints) &&
            const DeepCollectionEquality()
                .equals(other._teamHarmonyPoints, _teamHarmonyPoints) &&
            const DeepCollectionEquality()
                .equals(other._distances, _distances));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerId,
      userName,
      indexValue,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(_playerColorCatchCount),
      correctCount,
      incorrectCount,
      level,
      incorrectWeight,
      const DeepCollectionEquality().hash(_graphSpots),
      const DeepCollectionEquality().hash(_timeSpans),
      const DeepCollectionEquality().hash(_scorePoints),
      const DeepCollectionEquality().hash(_teamHarmonyPoints),
      const DeepCollectionEquality().hash(_distances));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerResultModelCopyWith<_$_PlayerResultModel> get copyWith =>
      __$$_PlayerResultModelCopyWithImpl<_$_PlayerResultModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerResultModelToJson(
      this,
    );
  }
}

abstract class _PlayerResultModel extends PlayerResultModel {
  const factory _PlayerResultModel(
      {required final String playerId,
      final String userName,
      final int? indexValue,
      final DateTime? startTime,
      final DateTime? endTime,
      final Map<String, int>? playerColorCatchCount,
      final int? correctCount,
      final int? incorrectCount,
      final int? level,
      final int incorrectWeight,
      @JsonKey(
          fromJson: spotFromJson,
          toJson: spotToJson,
          defaultValue: [],
          nullable: true)
      final List<FlSpot> graphSpots,
      @Deprecated(
          'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
      final List<Duration>? timeSpans,
      @JsonKey(
          toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
      final List<GameScorePointModel>? scorePoints,
      @JsonKey(
          toJson: _scoreToJson,
          fromJson: _harmonyPointsFromJson,
          includeIfNull: true)
      final List<GameScorePointModel>? teamHarmonyPoints,
      @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
      final List<DistanceModel>? distances}) = _$_PlayerResultModel;
  const _PlayerResultModel._() : super._();

  factory _PlayerResultModel.fromJson(Map<String, dynamic> json) =
      _$_PlayerResultModel.fromJson;

  @override
  String get playerId;
  @override
  String get userName;
  @override
  int? get indexValue;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  Map<String, int>? get playerColorCatchCount;
  @override
  int? get correctCount;
  @override
  int? get incorrectCount;
  @override
  int? get level;
  @override
  int get incorrectWeight;
  @override
  @JsonKey(
      fromJson: spotFromJson,
      toJson: spotToJson,
      defaultValue: [],
      nullable: true)
  List<FlSpot> get graphSpots;
  @override

  /// this has not been deleted to be able to parse the previous
  /// results kept on the server. in the future we should transform
  /// those data and convert
// ignore: deprecated_member_use_from_same_package
  ///  [timeSpans]
  ///  to [scorePoints].
  @Deprecated(
      'this has been deprecated because we need to link every timespan with its time https://app.clickup.com/t/31u27yu. use scorePoints instead')
  List<Duration>? get timeSpans;
  @override
  @JsonKey(toJson: _scoreToJson, fromJson: _scoreFromJson, includeIfNull: true)
  List<GameScorePointModel>? get scorePoints;
  @override

  /// this will be used to store the harmony between the team members
  /// the sentecnce above this makes 0 sense.
  ///
  /// let me explain:
  /// take the ekipIsi game for example, there what we are (previously)
  /// doing is we're stroing the last (second) player's response time.
  /// an additional thing we want for score is the harmony time, which
  /// means the time difference between the 2 players' responses.
  /// these games in the future should use something like
  /// [TeamResultModel] instead of [PlayerResultModel].
  /// I've not implemented that right now because of the time it will consume as
  /// it would require us to rearchitect the whole game system.
  @JsonKey(
      toJson: _scoreToJson,
      fromJson: _harmonyPointsFromJson,
      includeIfNull: true)
  List<GameScorePointModel>? get teamHarmonyPoints;
  @override // TODO: this is a temp for displaying
// a result in jumpOverThePad game.
  @JsonKey(toJson: _distanceToJson, fromJson: _distanceFromJson)
  List<DistanceModel>? get distances;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerResultModelCopyWith<_$_PlayerResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}
