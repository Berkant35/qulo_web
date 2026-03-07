import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/diamond_model.dart';

class DiamondRepository {
  final ApiClient _client;

  DiamondRepository(this._client);

  Future<DiamondBalance> getBalance() async {
    final response = await _client.dio.get(ApiEndpoints.diamondBalance);
    return DiamondBalance.fromJson(response.data);
  }

  Future<DiamondHistoryResponse> getHistory({int page = 1, int limit = 20}) async {
    final response = await _client.dio.get(ApiEndpoints.diamondHistory, queryParameters: {
      'page': page,
      'limit': limit,
    });
    return DiamondHistoryResponse.fromJson(response.data);
  }

  Future<void> purchase(String iapProductId) async {
    await _client.dio.post(ApiEndpoints.diamondPurchase, data: {'product_id': iapProductId});
  }
}
