import 'metric_card.dart';
import 'chart_data.dart';
import 'recent_activity.dart';

class DashboardData {
  final List<MetricCard> metricCards;
  final List<ChartSeries> charts;
  final List<RecentActivity> recentActivities;
  final DateTime lastUpdated;

  const DashboardData({
    required this.metricCards,
    required this.charts,
    required this.recentActivities,
    required this.lastUpdated,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardData &&
        other.metricCards == metricCards &&
        other.charts == charts &&
        other.recentActivities == recentActivities &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return Object.hash(metricCards, charts, recentActivities, lastUpdated);
  }

  @override
  String toString() {
    return 'DashboardData(metricCards: $metricCards, charts: $charts, recentActivities: $recentActivities, lastUpdated: $lastUpdated)';
  }
}
