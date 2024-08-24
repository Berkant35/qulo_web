import 'package:audiotodo/utilities/components/buttons/play_stop_button.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';

class CustomPlayStopButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final double? circleRadius;
  final double iconSize;
  final bool recordingOrPlayer;
  final String? iconPath;
  final Color? iconColor;
  const CustomPlayStopButton(
      {super.key,
      required this.onPressed,
      required this.recordingOrPlayer,
      this.circleRadius,
        this.iconPath,
        this.iconColor,
      required this.iconSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: circleRadius ?? 35.w,
      height: circleRadius ?? 35.w,
      decoration: CustomBoxDecoration.circleContainerDecoration.copyWith(
          color: CustomColors.fillWhiteColor,
          border: Border.all(color: CustomColors.primaryColor, width: 1.5)),
      child: Container(
        decoration: CustomBoxDecoration.circleContainerDecoration.copyWith(
          color: CustomColors.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(EdgeExtension.customTiny1.edgeValue),
          child: PlayStopButton(
            onPressed: onPressed,
            iconSize: iconSize,
            iconPath: iconPath,
            iconColor: iconColor,
            recordingPlayerControl: recordingOrPlayer,
          ),
        ),
      ),
    );
  }
}
