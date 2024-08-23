import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/utils/util_widgets/util_textfield.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/api/telegram/telegram_manager.dart';
import '../../prov/emb/emb_global_providers.dart';
import '../cp_colors.dart';
import '../l10n/l10n.dart';

class CustomCatchpadDialogs {
  static void oops(
      {required BuildContext context,
      required String buttonText,
      required String description,
      required Function() onPressed}) {
    AwesomeDialog(
      context: context,
      width: 40.w,
      dialogBackgroundColor: Colors.black,
      animType: AnimType.scale,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(22)),
      dialogType: DialogType.warning,
      keyboardAware: true,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            Gap(4.h),
            CustomCatchpadButtons.buildGradientButtonWithBorder(
                onPressed: onPressed, text: buttonText, context: context),
            Gap(4.h),
          ],
        ),
      ),
    ).show();
  }

  static void loading(
      {required BuildContext context,
      required String buttonText,
      required String description,
      required Function() onPressed}) {
    AwesomeDialog(
      context: context,
      width: 40.w,
      dialogBackgroundColor: Colors.black,
      animType: AnimType.scale,
      dialogBorderRadius: const BorderRadius.all(Radius.circular(22)),
      dialogType: DialogType.noHeader,
      keyboardAware: true,
      customHeader: const SizedBox(
          height: 85,
          width: 85,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            strokeWidth: 14,
            color: CpColors.cpPrimary,
          )),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            Gap(4.h),
            CustomCatchpadButtons.buildGradientButtonWithBorder(
                onPressed: onPressed, text: buttonText, context: context),
            Gap(4.h),
          ],
        ),
      ),
    ).show();
  }

  static Future<void> connectionWait(BuildContext context, WidgetRef ref,
      {bool inGameDisconnected = false}) async {
    // final currentAwe = AwesomeDialog(
    //     width: 40.w,
    //     dialogBackgroundColor: Colors.black,
    //     dialogBorderRadius: BorderRadius.all(Radius.circular(24.px)),
    //     borderSide: const BorderSide(color: CpColors.cpQuickSilver, width: 0.4),
    //     barrierColor: Colors.black.withOpacity(0.65),
    //     body: SizedBox(
    //       height: 35.h,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 2.w),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             CatchpadDialogDescription(
    //               description: !inGameDisconnected
    //                   ? L10n.inst(context).iga_oops_we_have_a_problem
    //                   : L10n.inst(context).iga_oops_we_have_a_problem,
    //             ),
    //             CustomCatchpadButtons.buildGradientButtonWithBorder(
    //                 width: 20.w,
    //                 height: 8.h,
    //                 textStyle: Theme.of(context)
    //                     .textTheme
    //                     .displaySmall!
    //                     .copyWith(
    //                         fontWeight: FontWeight.w600, color: Colors.white),
    //                 onPressed: () async {
    //                   try{
    //                     logger.i("@@@@onPressed");
    //                     TelegramManager.instance!.sendMobileReportMessage(
    //                         "Kullanıcı tarafından gönderilen geri bildirim.\nToplam Bağlantı Cihaz:${ref.read(bleConPr).values.where((element) => element.connectionState == DeviceConnectionState.connected).length.toString()}\n${ref.read(bleConPr).keys.map((e) => e.id).toList()}\nLocation:${ref.read(currentIgaResultManager.notifier).currentLocation?.igaLocationName}",
    //                         ref);
    //                   }catch(e){
    //                     logger.e("Error: $e");
    //                   }
    //                   Navigator.of(context).pop();
    //                 },
    //                 text: L10n.inst(context).report_an_issue,
    //                 context: context),
    //           ],
    //         ),
    //       ),
    //     ),
    //     context: context,
    //     dialogType: DialogType.noHeader,
    //     animType: AnimType.bottomSlide);
    //
    // await currentAwe.show().timeout(const Duration(seconds: 20),
    //     onTimeout: () => currentAwe.dismiss());
  }

  static void createdIgaUserBefore(BuildContext context, WidgetRef ref) {
    final createAwesome = AwesomeDialog(
        width: 40.w,
        dialogBackgroundColor: Colors.black,
        dialogBorderRadius: BorderRadius.all(Radius.circular(24.px)),
        borderSide: const BorderSide(color: CpColors.cpQuickSilver, width: 0.4),
        barrierColor: Colors.black.withOpacity(0.65),
        body: SizedBox(
          height: 35.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CatchpadDialogTitle(
                  title:
                      L10n.inst(context).iga_dialogue_title_before_created_user,
                ),
                CatchpadDialogDescription(
                  description: L10n.inst(context)
                      .iga_dialogue_description_before_created_user,
                ),
                CustomCatchpadButtons.buildGradientButtonWithBorder(
                    width: 15.w,
                    height: 6.h,
                    textStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    text: L10n.inst(context).ok,
                    context: context),
              ],
            ),
          ),
        ),
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.bottomSlide);

    createAwesome.show().timeout(const Duration(seconds: 15), onTimeout: () {
      Navigator.of(context).pop();
    });
  }

  static void createLocationForIga(BuildContext context, WidgetRef ref) {
    final locationIdController = TextEditingController();
    final locationNameController = TextEditingController();
    AwesomeDialog(
            width: 40.w,
            dialogBackgroundColor: Colors.black,
            dialogBorderRadius: BorderRadius.all(Radius.circular(24.px)),
            borderSide:
                const BorderSide(color: CpColors.cpQuickSilver, width: 0.4),
            barrierColor: Colors.black.withOpacity(0.65),
            body: SizedBox(
              height: 35.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CatchpadDialogTitle(
                      title: "Lokasyon Oluştur",
                    ),
                    CustomCatchpadTextFields.buildCompactTextField(
                        context: context, controller: locationIdController),
                    CustomCatchpadTextFields.buildCompactTextField(
                        context: context, controller: locationNameController),
                    CustomCatchpadButtons.buildGradientButtonWithBorder(
                        width: 15.w,
                        height: 6.h,
                        textStyle: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                        onPressed: () => ref
                            .read(currentIgaResultManager.notifier)
                            .createCurrentLocation(ref,
                                locationId: locationIdController.text,
                                locationName: locationNameController.text),
                        text: L10n.inst(context).form_cancel,
                        context: context),
                  ],
                ),
              ),
            ),
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.bottomSlide)
        .show();
  }

  static void notSelectedIga(
      BuildContext context, String title, String description) {
    final customAwe = AwesomeDialog(
        width: 40.w,
        dialogBackgroundColor: Colors.black,
        dialogBorderRadius: BorderRadius.all(Radius.circular(24.px)),
        borderSide:
        const BorderSide(color: CpColors.cpQuickSilver, width: 0.4),
        barrierColor: Colors.black.withOpacity(0.65),
        body: SizedBox(
          height: 35.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CatchpadDialogTitle(
                  title: title,
                ),
                CatchpadDialogDescription(
                  description: description,
                ),
                CustomCatchpadButtons.buildGradientButtonWithBorder(
                    width: 15.w,
                    height: 6.h,
                    context: context,
                    textStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    text: L10n.inst(context).form_cancel),
              ],
            ),
          ),
        ),
        context: context,
        dialogType: DialogType.noHeader,
        animType: AnimType.bottomSlide);

       customAwe.show().timeout(const Duration(seconds: 20),
        onTimeout: () => customAwe.dismiss());
  }
}

class CatchpadDialogTitle extends StatelessWidget {
  final String title;

  const CatchpadDialogTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(fontWeight: FontWeight.w600, color: CpColors.cpPrimary),
      textAlign: TextAlign.center,
    );
  }
}

class CatchpadDialogDescription extends StatelessWidget {
  final String description;

  const CatchpadDialogDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(fontWeight: FontWeight.w400, color: CpColors.cpQuickSilver),
      textAlign: TextAlign.center,
    );
  }
}
