import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Talk, and let [Audiotodo] handle your tasks

class BrandMottoText extends ConsumerWidget {
  final Set<String> boldTexts;
  final String mottoText;

  const BrandMottoText(
      {required this.mottoText, required this.boldTexts, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfTexts = mottoText.split(" ");

    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            children: listOfTexts
                .map((text) => boldTexts.any((perBoldTexts) =>
                        perBoldTexts.toUpperCase() == text.toUpperCase())
                    ? attractiveSpan(text)
                    : smoothSpan(text))
                .toList()));
  }

  TextSpan attractiveSpan(String text) {
    return TextSpan(
        text: "$text ",
        style: ThemeValueExtension.headline6.copyWith(
            color: CustomColors.primaryColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold));
  }

  TextSpan smoothSpan(String text, {List<InlineSpan>? spanChildren}) {
    return TextSpan(
        text: "$text ",
        style: ThemeValueExtension.headline6.copyWith(
          color: CustomColors.fillBlackElevationColor,
          fontStyle: FontStyle.italic,
        ),
        children: spanChildren);
  }
}
