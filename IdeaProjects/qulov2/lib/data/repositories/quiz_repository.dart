import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/quiz_model.dart';

class QuizRepository {
  final ApiClient _client;

  QuizRepository(this._client);

  Future<QuizStartResponse> startSession(String targetId) async {
    final response = await _client.dio.post(ApiEndpoints.quizStart, data: {'target_id': targetId});
    return QuizStartResponse.fromJson(response.data);
  }

  Future<QuizQuestionModel> getCurrentQuestion(String sessionId) async {
    final response = await _client.dio.get(ApiEndpoints.quizSession(sessionId));
    return QuizQuestionModel.fromJson(response.data);
  }

  Future<QuizAnswerResponse> answerQuestion(String sessionId, {required int selectedAnswer, String? powerUsed}) async {
    final response = await _client.dio.post(ApiEndpoints.quizAnswer(sessionId), data: {
      'selected_answer': selectedAnswer,
      if (powerUsed != null) 'power_used': powerUsed,
    });
    return QuizAnswerResponse.fromJson(response.data);
  }

  Future<QuizResultModel> getSessionResult(String sessionId) async {
    final response = await _client.dio.get(ApiEndpoints.quizResult(sessionId));
    return QuizResultModel.fromJson(response.data);
  }
}
