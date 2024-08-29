import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/ui/emb/iga/dialog/iga_dialogs.dart';
import 'package:catchpad/ui/widgets/cp_logo.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../prov/global_providers.dart';

class WakeUpButton extends ConsumerStatefulWidget {
  const WakeUpButton({super.key});

  @override
  ConsumerState createState() => _WakeUpButtonState();
}

class _WakeUpButtonState extends ConsumerState<WakeUpButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late VideoPlayerController controller;
  final String moviePath = 'assets/iga/iga_movie.mp4';
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    videoInitialize();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 1500),
    );
    controller.setVolume(0.0);
    animation =
        Tween<double>(begin: 25.h, end: 35.h).animate(animationController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.forward();
  }

  void videoInitialize() {
    controller = VideoPlayerController.asset(moviePath);
    controller.addListener(() {
    });
    controller.setLooping(true);
    controller.initialize().then((_) {
      setState(() {});
    });
    controller.play();
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller.play();
  }

  @override
  void dispose() {
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(ref.context).unfocus();
    controller.play();

    Future((){
      ref
          .read(currentSafeInGameToggleState.notifier)
          .changState(false, ref);
      ref.read(currentSafeInGameToggleState.notifier).startPadShow(ref, [], forcedVal: true);
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onLongPress: tapFunction,
        onTap: tapFunction,
        child: Stack(
          children: [
            VideoPlayer(controller),
            Opacity(
              opacity: 0.6,
              child: Container(color: Colors.black),
            ),
            Positioned(
              bottom: 4.h,
              child: SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // SizedBox(width: 2.5.w),
                    // Row(
                    //   children: [
                    //     Stack(
                    //       alignment: Alignment.center,
                    //       children: [
                    //         Image.asset(IgaAssets.qr_kickstarter.getPath, scale: 28),
                    //         Container(
                    //           width: 7.5.w,
                    //           height: 12.h,
                    //           decoration: BoxDecoration(
                    //             borderRadius: const BorderRadius.all(Radius.circular(15)),
                    //             color: CpColors.cpLightWhiteIGA.withOpacity(0.3),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(width: 0.5.w),
                    //     SizedBox(
                    //       height: 15.h,
                    //       width: 15.w,
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(height: 2.25.h),
                    //           Padding(
                    //             padding: EdgeInsets.only(left: 0.15.w),
                    //             child: Image.asset(IgaAssets.iga_kickstarter.getPath, scale: 5),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(width: 62.w),
                    CpLogoV2(size: 7.w),
                    SizedBox(width: 2.5.w),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 4),
                  Expanded(
                    flex: 6,
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: IconButton(
                            constraints: BoxConstraints.tight(Size(animation.value, animation.value)),
                            icon: Image.asset(IgaAssets.ic_wake_up.getPath),
                            onPressed: () {
                              ref.read(currentIgaIsThereAnyCustomerManager.notifier).changState(true, ref);
                              ref.read(currentIgaPageManager.notifier).changState(IGAStates.onBoardingOne, ref: ref);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tapFunction() {
        ref.read(currentIgaTraceManager.notifier).createIgaTraceModel(ref: ref);
        ref.read(currentIgaIsThereAnyCustomerManager.notifier).changState(true, ref);
        ref.read(currentIgaPageManager.notifier).changState(IGAStates.onBoardingOne, ref: ref);
      }
}
