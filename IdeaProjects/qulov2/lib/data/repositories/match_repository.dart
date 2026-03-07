import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/discover_model.dart';
import '../models/match_model.dart';

class MatchRepository {
  final ApiClient _client;

  MatchRepository(this._client);

  Future<DiscoverResponse> discover({int page = 1}) async {
    final response = await _client.dio.get(ApiEndpoints.discover, queryParameters: {'page': page});
    return DiscoverResponse.fromJson(response.data);
  }

  Future<SwipeResponse> swipe({required String targetId, required String action}) async {
    final response = await _client.dio.post(ApiEndpoints.swipe, data: {
      'target_id': targetId,
      'action': action,
    });
    return SwipeResponse.fromJson(response.data);
  }

  Future<List<MatchModel>> getMatches() async {
    final response = await _client.dio.get(ApiEndpoints.matchList);
    return (response.data as List).map((e) => MatchModel.fromJson(e)).toList();
  }

  Future<void> unmatch(String matchId) async {
    await _client.dio.delete(ApiEndpoints.unmatch(matchId));
  }
}
