import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/util_widgets/util_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../util_methods/util_methods.dart';
import '../utils.dart';

class CustomCpInformationCards {
  static Widget buildCardWithIcon({
    required String iconPath,
    required String title,
    required double size,
    required BuildContext context,
    bool? isMs,
    required String result,
  }) {
    final imageSize = size * 0.58;
    return SizedBox(
      height: size,
      width: size * 0.675,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size * 0.6,
              width: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -size * 0.05,
                    child: Image.asset(iconPath, height: imageSize),
                  ),
                  Positioned(
                    bottom: -size * 0.24,
                    child: SizedBox(
                        height: size * 0.45,
                        width: size * 0.35,
                        child: Text(
                          title,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: size * 0.6.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size * 0.1, vertical: size * 0.05),
              child: Container(
                width: size,
                height: size * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: CpColors.cpDavysGrey,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                    text: result,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: CpColors.cpPrimary, fontWeight: FontWeight.bold),
                  ),
                  if (isMs ?? false)
                    TextSpan(
                      text: 'ms',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: CpColors.cpPrimary,
                          fontWeight: FontWeight.bold),
                    ),
                ]))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget basicInformationsWithPrimaryHeaderCounters({
    required WidgetRef ref,
    required String primaryTitle,
    required String primaryDescription,
    required String upperFirstBoxName,
    required String upperFirstBoxValue,
    required String upperSecondBoxName,
    required String upperSecondBoxValue,
    required String upperThirdBoxName,
    required String upperThirdBoxValue,
    required String bottomFirstBoxValue,
    required String bottomFirstBoxName,
    required String bottomSecondBoxName,
    required String bottomSecondBoxValue,
    required String bottomThirdBoxName,
    required String bottomThirdBoxValue,
    required String bottomFourthBoxName,
    required String bottomFourthBoxValue,
    EdgeInsetsGeometry? insidePadding,
    bool firstColored = false,
    bool secondColored = false,
    bool thirtyColored = false,
    bool fourColored = false,
    double? paddingHorizontalDivider,
    double? paddingVerticalDivider,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        basicRowInformationCard(
            ref: ref,
            title: primaryTitle,
            description: primaryDescription,
            insidePadding: EdgeInsets.symmetric(vertical: 1.h)),
        buildDetailedCard(
          upperFirstBoxName: upperFirstBoxName,
          insidePadding: insidePadding,
          upperFirstBoxValue: upperFirstBoxValue,
          upperSecondBoxName: upperSecondBoxName,
          upperSecondBoxValue: upperSecondBoxValue,
          upperThirdBoxName: upperThirdBoxName,
          upperThirdBoxValue: upperThirdBoxValue,
          bottomFirstBoxName: bottomFirstBoxName,
          bottomFirstBoxValue: bottomFirstBoxValue,
          bottomSecondBoxName: bottomSecondBoxName,
          bottomSecondBoxValue: bottomSecondBoxValue,
          bottomThirdBoxName: bottomThirdBoxName,
          bottomThirdBoxValue: bottomThirdBoxValue,
          bottomFourthBoxName: bottomFourthBoxName,
          bottomFourthBoxValue: bottomFourthBoxValue,
          paddingHorizontalDivider: paddingHorizontalDivider,
          paddingVerticalDivider: paddingVerticalDivider,
          firstColored: firstColored,
          secondColored: secondColored,
          bottomBoxHeight: 7.h,
          bottomBoxWidth: 7.w,
          upBoxHeight: 7.h,
          upBoxWidth: 8.w,
          textStyle: Theme.of(ref.context).textTheme.displaySmall!.copyWith(
            fontSize: 12.sp
          )!,
          thirtyColored: thirtyColored,
          fourColored: fourColored,
          isCardTransparent: true,
          context: ref.context,
        )
      ],
    );
  }

  static Widget basicInformationsWithPrimaryHeader({
    required WidgetRef ref,
    required String primaryTitle,
    required String primaryDescription,
    required String bottomFirstBoxValue,
    required String bottomFirstBoxName,
    required String bottomSecondBoxName,
    required String bottomSecondBoxValue,
    required String bottomThirdBoxName,
    required String bottomThirdBoxValue,
    required String bottomFourthBoxName,
    required String bottomFourthBoxValue,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        basicRowInformationCard(
            ref: ref, title: primaryTitle, description: primaryDescription),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
          child: const Divider(
            color: CpColors.cpPrimary,
            thickness: 2.5,
          ),
        ),
        fourInformation(
          bottomFirstBoxValue,
          bottomFirstBoxName,
          ref.context,
          bottomSecondBoxName,
          bottomSecondBoxValue,
          bottomThirdBoxName,
          bottomThirdBoxValue,
          bottomFourthBoxName,
          bottomFourthBoxValue,
          textStyle: Theme.of(ref.context).textTheme.displaySmall!.copyWith(
            fontSize: 11.5.sp
          ),
          boxWidth: 7.w,
          boxHeight: 7.h
        )
      ],
    );
  }

  static Widget basicRowInformationCard(
      {required WidgetRef ref,
      required String title,
      required String description,
      EdgeInsets? insidePadding,
      List<Widget>? addToColumnWidgets}) {
    return Container(
      height: 15.h,
      width: 34.w,
      padding: insidePadding,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(24.px))),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
              flex: 6,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(ref.context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              )),
          const Spacer(),
          Expanded(
              flex: 4,
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.px)),
                  color: CpColors.cpDavysGrey.withOpacity(0.4),
                ),
                child: Center(
                  child: Text(
                    description,
                    style: Theme.of(ref.context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: CpColors.cpPrimary),
                  ),
                ),
              )),
          const Spacer()
        ],
      ),
    );
  }

  static Widget buildCompetitivePlayerResultCard({
    String? titleOfBottomCard, // inst.iga_your_average_reaction_time
    String?
        valueOfBottomCard, // averageDuration.inMilliseconds.toString() ?? "-",
    required String upperFirstBoxName, //'Hedef'
    required String upperFirstBoxValue, //scoreCorrect.toString()
    Duration? maxDuration, // maxDuration?.formatSecondsMilli(context) ?? "-",
    Duration?
        minDuration, // minDuration?.formatSecondsMilli(context).toString() ?? "-",
    required String bottomFirstBoxName, //Max
    required String bottomFirstBoxValue,
    bool showDivider = true,
    bool showCrown = true,
    String? bottomSecondBoxName, //"Min"
    String?
        bottomSecondBoxValue, //minDuration?.formatSecondsMilli(context).toString() ?? "-"
    String? bottomThirdBoxName, //inst.activity_result_screen_average
    String?
        bottomThirdBoxValue, //averageDuration?.formatSecondsMilli(context).toString() ?? "-"
    EdgeInsetsGeometry? insidePadding,
    required Color playerColor,
    required AppLocalizations inst,
    required BuildContext context,
  }) {
    return Column(
      children: [
        buildDetailedCard(
          showDivider: showDivider,
          insidePadding: insidePadding,
          bottomFirstBoxValue: '${maxDuration?.inMilliseconds.toString()}ms' ?? "-",
          bottomFirstBoxName: bottomFirstBoxName,
          bottomSecondBoxName: bottomSecondBoxName,
          bottomSecondBoxValue: bottomSecondBoxValue,
          bottomThirdBoxName: bottomThirdBoxName,
          bottomThirdBoxValue: bottomThirdBoxValue,
          textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
          upperFirstBoxName: upperFirstBoxName,
          upperFirstBoxValue: upperFirstBoxValue,
          isCardTransparent: true,
          uFirstColored: false,
          uSecondColored: true,
          uThirtyColored: true,
          showCrown: showCrown,
          firstColored: true,
          secondColored: true,
          thirtyColored: true,
          fourColored: true,
          isForcePrimaryDecoartion: true,
          context: context,
        ),
        SizedBox(height: 2.h),
        CustomDivider.gradientDivider(
            gradient: const LinearGradient(
                colors: [CpColors.cpSecondary, CpColors.cpPrimary]),
            height: 0.5.h,
            width: 28.w),
        SizedBox(height: 2.h),
        buildCardWithImage(
            title: titleOfBottomCard ?? "-",
            boxValue: valueOfBottomCard ?? "-",
            height: 14.h,
            cardColor: CpColors.cpPrimary,
            width: 30.w,
            iconColor: fakeColorGenerator(playerColor),
            context: context),
      ],
    );
  }

  static Widget buildBasicBoxV2(
      {required String boxText,
        bool isNewVersion = false,
        bool isBoxColored = false,
        double? size,
        double? fontSize,
        double? width,
        double? height,
        String? boxName,
        Color? backgroundColor,
        Color? forceTextColor,
        EdgeInsetsGeometry? insidePadding,
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle,
        Color? forceColor,
        bool isBold = false,
        BoxTheme? boxTheme,
        bool isColored = false,
        required BuildContext context,
        BoxType? boxType}) {
    size = 50;

    late final Decoration decoration;
    late final Color boxTextColor;
    late final Color boxNameColor;

    final deco = switch (boxTheme) {
      BoxTheme.v1 => {
        boxTextColor = isColored ? CpColors.cpPrimary : Colors.white,
        boxNameColor = Colors.white,
        decoration = BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(isBoxColored ? 28 : 15.0),
        ),
      },
      BoxTheme.v2 => {
        boxTextColor = Colors.black,
        boxNameColor = Colors.white,
        decoration = BoxDecoration(
          color: CpColors.cpPrimary,
          borderRadius: BorderRadius.circular(isBoxColored ? 28 : 15.0),
        ),
      },
      BoxTheme.v3 => {
        boxTextColor = isColored ? CpColors.cpPrimary : Colors.white,
        boxNameColor = isColored ? CpColors.cpPrimary : Colors.white,
        decoration = BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(isBoxColored ? 28 : 15.0),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
      },
      null => {
        boxTextColor = Colors.white,
        boxNameColor = Colors.white,
        decoration = BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(isBoxColored ? 28 : 15.0),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
        ),
      },
    };

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.4.w, vertical: 0.4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: insidePadding ?? const EdgeInsets.all(8),
                decoration: decoration,
                child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: boxText != 'null' ? boxText : "-",
                        style: textStyle ??
                            Theme.of(context).textTheme.labelLarge!.copyWith(
                                color: boxTextColor,
                                fontWeight:
                                isBold ? FontWeight.bold : FontWeight.w600,
                                fontSize: 16.sp),
                      ),
                      if (boxType != null)
                        TextSpan(
                          text: boxType == BoxType.ms ? 'ms' : 's',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: boxTextColor, fontWeight: FontWeight.w600),
                        ),
                    ]))),
            if (boxName != null)
              Center(
                child: Text(
                  boxName ?? '',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: boxNameColor, fontWeight: FontWeight.w600),
                ),
              )
          ],
        ));
  }

  static Widget buildBasicBox(
      {required String boxText,
      bool isNewVersion = false,
      bool isBoxColored = false,
      double? size,
      double? fontSize,
      double? width,
      double? height,
      String? boxName,
      Color? backgroundColor,
      Color? forceTextColor,
      EdgeInsetsGeometry? insidePadding,
      EdgeInsetsGeometry? padding,
      TextStyle? textStyle,
      bool isBold = false,
      required bool isColored,
      required BuildContext context,
      BoxType? boxType}) {
    size = 50;


    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: width,
                height: height,
                padding: insidePadding ?? const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isNewVersion
                      ? Colors.grey.withOpacity(0.15)
                      : isColored
                          ? CpColors.cpPrimary
                          : Colors.black,
                  borderRadius: BorderRadius.circular(isBoxColored ? 28 : 15.0),
                  border: isNewVersion
                      ? null
                      : Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                ),
                child: Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: boxText != 'null' ? boxText : "-",
                      style: textStyle?.copyWith(
                        color: forceTextColor
                      ) ??
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: forceTextColor ??
                                  (isColored
                                      ? CpColors.cpPrimary
                                      : (isBoxColored
                                          ? Colors.black
                                          : Colors.white)),
                              fontWeight:
                                  isBold ? FontWeight.bold : FontWeight.w600,
                              fontSize: 16.sp),
                    ),
                    if (boxType != null)
                      TextSpan(
                        text: boxType == BoxType.ms ? 'ms' : 's',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: forceTextColor ??
                                (isColored ? CpColors.cpPrimary : Colors.white),
                            fontWeight: FontWeight.w600),
                      ),
                  ])),
                )),
            if (boxName != null)
              Column(
                children: [
                  Gap(2.h),
                  Center(
                    child: Text(
                      boxName ?? '',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: forceTextColor ??
                              (isColored ? CpColors.cpPrimary : Colors.white),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static Widget buildCardWithImage({
    required String title,
    required String boxValue,
    String? imagePath,
    String? boxName,
    required double height,
    required double width,
    Color? cardColor = Colors.black,
    Color? iconColor,
    required BuildContext context,
    bool? isMs,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (imagePath != null)
            Expanded(
              flex: 2,
              child: Image.asset(
                imagePath,
                height: height * 0.7,
                width: width * 0.28,
              ),
            ),
          Expanded(
            flex: 6,
            child: Text(
              title,
              softWrap: true,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: cardColor == CpColors.cpPrimary
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(right: 0.5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 8.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        boxValue,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                            color: CpColors.cpPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp
                        ),
                      ),
                    ),
                  ),
                  if (boxName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        boxName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                            color: CpColors.cpBasicWhite),
                      ),
                    )
                ],
              ),
            ),
          ),
          if (iconColor != null)
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconColor,
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  static Widget buildDetailedCard(
      {required String upperFirstBoxName,
      required String upperFirstBoxValue,
      bool isBold = false,
      String? upperSecondBoxName,
      String? upperSecondBoxValue,
      String? upperThirdBoxName,
      String? upperThirdBoxValue,
      required String bottomFirstBoxName,
      required String bottomFirstBoxValue,
      String? bottomSecondBoxName,
      String? bottomSecondBoxValue,
      String? bottomThirdBoxName,
      String? bottomThirdBoxValue,
      String? bottomFourthBoxName,
      String? bottomFourthBoxValue,
      double? height,
      double? width,
      double? bottomBoxWidth,
      double? dividerWidth,
      double? bottomBoxHeight,
      double? upBoxWidth,
      double? upBoxHeight,
      double? paddingHorizontalDivider,
      double? paddingVerticalDivider,
      TextStyle? textStyle,
      required BuildContext context,
      EdgeInsetsGeometry? insidePadding,
      BoxType? boxType,
      bool showDivider = true,
      bool showCrown = false,
      bool isCardTransparent = false,
      bool isForcePrimaryDecoartion = false,
      bool uFirstColored = false,
      bool uSecondColored = false,
      bool uThirtyColored = true,
      bool firstColored = false,
      bool secondColored = false,
      bool thirtyColored = false,
        Color? forceColor,
      bool fourColored = false,
      bool isNewVersion = false}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: forceColor ?? (isCardTransparent ? Colors.transparent : Colors.black),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: forceColor ??  (isCardTransparent ? Colors.transparent : Colors.black),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  if (showCrown) Positioned(
                    top: 2,
                    left: 10,
                    child: IgaAssets.tac.getCustomIconWithSize(35),
                  ),
                  Padding(
                    padding: dynamicallyBoxEdge(showCrown),
                    child: box(isForcePrimaryDecoartion, isNewVersion, upperFirstBoxValue, textStyle, upperFirstBoxName, insidePadding, upBoxWidth, upBoxHeight, context, uFirstColored),
                  ),
                ],
              ),
              if (upperSecondBoxName != null && upperSecondBoxValue != null)
                (){
                return isForcePrimaryDecoartion ? buildBasicBoxV2(
                    isNewVersion: isNewVersion,
                    boxText: upperSecondBoxValue,
                    boxName: upperSecondBoxName,
                    textStyle: textStyle,
                    isColored: true,
                    boxTheme: BoxTheme.v2,
                    width: upBoxWidth,
                    height: upBoxHeight,
                    context: context) : buildBasicBox(
                    isNewVersion: isNewVersion,
                    boxText: upperSecondBoxValue,
                    boxName: upperSecondBoxName,
                    textStyle: textStyle,
                    isColored: uSecondColored,
                    width: upBoxWidth,
                    height: upBoxHeight,
                    context: context);
                }(),
              if (upperThirdBoxName != null && upperThirdBoxValue != null)
                (){
                return  isForcePrimaryDecoartion ? buildBasicBoxV2(
                    isNewVersion: isNewVersion,
                    boxText: upperThirdBoxValue,
                    boxName: upperThirdBoxName,
                    textStyle: textStyle,
                    isColored: true,
                    boxTheme: BoxTheme.v2,
                    forceTextColor: CpColors.cpPrimary,
                    width: upBoxWidth,
                    height: upBoxHeight,
                    context: context) : buildBasicBox(
                    isNewVersion: isNewVersion,
                    boxText: upperThirdBoxValue,
                    boxName: upperThirdBoxName,
                    textStyle: textStyle,
                    isColored: false,
                    forceTextColor: CpColors.cpPrimary,
                    width: upBoxWidth,
                    height: upBoxHeight,
                    context: context);
                }()
            ],
          ),
          () {
            return showDivider
                ? customDivider(
                    paddingHorizontalDivider, paddingVerticalDivider,
                    customWidth: dividerWidth  ?? 30.w)
                : Gap(2.h);
          }(),
          SizedBox(
            width: 40.w,
            height: 10.5.h,
            child: fourInformation(
              bottomFirstBoxValue,
              bottomFirstBoxName,
              context,
              bottomSecondBoxName,
              bottomSecondBoxValue,
              bottomThirdBoxName,
              bottomThirdBoxValue,
              bottomFourthBoxName,
              textStyle: textStyle,
              bottomFourthBoxValue,
              boxWidth: bottomBoxWidth,
              boxHeight: bottomBoxHeight,
              boxType: boxType,
              isForcePrimaryDecoartion: isForcePrimaryDecoartion

            ),
          )
        ],
      ),
    );
  }

  static EdgeInsets dynamicallyBoxEdge(bool showCrwn) =>  EdgeInsets.symmetric(horizontal: showCrwn ? 25 : 15,vertical: showCrwn ? 25 : 25);

  static Widget box(bool isForcePrimaryDecoartion, bool isNewVersion, String upperFirstBoxValue, TextStyle? textStyle, String upperFirstBoxName, EdgeInsetsGeometry? insidePadding, double? upBoxWidth, double? upBoxHeight, BuildContext context, bool uFirstColored) {
    return (){
                  return isForcePrimaryDecoartion ? buildBasicBoxV2(
                      isNewVersion: isNewVersion,
                      boxText: upperFirstBoxValue,
                      textStyle: textStyle,
                      boxName: upperFirstBoxName,
                      insidePadding: insidePadding,
                      isBold: true,
                      width: upBoxWidth,
                      height: upBoxHeight,
                      isColored: true,
                      boxTheme: BoxTheme.v2,
                      context: context
                  ): buildBasicBox(
                      isNewVersion: isNewVersion,
                      boxText: upperFirstBoxValue,
                      textStyle: textStyle,
                      boxName: upperFirstBoxName,
                      insidePadding: insidePadding,
                      isBold: true,
                      width: upBoxWidth,
                      height: upBoxHeight,
                      isColored:
                      /// The above code appears to be a comment in Dart programming language. It
                      /// starts with /// which is used for documentation comments in Dart. The
                      /// text "uFirstColored" seems to be a placeholder or a label for some code
                      /// that is not shown in the provided snippet.
                      uFirstColored,
                      context: context);
                }();
  }

  static Padding customDivider(
      double? paddingHorizontalDivider, double? paddingVerticalDivider,
      {double? customWidth}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: paddingHorizontalDivider ?? 2.h,
          horizontal: paddingVerticalDivider ?? 2.w),
      child: Container(
        width: customWidth ?? 1.h,
        height: 0.5.h,
        decoration: BoxDecoration(
            color: CpColors.cpPrimary,
            borderRadius: BorderRadius.all(Radius.circular(24.px))),
      ),
    );
  }

  static Row fourInformation(
    String bottomFirstBoxValue,
    String bottomFirstBoxName,
    BuildContext context,
    String? bottomSecondBoxName,
    String? bottomSecondBoxValue,
    String? bottomThirdBoxName,
    String? bottomThirdBoxValue,
    String? bottomFourthBoxName,
    String? bottomFourthBoxValue, {
    bool isNewVersion = false,
    BoxType? boxType,
    double? boxWidth,
    TextStyle? textStyle,
    double? boxHeight,
    bool firstColored = false,
    bool secondColored = false,
    bool thirtyColored = false,
    bool fourColored = false,
    bool isForcePrimaryDecoartion = false
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (){
        return isForcePrimaryDecoartion ? buildBasicBoxV2(
            isNewVersion: isNewVersion,
            textStyle: textStyle,
            boxText: bottomFirstBoxValue,
            boxName: bottomFirstBoxName,
            context: context,
            boxTheme: BoxTheme.v2,
            isColored: true,
            boxType: boxType,
            width: boxWidth,
            height: boxHeight) : buildBasicBox(
            isNewVersion: isNewVersion,
            textStyle: textStyle,
            boxText: bottomFirstBoxValue,
            boxName: bottomFirstBoxName,
            isColored: firstColored,
            context: context,
            boxType: boxType,
            width: boxWidth,
            height: boxHeight);
        }(),
        if (bottomSecondBoxName != null && bottomSecondBoxValue != null)
          (){
          return isForcePrimaryDecoartion ? buildBasicBoxV2(
              isNewVersion: isNewVersion,
              boxText: bottomSecondBoxValue,
              boxName: bottomSecondBoxName,
              textStyle: textStyle,
              isColored: true,
              boxTheme: BoxTheme.v2,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight) : buildBasicBox(
              isNewVersion: isNewVersion,
              boxText: bottomSecondBoxValue,
              boxName: bottomSecondBoxName,
              textStyle: textStyle,
              isColored: secondColored,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight);
          }(),
        if (bottomThirdBoxName != null && bottomThirdBoxValue != null)
          (){
          return isForcePrimaryDecoartion ? buildBasicBoxV2(
              isNewVersion: isNewVersion,
              boxText: bottomThirdBoxValue,
              textStyle: textStyle,
              boxName: bottomThirdBoxName,
              isColored: true,
              boxTheme: BoxTheme.v2,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight) : buildBasicBox(
              isNewVersion: isNewVersion,
              boxText: bottomThirdBoxValue,
              textStyle: textStyle,
              boxName: bottomThirdBoxName,
              isColored: thirtyColored,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight);
          }(),
        if (bottomFourthBoxName != null && bottomFourthBoxValue != null)
          (){
          return isForcePrimaryDecoartion ? buildBasicBoxV2(
              isNewVersion: isNewVersion,
              boxText: bottomFourthBoxValue,
              boxName: bottomFourthBoxName,
              isColored: fourColored,
              textStyle: textStyle,
              boxTheme: BoxTheme.v2,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight) : buildBasicBox(
              isNewVersion: isNewVersion,
              boxText: bottomFourthBoxValue,
              boxName: bottomFourthBoxName,
              isColored: fourColored,
              textStyle: textStyle,
              context: context,
              boxType: boxType,
              width: boxWidth,
              height: boxHeight);
          }(),
      ],
    );
  }
}
enum BoxTheme {
  v1,
  v2,
  v3;
}
enum BoxType {
  ms,
  second;
}
