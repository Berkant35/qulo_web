import 'package:catchpad/v2/screens/home/home_screen.dart';
import 'package:catchpad/v2/utils/widgets/cards/square_game_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

mixin HomeScreenMixin on State<HomeScreenV2> {
   final List<String> filters = ['Tümü', 'Reaksiyon', 'Odak', 'Kordinasyon'];
  final List<SquareGameCard> squareGameCardList = [
    SquareGameCard(
      gameTitle: 'Renkli Yarış',
      earnings: const ['Reaksiyon', 'Odak', 'Kordinasyon'],
      playerCount: '3-10',
      padCount: '2-12',
      onTap: () {},
      imagePath: 'assets/images/games/4.jpeg',
    ),
    SquareGameCard(
      imagePath: 'assets/images/games/16.jpeg',
      gameTitle: 'Dikkat Dikkat',
      earnings: const ['Reaksiyon', 'Odak', 'Kordinasyon'],
      playerCount: '3-10',
      padCount: '2-12',
      onTap: () {},
    ),
    SquareGameCard(
      imagePath: 'assets/images/games/5.jpeg',
      gameTitle: 'Sürat Testi',
      earnings: const ['Reaksiyon', 'Odak', 'Kordinasyon'],
      playerCount: '3-10',
      padCount: '2-12',
      onTap: () {},
    ),
    SquareGameCard(
      imagePath: 'assets/images/games/2.jpeg',
      gameTitle: 'Ekip İşi',
      earnings: const ['Reaksiyon', 'Odak', 'Kordinasyon'],
      playerCount: '3-10',
      padCount: '2-12',
      onTap: () {},
    ),
  ];
}
