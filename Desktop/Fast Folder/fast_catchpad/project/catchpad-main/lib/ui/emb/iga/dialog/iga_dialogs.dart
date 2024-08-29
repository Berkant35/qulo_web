import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_button.dart';
import 'package:catchpad/utils/util_widgets/util_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../prov/global_providers.dart';

class IgaDialogs {
  static Future<void> shareQrDialog(WidgetRef ref) async {
    final _context = ref.context;
    final l10n = L10n.inst(_context);
    if (!_context.mounted) return;

    await AwesomeDialog(
        context: _context,
        dialogBackgroundColor: CpColors.cpDireWolf,
        borderSide: const BorderSide(color: CpColors.cpFrenchLime, width: 3),
        dialogBorderRadius: BorderRadius.circular(30),
        dialogType: DialogType.noHeader,
        width: 50.w,
        body: SizedBox(
          width: double.infinity,
          height: 60.h,
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 30.h,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              IgaAssets.qr_get_discount.getPath,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 6.w,
                        child: Image.asset(
                          IgaAssets.balloon_pads.getPath,
                          height: 12.h,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    child: CustomCpInfoTexts.shareQrPopUpText(_context),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: CustomCatchpadButtons
                        .buildGradientBorderWithGradientTextButton(
                            width: 15.w,
                            onPressed: () => Navigator.of(_context).pop(),
                            text: l10n.ok),
                  )),
              Spacer()
            ],
          ),
        )).show();
  }

  static Future<void> giveRateDialog(
      BuildContext context, WidgetRef ref) async {
    double _rating = 0.0;
    final controller = TextEditingController();
    final inst = L10n.inst(context);
    await AwesomeDialog(
      dialogBackgroundColor: CpColors.cpDireWolf,
      borderSide: const BorderSide(color: CpColors.cpFrenchLime, width: 1),
      dialogBorderRadius: BorderRadius.circular(30),
      context: context,
      animType: AnimType.scale,
      width: 60.w,
      dialogType: DialogType.info,
      customHeader: CatchpadIconsV2.rateIcon,
      body: Column(
        children: [
          Text(
            inst.iga_rate_us,
            textAlign: TextAlign.center,
          ),
          Gap(1.h),
          AnimatedRatingStars(
            initialRating: 4,
            minRating: 0.0,
            maxRating: 5.0,
            filledColor: CpColors.cpFrenchLime,
            emptyColor: Colors.grey,
            filledIcon: Icons.star,
            halfFilledIcon: Icons.star_half,
            emptyIcon: Icons.star_border,
            onChanged: (double rating) {
              _rating = rating;
            },
            displayRatingValue: true,
            interactiveTooltips: true,
            customFilledIcon: Icons.star,
            customHalfFilledIcon: Icons.star_half,
            customEmptyIcon: Icons.star_border,
            starSize: 30.0,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,
            readOnly: false,
          ),
          Gap(1.h),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: inst.iga_write_feedback,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CpColors.cpFrenchLime, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CpColors.cpFrenchLime, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: CpColors.cpFrenchLime, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ))),
          Gap(1.h),
          TextButton(
              onPressed: () async {
                await FirebaseIgaCollectionEnumsWithField.iga_rates.reference
                    .add({
                  'rating': _rating,
                  'comment': controller.text,
                  'created_at': DateTime.now(),
                  "location_id":
                      ref.read(currentIgaResultManager)?.igaLocationId ??
                          "demo",
                  "game_id": ref.read(currentGiveRateManager.notifier).gameId,
                });
                controller.clear();
                _rating = 4.0;
                Navigator.of(context).pop();
              },
              child: Text(
                inst.form_send,
                style:
                    const TextStyle(color: CpColors.cpFrenchLime, fontSize: 20),
              ))
        ],
      ),
    ).show();
    ref.read(currentGiveRateManager.notifier).changState(false);
  }
}
