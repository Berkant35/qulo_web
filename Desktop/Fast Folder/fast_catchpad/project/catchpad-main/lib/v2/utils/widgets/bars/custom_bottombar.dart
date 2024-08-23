import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBottomBar extends ConsumerWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = 2;
    return NavigationBar(
      height: 7.h,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: CpColors.cpEerieBlack,
      indicatorColor: Colors.transparent,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        selectedIndex = index;
        print(selectedIndex);
      },
      destinations: [
        NavigationDestination(
          icon: CustomNavigationDestinationWidget(
            isSelected: selectedIndex == 0,
            svg: CatchpadIconsV2.homeV2,
          ),
          label: '',
        ),
        NavigationDestination(
          icon: CustomNavigationDestinationWidget(
            isSelected: selectedIndex == 1,
            svg: CatchpadIconsV2.testV2
                .copyWith(iconColor: CpColors.cpPrimary, height: 32),
          ),
          label: '',
        ),
        NavigationDestination(
          icon: CustomNavigationDestinationWidget(
            isSelected: selectedIndex == 2,
            svg: CatchpadIconsV2.catchpost
                .copyWith(iconColor: CpColors.cpPrimary, height: 32),
          ),
          label: '',
        ),
        NavigationDestination(
          icon: CustomNavigationDestinationWidget(
            isSelected: selectedIndex == 3,
            svg: CatchpadIconsV2.stats
                .copyWith(iconColor: CpColors.cpPrimary, height: 32),
          ),
          label: '',
        ),
        NavigationDestination(
          icon: CustomNavigationDestinationWidget(
            isSelected: selectedIndex == 4,
            svg: CatchpadIconsV2.settingsV2
                .copyWith(iconColor: CpColors.cpPrimary, height: 32),
          ),
          label: '',
        ),
      ],
    );
  }
}

class CustomNavigationDestinationWidget extends ConsumerWidget {
  final bool isSelected;
  final CustomSvg svg;
  const CustomNavigationDestinationWidget(
      {required this.svg, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: CpColors.cpPrimary.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ]
            : null,
      ),
      child: svg.copyWith(
          iconColor: isSelected ? CpColors.cpPrimary : CpColors.cpWolfram),
    );
  }
}
