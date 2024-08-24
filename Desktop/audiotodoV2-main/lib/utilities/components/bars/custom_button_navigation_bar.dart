import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../generated/l10n.dart';
import '../../constants/extensions/context_extension.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  ConsumerState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends ConsumerState<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        height: 10.h,
        decoration: const BoxDecoration(
          color: CustomColors.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 6.5.w, right: 6.5.w, top: 0.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: CustomColors.primaryColor,
              elevation: 0,
              selectedItemColor: CustomColors.accentColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.white,
              unselectedLabelStyle: ThemeValueExtension.chip.copyWith(
                  fontWeight: FontWeight.w500,
                  color: CustomColors.fillWhiteColor),
              selectedLabelStyle: ThemeValueExtension.chip.copyWith(
                  fontWeight: FontWeight.bold, color: CustomColors.accentColor),
              currentIndex: ref.watch(currentNavigationIndex),
              onTap: changeState,
              items: items(),
            ),
          ),
        ),
      ),
    );
  }

  void changeState(value) =>
      ref.read(currentNavigationIndex.notifier).changeState(value,ref);

  List<BottomNavigationBarItem> items() {
    return [
      bottomNavigationBarItem(Icons.person, S.current.profil, 0,
          svgPicture: IconPaths.icProfile.customSvgIcon(
              color: 0 == ref.watch(currentNavigationIndex)
                  ? CustomColors.fillWhiteColor
                  : CustomColors.lightGrey,
              iconSize: 10.w)),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.abc_outlined,
            color: Colors.transparent,
            size: 4.h,
          ),
          label: ''),
      bottomNavigationBarItem(Icons.list, S.current.navbar_meets, 2,
          svgPicture: IconPaths.icMeetings.customSvgIcon(
              color: 2 == ref.watch(currentNavigationIndex)
                  ? CustomColors.fillWhiteColor
                  : CustomColors.lightGrey,
              iconSize: 10.w)),
    ];
  }

  BottomNavigationBarItem bottomNavigationBarItem(
      IconData iconData, String label, int currentIndex,
      {SvgPicture? svgPicture}) {
    return BottomNavigationBarItem(
        icon: svgPicture ??
            Icon(
              iconData,
              size: 4.h,
              color: currentIndex == ref.watch(currentNavigationIndex)
                  ? CustomColors.accentColor
                  : CustomColors.fillWhiteColor,
            ),
        label: "");
  }
}
