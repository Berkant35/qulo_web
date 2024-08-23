# StaticGameSetupModel

this document describes the [`StaticGameSetupModel`](../../lib/models/game/static_game_setup_model.dart).

## context

the game model itself handles a lot of stuff, so to substitute the game model's job, we have StaticGameSetupModel. this model handles everything about the players' customizations and game settings.

## properties

### `stagedPlayerModel` and `generalStagedPlayerModel`

each of these properties represent a [`StagedPlayerModel`](../../lib/models/game/player/staged_player_model.dart), which are used to specify the base properties of what each player of the game should have and what to select. described in detail [in this document](./staged_player_model.md). the `stagedPlayerModel` defines what each player should be able to customize, while `generalStagedPlayerModel` defines a general player's customizations wihchi can be used in the game without affecting the players, scores etc.

### controlsSetup

this specifies the controls specific to the game, such as sound, music, etc.

### [type](./game_system.md#gameendtype)

### scoreTypeParam1

this specifies according to what parameter this game should be scored. we'll dive to details in [game score documentation](./game_score.md).

### scoreTypeParam2

this is the tie breaker parameter. if the `scoreTypeParam1` is the same, then the `scoreTypeParam2` is used to determine the winner. processing this value has not been implemented yet.

### sensorTypes

specifies which sensors will be active in this game. this is a map of ``to`bool`, where you specify your sensor and wether to lock or unlock its threshold. see [pad_sensor_manager.\_activate](https://github.com/catchpad/catchpad_flutter_lib/blob/main/lib/src/models/pad_sensor_manaxger.dart)

### dstConfig

config of the distance sensor, which will be initiated pre game and returned to default when game ends.

### accConfig

config of the accelerometer sensor, which will be initiated pre game and returned to default when game ends.

### playerCount

range of player count that can play this game.

### padCount

range of pad count each player can select for themself.

### roundCount

how many rounds this game will be played.

### duration

how long this game will be played.

### distance

some games need to specify the distance of the game, for example in _şınav_ game this parameter specifies at what distance one _şınav_ will have been executed.
