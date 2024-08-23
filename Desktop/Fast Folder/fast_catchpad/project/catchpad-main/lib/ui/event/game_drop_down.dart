import 'package:catchpad/models/game/game_model.dart';
import 'package:flutter/material.dart';

class GameDropdownWidget extends StatefulWidget {
  final Set<GameModel> games;
  final Function(GameModel) onGameSelected;

  const GameDropdownWidget({super.key, required this.games, required this.onGameSelected});

  @override
  _GameDropdownWidgetState createState() => _GameDropdownWidgetState();
}

class _GameDropdownWidgetState extends State<GameDropdownWidget> {
  GameModel? selectedGame;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GameModel>(
      value: selectedGame,
      items: widget.games.map((game) {
        return DropdownMenuItem<GameModel>(
          value: game,
          child: Text(game
              .metaData.name), // Assuming your GameModel has a 'name' property
        );
      }).toList(),
      onChanged: (game) {
        setState(() {
          selectedGame = game;
          widget.onGameSelected(game!);
        });
      },
    );
  }
}
