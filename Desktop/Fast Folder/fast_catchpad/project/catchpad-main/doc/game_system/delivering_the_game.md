# This document describes how we deliver the game
so, when we navigate to the game detail screen, we set the `detailGameProv` and `currentGameProv` to the selected game.

we use `detailGameProv` for a pure unedited copy of the selected game, and `currentGameProv` for a copy of the selected game that we can edit and config for example the duration of the game. 

why we need a pure copy:
while setting up some stuff like the duration or the distance, we need the origin duration as we calculate the min and max value accordingly. for example if the original duration is 30 seconds, and we set the min to be `originalDur - 10`, then set the selected duration to be 20 seconds, if we did not have the original the setter will use the edited duration and the min value will become 10, and then 0 and etc.
```dart
    return NumberPicker(
      value: sec,
      // see, if we had to use `sec` instead of `initSec`, then every time the min and max would change.
      minValue: initSec ~/ 2,
      maxValue: initSec * 2,
      onChanged: (val) {
        sec = val;
        setState((){});
      }, 
    );
  }
```