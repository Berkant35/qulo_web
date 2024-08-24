import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnderlineLauncherTextWidget extends ConsumerWidget {
  final Map<String, String> underLineTexts;
  final Color? underLineTextColor;
  final String contentText;
  final Function? customOnTap;

  const UnderlineLauncherTextWidget(
      {this.underLineTextColor,
      required this.contentText,
      required this.underLineTexts,
      this.customOnTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfTexts = contentText.split(" ");

    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            children: listOfTexts
                .map((text) => underLineTexts.keys.any((perBoldTexts) =>
                        perBoldTexts.toUpperCase() == text.toUpperCase())
                    ? attractiveSpan(text)
                    : smoothSpan(text))
                .toList()));
  }

  TextSpan attractiveSpan(String text) {
    return TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () => customOnTap!(),
        text: "$text ",
        style: ThemeValueExtension.subtitle2.copyWith(
            color: CustomColors.accentColor,
            //underline
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold));
  }

  TextSpan smoothSpan(String text, {List<InlineSpan>? spanChildren}) {
    return TextSpan(
        text: "$text ",
        style: ThemeValueExtension.subtitle2.copyWith(
          color: CustomColors.fillBlackElevationColor,
          fontStyle: FontStyle.italic,
        ),
        children: spanChildren);
  }
}
