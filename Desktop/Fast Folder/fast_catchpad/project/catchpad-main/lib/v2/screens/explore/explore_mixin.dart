import 'package:catchpad/v2/screens/explore/explore_screen.dart';
import 'package:catchpad/v2/utils/widgets/cards/square_game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ExploreScreenMixin on ConsumerState<ExploreScreen> {
  final SquareGameCard gameCardMock = SquareGameCard(
    imagePath: 'assets/images/games/12.jpeg',
    gameTitle: 'Renkli Yarış',
    earnings: const ['Reaksiyon', 'Odak', 'Odak', 'Odak', 'Odak', 'Odak'],
    playerCount: '3-10',
    padCount: '2-12',
    onTap: () {},
    direction: GameCardDirection.horizontal,
  );
}
