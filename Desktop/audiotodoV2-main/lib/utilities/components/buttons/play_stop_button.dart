import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/meet/player_states.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import '../../constants/enums/meet/record_states.dart';

class PlayStopButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final double iconSize;
  final bool recordingPlayerControl;
  final bool? forceIconControlIsStop;
  final Color? pColor;
  final Color? iconColor;
  final String? iconPath;

  const PlayStopButton({
    super.key,
    required this.onPressed,
    required this.iconSize,
    required this.recordingPlayerControl,
    this.forceIconControlIsStop,
    this.pColor,
    this.iconPath,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeumorphicButton(
      minDistance: -5.0,
      style: NeumorphicStyle(
          boxShape: const NeumorphicBoxShape.circle(),
          color: pColor ?? CustomColors.fillWhiteColor),
      onPressed: onPressed,
      child: Center(
        child: iconPath != null
            ? ShowCaseLogo(
                assetPath: iconPath,
                width: 50.w,
                height: 50.w,
                iconColor: iconColor ?? CustomColors.primaryColor,
              )
            : Icon(
                forceIconControlIsStop != null
                    ? forcePlayStopButton(ref)
                    : recordingPlayerControl
                        ? recordingPlayStopButton(ref)
                        : playingPlayStopButton(ref),
                color: iconColor ?? CustomColors.primaryColor,
                size: iconSize,
              ),
      ),
    );
  }

  IconData forcePlayStopButton(WidgetRef ref) {
    return !forceIconControlIsStop! ? Icons.play_arrow : Icons.stop;
  }

  IconData recordingPlayStopButton(WidgetRef ref) {
    return ref.watch(currentRecordStateManager) != RecordStates.recording
        ? Icons.play_arrow
        : Icons.stop;
  }

  IconData playingPlayStopButton(WidgetRef ref) {
    return ref.watch(currentPlayerControlState) != CustomPlayerStates.listen
        ? Icons.play_arrow
        : Icons.stop;
  }
}
