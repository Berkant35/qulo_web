import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/lang_model.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomRateWidget extends ConsumerStatefulWidget {
  const CustomRateWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomRateWidgetState();
}

class _CustomRateWidgetState extends ConsumerState<CustomRateWidget> {
  double _rating = 4.0;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                color: Colors.blueGrey,
                pressEvent: () {
                  AwesomeDialog(
                    dialogBackgroundColor: CpColors.cpDireWolf,
                    borderSide: const BorderSide(
                        color: CpColors.cpFrenchLime, width: 1),
                    dialogBorderRadius: BorderRadius.circular(30),
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.info,
                    customHeader: CatchpadIconsV2.rateIcon,
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
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
                              setState(() {
                                _rating = rating;
                              });
                              print('Rating: $rating');
                            },
                            displayRatingValue: true,
                            interactiveTooltips: true,
                            customFilledIcon: Icons.star,
                            customHalfFilledIcon: Icons.star_half,
                            customEmptyIcon: Icons.star_border,
                            starSize: 30.0,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            animationCurve: Curves.easeInOut,
                            readOnly: false,
                          ),
                          Gap(1.h),
                          TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  hintText: inst.iga_write_feedback,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                await FirebaseIgaCollectionEnumsWithField
                                    .iga_rates.reference
                                    .add({
                                  'rating': _rating,
                                  'comment': _controller.text,
                                  'created_at': DateTime.now(),
                                });
                                _controller.clear();

                                Navigator.of(context).pop();
                              },
                              child: Text(
                                inst.form_send,
                                style: const TextStyle(
                                    color: CpColors.cpFrenchLime, fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                  ).show();
                },
              ),
            ],
          ),
        ));
  }


}
