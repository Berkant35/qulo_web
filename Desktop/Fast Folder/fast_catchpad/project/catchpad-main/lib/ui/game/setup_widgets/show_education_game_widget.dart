import '../../../prov/selected_item_for_education_prov.dart';
import '../../../utils/util_methods/util_methods.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowEducationGameProperties extends ConsumerWidget {
  const ShowEducationGameProperties({Key? key, required this.showImage})
      : super(key: key);
  final bool showImage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var eduItem = ref.watch(eduItemProv);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          if (eduItem != null && showImage) ...[
            Image.asset(
              eduItem.imagePath,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: defPaddingSize,
            )
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localize(context, eduItem!.item).capitalize(),
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
