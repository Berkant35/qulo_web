import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/custom_colors.dart';

class RemainTimeShow extends ConsumerStatefulWidget {
  const RemainTimeShow({
    super.key,
  });

  @override
  ConsumerState createState() => _RemainTimeShowState();
}

class _RemainTimeShowState extends ConsumerState<RemainTimeShow> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  double percentage = 0.0; // İlk başta 0

  @override
  void initState() {
    super.initState();

    // Animasyonu başlatmak için Timer kullanabilirsiniz.
    // Örnek olarak burada 2 saniyede %80'e çıkacak şekilde ayarladım.
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        percentage = 80.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Stack(
        children: [
          Align(alignment: Alignment.topCenter, child: chart()),
          Align(
            alignment: Alignment.center,
            child: inChartInfo(),
          ),
          Align(
            alignment: Alignment.center,
            child: remainInfos(),
          )
        ],
      ),
    );
  }

  Widget remainInfos() {
    return SizedBox(
      width: 62.w,
      height: 7.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '%0',
            style: ThemeValueExtension.titleTextStyle.copyWith(
                color: CustomColors.profileGreyColor,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '%100',
            style: ThemeValueExtension.titleTextStyle.copyWith(
                color: CustomColors.profileGreyColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Column inChartInfo() {
    return Column(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: percentage),
          duration: const Duration(milliseconds: 1500), // Animasyon süresi
          builder: (context, value, child) {
            return Text(
              '%${value.toStringAsFixed(0)}', // Yüzdeyi tam sayıya çeviriyoruz.
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey, // Metin rengi
              ),
            );
          },
        ),
        Text(
          'Kalan Kullanım',
          style: ThemeValueExtension.titleTextStyle.copyWith(
              color: CustomColors.profileGreyColor,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Transform chart() {
    return Transform.rotate(
      angle: -90 * (3.14159265359 / 180),
      // 90 dereceyi radyan cinsinden çevirir.
      child: AnimatedCircularChart(
        key: _chartKey,
        duration: const Duration(milliseconds: 1500),
        size: Size(35.h, 80.w),
        initialChartData: const <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                40, // İkinci yarımda gösterilecek yüzde.
                CustomColors.primaryColor,
                rankKey: 'remaining',
              ),
              CircularSegmentEntry(
                10, // İkinci yarımda gösterilecek yüzde.
                CustomColors.grey2Color,
                rankKey: 'remaining',
              ),
            ],
            rankKey: 'progress',
          ),
        ],
        chartType: CircularChartType.Radial,
        percentageValues: true,
      ),
    );
  }
}
