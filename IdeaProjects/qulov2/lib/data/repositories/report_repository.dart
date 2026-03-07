import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';

class ReportRepository {
  final ApiClient _client;

  ReportRepository(this._client);

  Future<void> createReport({
    required String reportedId,
    required String reason,
    String? description,
  }) async {
    await _client.dio.post(ApiEndpoints.reports, data: {
      'reported_id': reportedId,
      'reason': reason,
      if (description != null) 'description': description,
    });
  }
}
