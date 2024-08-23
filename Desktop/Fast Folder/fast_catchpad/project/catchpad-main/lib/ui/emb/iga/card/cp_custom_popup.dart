import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CpCustomPopup extends ConsumerStatefulWidget {
  final String title;
  final String firstButtonText;
  final VoidCallback firstButtonOnPressed;
  final VoidCallback secondButtonOnPressed;
  final String secondButtonText;

  const CpCustomPopup(
      {required this.title,
      required this.firstButtonText,
      required this.firstButtonOnPressed,
      required this.secondButtonOnPressed,
      required this.secondButtonText,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CpCustomPopupState();
}

class _CpCustomPopupState extends ConsumerState<CpCustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 60.h,
        width: 40.w,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.white),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(181, 0, 0, 0),
              Colors.black,
            ], // İki renk gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(28.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const Gap(25),
            CustomCatchpadButtons.buildGradientButtonWithBorder(
                context: context,
                width: 30.w,
                height: 10.h,
                textStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                onPressed: widget.firstButtonOnPressed,
                text: widget.firstButtonText),
            const Gap(20),
            CustomCatchpadButtons.buildGradientButtonWithBorder(
              context: context,
              width: 30.w,
              height: 10.h,
              onPressed: widget.secondButtonOnPressed,
              textStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              text: widget.secondButtonText,
              backGroundColor1: Colors.black,
              backGroundColor2: Colors.black,
              borderColor: Colors.white,
              borderWidth: 1,
            ),
          ],
        ),
      ),
    ));
  }
}
