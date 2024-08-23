// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'static_game_setup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StaticGameSetupModel {
  GameControlsSetup get controlsSetup => throw _privateConstructorUsedError;
  GameEndType get type => throw _privateConstructorUsedError;
  GameScoreType get scoreTypeParam1 =>
      throw _privateConstructorUsedError; // TODO: do processing accordingly
  GameScoreType? get scoreTypeParam2 => throw _privateConstructorUsedError;
  GameScoreType? get scoreTypeParam3 => throw _privateConstructorUsedError;
  GameScoreType? get scoreTypeParam4 => throw _privateConstructorUsedError;
  GameScoreType? get scoreTypeParam5 => throw _privateConstructorUsedError;
  GameScoreType? get scoreTypeParam6 => throw _privateConstructorUsedError;

  /// some games will need general config
  /// and not player specific. for example,
  /// the xo game wants to have 9 pads
  /// but none assigned to the players,
  /// the catch the pad game wants to have
  /// indefinite number of pads and colors,
  /// again, none assigned to the players.
  ///
  /// should make sure to always mark
  /// hasName to false.
  StagedPlayerModel? get stagedPlayerModel =>
      throw _privateConstructorUsedError;
  StagedPlayerModel? get generalStagedPlayerModel =>
      throw _privateConstructorUsedError;
  int? get roundCount => throw _privateConstructorUsedError;
  @Deprecated("You can use [] if you want use this "
      "attribute you must listen this value.But this parameter "
      "member of object and object killing and setting default "
      "value when close game so you can't remember last status.")
  bool get doesHaveSound => throw _privateConstructorUsedError;
  bool get isPercentage => throw _privateConstructorUsedError;
  bool get isColorSelectOrder => throw _privateConstructorUsedError;
  bool get isScore => throw _privateConstructorUsedError;
  bool get isContainMainBase => throw _privateConstructorUsedError;

  ///When customer want same queue for all players this attribute must be true
  ///And then set queue that was saved queue
  bool? get isIncludePeriodicQueue => throw _privateConstructorUsedError;

  ///This attribute is periodic queue that will be used in game
  List<DiscoveredDevice> get periodicQueue =>
      throw _privateConstructorUsedError;

  ///These attributes determine how the game can be started. If this
  ///attribute is set to true, the chronometer will start automatically
  ///when the game starts. However, if this attribute is set to false,
  ///the game will only start when you move to the front pad or press the
  ///pad, and then you can start the chronometer.
  bool get autoStart => throw _privateConstructorUsedError;

  /// If set to [true], this attribute activates the vibration feature within the game.
  /// When set to [false], the game will not trigger any vibration feedback.
  bool get vibrationActivate => throw _privateConstructorUsedError;

  /// the values are in degrees for vibration
  NumRange? get vibrationActiveDegree => throw _privateConstructorUsedError;

  ///This attribute determine if the chronometer will be used in the game.
  bool get needChronometer => throw _privateConstructorUsedError;

  ///This attribute if we need input speacial value from keyboard
  ///and this we select which kind of keyboard run time type both number or text
  TextInputType? get keyboardType => throw _privateConstructorUsedError;

  ///With this attribute we can get value from current keyboard input.
  KeyboardValue get keyboardValue => throw _privateConstructorUsedError;

  /// this will be keyed by the sensor type,
  /// along with its lock value. keep false
  /// if you want the sensor to respect
  /// the threshold.
  /// btw the values of this means wether we
  /// accept conditionless flow of data AKA
  /// unlock the sensor
  Map<UsedSensorsType, bool> get sensorTypes =>
      throw _privateConstructorUsedError;

  ///This parameter help select both sequential and randomly.
  Map<ChallengeType, bool>? get challengeTypes =>
      throw _privateConstructorUsedError;
  Map<int, String>? get sequenceMap => throw _privateConstructorUsedError;
  int get chosedSensorIndex => throw _privateConstructorUsedError;
  int get choosedChallengeTypeIndex => throw _privateConstructorUsedError;
  bool get allowSameColor => throw _privateConstructorUsedError;
  DstConfigModel? get dstConfig => throw _privateConstructorUsedError;
  AccConfigModel? get accConfig => throw _privateConstructorUsedError;
  GameDropOptionsModel? get gameDropOptionsModel =>
      throw _privateConstructorUsedError;

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  NumRange? get playerCount => throw _privateConstructorUsedError;

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  NumRange? get padCount => throw _privateConstructorUsedError;

  /// the values are in seconds
  NumRange? get duration => throw _privateConstructorUsedError;

  /// the values are in seconds
  NumRange? get timeout => throw _privateConstructorUsedError;

  /// Is there any delay between pad leds like games in formula?
  /// default delay value is 2 seconds
  NumRange? get delay => throw _privateConstructorUsedError;

  /// the values are in milliseconds, so we have to use
  /// NumRange.distanceCm on this one as our excel values
  /// are in centimeters.
  NumRange? get distance => throw _privateConstructorUsedError;

  /// Sensitivty for motion games
  /// assign radius value for pads
  NumRange? get radius => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StaticGameSetupModelCopyWith<StaticGameSetupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaticGameSetupModelCopyWith<$Res> {
  factory $StaticGameSetupModelCopyWith(StaticGameSetupModel value,
          $Res Function(StaticGameSetupModel) then) =
      _$StaticGameSetupModelCopyWithImpl<$Res, StaticGameSetupModel>;
  @useResult
  $Res call(
      {GameControlsSetup controlsSetup,
      GameEndType type,
      GameScoreType scoreTypeParam1,
      GameScoreType? scoreTypeParam2,
      GameScoreType? scoreTypeParam3,
      GameScoreType? scoreTypeParam4,
      GameScoreType? scoreTypeParam5,
      GameScoreType? scoreTypeParam6,
      StagedPlayerModel? stagedPlayerModel,
      StagedPlayerModel? generalStagedPlayerModel,
      int? roundCount,
      @Deprecated("You can use [] if you want use this "
          "attribute you must listen this value.But this parameter "
          "member of object and object killing and setting default "
          "value when close game so you can't remember last status.")
      bool doesHaveSound,
      bool isPercentage,
      bool isColorSelectOrder,
      bool isScore,
      bool isContainMainBase,
      bool? isIncludePeriodicQueue,
      List<DiscoveredDevice> periodicQueue,
      bool autoStart,
      bool vibrationActivate,
      NumRange? vibrationActiveDegree,
      bool needChronometer,
      TextInputType? keyboardType,
      KeyboardValue keyboardValue,
      Map<UsedSensorsType, bool> sensorTypes,
      Map<ChallengeType, bool>? challengeTypes,
      Map<int, String>? sequenceMap,
      int chosedSensorIndex,
      int choosedChallengeTypeIndex,
      bool allowSameColor,
      DstConfigModel? dstConfig,
      AccConfigModel? accConfig,
      GameDropOptionsModel? gameDropOptionsModel,
      NumRange? playerCount,
      NumRange? padCount,
      NumRange? duration,
      NumRange? timeout,
      NumRange? delay,
      NumRange? distance,
      NumRange? radius});

  $GameControlsSetupCopyWith<$Res> get controlsSetup;
  $StagedPlayerModelCopyWith<$Res>? get stagedPlayerModel;
  $StagedPlayerModelCopyWith<$Res>? get generalStagedPlayerModel;
  $NumRangeCopyWith<$Res>? get vibrationActiveDegree;
  $DstConfigModelCopyWith<$Res>? get dstConfig;
  $AccConfigModelCopyWith<$Res>? get accConfig;
  $NumRangeCopyWith<$Res>? get playerCount;
  $NumRangeCopyWith<$Res>? get padCount;
  $NumRangeCopyWith<$Res>? get duration;
  $NumRangeCopyWith<$Res>? get timeout;
  $NumRangeCopyWith<$Res>? get delay;
  $NumRangeCopyWith<$Res>? get distance;
  $NumRangeCopyWith<$Res>? get radius;
}

