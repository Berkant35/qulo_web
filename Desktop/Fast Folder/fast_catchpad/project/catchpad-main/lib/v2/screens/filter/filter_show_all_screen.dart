import 'package:catchpad/v2/screens/filter/filter_screen.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_appbar.dart';
import 'package:catchpad/v2/utils/widgets/textfields/cp_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterShowAllScreen extends ConsumerStatefulWidget {
  const FilterShowAllScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterShowAllScreenState();
}

class _FilterShowAllScreenState extends ConsumerState<FilterShowAllScreen> {
  final List<String> items = ['Futbol', 'Basketbol', 'Voleybol', 'Tenis'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(
        isbluetoothButton: false,
        isBackButtonColored: true,
        title: 'Branş',
        appBarLeadingType: AppBarLeadingType.backButton,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const CpSearchBar(),
          ),
          Gap(2.h),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 0, 1.w, 0),
            child: BasicRadioList(items: items),
          )
        ],
      ),
    );
  }
}
