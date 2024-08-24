import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import '../../constants/extensions/context_extension.dart';

class CustomBarContainer extends ConsumerWidget {
  final bool isPrimaryContainer;
  final String text;
  final double? doubleValueForHeight;
  final Color? customColor;

  const CustomBarContainer(
      {super.key,
      this.isPrimaryContainer = false,
      this.customColor,
      required this.text,
      this.doubleValueForHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return button();
  }

  Neumorphic button() {
    return Neumorphic(
      style: NeumorphicStyle(
          boxShape: neumorphicBoxShape()),
      child: Container(
        height: doubleValueForHeight ?? 9.5.h,
        width: 65.w,
        decoration: BoxDecoration(
            color: customColor ?? (isPrimaryContainer
                ? CustomColors.primaryColor
                : Colors.white
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
              bottomRight: Radius.circular(EdgeExtension.hugeEdge.edgeValue),
            )),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(text,
                style: ThemeValueExtension.headline1.copyWith(
                  color: (isPrimaryContainer || customColor != null)
                      ? CustomColors.fillWhiteColor
                      : CustomColors.primaryColor,
                ))),
      ),
    );
  }

  NeumorphicBoxShape neumorphicBoxShape() {
    return NeumorphicBoxShape.roundRect(const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40)));
  }
}
