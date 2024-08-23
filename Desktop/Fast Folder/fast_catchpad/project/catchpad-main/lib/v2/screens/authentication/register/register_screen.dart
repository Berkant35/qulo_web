import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/screens/authentication/register/register_mixin.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:catchpad/v2/utils/widgets/textfields/textfield_with_headline.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Hoş geldin!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Gap(2.h),
                  //email
                  const TextfieldWithHeadline(
                    keyboardType: TextInputType.emailAddress,
                    headline: 'EMAIL',
                    hintText: 'info@catchpad.com',
                  ),
                  Gap(2.h),
                  //phone number
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('NUMARA'),
                      Gap(2.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              showCountryCodePicker(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: CpColors.cpDireWolf,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('+$pickedCountryCode'),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                          Gap(7.w),
                          Expanded(
                            flex: 3,
                            child: TextField(
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                    hintText: '532 123 45 67')),
                          )
                        ],
                      ),
                    ],
                  ),
                  Gap(2.h),
                  //name and surname
                  Row(children: [
                    const Expanded(
                      child: TextfieldWithHeadline(
                        headline: 'ADIN',
                        hintText: 'Ahmet',
                      ),
                    ),
                    Gap(7.w),
                    const Expanded(
                      child: TextfieldWithHeadline(
                        headline: 'SOYADIN',
                        hintText: 'Yilmaz',
                      ),
                    )
                  ]),
                  Gap(2.h),
                  //password
                  Column(children: [
                    const TextfieldWithHeadline(
                      headline: 'ŞİFRE',
                      hintText: '********',
                      obscureText: true,
                    ),
                    Gap(2.h),
                    const TextfieldWithHeadline(
                      headline: 'ŞİFREYİ TEKRAR GİRİN',
                      hintText: '********',
                      obscureText: true,
                    )
                  ]),
                  Gap(2.h),
                  Row(children: [
                    Checkbox.adaptive(
                        activeColor: CpColors.cpPrimary,
                        checkColor: CpColors.cpDireWolf,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: isAcceptedTerms,
                        onChanged: (value) {
                          setState(() {
                            isAcceptedTerms = value!;
                          });
                        }),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //  navigate to privacy policy page
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                            ),
                            children: const [
                              TextSpan(text: 'Devam ederek, '),
                              TextSpan(
                                text: 'gizlilik politikasını',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(text: ' onayladığınızı '),
                              TextSpan(
                                text: 'kabul etmiş',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(text: ' oluyorsunuz.'),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ]),
                  // continue button
                  Gap(1.h),
                  Align(
                    alignment: Alignment.center,
                    child: CustomCatchpadButtons.buildBackGroundGradientButton(
                        onPressed: () {},
                        text: 'ileri',
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 10.w)),
                  ),
                  Gap(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Zaten bir hesabin var mi? '),
                      Gap(1.w),
                      GestureDetector(
                        onTap: () {
                          // navigate to login page
                        },
                        child: const Text(
                          'Giris Yap',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white),
                        ),
                      ),
                    ],
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


