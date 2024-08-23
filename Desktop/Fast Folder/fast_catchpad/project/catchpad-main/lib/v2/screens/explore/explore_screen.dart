import 'package:catchpad/v2/screens/explore/explore_mixin.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_appbar.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_bottombar.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:catchpad/v2/utils/widgets/cards/square_game_card.dart';
import 'package:catchpad/v2/utils/widgets/chips/filter_chips.dart';
import 'package:catchpad/v2/utils/widgets/grid/game_card_grid.dart';
import 'package:catchpad/v2/utils/widgets/textfields/cp_search_bar_filter_icon.dart';
import 'package:catchpad/v2/utils/widgets/texts/menu_headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<ExploreScreen>
    with ExploreScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CustomBottomBar(),
        appBar: const CustomAppBar(
          title: 'Kesfet',
          appBarLeadingType: AppBarLeadingType.backButton,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(2.h),
                  Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: CpSearchBarFilterIcon(height: 5.h)),
                  Gap(1.5.h),
                  const FilterChips(
                    filters: ['Tüm Oyunlar', 'Popüler', 'Yeni', 'Kategoriler'],
                  ),
                  Gap(2.h),
                  ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MenuHeadline(text: 'Futbol'),
                            Gap(1.h),
                            GameCardGridView(
                                gameCard: gameCardMock, itemCount: 10),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
