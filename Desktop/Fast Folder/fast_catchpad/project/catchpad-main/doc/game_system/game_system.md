# The Game System
this document describes how the game (or sometimes referred to as activity) system works.

We have a `StaticGameModel`, you might think why not `GameModel`?
well, when I (@adnan) first got on the project, I was not sure how to implement the game system, and tried to implement a fully dynamic system right away (`DyanmicGameModel`). that did not go well, as each game was very specific, and the solution had to making the system dynamic incrementally, so there `StaticGameModel` was born.

## `GameModel`
`GameModel`: has the primary properties of the game.

### `enabled` and `priotirized`
properties are a temp solution to (enabled) unshow some games, and (priotirized) show the implemented ones on the top.

### `metadata`
this is the data of the game such as `id`, `name`, `descrption`, etc. a lot of the properties do not have an influence on the game play, but they are only for the ui.

some properties though, should be transferred to `StaticGameSetupModel` on init. these properties are `padCount`, `playerCount`, (not implemented yet) `duration`, (not implemented yet) `distance`, they should be transferred so some of them can be modified by the user like `duration` and `distance`. 

## `StaticGameModel`
`StaticGameModel` is a child of `GameModel`. its basically what's used everywhere in the app, we should remove `GameModel` soon, and keep everything in `StaticGameModel`, as `GameModel` has no advantage.

## `DynamicGameModel`
as described above, `DynamicGameModel` was an attempt to make all the system dynamic at once, but it did not go well, because currently we need a static system that we'd incrementally make it more dynamic, but this implementation is not bad, and might be what we want to evolve to in the future.

### `GameEndType`
this enum specifies when the game should stop execution. it has 3 types: duration, score, and instructions. when the type is duration, we keep executing the instructions until the duration is over, when the type is score, we keep executing the instructions until the score is reached, and when the type is instructions, we keep executing the instructions until the instructions are over.

