import '../../domain/entities/entities.dart';
import 'metric_card_model.dart';
import 'chart_data_model.dart';
import 'recent_activity_model.dart';

class DashboardDataModel extends DashboardData {
  const DashboardDataModel({
    required super.metricCards,
    required super.charts,
    required super.recentActivities,
    required super.lastUpdated,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      metricCards: (json['metricCards'] as List)
          .map((e) => MetricCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      charts: (json['charts'] as List)
          .map((e) => ChartSeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentActivities: (json['recentActivities'] as List)
          .map((e) => RecentActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metricCards': metricCards
          .map((e) => MetricCardModel.fromEntity(e).toJson())
          .toList(),
      'charts':
          charts.map((e) => ChartSeriesModel.fromEntity(e).toJson()).toList(),
      'recentActivities': recentActivities
          .map((e) => RecentActivityModel.fromEntity(e).toJson())
          .toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory DashboardDataModel.fromEntity(DashboardData entity) {
    return DashboardDataModel(
      metricCards: entity.metricCards,
      charts: entity.charts,
      recentActivities: entity.recentActivities,
      lastUpdated: entity.lastUpdated,
    );
  }
}
