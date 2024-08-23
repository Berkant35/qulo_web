import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GameCard extends StatefulWidget {
  bool isFavorite;
  final String gameTitle;
  final String imagePath;
  final List<String> earnings;
  final String playerCount;
  final String padCount;
  final void Function()? onTap;
  GameCard({
    super.key,
    this.isFavorite = false,
    required this.imagePath,
    required this.gameTitle,
    required this.onTap,
    required this.earnings,
    required this.playerCount,
    required this.padCount,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 80.w,
        height: 22.h,
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.4, 0.9],
                      colors: [
                        CpColors.cpPrimary.withOpacity(0.05),
                        CpColors.cpPrimary.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.5, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.5, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.center,
                      end: Alignment.topLeft,
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(widget.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined),
                    onPressed: () {
                      setState(() {
                        widget.isFavorite = !widget.isFavorite;
                      });
                    },
                    iconSize: 24,
                    color: CpColors.cpPrimary,
                  )),
              Positioned(
                left: 3.w,
                bottom: 1.h,
                child: GameCardContentWidget(
                  gameTitle: widget.gameTitle,
                  earnings: widget.earnings,
                  playerCount: widget.playerCount,
                  padCount: widget.padCount,
                  addGap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameCardContentWidget extends ConsumerWidget {
  final String gameTitle;
  final List<String> earnings;
  final String playerCount;
  final String padCount;
  final bool addGap;

  const GameCardContentWidget({
    super.key,
    required this.gameTitle,
    required this.earnings,
    required this.playerCount,
    required this.padCount,
    required this.addGap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CpLogoWithText(
            height: 3.5.h,
            width: 7.h,
          ),
          Text(
            gameTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(0.5.h),
          Text(
            '${earnings.join(', ')} ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          if (addGap) Gap(1.5.h),
          Row(
            children: [
              Image.asset(
                'assets/v2/icons/user.png',
                height: 1.h,
              ),
              Gap(0.5.w),
              Text(playerCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                  )),
              const Text(' · '),
              Image.asset(
                'assets/v2/icons/pad.png',
                height: 1.h,
              ),
              Gap(1.w),
              Text(padCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
