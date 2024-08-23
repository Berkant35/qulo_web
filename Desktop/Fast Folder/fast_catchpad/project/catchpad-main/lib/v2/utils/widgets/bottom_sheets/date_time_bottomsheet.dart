import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DatePickerBottomSheet extends StatefulWidget {
  const DatePickerBottomSheet({super.key});

  @override
  _DatePickerBottomSheetState createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  int _selectedDay = 15;
  int _selectedMonth = 6;
  int _selectedYear = 2000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.11, 1.0],
          colors: [
            CpColors.cpEerieBlack,
            Color(0xff1B1B1B),
            CpColors.cpChineseBlack,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Gün',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Gap(3.h),
                  NumberPicker(
                    value: _selectedDay,
                    minValue: 1,
                    maxValue: 31,
                    onChanged: (value) => setState(() => _selectedDay = value),
                    textStyle: const TextStyle(color: Colors.white54),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Ay',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Gap(3.h),
                  NumberPicker(
                    value: _selectedMonth,
                    minValue: 1,
                    maxValue: 12,
                    onChanged: (value) =>
                        setState(() => _selectedMonth = value),
                    textStyle: const TextStyle(color: Colors.white54),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Yil',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Gap(3.h),
                  NumberPicker(
                    value: _selectedYear,
                    minValue: 1900,
                    maxValue: 2022,
                    onChanged: (value) => setState(() => _selectedYear = value),
                    textStyle: const TextStyle(color: Colors.white54),
                    selectedTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ],
          ),
          Gap(3.h),
          CustomCatchpadButtons.buildBackGroundGradientButton(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
            onPressed: () {
              Navigator.pop(context, {
                'day': _selectedDay,
                'month': _selectedMonth,
                'year': _selectedYear,
              });
            },
            text: 'tamam',
          ),
        ],
      ),
    );
  }
}
