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

class TestsScreen extends ConsumerStatefulWidget {
  const TestsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestsScreenState();
}

class _TestsScreenState extends ConsumerState<TestsScreen> {
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
                children: [Gap(2.h)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
