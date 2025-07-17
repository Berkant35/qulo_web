import '../../../../core/network/dio_client.dart';
import '../models/models.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardDataModel> getDashboardData();
  Future<List<MetricCardModel>> getMetricCards();
  Future<List<ChartSeriesModel>> getChartData();
  Future<List<RecentActivityModel>> getRecentActivities({int limit = 10});
  Future<List<ChartSeriesModel>> getChartDataByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<DashboardDataModel> refreshDashboardData();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient dioClient;

  DashboardRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<DashboardDataModel> getDashboardData() async {
    final response = await dioClient.get('/dashboard');
    return DashboardDataModel.fromJson(response.data);
  }

  @override
  Future<List<MetricCardModel>> getMetricCards() async {
    final response = await dioClient.get('/dashboard/metrics');
    return (response.data as List)
        .map((e) => MetricCardModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ChartSeriesModel>> getChartData() async {
    final response = await dioClient.get('/dashboard/charts');
    return (response.data as List)
        .map((e) => ChartSeriesModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<RecentActivityModel>> getRecentActivities(
      {int limit = 10}) async {
    final response = await dioClient.get(
      '/dashboard/activities',
      queryParameters: {'limit': limit},
    );
    return (response.data as List)
        .map((e) => RecentActivityModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ChartSeriesModel>> getChartDataByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await dioClient.get(
      '/dashboard/charts',
      queryParameters: {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      },
    );
    return (response.data as List)
        .map((e) => ChartSeriesModel.fromJson(e))
        .toList();
  }

  @override
  Future<DashboardDataModel> refreshDashboardData() async {
    final response = await dioClient.get('/dashboard/refresh');
    return DashboardDataModel.fromJson(response.data);
  }
}
