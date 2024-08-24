import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/utilities/components/buttons/neu_button_configs.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NeuStadiumTextButton extends ConsumerWidget {
  final bool isPrimaryButton;
  final Color? forceColor;
  final String text;
  final VoidCallback? onPressed;
  final double? customWidth;
  final double? customHeight;

  const NeuStadiumTextButton(
      {super.key,
      this.isPrimaryButton = false,
      required this.text,
      required this.onPressed,
      this.customWidth,
      this.forceColor,
      this.customHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isClicked = false;

    return SizedBox(
      width: customWidth ?? NeuButtonConfigs.neuStadiumTextButtonWidth,
      height: customHeight ?? NeuButtonConfigs.neuStadiumTextButtonHeight,
      child: NeumorphicButton(
        minDistance: NeuButtonConfigs.neuStadiumTextButtonMinDistance,
        style: neuTextButtonNeuStyle(),
        onPressed: onPressed != null ? () {
          isClicked = true;
          onPressed!();
          Future.delayed(
              const Duration(milliseconds: 500), () => isClicked = false);
        } : null,
        child: Center(
          child: neuTextButtonTextWidget(),
        ),
      ),
    );
  }

  NeumorphicStyle neuTextButtonNeuStyle() => NeumorphicStyle(
      color: onPressed != null
          ? forceColor ??
              (isPrimaryButton
                  ? CustomColors.fillWhiteColor
                  : CustomColors.secondaryColor)
          : CustomColors.grey2Color,
      shadowLightColor: CustomColors.primaryColor,
      shadowDarkColor: CustomColors.accentColor,
      shadowDarkColorEmboss: CustomColors.primaryColor,
      shadowLightColorEmboss: CustomColors.accentColor,
      oppositeShadowLightSource: true,
      lightSource: LightSource.bottom,
      intensity: NeuButtonConfigs.neuStadiumTextButtonIntensity,
      boxShape: const NeumorphicBoxShape.stadium());

  Text neuTextButtonTextWidget() {
    return Text(
      text,
      style: ThemeValueExtension.buttonTextStyle.copyWith(
        color: isPrimaryButton
            ? CustomColors.primaryColor
            : CustomColors.fillWhiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}
