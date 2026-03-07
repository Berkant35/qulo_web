import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';

class PassportRepository {
  final ApiClient _client;

  PassportRepository(this._client);

  Future<Map<String, dynamic>> activate({
    required String city,
    required double lat,
    required double lng,
  }) async {
    final response = await _client.dio.post(ApiEndpoints.passportActivate, data: {
      'city': city,
      'lat': lat,
      'lng': lng,
    });
    return response.data;
  }

  Future<void> deactivate() async {
    await _client.dio.post(ApiEndpoints.passportDeactivate);
  }
}
