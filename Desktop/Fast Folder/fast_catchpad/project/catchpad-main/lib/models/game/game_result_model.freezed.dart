// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameResultModel {
  @JsonKey(required: true)
  GameEndType get type => throw _privateConstructorUsedError;
  @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
  List<PlayerModel> get players => throw _privateConstructorUsedError;
  @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
  List<PlayerResultModel> get playerResults =>
      throw _privateConstructorUsedError;
  @JsonKey(required: true)
  String get gameId => throw _privateConstructorUsedError;
  @JsonKey(nullable: true, defaultValue: '')
  String? get accountHolderId =>
      throw _privateConstructorUsedError; // TODO: this should have a default constructor
// DateTime.now(). there is a SO question about this
// https://stackoverflow.com/questions/67866162/the-constructor-being-called-isnt-a-const-constructor-try-removing-const-fro
// investigate and open an issue if necessary
  @JsonKey(nullable: true, name: 'createdAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(required: true, nullable: false)
  GameScoreType get scoreTypeParam1 => throw _privateConstructorUsedError;
  @JsonKey(nullable: true)
  GameScoreType? get scoreTypeParam2 => throw _privateConstructorUsedError;

  /// this will be calculated before converting
  /// to json, and read from json
  int? get indexValue => throw _privateConstructorUsedError;

  /// this will be calculated before converting
  /// to json, and read from json
  String? get winnerPlayerId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameResultModelCopyWith<GameResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResultModelCopyWith<$Res> {
  factory $GameResultModelCopyWith(
          GameResultModel value, $Res Function(GameResultModel) then) =
      _$GameResultModelCopyWithImpl<$Res, GameResultModel>;
  @useResult
  $Res call(
      {@JsonKey(required: true) GameEndType type,
      @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
      List<PlayerModel> players,
      @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
      List<PlayerResultModel> playerResults,
      @JsonKey(required: true) String gameId,
      @JsonKey(nullable: true, defaultValue: '') String? accountHolderId,
      @JsonKey(nullable: true, name: 'createdAt') DateTime? createdAt,
      @JsonKey(required: true, nullable: false) GameScoreType scoreTypeParam1,
      @JsonKey(nullable: true) GameScoreType? scoreTypeParam2,
      int? indexValue,
      String? winnerPlayerId});
}

/// @nodoc
class _$GameResultModelCopyWithImpl<$Res, $Val extends GameResultModel>
    implements $GameResultModelCopyWith<$Res> {
  _$GameResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? players = null,
    Object? playerResults = null,
    Object? gameId = null,
    Object? accountHolderId = freezed,
    Object? createdAt = freezed,
    Object? scoreTypeParam1 = null,
    Object? scoreTypeParam2 = freezed,
    Object? indexValue = freezed,
    Object? winnerPlayerId = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEndType,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      playerResults: null == playerResults
          ? _value.playerResults
          : playerResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultModel>,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderId: freezed == accountHolderId
          ? _value.accountHolderId
          : accountHolderId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      scoreTypeParam1: null == scoreTypeParam1
          ? _value.scoreTypeParam1
          : scoreTypeParam1 // ignore: cast_nullable_to_non_nullable
              as GameScoreType,
      scoreTypeParam2: freezed == scoreTypeParam2
          ? _value.scoreTypeParam2
          : scoreTypeParam2 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      indexValue: freezed == indexValue
          ? _value.indexValue
          : indexValue // ignore: cast_nullable_to_non_nullable
              as int?,
      winnerPlayerId: freezed == winnerPlayerId
          ? _value.winnerPlayerId
          : winnerPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameResultModelCopyWith<$Res>
    implements $GameResultModelCopyWith<$Res> {
  factory _$$_GameResultModelCopyWith(
          _$_GameResultModel value, $Res Function(_$_GameResultModel) then) =
      __$$_GameResultModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(required: true) GameEndType type,
      @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
      List<PlayerModel> players,
      @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
      List<PlayerResultModel> playerResults,
      @JsonKey(required: true) String gameId,
      @JsonKey(nullable: true, defaultValue: '') String? accountHolderId,
      @JsonKey(nullable: true, name: 'createdAt') DateTime? createdAt,
      @JsonKey(required: true, nullable: false) GameScoreType scoreTypeParam1,
      @JsonKey(nullable: true) GameScoreType? scoreTypeParam2,
      int? indexValue,
      String? winnerPlayerId});
}

