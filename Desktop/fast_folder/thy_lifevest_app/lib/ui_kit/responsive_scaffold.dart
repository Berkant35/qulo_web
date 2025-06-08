import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/app_constant.dart';
import 'package:thy_lifevest_app/core/shared/app_loading_widget.dart';
import 'package:thy_lifevest_app/core/utils/screen_size.dart';

import '../core/constant/theme/app_colors.dart';

class AppResponsiveScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final Drawer? drawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool isLoading;
  final bool? resizeToAvoidBottomInset;

  const AppResponsiveScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.backgroundColor,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.drawer,
    this.isLoading = false,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        physics: const ClampingScrollPhysics(),
        overscroll: false,
      ),
      child: FigmaScaleWrapper(
        child: Stack(
          children: [
            Scaffold(
              key: scaffoldKey,
              backgroundColor:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              appBar: appBar,
              body: body,
              drawer: drawer,
              extendBody: true,
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation:
                  floatingActionButtonLocation ??
                  FloatingActionButtonLocation.miniCenterFloat,
              bottomSheet: bottomSheet,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            ),
            Visibility(
              visible: isLoading,
              child: Stack(
                children: [
                  ModalBarrier(
                    dismissible: false,
                    color: AppColors.black.withValues(alpha: .2),
                  ),
                  const AppLoadingWidget(),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FigmaScaleWrapper extends StatelessWidget {
  const FigmaScaleWrapper({super.key, required this.child});

  final Widget child;

  final Size figmaSize = AppConstants.designDeviceSize;

  @override
  Widget build(BuildContext context) {
    final ratio = ScreenSize().ratio * 0.85;
    double resRatio = ratio;

    return FractionallySizedBox(
      widthFactor: resRatio,
      heightFactor: resRatio,
      child: Transform.scale(scale: 1 / resRatio, child: child),
    );
  }
}
