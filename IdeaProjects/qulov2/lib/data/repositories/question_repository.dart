import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/network_manager.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/question_service.dart';
import 'package:qulo_v2/data/models/question_model.dart';

class QuestionRepository {
  final QuestionService _service;
  final NetworkManager _network;

  QuestionRepository(this._service, this._network);

  Future<Result<List<QuestionModel>>> getMyQuestions() async {
    try {
      final response = await _service.getMyQuestions();
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<QuestionModel>> createQuestion(Map<String, dynamic> data) async {
    try {
      final response = await _service.createQuestion(data);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<QuestionModel>> updateQuestion(int orderNum, Map<String, dynamic> data) async {
    try {
      final response = await _service.updateQuestion(orderNum, data);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<void>> deleteQuestion(int orderNum) async {
    try {
      await _service.deleteQuestion(orderNum);
      return const Success(null);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<int>> getQuestionCount() async {
    return _network.get<int>(
      '/questions/count/me',
      parser: (json) => (json as Map<String, dynamic>)['count'] as int,
    );
  }
}
