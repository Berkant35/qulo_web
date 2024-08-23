# This document describes the game score system.

## GameResultModel
our journey should start from [`GameResultModel`](../../lib/models/game/game_result_model.dart). this model stores each indivisual game play result, meaning each time a game is played, we generate a new `GameResultModel`. this model is %100 serializable. 

### properties:

#### `type`
described in [game_system.md](./game_system.md)

#### `players`
a list of [`PlayerModel`](../../lib/models/game/player/player_model.dart). at the start of each game we ask the users to fill  the `PlayerModel` is the model that stores the each player's information.

playerResults
gameId
createdAt
scoreTypeParam1
scoreTypeParam2
indexValue
winnerPlayerId