/// @nodoc
class _$StaticGameSetupModelCopyWithImpl<$Res,
        $Val extends StaticGameSetupModel>
    implements $StaticGameSetupModelCopyWith<$Res> {
  _$StaticGameSetupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controlsSetup = null,
    Object? type = null,
    Object? scoreTypeParam1 = null,
    Object? scoreTypeParam2 = freezed,
    Object? scoreTypeParam3 = freezed,
    Object? scoreTypeParam4 = freezed,
    Object? scoreTypeParam5 = freezed,
    Object? scoreTypeParam6 = freezed,
    Object? stagedPlayerModel = freezed,
    Object? generalStagedPlayerModel = freezed,
    Object? roundCount = freezed,
    Object? doesHaveSound = null,
    Object? isPercentage = null,
    Object? isColorSelectOrder = null,
    Object? isScore = null,
    Object? isContainMainBase = null,
    Object? isIncludePeriodicQueue = freezed,
    Object? periodicQueue = null,
    Object? autoStart = null,
    Object? vibrationActivate = null,
    Object? vibrationActiveDegree = freezed,
    Object? needChronometer = null,
    Object? keyboardType = freezed,
    Object? keyboardValue = null,
    Object? sensorTypes = null,
    Object? challengeTypes = freezed,
    Object? sequenceMap = freezed,
    Object? chosedSensorIndex = null,
    Object? choosedChallengeTypeIndex = null,
    Object? allowSameColor = null,
    Object? dstConfig = freezed,
    Object? accConfig = freezed,
    Object? gameDropOptionsModel = freezed,
    Object? playerCount = freezed,
    Object? padCount = freezed,
    Object? duration = freezed,
    Object? timeout = freezed,
    Object? delay = freezed,
    Object? distance = freezed,
    Object? radius = freezed,
  }) {
    return _then(_value.copyWith(
      controlsSetup: null == controlsSetup
          ? _value.controlsSetup
          : controlsSetup // ignore: cast_nullable_to_non_nullable
              as GameControlsSetup,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEndType,
      scoreTypeParam1: null == scoreTypeParam1
          ? _value.scoreTypeParam1
          : scoreTypeParam1 // ignore: cast_nullable_to_non_nullable
              as GameScoreType,
      scoreTypeParam2: freezed == scoreTypeParam2
          ? _value.scoreTypeParam2
          : scoreTypeParam2 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam3: freezed == scoreTypeParam3
          ? _value.scoreTypeParam3
          : scoreTypeParam3 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam4: freezed == scoreTypeParam4
          ? _value.scoreTypeParam4
          : scoreTypeParam4 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam5: freezed == scoreTypeParam5
          ? _value.scoreTypeParam5
          : scoreTypeParam5 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam6: freezed == scoreTypeParam6
          ? _value.scoreTypeParam6
          : scoreTypeParam6 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      stagedPlayerModel: freezed == stagedPlayerModel
          ? _value.stagedPlayerModel
          : stagedPlayerModel // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel?,
      generalStagedPlayerModel: freezed == generalStagedPlayerModel
          ? _value.generalStagedPlayerModel
          : generalStagedPlayerModel // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel?,
      roundCount: freezed == roundCount
          ? _value.roundCount
          : roundCount // ignore: cast_nullable_to_non_nullable
              as int?,
      doesHaveSound: null == doesHaveSound
          ? _value.doesHaveSound
          : doesHaveSound // ignore: cast_nullable_to_non_nullable
              as bool,
      isPercentage: null == isPercentage
          ? _value.isPercentage
          : isPercentage // ignore: cast_nullable_to_non_nullable
              as bool,
      isColorSelectOrder: null == isColorSelectOrder
          ? _value.isColorSelectOrder
          : isColorSelectOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      isScore: null == isScore
          ? _value.isScore
          : isScore // ignore: cast_nullable_to_non_nullable
              as bool,
      isContainMainBase: null == isContainMainBase
          ? _value.isContainMainBase
          : isContainMainBase // ignore: cast_nullable_to_non_nullable
              as bool,
      isIncludePeriodicQueue: freezed == isIncludePeriodicQueue
          ? _value.isIncludePeriodicQueue
          : isIncludePeriodicQueue // ignore: cast_nullable_to_non_nullable
              as bool?,
      periodicQueue: null == periodicQueue
          ? _value.periodicQueue
          : periodicQueue // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
      autoStart: null == autoStart
          ? _value.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationActivate: null == vibrationActivate
          ? _value.vibrationActivate
          : vibrationActivate // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationActiveDegree: freezed == vibrationActiveDegree
          ? _value.vibrationActiveDegree
          : vibrationActiveDegree // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      needChronometer: null == needChronometer
          ? _value.needChronometer
          : needChronometer // ignore: cast_nullable_to_non_nullable
              as bool,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as TextInputType?,
      keyboardValue: null == keyboardValue
          ? _value.keyboardValue
          : keyboardValue // ignore: cast_nullable_to_non_nullable
              as KeyboardValue,
      sensorTypes: null == sensorTypes
          ? _value.sensorTypes
          : sensorTypes // ignore: cast_nullable_to_non_nullable
              as Map<UsedSensorsType, bool>,
      challengeTypes: freezed == challengeTypes
          ? _value.challengeTypes
          : challengeTypes // ignore: cast_nullable_to_non_nullable
              as Map<ChallengeType, bool>?,
      sequenceMap: freezed == sequenceMap
          ? _value.sequenceMap
          : sequenceMap // ignore: cast_nullable_to_non_nullable
              as Map<int, String>?,
      chosedSensorIndex: null == chosedSensorIndex
          ? _value.chosedSensorIndex
          : chosedSensorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      choosedChallengeTypeIndex: null == choosedChallengeTypeIndex
          ? _value.choosedChallengeTypeIndex
          : choosedChallengeTypeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      allowSameColor: null == allowSameColor
          ? _value.allowSameColor
          : allowSameColor // ignore: cast_nullable_to_non_nullable
              as bool,
      dstConfig: freezed == dstConfig
          ? _value.dstConfig
          : dstConfig // ignore: cast_nullable_to_non_nullable
              as DstConfigModel?,
      accConfig: freezed == accConfig
          ? _value.accConfig
          : accConfig // ignore: cast_nullable_to_non_nullable
              as AccConfigModel?,
      gameDropOptionsModel: freezed == gameDropOptionsModel
          ? _value.gameDropOptionsModel
          : gameDropOptionsModel // ignore: cast_nullable_to_non_nullable
              as GameDropOptionsModel?,
      playerCount: freezed == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      padCount: freezed == padCount
          ? _value.padCount
          : padCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameControlsSetupCopyWith<$Res> get controlsSetup {
    return $GameControlsSetupCopyWith<$Res>(_value.controlsSetup, (value) {
      return _then(_value.copyWith(controlsSetup: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StagedPlayerModelCopyWith<$Res>? get stagedPlayerModel {
    if (_value.stagedPlayerModel == null) {
      return null;
    }

    return $StagedPlayerModelCopyWith<$Res>(_value.stagedPlayerModel!, (value) {
      return _then(_value.copyWith(stagedPlayerModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StagedPlayerModelCopyWith<$Res>? get generalStagedPlayerModel {
    if (_value.generalStagedPlayerModel == null) {
      return null;
    }

    return $StagedPlayerModelCopyWith<$Res>(_value.generalStagedPlayerModel!,
        (value) {
      return _then(_value.copyWith(generalStagedPlayerModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get vibrationActiveDegree {
    if (_value.vibrationActiveDegree == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.vibrationActiveDegree!, (value) {
      return _then(_value.copyWith(vibrationActiveDegree: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DstConfigModelCopyWith<$Res>? get dstConfig {
    if (_value.dstConfig == null) {
      return null;
    }

    return $DstConfigModelCopyWith<$Res>(_value.dstConfig!, (value) {
      return _then(_value.copyWith(dstConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AccConfigModelCopyWith<$Res>? get accConfig {
    if (_value.accConfig == null) {
      return null;
    }

    return $AccConfigModelCopyWith<$Res>(_value.accConfig!, (value) {
      return _then(_value.copyWith(accConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get playerCount {
    if (_value.playerCount == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.playerCount!, (value) {
      return _then(_value.copyWith(playerCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get padCount {
    if (_value.padCount == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.padCount!, (value) {
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
  $NumRangeCopyWith<$Res>? get radius {
    if (_value.radius == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.radius!, (value) {
      return _then(_value.copyWith(radius: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StaticGameSetupModelCopyWith<$Res>
    implements $StaticGameSetupModelCopyWith<$Res> {
  factory _$$_StaticGameSetupModelCopyWith(_$_StaticGameSetupModel value,
          $Res Function(_$_StaticGameSetupModel) then) =
      __$$_StaticGameSetupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameControlsSetup controlsSetup,
      GameEndType type,
      GameScoreType scoreTypeParam1,
      GameScoreType? scoreTypeParam2,
      GameScoreType? scoreTypeParam3,
      GameScoreType? scoreTypeParam4,
      GameScoreType? scoreTypeParam5,
      GameScoreType? scoreTypeParam6,
      StagedPlayerModel? stagedPlayerModel,
      StagedPlayerModel? generalStagedPlayerModel,
      int? roundCount,
      @Deprecated("You can use [] if you want use this "
          "attribute you must listen this value.But this parameter "
          "member of object and object killing and setting default "
          "value when close game so you can't remember last status.")
      bool doesHaveSound,
      bool isPercentage,
      bool isColorSelectOrder,
      bool isScore,
      bool isContainMainBase,
      bool? isIncludePeriodicQueue,
      List<DiscoveredDevice> periodicQueue,
      bool autoStart,
      bool vibrationActivate,
      NumRange? vibrationActiveDegree,
      bool needChronometer,
      TextInputType? keyboardType,
      KeyboardValue keyboardValue,
      Map<UsedSensorsType, bool> sensorTypes,
      Map<ChallengeType, bool>? challengeTypes,
      Map<int, String>? sequenceMap,
      int chosedSensorIndex,
      int choosedChallengeTypeIndex,
      bool allowSameColor,
      DstConfigModel? dstConfig,
      AccConfigModel? accConfig,
      GameDropOptionsModel? gameDropOptionsModel,
      NumRange? playerCount,
      NumRange? padCount,
      NumRange? duration,
      NumRange? timeout,
      NumRange? delay,
      NumRange? distance,
      NumRange? radius});

  @override
  $GameControlsSetupCopyWith<$Res> get controlsSetup;
  @override
  $StagedPlayerModelCopyWith<$Res>? get stagedPlayerModel;
  @override
  $StagedPlayerModelCopyWith<$Res>? get generalStagedPlayerModel;
  @override
  $NumRangeCopyWith<$Res>? get vibrationActiveDegree;
  @override
  $DstConfigModelCopyWith<$Res>? get dstConfig;
  @override
  $AccConfigModelCopyWith<$Res>? get accConfig;
  @override
  $NumRangeCopyWith<$Res>? get playerCount;
  @override
  $NumRangeCopyWith<$Res>? get padCount;
  @override
  $NumRangeCopyWith<$Res>? get duration;
  @override
  $NumRangeCopyWith<$Res>? get timeout;
  @override
  $NumRangeCopyWith<$Res>? get delay;
  @override
  $NumRangeCopyWith<$Res>? get distance;
  @override
  $NumRangeCopyWith<$Res>? get radius;
}

/// @nodoc
class __$$_StaticGameSetupModelCopyWithImpl<$Res>
    extends _$StaticGameSetupModelCopyWithImpl<$Res, _$_StaticGameSetupModel>
    implements _$$_StaticGameSetupModelCopyWith<$Res> {
  __$$_StaticGameSetupModelCopyWithImpl(_$_StaticGameSetupModel _value,
      $Res Function(_$_StaticGameSetupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controlsSetup = null,
    Object? type = null,
    Object? scoreTypeParam1 = null,
    Object? scoreTypeParam2 = freezed,
    Object? scoreTypeParam3 = freezed,
    Object? scoreTypeParam4 = freezed,
    Object? scoreTypeParam5 = freezed,
    Object? scoreTypeParam6 = freezed,
    Object? stagedPlayerModel = freezed,
    Object? generalStagedPlayerModel = freezed,
    Object? roundCount = freezed,
    Object? doesHaveSound = null,
    Object? isPercentage = null,
    Object? isColorSelectOrder = null,
    Object? isScore = null,
    Object? isContainMainBase = null,
    Object? isIncludePeriodicQueue = freezed,
    Object? periodicQueue = null,
    Object? autoStart = null,
    Object? vibrationActivate = null,
    Object? vibrationActiveDegree = freezed,
    Object? needChronometer = null,
    Object? keyboardType = freezed,
    Object? keyboardValue = null,
    Object? sensorTypes = null,
    Object? challengeTypes = freezed,
    Object? sequenceMap = freezed,
    Object? chosedSensorIndex = null,
    Object? choosedChallengeTypeIndex = null,
    Object? allowSameColor = null,
    Object? dstConfig = freezed,
    Object? accConfig = freezed,
    Object? gameDropOptionsModel = freezed,
    Object? playerCount = freezed,
    Object? padCount = freezed,
    Object? duration = freezed,
    Object? timeout = freezed,
    Object? delay = freezed,
    Object? distance = freezed,
    Object? radius = freezed,
  }) {
    return _then(_$_StaticGameSetupModel(
      controlsSetup: null == controlsSetup
          ? _value.controlsSetup
          : controlsSetup // ignore: cast_nullable_to_non_nullable
              as GameControlsSetup,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GameEndType,
      scoreTypeParam1: null == scoreTypeParam1
          ? _value.scoreTypeParam1
          : scoreTypeParam1 // ignore: cast_nullable_to_non_nullable
              as GameScoreType,
      scoreTypeParam2: freezed == scoreTypeParam2
          ? _value.scoreTypeParam2
          : scoreTypeParam2 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam3: freezed == scoreTypeParam3
          ? _value.scoreTypeParam3
          : scoreTypeParam3 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam4: freezed == scoreTypeParam4
          ? _value.scoreTypeParam4
          : scoreTypeParam4 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam5: freezed == scoreTypeParam5
          ? _value.scoreTypeParam5
          : scoreTypeParam5 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      scoreTypeParam6: freezed == scoreTypeParam6
          ? _value.scoreTypeParam6
          : scoreTypeParam6 // ignore: cast_nullable_to_non_nullable
              as GameScoreType?,
      stagedPlayerModel: freezed == stagedPlayerModel
          ? _value.stagedPlayerModel
          : stagedPlayerModel // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel?,
      generalStagedPlayerModel: freezed == generalStagedPlayerModel
          ? _value.generalStagedPlayerModel
          : generalStagedPlayerModel // ignore: cast_nullable_to_non_nullable
              as StagedPlayerModel?,
      roundCount: freezed == roundCount
          ? _value.roundCount
          : roundCount // ignore: cast_nullable_to_non_nullable
              as int?,
      doesHaveSound: null == doesHaveSound
          ? _value.doesHaveSound
          : doesHaveSound // ignore: cast_nullable_to_non_nullable
              as bool,
      isPercentage: null == isPercentage
          ? _value.isPercentage
          : isPercentage // ignore: cast_nullable_to_non_nullable
              as bool,
      isColorSelectOrder: null == isColorSelectOrder
          ? _value.isColorSelectOrder
          : isColorSelectOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      isScore: null == isScore
          ? _value.isScore
          : isScore // ignore: cast_nullable_to_non_nullable
              as bool,
      isContainMainBase: null == isContainMainBase
          ? _value.isContainMainBase
          : isContainMainBase // ignore: cast_nullable_to_non_nullable
              as bool,
      isIncludePeriodicQueue: freezed == isIncludePeriodicQueue
          ? _value.isIncludePeriodicQueue
          : isIncludePeriodicQueue // ignore: cast_nullable_to_non_nullable
              as bool?,
      periodicQueue: null == periodicQueue
          ? _value._periodicQueue
          : periodicQueue // ignore: cast_nullable_to_non_nullable
              as List<DiscoveredDevice>,
      autoStart: null == autoStart
          ? _value.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationActivate: null == vibrationActivate
          ? _value.vibrationActivate
          : vibrationActivate // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationActiveDegree: freezed == vibrationActiveDegree
          ? _value.vibrationActiveDegree
          : vibrationActiveDegree // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      needChronometer: null == needChronometer
          ? _value.needChronometer
          : needChronometer // ignore: cast_nullable_to_non_nullable
              as bool,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as TextInputType?,
      keyboardValue: null == keyboardValue
          ? _value.keyboardValue
          : keyboardValue // ignore: cast_nullable_to_non_nullable
              as KeyboardValue,
      sensorTypes: null == sensorTypes
          ? _value._sensorTypes
          : sensorTypes // ignore: cast_nullable_to_non_nullable
              as Map<UsedSensorsType, bool>,
      challengeTypes: freezed == challengeTypes
          ? _value._challengeTypes
          : challengeTypes // ignore: cast_nullable_to_non_nullable
              as Map<ChallengeType, bool>?,
      sequenceMap: freezed == sequenceMap
          ? _value._sequenceMap
          : sequenceMap // ignore: cast_nullable_to_non_nullable
              as Map<int, String>?,
      chosedSensorIndex: null == chosedSensorIndex
          ? _value.chosedSensorIndex
          : chosedSensorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      choosedChallengeTypeIndex: null == choosedChallengeTypeIndex
          ? _value.choosedChallengeTypeIndex
          : choosedChallengeTypeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      allowSameColor: null == allowSameColor
          ? _value.allowSameColor
          : allowSameColor // ignore: cast_nullable_to_non_nullable
              as bool,
      dstConfig: freezed == dstConfig
          ? _value.dstConfig
          : dstConfig // ignore: cast_nullable_to_non_nullable
              as DstConfigModel?,
      accConfig: freezed == accConfig
          ? _value.accConfig
          : accConfig // ignore: cast_nullable_to_non_nullable
              as AccConfigModel?,
      gameDropOptionsModel: freezed == gameDropOptionsModel
          ? _value.gameDropOptionsModel
          : gameDropOptionsModel // ignore: cast_nullable_to_non_nullable
              as GameDropOptionsModel?,
      playerCount: freezed == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      padCount: freezed == padCount
          ? _value.padCount
          : padCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      timeout: freezed == timeout
          ? _value.timeout
          : timeout // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      radius: freezed == radius
          ? _value.radius
          : radius // ignore: cast_nullable_to_non_nullable
              as NumRange?,
    ));
  }
}

/// @nodoc

class _$_StaticGameSetupModel extends _StaticGameSetupModel {
  const _$_StaticGameSetupModel(
      {this.controlsSetup = const GameControlsSetup(),
      required this.type,
      required this.scoreTypeParam1,
      required this.scoreTypeParam2,
      this.scoreTypeParam3,
      this.scoreTypeParam4,
      this.scoreTypeParam5,
      this.scoreTypeParam6,
      this.stagedPlayerModel,
      this.generalStagedPlayerModel,
      this.roundCount,
      @Deprecated("You can use [] if you want use this "
          "attribute you must listen this value.But this parameter "
          "member of object and object killing and setting default "
          "value when close game so you can't remember last status.")
      this.doesHaveSound = true,
      this.isPercentage = false,
      this.isColorSelectOrder = false,
      this.isScore = false,
      this.isContainMainBase = false,
      this.isIncludePeriodicQueue,
      final List<DiscoveredDevice> periodicQueue = const [],
      this.autoStart = false,
      this.vibrationActivate = false,
      this.vibrationActiveDegree,
      this.needChronometer = false,
      this.keyboardType,
      this.keyboardValue,
      required final Map<UsedSensorsType, bool> sensorTypes,
      final Map<ChallengeType, bool>? challengeTypes,
      final Map<int, String>? sequenceMap,
      this.chosedSensorIndex = 0,
      this.choosedChallengeTypeIndex = 0,
      this.allowSameColor = true,
      this.dstConfig,
      this.accConfig,
      this.gameDropOptionsModel,
      this.playerCount,
      this.padCount,
      this.duration,
      this.timeout,
      this.delay,
      this.distance,
      this.radius})
      : assert(sensorTypes.length >= 1, '1, not 0, not 2, ONLY 1.'),
        _periodicQueue = periodicQueue,
        _sensorTypes = sensorTypes,
        _challengeTypes = challengeTypes,
        _sequenceMap = sequenceMap,
        super._();

  @override
  @JsonKey()
  final GameControlsSetup controlsSetup;
  @override
  final GameEndType type;
  @override
  final GameScoreType scoreTypeParam1;
// TODO: do processing accordingly
  @override
  final GameScoreType? scoreTypeParam2;
  @override
  final GameScoreType? scoreTypeParam3;
  @override
  final GameScoreType? scoreTypeParam4;
  @override
  final GameScoreType? scoreTypeParam5;
  @override
  final GameScoreType? scoreTypeParam6;

  /// some games will need general config
  /// and not player specific. for example,
  /// the xo game wants to have 9 pads
  /// but none assigned to the players,
  /// the catch the pad game wants to have
  /// indefinite number of pads and colors,
  /// again, none assigned to the players.
  ///
  /// should make sure to always mark
  /// hasName to false.
  @override
  final StagedPlayerModel? stagedPlayerModel;
  @override
  final StagedPlayerModel? generalStagedPlayerModel;
  @override
  final int? roundCount;
  @override
  @JsonKey()
  @Deprecated("You can use [] if you want use this "
      "attribute you must listen this value.But this parameter "
      "member of object and object killing and setting default "
      "value when close game so you can't remember last status.")
  final bool doesHaveSound;
  @override
  @JsonKey()
  final bool isPercentage;
  @override
  @JsonKey()
  final bool isColorSelectOrder;
  @override
  @JsonKey()
  final bool isScore;
  @override
  @JsonKey()
  final bool isContainMainBase;

  ///When customer want same queue for all players this attribute must be true
  ///And then set queue that was saved queue
  @override
  final bool? isIncludePeriodicQueue;

  ///This attribute is periodic queue that will be used in game
  final List<DiscoveredDevice> _periodicQueue;

  ///This attribute is periodic queue that will be used in game
  @override
  @JsonKey()
  List<DiscoveredDevice> get periodicQueue {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_periodicQueue);
  }

  ///These attributes determine how the game can be started. If this
  ///attribute is set to true, the chronometer will start automatically
  ///when the game starts. However, if this attribute is set to false,
  ///the game will only start when you move to the front pad or press the
  ///pad, and then you can start the chronometer.
  @override
  @JsonKey()
  final bool autoStart;

  /// If set to [true], this attribute activates the vibration feature within the game.
  /// When set to [false], the game will not trigger any vibration feedback.
  @override
  @JsonKey()
  final bool vibrationActivate;

  /// the values are in degrees for vibration
  @override
  final NumRange? vibrationActiveDegree;

  ///This attribute determine if the chronometer will be used in the game.
  @override
  @JsonKey()
  final bool needChronometer;

  ///This attribute if we need input speacial value from keyboard
  ///and this we select which kind of keyboard run time type both number or text
  @override
  final TextInputType? keyboardType;

  ///With this attribute we can get value from current keyboard input.
  @override
  final KeyboardValue keyboardValue;

  /// this will be keyed by the sensor type,
  /// along with its lock value. keep false
  /// if you want the sensor to respect
  /// the threshold.
  /// btw the values of this means wether we
  /// accept conditionless flow of data AKA
  /// unlock the sensor
  final Map<UsedSensorsType, bool> _sensorTypes;

  /// this will be keyed by the sensor type,
  /// along with its lock value. keep false
  /// if you want the sensor to respect
  /// the threshold.
  /// btw the values of this means wether we
  /// accept conditionless flow of data AKA
  /// unlock the sensor
  @override
  Map<UsedSensorsType, bool> get sensorTypes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sensorTypes);
  }

  ///This parameter help select both sequential and randomly.
  final Map<ChallengeType, bool>? _challengeTypes;

  ///This parameter help select both sequential and randomly.
  @override
  Map<ChallengeType, bool>? get challengeTypes {
    final value = _challengeTypes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<int, String>? _sequenceMap;
  @override
  Map<int, String>? get sequenceMap {
    final value = _sequenceMap;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final int chosedSensorIndex;
  @override
  @JsonKey()
  final int choosedChallengeTypeIndex;
  @override
  @JsonKey()
  final bool allowSameColor;
  @override
  final DstConfigModel? dstConfig;
  @override
  final AccConfigModel? accConfig;
  @override
  final GameDropOptionsModel? gameDropOptionsModel;

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  @override
  final NumRange? playerCount;

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  @override
  final NumRange? padCount;

  /// the values are in seconds
  @override
  final NumRange? duration;

  /// the values are in seconds
  @override
  final NumRange? timeout;

  /// Is there any delay between pad leds like games in formula?
  /// default delay value is 2 seconds
  @override
  final NumRange? delay;

  /// the values are in milliseconds, so we have to use
  /// NumRange.distanceCm on this one as our excel values
  /// are in centimeters.
  @override
  final NumRange? distance;

  /// Sensitivty for motion games
  /// assign radius value for pads
  @override
  final NumRange? radius;

  @override
  String toString() {
    return 'StaticGameSetupModel(controlsSetup: $controlsSetup, type: $type, scoreTypeParam1: $scoreTypeParam1, scoreTypeParam2: $scoreTypeParam2, scoreTypeParam3: $scoreTypeParam3, scoreTypeParam4: $scoreTypeParam4, scoreTypeParam5: $scoreTypeParam5, scoreTypeParam6: $scoreTypeParam6, stagedPlayerModel: $stagedPlayerModel, generalStagedPlayerModel: $generalStagedPlayerModel, roundCount: $roundCount, doesHaveSound: $doesHaveSound, isPercentage: $isPercentage, isColorSelectOrder: $isColorSelectOrder, isScore: $isScore, isContainMainBase: $isContainMainBase, isIncludePeriodicQueue: $isIncludePeriodicQueue, periodicQueue: $periodicQueue, autoStart: $autoStart, vibrationActivate: $vibrationActivate, vibrationActiveDegree: $vibrationActiveDegree, needChronometer: $needChronometer, keyboardType: $keyboardType, keyboardValue: $keyboardValue, sensorTypes: $sensorTypes, challengeTypes: $challengeTypes, sequenceMap: $sequenceMap, chosedSensorIndex: $chosedSensorIndex, choosedChallengeTypeIndex: $choosedChallengeTypeIndex, allowSameColor: $allowSameColor, dstConfig: $dstConfig, accConfig: $accConfig, gameDropOptionsModel: $gameDropOptionsModel, playerCount: $playerCount, padCount: $padCount, duration: $duration, timeout: $timeout, delay: $delay, distance: $distance, radius: $radius)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StaticGameSetupModel &&
            (identical(other.controlsSetup, controlsSetup) ||
                other.controlsSetup == controlsSetup) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.scoreTypeParam1, scoreTypeParam1) ||
                other.scoreTypeParam1 == scoreTypeParam1) &&
            (identical(other.scoreTypeParam2, scoreTypeParam2) ||
                other.scoreTypeParam2 == scoreTypeParam2) &&
            (identical(other.scoreTypeParam3, scoreTypeParam3) ||
                other.scoreTypeParam3 == scoreTypeParam3) &&
            (identical(other.scoreTypeParam4, scoreTypeParam4) ||
                other.scoreTypeParam4 == scoreTypeParam4) &&
            (identical(other.scoreTypeParam5, scoreTypeParam5) ||
                other.scoreTypeParam5 == scoreTypeParam5) &&
            (identical(other.scoreTypeParam6, scoreTypeParam6) ||
                other.scoreTypeParam6 == scoreTypeParam6) &&
            (identical(other.stagedPlayerModel, stagedPlayerModel) ||
                other.stagedPlayerModel == stagedPlayerModel) &&
            (identical(other.generalStagedPlayerModel, generalStagedPlayerModel) ||
                other.generalStagedPlayerModel == generalStagedPlayerModel) &&
            (identical(other.roundCount, roundCount) ||
                other.roundCount == roundCount) &&
            (identical(other.doesHaveSound, doesHaveSound) ||
                other.doesHaveSound == doesHaveSound) &&
            (identical(other.isPercentage, isPercentage) ||
                other.isPercentage == isPercentage) &&
            (identical(other.isColorSelectOrder, isColorSelectOrder) ||
                other.isColorSelectOrder == isColorSelectOrder) &&
            (identical(other.isScore, isScore) || other.isScore == isScore) &&
            (identical(other.isContainMainBase, isContainMainBase) ||
                other.isContainMainBase == isContainMainBase) &&
            (identical(other.isIncludePeriodicQueue, isIncludePeriodicQueue) ||
                other.isIncludePeriodicQueue == isIncludePeriodicQueue) &&
            const DeepCollectionEquality()
                .equals(other._periodicQueue, _periodicQueue) &&
            (identical(other.autoStart, autoStart) ||
                other.autoStart == autoStart) &&
            (identical(other.vibrationActivate, vibrationActivate) ||
                other.vibrationActivate == vibrationActivate) &&
            (identical(other.vibrationActiveDegree, vibrationActiveDegree) ||
                other.vibrationActiveDegree == vibrationActiveDegree) &&
            (identical(other.needChronometer, needChronometer) ||
                other.needChronometer == needChronometer) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            const DeepCollectionEquality()
                .equals(other.keyboardValue, keyboardValue) &&
            const DeepCollectionEquality()
                .equals(other._sensorTypes, _sensorTypes) &&
            const DeepCollectionEquality()
                .equals(other._challengeTypes, _challengeTypes) &&
            const DeepCollectionEquality()
                .equals(other._sequenceMap, _sequenceMap) &&
            (identical(other.chosedSensorIndex, chosedSensorIndex) ||
                other.chosedSensorIndex == chosedSensorIndex) &&
            (identical(other.choosedChallengeTypeIndex, choosedChallengeTypeIndex) ||
                other.choosedChallengeTypeIndex == choosedChallengeTypeIndex) &&
            (identical(other.allowSameColor, allowSameColor) ||
                other.allowSameColor == allowSameColor) &&
            (identical(other.dstConfig, dstConfig) ||
                other.dstConfig == dstConfig) &&
            (identical(other.accConfig, accConfig) ||
                other.accConfig == accConfig) &&
            (identical(other.gameDropOptionsModel, gameDropOptionsModel) ||
                other.gameDropOptionsModel == gameDropOptionsModel) &&
            (identical(other.playerCount, playerCount) ||
                other.playerCount == playerCount) &&
            (identical(other.padCount, padCount) ||
                other.padCount == padCount) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.timeout, timeout) || other.timeout == timeout) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.distance, distance) || other.distance == distance) &&
            (identical(other.radius, radius) || other.radius == radius));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        controlsSetup,
        type,
        scoreTypeParam1,
        scoreTypeParam2,
        scoreTypeParam3,
        scoreTypeParam4,
        scoreTypeParam5,
        scoreTypeParam6,
        stagedPlayerModel,
        generalStagedPlayerModel,
        roundCount,
        doesHaveSound,
        isPercentage,
        isColorSelectOrder,
        isScore,
        isContainMainBase,
        isIncludePeriodicQueue,
        const DeepCollectionEquality().hash(_periodicQueue),
        autoStart,
        vibrationActivate,
        vibrationActiveDegree,
        needChronometer,
        keyboardType,
        const DeepCollectionEquality().hash(keyboardValue),
        const DeepCollectionEquality().hash(_sensorTypes),
        const DeepCollectionEquality().hash(_challengeTypes),
        const DeepCollectionEquality().hash(_sequenceMap),
        chosedSensorIndex,
        choosedChallengeTypeIndex,
        allowSameColor,
        dstConfig,
        accConfig,
        gameDropOptionsModel,
        playerCount,
        padCount,
        duration,
        timeout,
        delay,
        distance,
        radius
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StaticGameSetupModelCopyWith<_$_StaticGameSetupModel> get copyWith =>
      __$$_StaticGameSetupModelCopyWithImpl<_$_StaticGameSetupModel>(
          this, _$identity);
}

abstract class _StaticGameSetupModel extends StaticGameSetupModel {
  const factory _StaticGameSetupModel(
      {final GameControlsSetup controlsSetup,
      required final GameEndType type,
      required final GameScoreType scoreTypeParam1,
      required final GameScoreType? scoreTypeParam2,
      final GameScoreType? scoreTypeParam3,
      final GameScoreType? scoreTypeParam4,
      final GameScoreType? scoreTypeParam5,
      final GameScoreType? scoreTypeParam6,
      final StagedPlayerModel? stagedPlayerModel,
      final StagedPlayerModel? generalStagedPlayerModel,
      final int? roundCount,
      @Deprecated("You can use [] if you want use this "
          "attribute you must listen this value.But this parameter "
          "member of object and object killing and setting default "
          "value when close game so you can't remember last status.")
      final bool doesHaveSound,
      final bool isPercentage,
      final bool isColorSelectOrder,
      final bool isScore,
      final bool isContainMainBase,
      final bool? isIncludePeriodicQueue,
      final List<DiscoveredDevice> periodicQueue,
      final bool autoStart,
      final bool vibrationActivate,
      final NumRange? vibrationActiveDegree,
      final bool needChronometer,
      final TextInputType? keyboardType,
      final KeyboardValue keyboardValue,
      required final Map<UsedSensorsType, bool> sensorTypes,
      final Map<ChallengeType, bool>? challengeTypes,
      final Map<int, String>? sequenceMap,
      final int chosedSensorIndex,
      final int choosedChallengeTypeIndex,
      final bool allowSameColor,
      final DstConfigModel? dstConfig,
      final AccConfigModel? accConfig,
      final GameDropOptionsModel? gameDropOptionsModel,
      final NumRange? playerCount,
      final NumRange? padCount,
      final NumRange? duration,
      final NumRange? timeout,
      final NumRange? delay,
      final NumRange? distance,
      final NumRange? radius}) = _$_StaticGameSetupModel;
  const _StaticGameSetupModel._() : super._();

  @override
  GameControlsSetup get controlsSetup;
  @override
  GameEndType get type;
  @override
  GameScoreType get scoreTypeParam1;
  @override // TODO: do processing accordingly
  GameScoreType? get scoreTypeParam2;
  @override
  GameScoreType? get scoreTypeParam3;
  @override
  GameScoreType? get scoreTypeParam4;
  @override
  GameScoreType? get scoreTypeParam5;
  @override
  GameScoreType? get scoreTypeParam6;
  @override

  /// some games will need general config
  /// and not player specific. for example,
  /// the xo game wants to have 9 pads
  /// but none assigned to the players,
  /// the catch the pad game wants to have
  /// indefinite number of pads and colors,
  /// again, none assigned to the players.
  ///
  /// should make sure to always mark
  /// hasName to false.
  StagedPlayerModel? get stagedPlayerModel;
  @override
  StagedPlayerModel? get generalStagedPlayerModel;
  @override
  int? get roundCount;
  @override
  @Deprecated("You can use [] if you want use this "
      "attribute you must listen this value.But this parameter "
      "member of object and object killing and setting default "
      "value when close game so you can't remember last status.")
  bool get doesHaveSound;
  @override
  bool get isPercentage;
  @override
  bool get isColorSelectOrder;
  @override
  bool get isScore;
  @override
  bool get isContainMainBase;
  @override

  ///When customer want same queue for all players this attribute must be true
  ///And then set queue that was saved queue
  bool? get isIncludePeriodicQueue;
  @override

  ///This attribute is periodic queue that will be used in game
  List<DiscoveredDevice> get periodicQueue;
  @override

  ///These attributes determine how the game can be started. If this
  ///attribute is set to true, the chronometer will start automatically
  ///when the game starts. However, if this attribute is set to false,
  ///the game will only start when you move to the front pad or press the
  ///pad, and then you can start the chronometer.
  bool get autoStart;
  @override

  /// If set to [true], this attribute activates the vibration feature within the game.
  /// When set to [false], the game will not trigger any vibration feedback.
  bool get vibrationActivate;
  @override

  /// the values are in degrees for vibration
  NumRange? get vibrationActiveDegree;
  @override

  ///This attribute determine if the chronometer will be used in the game.
  bool get needChronometer;
  @override

  ///This attribute if we need input speacial value from keyboard
  ///and this we select which kind of keyboard run time type both number or text
  TextInputType? get keyboardType;
  @override

  ///With this attribute we can get value from current keyboard input.
  KeyboardValue get keyboardValue;
  @override

  /// this will be keyed by the sensor type,
  /// along with its lock value. keep false
  /// if you want the sensor to respect
  /// the threshold.
  /// btw the values of this means wether we
  /// accept conditionless flow of data AKA
  /// unlock the sensor
  Map<UsedSensorsType, bool> get sensorTypes;
  @override

  ///This parameter help select both sequential and randomly.
  Map<ChallengeType, bool>? get challengeTypes;
  @override
  Map<int, String>? get sequenceMap;
  @override
  int get chosedSensorIndex;
  @override
  int get choosedChallengeTypeIndex;
  @override
  bool get allowSameColor;
  @override
  DstConfigModel? get dstConfig;
  @override
  AccConfigModel? get accConfig;
  @override
  GameDropOptionsModel? get gameDropOptionsModel;
  @override

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  NumRange? get playerCount;
  @override

  /// this is non nullable, you can use '!' with this.
  /// see the comment above.
  NumRange? get padCount;
  @override

  /// the values are in seconds
  NumRange? get duration;
  @override

  /// the values are in seconds
  NumRange? get timeout;
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

  /// Sensitivty for motion games
  /// assign radius value for pads
  NumRange? get radius;
  @override
  @JsonKey(ignore: true)
  _$$_StaticGameSetupModelCopyWith<_$_StaticGameSetupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
