# PlayerModel

this document describes the [`PlayerModel`](../../lib/models/game/player/player_model.dart).

## context
pre game we ask the players to customize their players according to the [`StagedPlayerModel`](./staged_player_model.md) we have specified. each of these customizations result in a `PlayerModel`, and we generate a `PlayerModel` for each player.

## properties

### id
an incremental id that is generated for each player. this is unique only gameplay-wise, meaning that each time we wanna play a game we reset the id to 1, and give each player an increasing id. the goal of this is to make it easier for the user to identify each player in each single game play, not to identfiy them leaderboard-wise, for that we'll use the [`user` property](#user).

### createdAt
this is only used for sorting the players in the game's indivisual result page. as the [`id`](#id) is a string, we can't sort by it, as we want for example '2' to come before '10', however when they are strings, '10' will be before '2'. so we use this property to sort by the time the player was created.

### name
each player has 2 options: select an existing user or write a name. if the user selects to write a name, then we will show a name input field and set this property to the name the user entered. if the user selects an existing user, this property will stay null and the user's name will be taken from the name of the [`user` property](#user).

### user
when the player selects an existing user, we set this property to that user's info. this contains name, uid, and optionally email and phone number. 

### colors
a list of the colors the player has selected.

### devices
a list of the devices the player has selected.