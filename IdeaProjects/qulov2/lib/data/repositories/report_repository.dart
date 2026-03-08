import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/report_service.dart';

class ReportRepository {
  final ReportService _service;

  ReportRepository(this._service);

  Future<Result<void>> createReport({
    required String reportedId,
    required String reason,
    String? description,
  }) async {
    try {
      await _service.createReport({
        'reported_id': reportedId,
        'reason': reason,
        if (description != null) 'description': description,
      });
      return const Success(null);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
