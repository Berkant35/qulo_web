# StagedPlayerModel

this document describes the [`StagedPlayerModel`](../../lib/models/game/player/staged_player_model.dart).

## context:
the staged player model is specified written to the [`StaticGameSetupModel`](./static_game_setup_model.md), and it is used pre game to make the player customizable.

## properties

### colorCount
the range of count of colors this player has to select.

### defaultSelectedColors
the colors that are selected by default.

### hasName
wether this player has a name. if this is true, we will show a name input field.

### unavailableColors
the colors that are restricted to being selected in this game. due to the nature of the game, some colors are not available to be selected. for example if this game uses red color to indicate mistake, then red is not available to be selected.

### deviceCount
the range of count of devices this player has to select. the `min` and `max` count will be changed during players' device selection. their range will always be between the original `min` and the original `max`. 

imagine we have a game that has 4 players.
and connected to 12 pads.
#### how `min` changes
each player should select 1-4 devices. when the first player selects 2 devices, then each player's min will be 2.

#### how `max` changes
originally its true that each player can select up to 4 devices, but as we're connected to 12 pads and we have 4 players, when we do the math, each player can select up to 3 devies. we do not let the user do this math, instead we do it ourselves and restrict the range of devices to be between 1 and 3.

### hasDevices
related to [deviceCount](#deviceCount) but as different from it. when this is true, this player can select a range of devices as much as the range of [GameMetadataModel.padCount](../../lib/models/game/metadata/game_metadata_model.dart). 

**you should be careful when setting this to true, as if you have more than 1 player alloweed to select a lot of devices, then the user might not be able to start the game as most of the cases not each player will have the ability to select the range of devices, and in case they start the game, the game will most likely be broken. THIS SHOULD ONLY BE TRUE FOR GENERAL PLAYER**.