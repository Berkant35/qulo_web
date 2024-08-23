import 'package:catchpad/v2/utils/widgets/cards/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SquareGameCard extends ConsumerStatefulWidget {
  final imagePath;
  final String gameTitle;
  final List<String> earnings;
  final String playerCount;
  final String padCount;
  final void Function() onTap;
  final GameCardDirection? direction;

  const SquareGameCard({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.gameTitle,
    required this.earnings,
    required this.playerCount,
    required this.padCount,
    this.direction = GameCardDirection.vertical,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SquareGameCardState();
}

class _SquareGameCardState extends ConsumerState<SquareGameCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.direction == GameCardDirection.vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(),
                _content(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(),
                Gap(3.w),
                _content(),
              ],
            ),
    );
  }

  GameCardContentWidget _content() {
    return GameCardContentWidget(
      gameTitle: widget.gameTitle,
      earnings: widget.earnings,
      playerCount: widget.playerCount,
      padCount: widget.padCount,
      addGap: true,
    );
  }

  Container _image() {
    final double size = 14.h;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          widget.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

enum GameCardDirection { horizontal, vertical }
