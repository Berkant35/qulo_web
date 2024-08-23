// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_metadata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameMetaDataModel _$GameMetaDataModelFromJson(Map<String, dynamic> json) {
  return _GameMetaDataModel.fromJson(json);
}

/// @nodoc
mixin _$GameMetaDataModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String? get primaryScoreString => throw _privateConstructorUsedError; //
  List<GameEarning> get earnings => throw _privateConstructorUsedError;
  GameTag get tag => throw _privateConstructorUsedError;

  /// [isContainOnIga] if you want active iga conditions you
  /// must look first to this parameter and then of course you must look
  /// [currentEmbModeManager].This state must be 1
  bool get isContainOnIga => throw _privateConstructorUsedError;
  String? get inGameIgaHeader => throw _privateConstructorUsedError;

  /// [igaTextSpans] This parameter created for special explain to customer at IGA.
  /// So you can change by this parameter what you want show on platform screen
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaTextSpans => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaCountDownTextSpans =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaIngGameTextSpans =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get igaPickColor => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get igaMultiplePickColor => throw _privateConstructorUsedError;
  GameBadgeTypes get badgeType => throw _privateConstructorUsedError;

  /// the int key is the priority index of the category.
  /// so if this game has 2 of [GameCategory.multiplayer]
  /// and other has 1 of [GameCategory.multiplayer],
  /// the other will be the first one in the list.
  /// the value may be null, indicating that this
  /// should be in the last position.
  Map<GameCategory, int?> get categories =>
      throw _privateConstructorUsedError; //
  NumRange get playerCount => throw _privateConstructorUsedError;

  /// This parameter help to define how many color count per player
  /// this parameter shows how much could add pad count which game
  NumRange? get gamePadCount => throw _privateConstructorUsedError;

  /// the min of this has to be the min for
  /// min player count. e.g. min player count
  /// is 2, and min 2 pads for each player,
  /// then min pad count is 4. and when the
  /// user adds a 3rd player, we'll force them
  /// to have at least 6 pads.
  NumRange get padCount => throw _privateConstructorUsedError;

  /// the values are in seconds
  NumRange? get duration => throw _privateConstructorUsedError;

  /// Is there any delay between pad leds like games in formula?
  /// default delay value is 2 seconds
  NumRange? get delay => throw _privateConstructorUsedError;

  /// the values are in milliseconds, so we have to use
  /// NumRange.distanceCm on this one as our excel values
  /// are in centimeters.
  NumRange? get distance => throw _privateConstructorUsedError;

  /// the values are in seconds. And sometimes we need define open light time.
  /// So we can help this parameter.
  NumRange? get timeout => throw _privateConstructorUsedError;

  /// Sensitivty for motion games
  /// assign radius value for pads
  NumRange? get radius => throw _privateConstructorUsedError;
  NumRange? get vibrationRadius => throw _privateConstructorUsedError;

  /// this method will give you each result of each player in the
  /// game and let you be responsible to provide key value pairs
  /// for the results of this player.
  /// the output of this will be displayed to the user in a post
  /// game score dialog and in the leaderboard.
  ///
  /// leaving this null will result in the score disaplaying
  /// [GameResultModel.resultsMap]
  ///
  /// if [allResultsListing] is specified, then this will be ignored.
  ///
  /// for now we're making this an unserializable thing, but in the
  /// future when we wanna support fetching metadata from the server,
  /// this can be converted to a map with:
  ///   key: the title of that value localized to the app's language
  ///   value: an enum of the type of the value, and the value should
  ///          be retrieved accordingly.
  ///   example:
  ///   ```dart
  ///   {
  ///     'Player Name': PlayerResultType.playerName,
  ///   }
  ///   ```
  ///
  ///
  /// here is a valid usage example of this:
  /// ```dart
  /// (context, results, result, player) {
  ///   final inst = L10n.inst(context);
  ///
  ///   final map = <String, String?>{
  ///     if (player.playerName != null)
  ///       inst.activity_default_scores_name: player.playerName?.toString(),
  ///     inst.activity_default_scores_total_duration:
  ///         e.totalDuration?.formatSecondsMilli(context).toString(),
  ///   };
  ///
  ///   return map;
  /// };
  /// ```
  ///
  @JsonKey(ignore: true)
  SinglePlayerListingCB? get singlePlayerListing =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameMetaDataModelCopyWith<GameMetaDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameMetaDataModelCopyWith<$Res> {
  factory $GameMetaDataModelCopyWith(
          GameMetaDataModel value, $Res Function(GameMetaDataModel) then) =
      _$GameMetaDataModelCopyWithImpl<$Res, GameMetaDataModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imagePath,
      String? primaryScoreString,
      List<GameEarning> earnings,
      GameTag tag,
      bool isContainOnIga,
      String? inGameIgaHeader,
      @JsonKey(ignore: true) List<List<TextSpan>> igaTextSpans,
      @JsonKey(ignore: true) List<List<TextSpan>> igaCountDownTextSpans,
      @JsonKey(ignore: true) List<List<TextSpan>> igaIngGameTextSpans,
      @JsonKey(ignore: true) bool igaPickColor,
      @JsonKey(ignore: true) bool igaMultiplePickColor,
      GameBadgeTypes badgeType,
      Map<GameCategory, int?> categories,
      NumRange playerCount,
      NumRange? gamePadCount,
      NumRange padCount,
      NumRange? duration,
      NumRange? delay,
      NumRange? distance,
      NumRange? timeout,
      NumRange? radius,
      NumRange? vibrationRadius,
      @JsonKey(ignore: true) SinglePlayerListingCB? singlePlayerListing});

  $NumRangeCopyWith<$Res> get playerCount;
  $NumRangeCopyWith<$Res>? get gamePadCount;
  $NumRangeCopyWith<$Res> get padCount;
  $NumRangeCopyWith<$Res>? get duration;
  $NumRangeCopyWith<$Res>? get delay;
  $NumRangeCopyWith<$Res>? get distance;
  $NumRangeCopyWith<$Res>? get timeout;
  $NumRangeCopyWith<$Res>? get radius;
  $NumRangeCopyWith<$Res>? get vibrationRadius;
}

