import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:catchpad/v2/utils/widgets/bottom_sheets/date_time_bottomsheet.dart';
import 'package:catchpad/v2/utils/widgets/dropdowns/cp_dropdown.dart';
import 'package:catchpad/v2/utils/widgets/dropdowns/dropdown_with_headline.dart';
import 'package:catchpad/v2/utils/widgets/textfields/textfield_with_headline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/screens/self_identify/self_identify_mixin.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:gap/gap.dart';

class SelfIdentifyScreen extends StatefulWidget {
  const SelfIdentifyScreen({super.key});

  @override
  _SelfIdentifyScreenState createState() => _SelfIdentifyScreenState();
}

class _SelfIdentifyScreenState extends State<SelfIdentifyScreen>
    with SelfIdentifyMixin {
  @override
  Widget build(BuildContext context) {
    final headline = switch (currentIndex) {
      0 => 'Uzmanlık & İlgi Alanları',
      1 => 'Uzmanlık & İlgi Alanları',
      2 => 'Uzmanlık & İlgi Alanları',
      3 => 'Merhaba Ahmet seni biraz\ntanımak istiyoruz',
      4 => 'Harika şimdi bir profil resmi seç',
      int() => 'Uzmanlık & İlgi Alanları',
    };
    return BaseBackground(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          title: Text(
            headline,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 20),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            key: ValueKey<int>(
                                currentIndex), // Ensure unique key
                            children: [
                              Text(
                                titles[currentIndex],
                                key: ValueKey<int>(
                                    currentIndex), // Ensure unique key
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: currentIndex >= 3 ? 11.sp : 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Gap(5.h),
                              // chips
                              if (currentIndex < 3) _contentChips(),
                              if (currentIndex == 3) _personalInfos(context),
                              if (currentIndex == 4) _addPhoto()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(children: [
                ...List<Widget>.generate(5, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    height: 9.0,
                    width: 9.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? CpColors.cpPrimary
                          : CpColors.cpPrimary.withOpacity(0.4),
                    ),
                  );
                }),
                const Spacer(),
                CustomCatchpadButtons.buildGradientAccentButton(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (currentIndex != 4) {
                        currentIndex++;
                      }
                    });
                  },
                  text: 'devam et',
                ),
              ]),
              Gap(2.h),
            ],
          ),
        ),
      ),
    );
  }

  Column _addPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 30.w,
            backgroundColor: CpColors.cpDireWolf,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 20.w,
                ),
                Text(
                  'Fotoğraf çek',
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Gap(5.h),
        const Text(
          'Ya da',
          style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white),
        ),
        Gap(5.h),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Film rulosundan seç',
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Column _personalInfos(BuildContext context) {
    return Column(
      children: [
        const TextfieldWithHeadline(
          headline: 'KULLANICI ADI',
          hintText: 'kullanici adi',
          subTitle:
              'Kullanıcı adınız CatchPad kullanıcıları tarafından görülür.',
        ),
        Gap(4.h),
        Row(
          children: [
            Expanded(
              child: DropdownWithHeadline(
                items: kilogram,
                title: 'AĞIRLIK',
              ),
            ),
            Gap(5.w),
            Expanded(
              child: DropdownWithHeadline(
                items: height,
                title: 'BOY',
              ),
            ),
          ],
        ),
        Gap(4.h),
        DropdownWithHeadline(
          items: gender,
          title: 'CİNSİYET',
        ),
        Gap(4.h),
        Column(
          children: [
            Row(
              children: [
                const Text(
                  'DOĞUM TARİHİ',
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_calendar_outlined,
                      color: Colors.white,
                      size: 18,
                    ))
              ],
            ),
            GestureDetector(
              onTap: () async {
                print('Tapped');
                final result = await showModalBottomSheet(
                  context: context,
                  builder: (context) => const DatePickerBottomSheet(),
                );
                if (result != null) {
                  dayController.text = result['day'].toString();
                  monthController.text = result['month'].toString();
                  yearController.text = result['year'].toString();
                  print(
                      'Selected date: ${result['day']}/${result['month']}/${result['year']}');
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dayController,
                      decoration: const InputDecoration(hintText: 'Gün'),
                      enabled: false,
                    ),
                  ),
                  Gap(5.w),
                  Expanded(
                    child: TextField(
                      controller: monthController,
                      decoration: const InputDecoration(hintText: 'Ay'),
                      enabled: false,
                    ),
                  ),
                  Gap(5.w),
                  Expanded(
                    child: TextField(
                      controller: yearController,
                      decoration: const InputDecoration(hintText: 'Yıl'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Column _contentChips() {
    return Column(
      children: [
        Center(
          child: Wrap(
            key: ValueKey<int>(currentIndex), // Ensure unique key
            spacing: 8.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.center,
            children: chipContents[currentIndex].map((item) {
              final isSelected = selectedItems.contains(item);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              CpColors.cpPrimary.withOpacity(0.2),
                              CpColors.cpPrimary.withOpacity(0.15),
                              CpColors.cpPrimary.withOpacity(0.1),
                              CpColors.cpPrimary.withOpacity(0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 0.5, 0.7, 1.0],
                          )
                        : const LinearGradient(
                            colors: [Colors.black, Colors.black],
                          ),
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: CpColors.cpPrimary,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: CpColors.cpPrimary.withOpacity(0.4),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Gap(2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              CustomCatchpadButtons.buildBorderTextButton(
                width: 100.w,
                onPressed: () {
                  setState(() {
                    isClickedOthers = !isClickedOthers;
                  });
                },
                borderWidth: isClickedOthers ? 0 : 1,
                gradient: isClickedOthers
                    ? const LinearGradient(
                        begin: Alignment(1.00, -0.01),
                        end: Alignment(-1, 0.01),
                        colors: [CpColors.cpNewGreen, CpColors.cpPear],
                      )
                    : null,
                text: 'diğer',
                textColor: isClickedOthers ? Colors.black : Colors.white,
              ),
              Gap(2.h),
              _addOther(),
            ],
          ),
        ),
      ],
    );
  }

  Column _addOther() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isClickedOthers) ...[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Buraya yaz',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 0,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Gap(15.w),
              CircleAvatar(
                radius: 25.0,
                backgroundColor: CpColors.cpDireWolf,
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: addItem,
                ),
              ),
            ],
          ),
        ],
        Gap(1.h),
        Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.start,
          children: otherItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.white.withOpacity(0.04),
                    child: IconButton(
                      icon:
                          const Icon(Icons.remove, color: CpColors.cpFieryRed),
                      onPressed: () => removeItem(item),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
