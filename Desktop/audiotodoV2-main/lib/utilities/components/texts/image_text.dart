import 'package:audiotodo/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/extensions/context_extension.dart';
import '../../constants/extensions/icon_size_extensions.dart';
import '../buttons/neu_stadium_button.dart';

class ImageWithText extends ConsumerWidget {
  final String path;
  final String text;
  final VoidCallback? onTap;

  const ImageWithText(this.path, this.text, this.onTap,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(path,
                  width: IconSizeExtension.medium.sizeValue,
                  height: IconSizeExtension.medium.sizeValue,
                  fit: BoxFit.contain),
              GapSizedBox.smallGapW,
              Text(text, style: ThemeValueExtension.headline6),
            ],
          ),
          NeuStadiumTextButton(
            onPressed: onTap,
            text: S.current.contiune,
          )
        ],
      ),
    );
  }
}
