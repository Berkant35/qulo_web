import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/data_sources.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final DashboardLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getDashboardData();
        await localDataSource.cacheDashboardData(remoteData);
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      try {
        final localData = await localDataSource.getCachedDashboardData();
        if (localData != null) {
          return Right(localData);
        } else {
          return const Left(CacheFailure('No cached dashboard data available'));
        }
      } catch (e) {
        return const Left(CacheFailure('Failed to load cached dashboard data'));
      }
    }
  }

  @override
  Future<Either<Failure, List<MetricCard>>> getMetricCards() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getMetricCards();
        await localDataSource.cacheMetricCards(remoteData);
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      try {
        final localData = await localDataSource.getCachedMetricCards();
        if (localData != null) {
          return Right(localData);
        } else {
          return const Left(CacheFailure('No cached metric cards available'));
        }
      } catch (e) {
        return const Left(CacheFailure('Failed to load cached metric cards'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ChartSeries>>> getChartData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getChartData();
        await localDataSource.cacheChartData(remoteData);
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      try {
        final localData = await localDataSource.getCachedChartData();
        if (localData != null) {
          return Right(localData);
        } else {
          return const Left(CacheFailure('No cached chart data available'));
        }
      } catch (e) {
        return const Left(CacheFailure('Failed to load cached chart data'));
      }
    }
  }

  @override
  Future<Either<Failure, List<RecentActivity>>> getRecentActivities({
    int limit = 10,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataSource.getRecentActivities(limit: limit);
        await localDataSource.cacheRecentActivities(remoteData);
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      try {
        final localData = await localDataSource.getCachedRecentActivities();
        if (localData != null) {
          // Limit cache'den gelen veriyi de
          final limitedData = localData.take(limit).toList();
          return Right(limitedData);
        } else {
          return const Left(
              CacheFailure('No cached recent activities available'));
        }
      } catch (e) {
        return const Left(
            CacheFailure('Failed to load cached recent activities'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ChartSeries>>> getChartDataByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getChartDataByDateRange(
          startDate: startDate,
          endDate: endDate,
        );
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      return const Left(
          NetworkFailure('No internet connection for date range query'));
    }
  }

  @override
  Future<Either<Failure, DashboardData>> refreshDashboardData() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.refreshDashboardData();
        await localDataSource.cacheDashboardData(remoteData);
        return Right(remoteData);
      } catch (e) {
        return _handleError(e);
      }
    } else {
      return const Left(
          NetworkFailure('No internet connection for data refresh'));
    }
  }

  Left<Failure, T> _handleError<T>(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return const Left(NetworkFailure('Network connection failed'));
    } else if (error.toString().contains('FormatException')) {
      return const Left(ServerFailure('Invalid data format received'));
    } else if (error.toString().contains('TimeoutException')) {
      return const Left(NetworkFailure('Request timeout'));
    } else {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }
}
