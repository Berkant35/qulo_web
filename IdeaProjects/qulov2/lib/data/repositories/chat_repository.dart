import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/message_model.dart';

class ChatRepository {
  final ApiClient _client;

  ChatRepository(this._client);

  Future<MessagesResponse> getMessages(String matchId, {int page = 1, int limit = 30}) async {
    final response = await _client.dio.get(
      ApiEndpoints.chatMessages(matchId),
      queryParameters: {'page': page, 'limit': limit},
    );
    return MessagesResponse.fromJson(response.data);
  }

  Future<MessageModel> sendMessage(String matchId, {required String content, bool isImage = false}) async {
    final response = await _client.dio.post(
      ApiEndpoints.chatMessages(matchId),
      data: {'content': content, 'is_image': isImage},
    );
    return MessageModel.fromJson(response.data);
  }

  Future<void> markAsRead(String matchId) async {
    await _client.dio.post(ApiEndpoints.chatRead(matchId));
  }
}
