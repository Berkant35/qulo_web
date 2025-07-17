import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/models.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardDataModel?> getCachedDashboardData();
  Future<void> cacheDashboardData(DashboardDataModel data);
  Future<List<MetricCardModel>?> getCachedMetricCards();
  Future<void> cacheMetricCards(List<MetricCardModel> cards);
  Future<List<ChartSeriesModel>?> getCachedChartData();
  Future<void> cacheChartData(List<ChartSeriesModel> charts);
  Future<List<RecentActivityModel>?> getCachedRecentActivities();
  Future<void> cacheRecentActivities(List<RecentActivityModel> activities);
  Future<void> clearCache();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final SharedPreferences sharedPreferences;

  DashboardLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<DashboardDataModel?> getCachedDashboardData() async {
    final jsonString =
        sharedPreferences.getString(AppConstants.dashboardCacheKey);
    if (jsonString != null) {
      return DashboardDataModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheDashboardData(DashboardDataModel data) async {
    await sharedPreferences.setString(
      AppConstants.dashboardCacheKey,
      jsonEncode(data.toJson()),
    );
  }

  @override
  Future<List<MetricCardModel>?> getCachedMetricCards() async {
    final jsonString =
        sharedPreferences.getString(AppConstants.metricCardsCacheKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => MetricCardModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<void> cacheMetricCards(List<MetricCardModel> cards) async {
    final jsonString = jsonEncode(cards.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(
        AppConstants.metricCardsCacheKey, jsonString);
  }

  @override
  Future<List<ChartSeriesModel>?> getCachedChartData() async {
    final jsonString =
        sharedPreferences.getString(AppConstants.chartDataCacheKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => ChartSeriesModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<void> cacheChartData(List<ChartSeriesModel> charts) async {
    final jsonString = jsonEncode(charts.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(
        AppConstants.chartDataCacheKey, jsonString);
  }

  @override
  Future<List<RecentActivityModel>?> getCachedRecentActivities() async {
    final jsonString =
        sharedPreferences.getString(AppConstants.recentActivitiesCacheKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => RecentActivityModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<void> cacheRecentActivities(
      List<RecentActivityModel> activities) async {
    final jsonString = jsonEncode(activities.map((e) => e.toJson()).toList());
    await sharedPreferences.setString(
        AppConstants.recentActivitiesCacheKey, jsonString);
  }

  @override
  Future<void> clearCache() async {
    await Future.wait([
      sharedPreferences.remove(AppConstants.dashboardCacheKey),
      sharedPreferences.remove(AppConstants.metricCardsCacheKey),
      sharedPreferences.remove(AppConstants.chartDataCacheKey),
      sharedPreferences.remove(AppConstants.recentActivitiesCacheKey),
    ]);
  }
}
