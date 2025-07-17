import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/use_cases/use_case.dart';
import '../../domain/use_cases/use_cases.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardData getDashboardData;
  final GetMetricCards getMetricCards;
  final GetChartData getChartData;
  final GetRecentActivities getRecentActivities;
  final RefreshDashboardData refreshDashboardData;

  DashboardCubit({
    required this.getDashboardData,
    required this.getMetricCards,
    required this.getChartData,
    required this.getRecentActivities,
    required this.refreshDashboardData,
  }) : super(const DashboardInitial());

  /// Tüm dashboard verilerini yükle
  Future<void> loadDashboardData() async {
    emit(const DashboardLoading());

    final result = await getDashboardData(const NoParams());
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (data) => emit(DashboardLoaded(data: data)),
    );
  }

  /// Dashboard verilerini refresh et
  Future<void> refreshData() async {
    if (state is DashboardLoaded) {
      emit(DashboardRefreshing(currentData: (state as DashboardLoaded).data));
    } else {
      emit(const DashboardLoading());
    }

    final result = await refreshDashboardData(const NoParams());
    result.fold(
      (failure) {
        if (state is DashboardRefreshing) {
          final currentData = (state as DashboardRefreshing).currentData;
          emit(DashboardError(
            message: failure.message,
            cachedData: currentData,
          ));
        } else {
          emit(DashboardError(message: failure.message));
        }
      },
      (data) => emit(DashboardLoaded(data: data)),
    );
  }

  /// Sadece metric kartları yükle
  Future<void> loadMetricCards() async {
    emit(const DashboardMetricCardsLoading());

    final result = await getMetricCards(const NoParams());
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (metricCards) =>
          emit(DashboardMetricCardsLoaded(metricCards: metricCards)),
    );
  }

  /// Sadece chart verilerini yükle
  Future<void> loadChartData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(const DashboardChartDataLoading());

    final params = GetChartDataParams(
      startDate: startDate,
      endDate: endDate,
    );

    final result = await getChartData(params);
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (chartData) => emit(DashboardChartDataLoaded(chartData: chartData)),
    );
  }

  /// Sadece son aktiviteleri yükle
  Future<void> loadRecentActivities({int limit = 10}) async {
    emit(const DashboardRecentActivitiesLoading());

    final params = GetRecentActivitiesParams(limit: limit);
    final result = await getRecentActivities(params);
    result.fold(
      (failure) => emit(DashboardError(message: failure.message)),
      (activities) =>
          emit(DashboardRecentActivitiesLoaded(recentActivities: activities)),
    );
  }

  /// Chart verilerini tarih aralığı ile filtrele
  Future<void> filterChartDataByDate({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await loadChartData(startDate: startDate, endDate: endDate);
  }

  /// Error state'i temizle
  void clearError() {
    if (state is DashboardError) {
      final errorState = state as DashboardError;
      if (errorState.cachedData != null) {
        emit(DashboardLoaded(data: errorState.cachedData!));
      } else {
        emit(const DashboardInitial());
      }
    }
  }
}
