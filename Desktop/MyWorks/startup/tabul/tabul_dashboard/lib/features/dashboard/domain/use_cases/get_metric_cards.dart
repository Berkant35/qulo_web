import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/dashboard_repository.dart';

class GetMetricCards implements UseCase<List<MetricCard>, NoParams> {
  final DashboardRepository repository;

  GetMetricCards(this.repository);

  @override
  Future<Either<Failure, List<MetricCard>>> call(NoParams params) async {
    return await repository.getMetricCards();
  }
}
