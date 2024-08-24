import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/end/review_record.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/record/top_record_widgets/recording_control_widget.dart';
import 'package:audiotodo/utilities/components/containers/custom_bar_container.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:audiotodo/utilities/constants/extensions/ui_extensions.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import 'top_record_widgets/sub_content.dart';

class TopRecordControl extends ConsumerStatefulWidget {
  const TopRecordControl({
    super.key,
  });

  @override
  ConsumerState createState() => _TopRecordControlState();
}

class _TopRecordControlState extends ConsumerState<TopRecordControl>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, customRef, child) {
      final audioStep = customRef.watch(currentAudioStepManager);

      if (audioStep == AudioToDoSteps.record ||
          audioStep == AudioToDoSteps.reviewMeet) {
        _animationController.forward().then((value) {
          ShowCaseWidget.of(
              context)
              .next();
        });
      } else {
        _animationController.reverse();
      }

      return Container(
        color: CustomColors.fillWhiteColor,
        child: Stack(
          children: [
            RepaintBoundary(
              child: SlideTransition(
                position: _slideAnimation,
                child: Stack(
                  children: [
                    Container(
                      width: 100.w,
                      height: 22.5.h,
                      decoration: CustomBoxDecoration.customType2BoxDecoration,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 90.w,
                        height: 8.5.h,
                        child: (audioStep == AudioToDoSteps.reviewMeet)
                            ? const ReviewRecord()
                            : const RecordingControlWidget(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 0.6.h),
                        child: Container(
                          width: 70.w,
                          height: 7.5.h,
                          decoration: CustomBoxDecoration.customType1BoxDecoration,
                          child: const SubContent(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: CustomBarContainer(
                  text: S.current.record,
                  doubleValueForHeight: 10.5.h
                )
            ),
          ],
        ),
      );
    });
  }
}
