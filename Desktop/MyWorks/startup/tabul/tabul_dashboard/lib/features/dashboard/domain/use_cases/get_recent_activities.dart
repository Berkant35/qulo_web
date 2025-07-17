import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/dashboard_repository.dart';

class GetRecentActivities
    implements UseCase<List<RecentActivity>, GetRecentActivitiesParams> {
  final DashboardRepository repository;

  GetRecentActivities(this.repository);

  @override
  Future<Either<Failure, List<RecentActivity>>> call(
      GetRecentActivitiesParams params) async {
    return await repository.getRecentActivities(limit: params.limit);
  }
}

class GetRecentActivitiesParams extends Equatable {
  final int limit;

  const GetRecentActivitiesParams({
    this.limit = 10,
  });

  @override
  List<Object> get props => [limit];
}
