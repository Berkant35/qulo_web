import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../managers/asset_manager.dart';
import '../../../models/enums/utility/show_case_enum.dart';
import '../../../prov/dialogs/show_case_prov.dart';
import '../../../utils/util_widgets/util_button.dart';

class CustomShowCaseWidget extends ConsumerWidget {
  final Widget showCaseContentWidget;
  final ShowCaseInfo? showCaseInfo;

  const CustomShowCaseWidget(
      {required this.showCaseInfo,
      required this.showCaseContentWidget,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*if (showCaseInfo?.key == Tips.connectToPads.name) {
      ref.read(currentAllShowCases.notifier).forceRemove(showCaseInfo!.key);
    }*/
    final l10n = L10n.inst(context);
    GlobalKey? key = ref
            .read(currentAllShowCases.notifier)
            .needShowCaseGlobalKeys[showCaseInfo?.key] ??
        ref
            .read(currentAllShowCases.notifier)
            .tipGlobalKeys[showCaseInfo?.key] ??
        GlobalKey();

    if (showCaseInfo?.key == Tips.favorites.name &&
        ref.read(currentAllShowCases.notifier).favoriteForceOnce) {
      key = GlobalKey();
    } else if (showCaseInfo?.key == Tips.favorites.name &&
        !ref.read(currentAllShowCases.notifier).favoriteForceOnce) {
      ref.read(currentAllShowCases.notifier).setTrueFavoriteForceOnce();
      key = ref
              .read(currentAllShowCases.notifier)
              .needShowCaseGlobalKeys[showCaseInfo?.key] ??
          GlobalKey();
    }

    if (showCaseInfo?.key == Tips.connectToPads.name &&
        ref.read(currentAllShowCases.notifier).favoriteForceOnce) {
      ref.read(currentAllShowCases.notifier).setTrueConnectedForceOnce();
    }

    return Showcase.withWidget(
        key: key,
        onTargetClick: () => dosentMatterClickFunction(ref, showCaseInfo),
        disposeOnTap: false,
        disableDefaultTargetGestures: true,
        onBarrierClick: () => dosentMatterClickFunction(ref, showCaseInfo),
        onTargetDoubleTap: () => dosentMatterClickFunction(ref, showCaseInfo),
        onTargetLongPress: () => dosentMatterClickFunction(ref, showCaseInfo),
        height: 40.h,
        width: 60.w,
        container: InkWell(
          onTap: () {
            ShowCaseWidget.of(context).next();
            dosentMatterClickFunction(ref, showCaseInfo);
          },
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ShowCaseLogo(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showCaseInfo?.title ?? "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.blue),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                showCaseInfo?.description ?? "-",
                                overflow: TextOverflow.clip,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: context.isTablet ? 15 : 4,
                right: context.isTablet ? 15 : 8,
                child: ElevatedButton(
                  onPressed: () {
                    dosentMatterClickFunction(ref, showCaseInfo);
                    ShowCaseWidget.of(context).next();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    l10n.next,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        child: showCaseContentWidget);
  }

  void dosentMatterClickFunction(WidgetRef ref, ShowCaseInfo? showCaseInfo) =>
      showCaseInfo != null &&
              (showCaseInfo.showCaseAppState == ShowCaseAppState.onboarding ||
                  showCaseInfo.showCaseAppState ==
                      ShowCaseAppState.specialOnBoarding)
          ? ref
              .read(currentAllShowCases.notifier)
              .itsDoneShowCase(ref, showCaseInfo)
          : null;
}

class ShowCaseLogo extends StatelessWidget {
  const ShowCaseLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetManager.getImgPath('show_case_app_icon.png'),
      width: 24.w,
      height: 24.w,
      fit: BoxFit.cover,
    );
  }
}
