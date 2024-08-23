import 'package:auto_size_text/auto_size_text.dart';
import 'package:catchpad/utils/util_methods/util_methods.dart';
import 'package:flutter/material.dart';

class StroopTestWidget extends StatelessWidget {
  const StroopTestWidget({super.key, required this.word, required this.color});
  final String word;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        colorNameReturner(word, context),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: fakeColorGenerator(color),
            fontSize: MediaQuery.of(context).size.width * 0.12),
      ),
    );
  }
}
