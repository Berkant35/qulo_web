import 'package:catchpad/prov/analysis/analaysis_prov.dart';
import 'package:catchpad/ui/analysis/game_result_card.dart';
import 'package:catchpad/ui/analysis/performance_analysis_main.dart';
import 'package:catchpad/ui/game/widgets/in_game_score_widgets/game_show_score_widget.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalityAnalysis extends ConsumerStatefulWidget {
  const PersonalityAnalysis({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalityAnalysisState();
}

class _PersonalityAnalysisState extends ConsumerState<PersonalityAnalysis> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reversedGameList = ref
        .watch(analysisOptionsProvider)!
        .gameResultModelList
        .reversed
        .toList();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollToEnd();
    });
    return Consumer(
      builder: (context, provider, child) {
        ref.watch(selectedGame.notifier).state;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: (ref
                    .watch(analysisOptionsProvider)!
                    .gameResultModelList
                    .isNotEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AverageScore(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Tüm Egzersizlerin Zamana Bağlı Skor Grafiği",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: CpColors.yellow),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.3,
                            maxWidth: MediaQuery.of(context).size.width * 0.9),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: Container(
                              width: ref
                                      .read(analysisOptionsProvider)!
                                      .flSpots
                                      .length *
                                  25,
                              child: LineChart(timeIndexData())),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Son Oyunlar",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: CpColors.yellow),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: reversedGameList.length,
                            reverse: false,
                            itemBuilder: (context, index) {
                              return GameResultCard(
                                gameResultModel: reversedGameList[index],
                              );
                            }),
                      )
                    ],
                  )
                : const Center(
                    child: Text("Henüz egzersiz bulunmamaktadır."),
                  ),
          ),
        );
      },
    );
  }

  void scrollToEnd() {
    if ((ref.watch(analysisOptionsProvider)!.gameResultModelList.isNotEmpty)) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  LineChartData timeIndexData() {
    return LineChartData(
        lineTouchData: const LineTouchData(
          enabled: true,
        ),
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: true,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: leftTitleWidgets,
              interval: 1,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        maxX: ref.watch(analysisOptionsProvider)!.maxX.toDouble(),
        maxY: ref.watch(analysisOptionsProvider)!.maxY.toDouble(),
        minX: ref.watch(analysisOptionsProvider)!.minX.toDouble(),
        minY: ref.watch(analysisOptionsProvider)!.minY.toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: ref.watch(analysisOptionsProvider)!.flSpots,
            isCurved: false,
          )
        ]);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SizedBox(
        child: Text(value.toInt().toString(),
            style: Theme.of(context).textTheme.bodySmall));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return value % 1000 == 0
        ? Text(value.toString().substring(0, 1) + 'k',
            style: Theme.of(context).textTheme.bodySmall)
        : const SizedBox();
  }
}

class AverageScore extends ConsumerWidget {
  const AverageScore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      padding:  const EdgeInsets.all(defPaddingSize),
      decoration: BoxDecoration(
          color: const Color(0xFF333846).withOpacity(0.8),
          borderRadius: BorderRadius.circular(defPaddingSize)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ortalama Skor",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: CpColors.cpBasicWhite),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.2,
            height: MediaQuery.of(context).size.width*0.2,
            decoration: BoxDecoration(
                color: CpColors.bgGC2,
                border: Border.all(color: CpColors.yellow),
                borderRadius: BorderRadius.circular(defPaddingSize)),
            child: Center(
              child: Text(
                ref.watch(analysisOptionsProvider)!.ort.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: CpColors.cpBasicWhite)
              ),
            ),
          ),
        ],
      ),

    );
  }
}

