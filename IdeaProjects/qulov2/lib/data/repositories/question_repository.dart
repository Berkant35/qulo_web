import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/question_model.dart';

class QuestionRepository {
  final ApiClient _client;

  QuestionRepository(this._client);

  Future<List<QuestionModel>> getMyQuestions() async {
    final response = await _client.dio.get(ApiEndpoints.questions);
    return (response.data as List).map((e) => QuestionModel.fromJson(e)).toList();
  }

  Future<QuestionModel> createQuestion(Map<String, dynamic> data) async {
    final response = await _client.dio.post(ApiEndpoints.questions, data: data);
    return QuestionModel.fromJson(response.data);
  }

  Future<QuestionModel> updateQuestion(int orderNum, Map<String, dynamic> data) async {
    final response = await _client.dio.patch(ApiEndpoints.questionByOrder(orderNum), data: data);
    return QuestionModel.fromJson(response.data);
  }

  Future<void> deleteQuestion(int orderNum) async {
    await _client.dio.delete(ApiEndpoints.questionByOrder(orderNum));
  }

  Future<int> getQuestionCount() async {
    final response = await _client.dio.get(ApiEndpoints.questionCount);
    return response.data['count'] as int;
  }
}
