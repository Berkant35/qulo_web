import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/v2/screens/explore/explore_screen.dart';
import 'package:catchpad/v2/screens/home/home_mixin.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_appbar.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_bottombar.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:catchpad/v2/utils/widgets/buttons/gradient_text_button.dart';
import 'package:catchpad/v2/utils/widgets/cards/game_card.dart';
import 'package:catchpad/v2/utils/widgets/cards/square_game_card.dart';
import 'package:catchpad/v2/utils/widgets/chips/filter_chips.dart';
import 'package:catchpad/v2/utils/widgets/textfields/cp_search_bar_filter_icon.dart';
import 'package:catchpad/v2/utils/widgets/texts/menu_headline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreenV2 extends ConsumerStatefulWidget {
  const HomeScreenV2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreenV2>
    with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Egzersiz Platformu',
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(3.h),
                  Gap(3.h),
                  const MenuHeadline(
                    text: 'Önerilen Egzersizler',
                  ),
                  Gap(1.h),
                  SizedBox(
                    height: 20.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: squareGameCardList.map((game) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: GameCard(
                            gameTitle: game.gameTitle,
                            earnings: game.earnings,
                            playerCount: game.playerCount,
                            padCount: game.padCount,
                            imagePath: game.imagePath,
                            onTap: () {},
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Gap(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MenuHeadline(text: 'Keşfet'),
                      Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: GradientTextButton(
                            text: 'hepsini gör',
                            onTap: () {
                              Navigator.pushNamed(context, '/explore');
                            }),
                      )
                    ],
                  ),
                  Gap(1.h),
                  SizedBox(
                    height: 60.w, // Adjust the height as needed
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: squareGameCardList.map((game) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: SquareGameCard(
                            gameTitle: game.gameTitle,
                            earnings: game.earnings,
                            playerCount: game.playerCount,
                            padCount: game.padCount,
                            imagePath: game.imagePath,
                            onTap: () {},
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Gap(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MenuHeadline(text: 'Favorilerim'),
                      Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: GradientTextButton(
                            text: 'hepsini gör', onTap: () {}),
                      )
                    ],
                  ),
                  Gap(1.h),
                  SizedBox(
                    height: 20.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: squareGameCardList.map((game) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: GameCard(
                            gameTitle: game.gameTitle,
                            earnings: game.earnings,
                            playerCount: game.playerCount,
                            padCount: game.padCount,
                            imagePath: game.imagePath,
                            onTap: () {},
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
