import 'package:catchpad/v2/utils/widgets/cards/square_game_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GameCardGridView extends StatelessWidget {
  const GameCardGridView({
    super.key,
    required this.gameCard,
    required this.itemCount,
  });

  final SquareGameCard gameCard;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          childAspectRatio: 0.45,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return gameCard;
        },
      ),
    );
  }
}
