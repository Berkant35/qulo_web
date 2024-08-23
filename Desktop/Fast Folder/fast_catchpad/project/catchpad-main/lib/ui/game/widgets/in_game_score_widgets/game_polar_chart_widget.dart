import 'package:catchpad/models/game/player/player_model.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/hold_steady_prov.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolarChartWidget extends ConsumerStatefulWidget {
  final bool showCurrentChart;
  final PlayerModel playerModel;

  const PolarChartWidget(this.showCurrentChart,
      {super.key, required this.playerModel});

  @override
  ConsumerState createState() => _PolarChartWidgetState();
}

class _PolarChartWidgetState extends ConsumerState<PolarChartWidget> {
  @override
  Widget build(BuildContext context) {
    final livePolarDiagram = ref.watch(livePolarDiagramProvider);
    final isNewVerison = ref.watch(currentNewVersionState);
    // isBottom
    // isBottomLeft
    // isBottomRight
    // isTop
    // isTopRight
    // isTopLeft

    return SizedBox(
        height: 300,
        width: 300,
        child: widget.showCurrentChart
            ? RadarChart(
                RadarChartData(
                  getTitle: getTitleWidget,
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 8),
                  dataSets: [
                    RadarDataSet(
                      entryRadius: 2,
                      fillColor: widget.showCurrentChart
                          ? isNewVerison
                              ? CpColors.cpPrimary.withOpacity(0.25)
                              : CpColors.blue.withOpacity(0.25)
                          : CpColors.cpPrimary.withOpacity(0.25),
                      borderColor: CpColors.cpPrimary,
                      dataEntries: liveEntries(livePolarDiagram),
                    )
                  ],
                ),
              )
            : RadarChart(
                RadarChartData(
                  getTitle: getTitleWidget,
                  titleTextStyle: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 8),
                  dataSets: [
                    RadarDataSet(
                      entryRadius: 2,
                      fillColor: isNewVerison
                          ? CpColors.cpPrimary.withOpacity(0.25)
                          : Colors.pink.withOpacity(0.25),
                      borderColor: isNewVerison ? CpColors.cpPrimary : null,
                      dataEntries: averageEntries(ref),
                    )
                  ],
                ),
              ));
  }

  RadarChartTitle getTitleWidget(index, angle) {
    String radarChartTitle = "";

    switch (index) {
      case 0:
        radarChartTitle = "T";
      case 1:
        radarChartTitle = "TR";
      case 2:
        radarChartTitle = "R";
      case 3:
        radarChartTitle = "BR";
      case 4:
        radarChartTitle = "B";
      case 5:
        radarChartTitle = "BL";
      case 6:
        radarChartTitle = "L";
      case 7:
        radarChartTitle = "TL";
    }

    return RadarChartTitle(text: radarChartTitle);
  }

  List<RadarEntry> averageEntries(WidgetRef ref) {
    final averageAllDiagram =
        ref.read(livePolarDiagramProvider.notifier).averageDiagram;

    return [
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]?[MainAxis.isRight.name] ??
            0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]
                ?[CornerAxis.isBottomRight.name] ??
            0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]?[MainAxis.isBottom.name] ??
            0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]
                ?[CornerAxis.isBottomLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]?[MainAxis.isLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]
                ?[CornerAxis.isTopLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value:
            averageAllDiagram[widget.playerModel]?[MainAxis.isTop.name] ?? 0.05,
      ),
      RadarEntry(
        value: averageAllDiagram[widget.playerModel]
                ?[CornerAxis.isTopRight.name] ??
            0.05,
      ),
    ];
  }

  List<RadarEntry> liveEntries(
      PerPlayerDiagramState perPlayerLivePolarDiagramState) {
    return [
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[MainAxis.isRight.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[CornerAxis.isBottomRight.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[MainAxis.isBottom.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[CornerAxis.isBottomLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[MainAxis.isLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[CornerAxis.isTopLeft.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[MainAxis.isTop.name] ??
            0.05,
      ),
      RadarEntry(
        value: perPlayerLivePolarDiagramState[widget.playerModel]
                ?[CornerAxis.isTopRight.name] ??
            0.05,
      ),
    ];
  }
}
