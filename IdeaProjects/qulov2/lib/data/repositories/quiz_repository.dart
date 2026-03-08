import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/quiz_service.dart';
import 'package:qulo_v2/data/models/quiz_model.dart';

class QuizRepository {
  final QuizService _service;

  QuizRepository(this._service);

  Future<Result<QuizStartResponse>> startSession(String targetId) async {
    try {
      final response = await _service.startSession({'target_id': targetId});
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<QuizQuestionModel>> getCurrentQuestion(String sessionId) async {
    try {
      final response = await _service.getCurrentQuestion(sessionId);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<QuizAnswerResponse>> answerQuestion(
    String sessionId, {
    required int selectedAnswer,
    String? powerUsed,
  }) async {
    try {
      final response = await _service.answerQuestion(sessionId, {
        'selected_answer': selectedAnswer,
        if (powerUsed != null) 'power_used': powerUsed,
      });
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<QuizResultModel>> getSessionResult(String sessionId) async {
    try {
      final response = await _service.getSessionResult(sessionId);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
