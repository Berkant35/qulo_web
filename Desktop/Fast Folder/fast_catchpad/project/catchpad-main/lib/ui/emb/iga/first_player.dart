import 'package:catchpad/ui/emb/iga/cp_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_picker/src/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/cp_colors.dart';
import '../../../utils/util_widgets/util_localizations.dart';
class FirstPlayer extends ConsumerWidget {
  final String countryCode;
  const FirstPlayer({super.key,required this.countryCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 130,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              height: 35,
              child: Transform.rotate(
                  angle: -1 * (6 * 3.14 / 180),
                  child: Image.asset('assets/iga/tac.png'))),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Container(
              padding: EdgeInsets.all(1.5.px),
              decoration: BoxDecoration(
                  color: CpColors.cpPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(60.px))),
              child: UtilLocalizations.getCountryFlag(countryCode ?? "TR"),
            ),
          ),
        ],
      ),
    );
  }
}
