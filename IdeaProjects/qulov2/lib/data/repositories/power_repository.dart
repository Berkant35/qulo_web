import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/power_model.dart';

class PowerRepository {
  final ApiClient _client;

  PowerRepository(this._client);

  Future<List<PowerModel>> getPowers() async {
    final response = await _client.dio.get(ApiEndpoints.powers);
    return (response.data as List).map((e) => PowerModel.fromJson(e)).toList();
  }
}
