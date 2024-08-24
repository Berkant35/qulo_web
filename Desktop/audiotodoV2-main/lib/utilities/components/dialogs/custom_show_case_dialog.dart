import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCaseWidget extends ConsumerWidget {
  final Widget showCaseContentWidget;
  final ShowCaseInfo? showCaseInfo;
  final Function? onPressedTarget;

  const CustomShowCaseWidget(
      {required this.showCaseInfo,
      required this.showCaseContentWidget,
      required this.onPressedTarget,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*if (showCaseInfo?.key == Tips.connectToPads.name) {
      ref.read(currentAllShowCases.notifier).forceRemove(showCaseInfo!.key);
    }*/

    GlobalKey? key = ref
            .read(currentAllShowCases.notifier)
            .needShowCaseGlobalKeys[showCaseInfo?.key] ??
        // ref
        //     .read(currentAllShowCases.notifier)
        //     .showCSGlobalKeys[showCaseInfo?.key] ??
        GlobalKey();

    final needs = ref.read(currentAllShowCases.notifier).needShowCaseGlobalKeys;
    final user = ref.read(authManager)!;
    final firstEnter = user.firstEnter ?? false;
    final hasPlan = user.planType != PlanType.none;

    if (showCaseInfo?.key == ShowCaseStates.resultButtonFinish.name) {
      Future(() {
        //if first enter is false we must convert to true
        if (user!.firstEnter == null || !user.firstEnter!) {
          ref
              .read(authManager.notifier)
              .changeUser(user.copyWith(firstEnter: true));
          //update to firebase
          ref.read(authManager.notifier).updateCurrentUser(ref);
        }
      });
    }

    return (!firstEnter &&
            hasPlan &&
            needs.containsKey(showCaseInfo?.key) &&
            !ref
                .read(currentAllShowCases.notifier)
                .dontShowAgainTemp
                .contains(key))
        ? Showcase.withWidget(
            key: key,
            onTargetClick: () {
              dosentMatterClickFunction(ref, showCaseInfo);

              onPressedTarget!();
            },
            disableBarrierInteraction: true,
            disposeOnTap: false,
            blurValue: 1,
            targetShapeBorder: showCaseInfo!.showCaseStates.getShapeBorder(),
            overlayColor: CustomColors.lightGreenColor,
            disableDefaultTargetGestures: false,
            //     onBarrierClick: () {
            //       // dosentMatterClickFunction(ref, showCaseInfo);
            // },
            onTargetDoubleTap: () {
              // dosentMatterClickFunction(ref, showCaseInfo);
            },
            onTargetLongPress: () {
              // dosentMatterClickFunction(ref, showCaseInfo);
            },
            height: 60.h,
            width: 100.w,
            tooltipPosition: showCaseInfo?.tooltipPosition,
            toolTipSlideEndDistance: 10.w,
            targetPadding: EdgeInsets.all(2.w),
            overlayOpacity: 0.5,
            container: InkWell(
              onTap: () {
                // ShowCaseWidget.of(context).next();
                // dosentMatterClickFunction(ref, showCaseInfo);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Container(
                  width: 92.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                      color: CustomColors.lightGreenColor.withOpacity(0.7),
                      border: Border.all(
                          color: CustomColors.fillWhiteColor, width: 1.px),
                      borderRadius: BorderRadius.all(Radius.circular(15.px))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      const ShowCaseLogo(),
                      SizedBox(
                        width: 62.w,
                        child: Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Text(
                            showCaseInfo?.description ?? "-",
                            overflow: TextOverflow.clip,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: CustomColors.fillWhiteColor,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: showCaseContentWidget)
        : showCaseContentWidget;
  }

  void dosentMatterClickFunction(WidgetRef ref, ShowCaseInfo? showCaseInfo) {
    if (showCaseInfo != null) {
      // logger.i("oh no!1");

      ref.read(currentAllShowCases.notifier).itsDoneShowCase(ref, showCaseInfo);

      if (showCaseInfo.key != ShowCaseStates.startMeeting.name &&
          showCaseInfo.key != ShowCaseStates.goReview.name) {
        ShowCaseWidget.of(ref.context).next();
      }
    }
  }
}

class ShowCaseLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final String? assetPath;
  final Color? iconColor;

  const ShowCaseLogo(
      {super.key, this.width, this.height, this.assetPath, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath ?? IconPaths.icLogoSvg,
      fit: BoxFit.cover,
      width: width ?? 24.w,
      height: height ?? 24.w,
      color: iconColor ?? Colors.white,
    );
  }
}