/// @nodoc
class _$GameMetaDataModelCopyWithImpl<$Res, $Val extends GameMetaDataModel>
    implements $GameMetaDataModelCopyWith<$Res> {
  _$GameMetaDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imagePath = null,
    Object? primaryScoreString = freezed,
    Object? earnings = null,
    Object? tag = null,
    Object? isContainOnIga = null,
    Object? inGameIgaHeader = freezed,
    Object? igaTextSpans = null,
    Object? igaCountDownTextSpans = null,
    Object? igaIngGameTextSpans = null,
    Object? igaPickColor = null,
    Object? igaMultiplePickColor = null,
    Object? badgeType = null,
    Object? categories = null,
    Object? playerCount = null,
    Object? gamePadCount = freezed,
    Object? padCount = null,
    Object? duration = freezed,
    Object? delay = freezed,
    Object? distance = freezed,
    Object? timeout = freezed,
    Object? radius = freezed,
    Object? vibrationRadius = freezed,
    Object? singlePlayerListing = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      primaryScoreString: freezed == primaryScoreString
          ? _value.primaryScoreString
          : primaryScoreString // ignore: cast_nullable_to_non_nullable
              as String?,
      earnings: null == earnings
          ? _value.earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as List<GameEarning>,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as GameTag,
      isContainOnIga: null == isContainOnIga
          ? _value.isContainOnIga
          : isContainOnIga // ignore: cast_nullable_to_non_nullable
              as bool,
      inGameIgaHeader: freezed == inGameIgaHeader
          ? _value.inGameIgaHeader
          : inGameIgaHeader // ignore: cast_nullable_to_non_nullable
              as String?,
      igaTextSpans: null == igaTextSpans
          ? _value.igaTextSpans
          : igaTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaCountDownTextSpans: null == igaCountDownTextSpans
          ? _value.igaCountDownTextSpans
          : igaCountDownTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaIngGameTextSpans: null == igaIngGameTextSpans
          ? _value.igaIngGameTextSpans
          : igaIngGameTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaPickColor: null == igaPickColor
          ? _value.igaPickColor
          : igaPickColor // ignore: cast_nullable_to_non_nullable
              as bool,
      igaMultiplePickColor: null == igaMultiplePickColor
          ? _value.igaMultiplePickColor
          : igaMultiplePickColor // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeType: null == badgeType
          ? _value.badgeType
          : badgeType // ignore: cast_nullable_to_non_nullable
              as GameBadgeTypes,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<GameCategory, int?>,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as NumRange,
      gamePadCount: freezed == gamePadCount
          ? _value.gamePadCount
          : gamePadCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      padCount: null == padCount
          ? _value.padCount
          : padCount // ignore: cast_nullable_to_non_nullable
              as NumRange,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      vibrationRadius: freezed == vibrationRadius
          ? _value.vibrationRadius
          : vibrationRadius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      singlePlayerListing: freezed == singlePlayerListing
          ? _value.singlePlayerListing
          : singlePlayerListing // ignore: cast_nullable_to_non_nullable
              as SinglePlayerListingCB?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res> get playerCount {
    return $NumRangeCopyWith<$Res>(_value.playerCount, (value) {
      return _then(_value.copyWith(playerCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get gamePadCount {
    if (_value.gamePadCount == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.gamePadCount!, (value) {
      return _then(_value.copyWith(gamePadCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res> get padCount {
    return $NumRangeCopyWith<$Res>(_value.padCount, (value) {
      return _then(_value.copyWith(padCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get duration {
    if (_value.duration == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.duration!, (value) {
      return _then(_value.copyWith(duration: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get delay {
    if (_value.delay == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.delay!, (value) {
      return _then(_value.copyWith(delay: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get distance {
    if (_value.distance == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.distance!, (value) {
      return _then(_value.copyWith(distance: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get timeout {
    if (_value.timeout == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.timeout!, (value) {
      return _then(_value.copyWith(timeout: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get radius {
    if (_value.radius == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.radius!, (value) {
      return _then(_value.copyWith(radius: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get vibrationRadius {
    if (_value.vibrationRadius == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.vibrationRadius!, (value) {
      return _then(_value.copyWith(vibrationRadius: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GameMetaDataModelCopyWith<$Res>
    implements $GameMetaDataModelCopyWith<$Res> {
  factory _$$_GameMetaDataModelCopyWith(_$_GameMetaDataModel value,
          $Res Function(_$_GameMetaDataModel) then) =
      __$$_GameMetaDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String imagePath,
      String? primaryScoreString,
      List<GameEarning> earnings,
      GameTag tag,
      bool isContainOnIga,
      String? inGameIgaHeader,
      @JsonKey(ignore: true) List<List<TextSpan>> igaTextSpans,
      @JsonKey(ignore: true) List<List<TextSpan>> igaCountDownTextSpans,
      @JsonKey(ignore: true) List<List<TextSpan>> igaIngGameTextSpans,
      @JsonKey(ignore: true) bool igaPickColor,
      @JsonKey(ignore: true) bool igaMultiplePickColor,
      GameBadgeTypes badgeType,
      Map<GameCategory, int?> categories,
      NumRange playerCount,
      NumRange? gamePadCount,
      NumRange padCount,
      NumRange? duration,
      NumRange? delay,
      NumRange? distance,
      NumRange? timeout,
      NumRange? radius,
      NumRange? vibrationRadius,
      @JsonKey(ignore: true) SinglePlayerListingCB? singlePlayerListing});

  @override
  $NumRangeCopyWith<$Res> get playerCount;
  @override
  $NumRangeCopyWith<$Res>? get gamePadCount;
  @override
  $NumRangeCopyWith<$Res> get padCount;
  @override
  $NumRangeCopyWith<$Res>? get duration;
  @override
  $NumRangeCopyWith<$Res>? get delay;
  @override
  $NumRangeCopyWith<$Res>? get distance;
  @override
  $NumRangeCopyWith<$Res>? get timeout;
  @override
  $NumRangeCopyWith<$Res>? get radius;
  @override
  $NumRangeCopyWith<$Res>? get vibrationRadius;
}

/// @nodoc
class __$$_GameMetaDataModelCopyWithImpl<$Res>
    extends _$GameMetaDataModelCopyWithImpl<$Res, _$_GameMetaDataModel>
    implements _$$_GameMetaDataModelCopyWith<$Res> {
  __$$_GameMetaDataModelCopyWithImpl(
      _$_GameMetaDataModel _value, $Res Function(_$_GameMetaDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? imagePath = null,
    Object? primaryScoreString = freezed,
    Object? earnings = null,
    Object? tag = null,
    Object? isContainOnIga = null,
    Object? inGameIgaHeader = freezed,
    Object? igaTextSpans = null,
    Object? igaCountDownTextSpans = null,
    Object? igaIngGameTextSpans = null,
    Object? igaPickColor = null,
    Object? igaMultiplePickColor = null,
    Object? badgeType = null,
    Object? categories = null,
    Object? playerCount = null,
    Object? gamePadCount = freezed,
    Object? padCount = null,
    Object? duration = freezed,
    Object? delay = freezed,
    Object? distance = freezed,
    Object? timeout = freezed,
    Object? radius = freezed,
    Object? vibrationRadius = freezed,
    Object? singlePlayerListing = freezed,
  }) {
    return _then(_$_GameMetaDataModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      primaryScoreString: freezed == primaryScoreString
          ? _value.primaryScoreString
          : primaryScoreString // ignore: cast_nullable_to_non_nullable
              as String?,
      earnings: null == earnings
          ? _value._earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as List<GameEarning>,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as GameTag,
      isContainOnIga: null == isContainOnIga
          ? _value.isContainOnIga
          : isContainOnIga // ignore: cast_nullable_to_non_nullable
              as bool,
      inGameIgaHeader: freezed == inGameIgaHeader
          ? _value.inGameIgaHeader
          : inGameIgaHeader // ignore: cast_nullable_to_non_nullable
              as String?,
      igaTextSpans: null == igaTextSpans
          ? _value._igaTextSpans
          : igaTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaCountDownTextSpans: null == igaCountDownTextSpans
          ? _value._igaCountDownTextSpans
          : igaCountDownTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaIngGameTextSpans: null == igaIngGameTextSpans
          ? _value._igaIngGameTextSpans
          : igaIngGameTextSpans // ignore: cast_nullable_to_non_nullable
              as List<List<TextSpan>>,
      igaPickColor: null == igaPickColor
          ? _value.igaPickColor
          : igaPickColor // ignore: cast_nullable_to_non_nullable
              as bool,
      igaMultiplePickColor: null == igaMultiplePickColor
          ? _value.igaMultiplePickColor
          : igaMultiplePickColor // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeType: null == badgeType
          ? _value.badgeType
          : badgeType // ignore: cast_nullable_to_non_nullable
              as GameBadgeTypes,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<GameCategory, int?>,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as NumRange,
      gamePadCount: freezed == gamePadCount
          ? _value.gamePadCount
          : gamePadCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      padCount: null == padCount
          ? _value.padCount
          : padCount // ignore: cast_nullable_to_non_nullable
              as NumRange,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      vibrationRadius: freezed == vibrationRadius
          ? _value.vibrationRadius
          : vibrationRadius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      singlePlayerListing: freezed == singlePlayerListing
          ? _value.singlePlayerListing
          : singlePlayerListing // ignore: cast_nullable_to_non_nullable
              as SinglePlayerListingCB?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameMetaDataModel extends _GameMetaDataModel {
  _$_GameMetaDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imagePath,
      this.primaryScoreString,
      required final List<GameEarning> earnings,
      required this.tag,
      this.isContainOnIga = false,
      this.inGameIgaHeader,
      @JsonKey(ignore: true) final List<List<TextSpan>> igaTextSpans = const [],
      @JsonKey(ignore: true)
      final List<List<TextSpan>> igaCountDownTextSpans = const [],
      @JsonKey(ignore: true)
      final List<List<TextSpan>> igaIngGameTextSpans = const [],
      @JsonKey(ignore: true) this.igaPickColor = false,
      @JsonKey(ignore: true) this.igaMultiplePickColor = false,
      this.badgeType = GameBadgeTypes.none,
      required final Map<GameCategory, int?> categories,
      required this.playerCount,
      this.gamePadCount,
      required this.padCount,
      this.duration,
      this.delay,
      this.distance,
      this.timeout,
      this.radius,
      this.vibrationRadius,
      @JsonKey(ignore: true) this.singlePlayerListing})
      : _earnings = earnings,
        _igaTextSpans = igaTextSpans,
        _igaCountDownTextSpans = igaCountDownTextSpans,
        _igaIngGameTextSpans = igaIngGameTextSpans,
        _categories = categories,
        super._();

  factory _$_GameMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_GameMetaDataModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imagePath;
  @override
  final String? primaryScoreString;
//
  final List<GameEarning> _earnings;
//
  @override
  List<GameEarning> get earnings {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earnings);
  }

  @override
  final GameTag tag;

  /// [isContainOnIga] if you want active iga conditions you
  /// must look first to this parameter and then of course you must look
  /// [currentEmbModeManager].This state must be 1
  @override
  @JsonKey()
  final bool isContainOnIga;
  @override
  final String? inGameIgaHeader;

  /// [igaTextSpans] This parameter created for special explain to customer at IGA.
  /// So you can change by this parameter what you want show on platform screen
  final List<List<TextSpan>> _igaTextSpans;

  /// [igaTextSpans] This parameter created for special explain to customer at IGA.
  /// So you can change by this parameter what you want show on platform screen
  @override
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaTextSpans {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_igaTextSpans);
  }

  final List<List<TextSpan>> _igaCountDownTextSpans;
  @override
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaCountDownTextSpans {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_igaCountDownTextSpans);
  }

  final List<List<TextSpan>> _igaIngGameTextSpans;
  @override
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaIngGameTextSpans {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_igaIngGameTextSpans);
  }

  @override
  @JsonKey(ignore: true)
  final bool igaPickColor;
  @override
  @JsonKey(ignore: true)
  final bool igaMultiplePickColor;
  @override
  @JsonKey()
  final GameBadgeTypes badgeType;

  /// the int key is the priority index of the category.
  /// so if this game has 2 of [GameCategory.multiplayer]
  /// and other has 1 of [GameCategory.multiplayer],
  /// the other will be the first one in the list.
  /// the value may be null, indicating that this
  /// should be in the last position.
  final Map<GameCategory, int?> _categories;

  /// the int key is the priority index of the category.
  /// so if this game has 2 of [GameCategory.multiplayer]
  /// and other has 1 of [GameCategory.multiplayer],
  /// the other will be the first one in the list.
  /// the value may be null, indicating that this
  /// should be in the last position.
  @override
  Map<GameCategory, int?> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categories);
  }

//
  @override
  final NumRange playerCount;

  /// This parameter help to define how many color count per player
  /// this parameter shows how much could add pad count which game
  @override
  final NumRange? gamePadCount;

  /// the min of this has to be the min for
  /// min player count. e.g. min player count
  /// is 2, and min 2 pads for each player,
  /// then min pad count is 4. and when the
  /// user adds a 3rd player, we'll force them
  /// to have at least 6 pads.
  @override
  final NumRange padCount;

  /// the values are in seconds
  @override
  final NumRange? duration;

  /// Is there any delay between pad leds like games in formula?
  /// default delay value is 2 seconds
  @override
  final NumRange? delay;

  /// the values are in milliseconds, so we have to use
  /// NumRange.distanceCm on this one as our excel values
  /// are in centimeters.
  @override
  final NumRange? distance;

  /// the values are in seconds. And sometimes we need define open light time.
  /// So we can help this parameter.
  @override
  final NumRange? timeout;

  /// Sensitivty for motion games
  /// assign radius value for pads
  @override
  final NumRange? radius;
  @override
  final NumRange? vibrationRadius;

  /// this method will give you each result of each player in the
  /// game and let you be responsible to provide key value pairs
  /// for the results of this player.
  /// the output of this will be displayed to the user in a post
  /// game score dialog and in the leaderboard.
  ///
  /// leaving this null will result in the score disaplaying
  /// [GameResultModel.resultsMap]
  ///
  /// if [allResultsListing] is specified, then this will be ignored.
  ///
  /// for now we're making this an unserializable thing, but in the
  /// future when we wanna support fetching metadata from the server,
  /// this can be converted to a map with:
  ///   key: the title of that value localized to the app's language
  ///   value: an enum of the type of the value, and the value should
  ///          be retrieved accordingly.
  ///   example:
  ///   ```dart
  ///   {
  ///     'Player Name': PlayerResultType.playerName,
  ///   }
  ///   ```
  ///
  ///
  /// here is a valid usage example of this:
  /// ```dart
  /// (context, results, result, player) {
  ///   final inst = L10n.inst(context);
  ///
  ///   final map = <String, String?>{
  ///     if (player.playerName != null)
  ///       inst.activity_default_scores_name: player.playerName?.toString(),
  ///     inst.activity_default_scores_total_duration:
  ///         e.totalDuration?.formatSecondsMilli(context).toString(),
  ///   };
  ///
  ///   return map;
  /// };
  /// ```
  ///
  @override
  @JsonKey(ignore: true)
  final SinglePlayerListingCB? singlePlayerListing;

  @override
  String toString() {
    return 'GameMetaDataModel(id: $id, name: $name, description: $description, imagePath: $imagePath, primaryScoreString: $primaryScoreString, earnings: $earnings, tag: $tag, isContainOnIga: $isContainOnIga, inGameIgaHeader: $inGameIgaHeader, igaTextSpans: $igaTextSpans, igaCountDownTextSpans: $igaCountDownTextSpans, igaIngGameTextSpans: $igaIngGameTextSpans, igaPickColor: $igaPickColor, igaMultiplePickColor: $igaMultiplePickColor, badgeType: $badgeType, categories: $categories, playerCount: $playerCount, gamePadCount: $gamePadCount, padCount: $padCount, duration: $duration, delay: $delay, distance: $distance, timeout: $timeout, radius: $radius, vibrationRadius: $vibrationRadius, singlePlayerListing: $singlePlayerListing)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameMetaDataModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.primaryScoreString, primaryScoreString) ||
                other.primaryScoreString == primaryScoreString) &&
            const DeepCollectionEquality().equals(other._earnings, _earnings) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.isContainOnIga, isContainOnIga) ||
                other.isContainOnIga == isContainOnIga) &&
            (identical(other.inGameIgaHeader, inGameIgaHeader) ||
                other.inGameIgaHeader == inGameIgaHeader) &&
            const DeepCollectionEquality()
                .equals(other._igaTextSpans, _igaTextSpans) &&
            const DeepCollectionEquality()
                .equals(other._igaCountDownTextSpans, _igaCountDownTextSpans) &&
            const DeepCollectionEquality()
                .equals(other._igaIngGameTextSpans, _igaIngGameTextSpans) &&
            (identical(other.igaPickColor, igaPickColor) ||
                other.igaPickColor == igaPickColor) &&
            (identical(other.igaMultiplePickColor, igaMultiplePickColor) ||
                other.igaMultiplePickColor == igaMultiplePickColor) &&
            (identical(other.badgeType, badgeType) ||
                other.badgeType == badgeType) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.playerCount, playerCount) ||
                other.playerCount == playerCount) &&
            (identical(other.gamePadCount, gamePadCount) ||
                other.gamePadCount == gamePadCount) &&
            (identical(other.padCount, padCount) ||
                other.padCount == padCount) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            (identical(other.radius, radius) || other.radius == radius) &&
            (identical(other.vibrationRadius, vibrationRadius) ||
                other.vibrationRadius == vibrationRadius) &&
            (identical(other.singlePlayerListing, singlePlayerListing) ||
                other.singlePlayerListing == singlePlayerListing));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        imagePath,
        primaryScoreString,
        const DeepCollectionEquality().hash(_earnings),
        tag,
        isContainOnIga,
        inGameIgaHeader,
        const DeepCollectionEquality().hash(_igaTextSpans),
        const DeepCollectionEquality().hash(_igaCountDownTextSpans),
        const DeepCollectionEquality().hash(_igaIngGameTextSpans),
        igaPickColor,
        igaMultiplePickColor,
        badgeType,
        const DeepCollectionEquality().hash(_categories),
        playerCount,
        gamePadCount,
        padCount,
        duration,
        delay,
        distance,
        timeout,
        radius,
        vibrationRadius,
        singlePlayerListing
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameMetaDataModelCopyWith<_$_GameMetaDataModel> get copyWith =>
      __$$_GameMetaDataModelCopyWithImpl<_$_GameMetaDataModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameMetaDataModelToJson(
      this,
    );
  }
}

abstract class _GameMetaDataModel extends GameMetaDataModel {
  factory _GameMetaDataModel(
      {required final String id,
      required final String name,
      required final String description,
      required final String imagePath,
      final String? primaryScoreString,
      required final List<GameEarning> earnings,
      required final GameTag tag,
      final bool isContainOnIga,
      final String? inGameIgaHeader,
      @JsonKey(ignore: true) final List<List<TextSpan>> igaTextSpans,
      @JsonKey(ignore: true) final List<List<TextSpan>> igaCountDownTextSpans,
      @JsonKey(ignore: true) final List<List<TextSpan>> igaIngGameTextSpans,
      @JsonKey(ignore: true) final bool igaPickColor,
      @JsonKey(ignore: true) final bool igaMultiplePickColor,
      final GameBadgeTypes badgeType,
      required final Map<GameCategory, int?> categories,
      required final NumRange playerCount,
      final NumRange? gamePadCount,
      required final NumRange padCount,
      final NumRange? duration,
      final NumRange? delay,
      final NumRange? distance,
      final NumRange? timeout,
      final NumRange? radius,
      final NumRange? vibrationRadius,
      @JsonKey(ignore: true)
      final SinglePlayerListingCB? singlePlayerListing}) = _$_GameMetaDataModel;
  _GameMetaDataModel._() : super._();

  factory _GameMetaDataModel.fromJson(Map<String, dynamic> json) =
      _$_GameMetaDataModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imagePath;
  @override
  String? get primaryScoreString;
  @override //
  List<GameEarning> get earnings;
  @override
  GameTag get tag;
  @override

  /// [isContainOnIga] if you want active iga conditions you
  /// must look first to this parameter and then of course you must look
  /// [currentEmbModeManager].This state must be 1
  bool get isContainOnIga;
  @override
  String? get inGameIgaHeader;
  @override

  /// [igaTextSpans] This parameter created for special explain to customer at IGA.
  /// So you can change by this parameter what you want show on platform screen
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaTextSpans;
  @override
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaCountDownTextSpans;
  @override
  @JsonKey(ignore: true)
  List<List<TextSpan>> get igaIngGameTextSpans;
  @override
  @JsonKey(ignore: true)
  bool get igaPickColor;
  @override
  @JsonKey(ignore: true)
  bool get igaMultiplePickColor;
  @override
  GameBadgeTypes get badgeType;
  @override

  /// the int key is the priority index of the category.
  /// so if this game has 2 of [GameCategory.multiplayer]
  /// and other has 1 of [GameCategory.multiplayer],
  /// the other will be the first one in the list.
  /// the value may be null, indicating that this
  /// should be in the last position.
  Map<GameCategory, int?> get categories;
  @override //
  NumRange get playerCount;
  @override

  /// This parameter help to define how many color count per player
  /// this parameter shows how much could add pad count which game
  NumRange? get gamePadCount;
  @override

  /// the min of this has to be the min for
  /// min player count. e.g. min player count
  /// is 2, and min 2 pads for each player,
  /// then min pad count is 4. and when the
  /// user adds a 3rd player, we'll force them
  /// to have at least 6 pads.
  NumRange get padCount;
  @override

  /// the values are in seconds
  NumRange? get duration;
  @override

  /// Is there any delay between pad leds like games in formula?
  /// default delay value is 2 seconds
  NumRange? get delay;
  @override

  /// the values are in milliseconds, so we have to use
  /// NumRange.distanceCm on this one as our excel values
  /// are in centimeters.
  NumRange? get distance;
  @override

  /// the values are in seconds. And sometimes we need define open light time.
  /// So we can help this parameter.
  NumRange? get timeout;
  @override

  /// Sensitivty for motion games
  /// assign radius value for pads
  NumRange? get radius;
  @override
  NumRange? get vibrationRadius;
  @override

  /// this method will give you each result of each player in the
  /// game and let you be responsible to provide key value pairs
  /// for the results of this player.
  /// the output of this will be displayed to the user in a post
  /// game score dialog and in the leaderboard.
  ///
  /// leaving this null will result in the score disaplaying
  /// [GameResultModel.resultsMap]
  ///
  /// if [allResultsListing] is specified, then this will be ignored.
  ///
  /// for now we're making this an unserializable thing, but in the
  /// future when we wanna support fetching metadata from the server,
  /// this can be converted to a map with:
  ///   key: the title of that value localized to the app's language
  ///   value: an enum of the type of the value, and the value should
  ///          be retrieved accordingly.
  ///   example:
  ///   ```dart
  ///   {
  ///     'Player Name': PlayerResultType.playerName,
  ///   }
  ///   ```
  ///
  ///
  /// here is a valid usage example of this:
  /// ```dart
  /// (context, results, result, player) {
  ///   final inst = L10n.inst(context);
  ///
  ///   final map = <String, String?>{
  ///     if (player.playerName != null)
  ///       inst.activity_default_scores_name: player.playerName?.toString(),
  ///     inst.activity_default_scores_total_duration:
  ///         e.totalDuration?.formatSecondsMilli(context).toString(),
  ///   };
  ///
  ///   return map;
  /// };
  /// ```
  ///
  @JsonKey(ignore: true)
  SinglePlayerListingCB? get singlePlayerListing;
  @override
  @JsonKey(ignore: true)
  _$$_GameMetaDataModelCopyWith<_$_GameMetaDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
