import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/utils/widgets/bars/custom_appbar.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:catchpad/v2/utils/widgets/buttons/gradient_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  final List<String> items = [
    'Futbol',
    'Basketbol',
    'Voleybol',
    'Tenis',
    'Yüzme',
    'Atletizm',
  ];
  final List<String> players = [
    'Tek oyuncu',
    'İki oyuncu',
    'Çok oyuncu',
  ];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          isbluetoothButton: false,
          isBackButtonColored: true,
          title: 'Branş',
          appBarLeadingType: AppBarLeadingType.backButton,
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      CpRadioList(
                        title: 'Branş',
                        items: players,
                      ),
                      Gap(2.h),
                      CpRadioList(
                        title: 'Branş',
                        items: items,
                        showAll: true,
                      ),
                      Gap(10.h),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: 10.h,
                    width: 100.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCatchpadButtons.buildBorderButton(
                            onPressed: () {},
                            text: 'temizle',
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            ref: ref,
                            height: 6.h,
                            borderColor: Colors.white),
                        Gap(5.w),
                        CustomCatchpadButtons.buildGradientAccentButton(
                            onPressed: () {},
                            text: 'hepsini göster',
                            height: 6.h,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 5.w),
                            color: Colors.white),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CpRadioList extends ConsumerStatefulWidget {
  final List<String> items;
  final String title;
  final bool? isTransparent;
  bool showAll;
  CpRadioList({
    this.isTransparent,
    this.showAll = false,
    required this.title,
    required this.items,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CpRadioListState();
}

class _CpRadioListState extends ConsumerState<CpRadioList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    int count = widget.showAll ? 3 : widget.items.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: (widget.isTransparent ?? false)
            ? Colors.transparent
            : CpColors.cpDireWolf,
        border: Border.all(
          color: CpColors.cpBasicWhite.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: EdgeInsets.fromLTRB(8.w, 3.h, 20.w, 3.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
        Gap(2.h),
        for (int i = 0; i < count; i++)
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.items[i],
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w300),
                ),
                Radio<String>(
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: CpColors.cpPrimary,
                  value: widget.items[i],
                  groupValue: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
        Gap(2.h),
        if (widget.showAll)
          GradientTextButton(
              text: 'Hepsini gör', onTap: () {}, fontSize: 17.sp),
      ]),
    );
  }
}

class BasicRadioList extends ConsumerStatefulWidget {
  final List<String> items;
  const BasicRadioList({required this.items, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicRadioListState();
}

class _BasicRadioListState extends ConsumerState<BasicRadioList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.items.map((item) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w300),
          ),
          Radio<String>(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            activeColor: CpColors.cpPrimary,
            value: item,
            groupValue: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ],
      );
    }).toList());
  }
}
