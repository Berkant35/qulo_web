
import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/constant/theme/app_colors.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';
import 'package:thy_lifevest_app/core/navigation/navigation_service.dart';
import 'package:thy_lifevest_app/core/shared/app_bottom_sheet_mixin.dart';
import 'package:thy_lifevest_app/core/shared/app_mini_divider.dart';
import 'package:thy_lifevest_app/core/theme/app_box_decorations.dart';
import 'package:thy_lifevest_app/core/utils/screen_size.dart';

class AppBottomSheet with AppBottomSheetMixin {
  final Widget child;
  final Widget? dividerWidget;
  final bool isDismissible;
  final double? maxHeightRatio;
  final bool fitToContent;
  final bool useRootNavigator;
  final Color? backgroundColor;
  final EdgeInsets? fixedPadding;
  final void Function()? closedBottomModel;

  AppBottomSheet(
      {required this.child,
        this.isDismissible = true,
        this.maxHeightRatio,
        this.fitToContent = false,
        this.closedBottomModel,
        this.useRootNavigator = false,
        this.dividerWidget,
        this.fixedPadding,
        this.backgroundColor = AppColors.white});

  Future<void> show() async {
    final BuildContext? context = NavigationService.instance.navigatorKey.currentState?.context;
    if(context.isNull) return;
    final Size screenSize = ScreenSize().screenSize;
    final double scaleFactor = getScaleFactor(context!);
    final double heightRatio = maxHeightRatio ?? 0.85;
    final double maxHeight = screenSize.height * heightRatio;

    await showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor ?? AppColors.white,
      shape: AppBoxDecorations().bottomDialogRectangleBorder,
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      builder: (BuildContext ctx) {
        final bottomPadding = ScreenSize().bottomPadding;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: fitToContent
              ? _buildFitContentLayout(
            ctx,
            scaleFactor,
            bottomPadding,
            maxHeight,
          )
              : _buildFixedLayout(
            ctx,
            scaleFactor,
            bottomPadding,
            maxHeight,
          ),
        );
      },
    ).then((_) {
      closedBottomModel?.call();
    });
  }

  Widget _buildFitContentLayout(BuildContext context, double scaleFactor, double bottomPadding, double maxHeight) {
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight - bottomPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onVerticalDragEnd: (details) {
                  if (isDismissible && details.primaryVelocity! > 0) {
                    Navigator.of(context).pop();
                  }
                },
                child: Center(
                  child: dividerWidget.isNotNull
                      ? dividerWidget
                      : Padding(
                    padding: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
                    child: const AppMiniDivider(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16 * scaleFactor),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFixedLayout(BuildContext context, double scaleFactor, double bottomPadding, double maxHeight) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight - bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                Navigator.of(context).pop();
              }
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
                child: const AppMiniDivider(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: fixedPadding ?? EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
              child: SingleChildScrollView(
                child: Padding(
                  padding: fixedPadding ?? EdgeInsets.only(bottom: 16 * scaleFactor),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
