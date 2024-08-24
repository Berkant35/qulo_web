import 'package:flutter/cupertino.dart';

import 'package:audiotodo/utilities/components/buttons/play_stop_button.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class TextToSpeechControlButton extends ConsumerStatefulWidget {
  final Color primaryColor;
  final Color iconColor;
  final double iconSize;
  final bool forceIconControlIsStop;
  final bool recordingPlayerControl;
  final VoidCallback onPressed;
  const TextToSpeechControlButton({
    super.key,
    required this.primaryColor,
    required this.iconColor,
    required this.iconSize,
    required this.forceIconControlIsStop,
    required this.recordingPlayerControl,
    required this.onPressed,
  });

  @override
  ConsumerState createState() => _TextToSpeechControlButtonState();
}

class _TextToSpeechControlButtonState extends ConsumerState<TextToSpeechControlButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.25.w),
      child: PlayStopButton(
        onPressed: widget.onPressed,
        iconSize: widget.iconSize,
        pColor: widget.primaryColor,
        iconColor: widget.iconColor,
        forceIconControlIsStop: widget.forceIconControlIsStop,
        recordingPlayerControl: widget.recordingPlayerControl
      ),
    );
  }
}
