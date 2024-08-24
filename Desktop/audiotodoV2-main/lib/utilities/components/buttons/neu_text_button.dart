import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import 'neu_button_configs.dart';

class NeuTextButton extends ConsumerWidget {
  final bool isPrimaryButton;
  final String text;
  final VoidCallback onPressed;
  final double? customHeight;
  const NeuTextButton(
      {super.key,
      this.isPrimaryButton = false,
        this.customHeight,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: NeuButtonConfigs.neuTextButtonWidth,
      height: customHeight ?? NeuButtonConfigs.neuTextButtonHeight,
      child: NeumorphicButton(
        minDistance: NeuButtonConfigs.neuTextButtonMinDistance,
        style: neuTextButtonNeuStyle(),
        onPressed: onPressed,
        child: Center(
          child: neuTextButtonTextWidget(),
        ),
      ),
    );
  }

  NeumorphicStyle neuTextButtonNeuStyle() => NeumorphicStyle(
      color: isPrimaryButton
          ? CustomColors.fillWhiteColor
          : CustomColors.secondaryColor,
      lightSource: LightSource.bottom,
      shadowLightColor: CustomColors.fillBlackElevationColor,
      intensity: NeuButtonConfigs.neuTextButtonIntensity);

  Text neuTextButtonTextWidget() {
    return Text(
      text,
      style: ThemeValueExtension.buttonTextStyle.copyWith(
          color: isPrimaryButton
              ? CustomColors.primaryColor
              : CustomColors.fillWhiteColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600
      ),
    );
  }
}
