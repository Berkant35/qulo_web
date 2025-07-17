import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardRefreshing extends DashboardState {
  final DashboardData currentData;

  const DashboardRefreshing({required this.currentData});

  @override
  List<Object?> get props => [currentData];
}

class DashboardLoaded extends DashboardState {
  final DashboardData data;

  const DashboardLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class DashboardError extends DashboardState {
  final String message;
  final DashboardData? cachedData;

  const DashboardError({
    required this.message,
    this.cachedData,
  });

  @override
  List<Object?> get props => [message, cachedData];
}

class DashboardMetricCardsLoading extends DashboardState {
  const DashboardMetricCardsLoading();
}

class DashboardMetricCardsLoaded extends DashboardState {
  final List<MetricCard> metricCards;

  const DashboardMetricCardsLoaded({required this.metricCards});

  @override
  List<Object?> get props => [metricCards];
}

class DashboardChartDataLoading extends DashboardState {
  const DashboardChartDataLoading();
}

class DashboardChartDataLoaded extends DashboardState {
  final List<ChartSeries> chartData;

  const DashboardChartDataLoaded({required this.chartData});

  @override
  List<Object?> get props => [chartData];
}

class DashboardRecentActivitiesLoading extends DashboardState {
  const DashboardRecentActivitiesLoading();
}

class DashboardRecentActivitiesLoaded extends DashboardState {
  final List<RecentActivity> recentActivities;

  const DashboardRecentActivitiesLoaded({required this.recentActivities});

  @override
  List<Object?> get props => [recentActivities];
}
