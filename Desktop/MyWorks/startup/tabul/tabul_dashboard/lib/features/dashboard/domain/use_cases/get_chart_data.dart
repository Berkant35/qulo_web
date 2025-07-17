import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/entities.dart';
import '../repositories/dashboard_repository.dart';

class GetChartData implements UseCase<List<ChartSeries>, GetChartDataParams> {
  final DashboardRepository repository;

  GetChartData(this.repository);

  @override
  Future<Either<Failure, List<ChartSeries>>> call(
      GetChartDataParams params) async {
    if (params.startDate != null && params.endDate != null) {
      return await repository.getChartDataByDateRange(
        startDate: params.startDate!,
        endDate: params.endDate!,
      );
    }
    return await repository.getChartData();
  }
}

class GetChartDataParams extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;

  const GetChartDataParams({
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}
