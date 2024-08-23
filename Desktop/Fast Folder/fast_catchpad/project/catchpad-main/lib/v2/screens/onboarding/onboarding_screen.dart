import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/v2/screens/onboarding/onboarding_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with OnboardingMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xff1C1C1C),
      body: GestureDetector(
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Container(
            key: ValueKey<int>(currentIndex),
            child: Stack(
              children: [
                if (onboardingContents[currentIndex].imageType ==
                    ImageType.background)
                  Image.asset(
                    onboardingContents[currentIndex].imagePath,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: onboardingContents[currentIndex].imageType ==
                                  ImageType.frame
                              ? Image.asset(
                                  onboardingContents[currentIndex].imagePath,
                                )
                              : const SizedBox()),
                      Gap(3.h),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              onboardingContents[currentIndex].title,
                              textAlign: TextAlign.center,
                              style: textTheme.titleMedium!.copyWith(
                                  color: Colors.white, fontSize: 23.sp),
                            ),
                            Text(
                              onboardingContents[currentIndex].description,
                              style: textTheme.bodyLarge!.copyWith(
                                  color: Colors.white, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    onboardingContents.length, (int index) {
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
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 5,
                                  child: CustomCatchpadButtons
                                      .buildGradientAccentButton(
                                    color: Colors.white,
                                    height: 6.h,
                                    customGradientColor: [
                                      CpColors.cpPrimary.withOpacity(0.01),
                                      Colors.transparent
                                    ],
                                    onPressed: () {},
                                    text: 'kayıt ol',
                                  ),
                                ),
                                Gap(5.w),
                                Expanded(
                                  flex: 5,
                                  child: CustomCatchpadButtons
                                      .buildBorderTextButton(
                                          onPressed: () {},
                                          height: 6.h,
                                          text: 'giriş yap',
                                          textColor: Colors.white),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