/// @nodoc
class __$$_GameResultModelCopyWithImpl<$Res>
    extends _$GameResultModelCopyWithImpl<$Res, _$_GameResultModel>
    implements _$$_GameResultModelCopyWith<$Res> {
  __$$_GameResultModelCopyWithImpl(
      _$_GameResultModel _value, $Res Function(_$_GameResultModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? players = null,
    Object? playerResults = null,
    Object? gameId = null,
    Object? accountHolderId = freezed,
    Object? createdAt = freezed,
    Object? scoreTypeParam1 = null,
    Object? scoreTypeParam2 = freezed,
    Object? indexValue = freezed,
    Object? winnerPlayerId = freezed,
  }) {
    return _then(_$_GameResultModel(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEndType,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      playerResults: null == playerResults
          ? _value._playerResults
          : playerResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultModel>,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderId: freezed == accountHolderId
          ? _value.accountHolderId
          : accountHolderId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      scoreTypeParam1: null == scoreTypeParam1
          ? _value.scoreTypeParam1
          : scoreTypeParam1 // ignore: cast_nullable_to_non_nullable
              as GameScoreType,
      scoreTypeParam2: freezed == scoreTypeParam2
          ? _value.scoreTypeParam2
          : scoreTypeParam2 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      indexValue: freezed == indexValue
          ? _value.indexValue
          : indexValue // ignore: cast_nullable_to_non_nullable
              as int?,
      winnerPlayerId: freezed == winnerPlayerId
          ? _value.winnerPlayerId
          : winnerPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_GameResultModel extends _GameResultModel with DiagnosticableTreeMixin {
  _$_GameResultModel(
      {@JsonKey(required: true) required this.type,
      @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
      final List<PlayerModel> players = const [],
      @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
      final List<PlayerResultModel> playerResults = const [],
      @JsonKey(required: true) required this.gameId,
      @JsonKey(nullable: true, defaultValue: '') required this.accountHolderId,
      @JsonKey(nullable: true, name: 'createdAt') this.createdAt,
      @JsonKey(required: true, nullable: false) required this.scoreTypeParam1,
      @JsonKey(nullable: true) required this.scoreTypeParam2,
      this.indexValue,
      this.winnerPlayerId})
      : _players = players,
        _playerResults = playerResults,
        super._();

  @override
  @JsonKey(required: true)
  final GameEndType type;
  final List<PlayerModel> _players;
  @override
  @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
  List<PlayerModel> get players {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<PlayerResultModel> _playerResults;
  @override
  @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
  List<PlayerResultModel> get playerResults {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerResults);
  }

  @override
  @JsonKey(required: true)
  final String gameId;
  @override
  @JsonKey(nullable: true, defaultValue: '')
  final String? accountHolderId;
// TODO: this should have a default constructor
// DateTime.now(). there is a SO question about this
// https://stackoverflow.com/questions/67866162/the-constructor-being-called-isnt-a-const-constructor-try-removing-const-fro
// investigate and open an issue if necessary
  @override
  @JsonKey(nullable: true, name: 'createdAt')
  final DateTime? createdAt;
  @override
  @JsonKey(required: true, nullable: false)
  final GameScoreType scoreTypeParam1;
  @override
  @JsonKey(nullable: true)
  final GameScoreType? scoreTypeParam2;

  /// this will be calculated before converting
  /// to json, and read from json
  @override
  final int? indexValue;

  /// this will be calculated before converting
  /// to json, and read from json
  @override
  final String? winnerPlayerId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameResultModel(type: $type, players: $players, playerResults: $playerResults, gameId: $gameId, accountHolderId: $accountHolderId, createdAt: $createdAt, scoreTypeParam1: $scoreTypeParam1, scoreTypeParam2: $scoreTypeParam2, indexValue: $indexValue, winnerPlayerId: $winnerPlayerId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameResultModel'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('players', players))
      ..add(DiagnosticsProperty('playerResults', playerResults))
      ..add(DiagnosticsProperty('gameId', gameId))
      ..add(DiagnosticsProperty('accountHolderId', accountHolderId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('scoreTypeParam1', scoreTypeParam1))
      ..add(DiagnosticsProperty('scoreTypeParam2', scoreTypeParam2))
      ..add(DiagnosticsProperty('indexValue', indexValue))
      ..add(DiagnosticsProperty('winnerPlayerId', winnerPlayerId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameResultModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality()
                .equals(other._playerResults, _playerResults) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.accountHolderId, accountHolderId) ||
                other.accountHolderId == accountHolderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scoreTypeParam1, scoreTypeParam1) ||
                other.scoreTypeParam1 == scoreTypeParam1) &&
            (identical(other.scoreTypeParam2, scoreTypeParam2) ||
                other.scoreTypeParam2 == scoreTypeParam2) &&
            (identical(other.indexValue, indexValue) ||
                other.indexValue == indexValue) &&
            (identical(other.winnerPlayerId, winnerPlayerId) ||
                other.winnerPlayerId == winnerPlayerId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_playerResults),
      gameId,
      accountHolderId,
      createdAt,
      scoreTypeParam1,
      scoreTypeParam2,
      indexValue,
      winnerPlayerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameResultModelCopyWith<_$_GameResultModel> get copyWith =>
      __$$_GameResultModelCopyWithImpl<_$_GameResultModel>(this, _$identity);
}

abstract class _GameResultModel extends GameResultModel {
  factory _GameResultModel(
      {@JsonKey(required: true) required final GameEndType type,
      @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
      final List<PlayerModel> players,
      @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
      final List<PlayerResultModel> playerResults,
      @JsonKey(required: true) required final String gameId,
      @JsonKey(nullable: true, defaultValue: '')
      required final String? accountHolderId,
      @JsonKey(nullable: true, name: 'createdAt') final DateTime? createdAt,
      @JsonKey(required: true, nullable: false)
      required final GameScoreType scoreTypeParam1,
      @JsonKey(nullable: true) required final GameScoreType? scoreTypeParam2,
      final int? indexValue,
      final String? winnerPlayerId}) = _$_GameResultModel;
  _GameResultModel._() : super._();

  @override
  @JsonKey(required: true)
  GameEndType get type;
  @override
  @JsonKey(toJson: _playersToJson, fromJson: _playersFromJson)
  List<PlayerModel> get players;
  @override
  @JsonKey(toJson: _playerResultsToJson, fromJson: _playerResultsFromJson)
  List<PlayerResultModel> get playerResults;
  @override
  @JsonKey(required: true)
  String get gameId;
  @override
  @JsonKey(nullable: true, defaultValue: '')
  String? get accountHolderId;
  @override // TODO: this should have a default constructor
// DateTime.now(). there is a SO question about this
// https://stackoverflow.com/questions/67866162/the-constructor-being-called-isnt-a-const-constructor-try-removing-const-fro
// investigate and open an issue if necessary
  @JsonKey(nullable: true, name: 'createdAt')
  DateTime? get createdAt;
  @override
  @JsonKey(required: true, nullable: false)
  GameScoreType get scoreTypeParam1;
  @override
  @JsonKey(nullable: true)
  GameScoreType? get scoreTypeParam2;
  @override

  /// this will be calculated before converting
  /// to json, and read from json
  int? get indexValue;
  @override

  /// this will be calculated before converting
  /// to json, and read from json
  String? get winnerPlayerId;
  @override
  @JsonKey(ignore: true)
  _$$_GameResultModelCopyWith<_$_GameResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}
