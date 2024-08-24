import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/custom_colors.dart';

class Packets extends ConsumerStatefulWidget {
  const Packets({
    super.key,
  });

  @override
  ConsumerState createState() => _PacketsState();
}

class _PacketsState extends ConsumerState<Packets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Paketler",
          style: ThemeValueExtension.headline6
              .copyWith(color: CustomColors.primaryColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buyCard("Bronz Paket", "1 Ay", "1.000", "Dakika"),
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: buyCard("Gümüş Paket", "2 Ay", "2.000", "Dakika"),
            ),
            buyCard("Altın Paket", "3 Ay", "3.000", "Dakika"),
          ],
        )
      ],
    );
  }

  Widget buyCard(String title1, String title2, String title3, String title4) {
    return SizedBox(
      height: 22.h,
      width: 30.w,
      child: Card(
        color: CustomColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title1,
              style: ThemeValueExtension.subtitle.copyWith(color: Colors.white),
            ),

            Text(
              title2,
              style: ThemeValueExtension.subtitle.copyWith(color: Colors.white),
            ),

            Text(
              title3,
              style: ThemeValueExtension.headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),

            Text(
              title4,
              style: ThemeValueExtension.subtitle.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
