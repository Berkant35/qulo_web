import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/quiz_model.dart';
import 'api_provider.dart';

class QuizState {
  final String? sessionId;
  final int totalQuestions;
  final QuizQuestionModel? currentQuestion;
  final QuizAnswerResponse? lastAnswer;
  final bool isLoading;
  final String? error;

  const QuizState({
    this.sessionId,
    this.totalQuestions = 0,
    this.currentQuestion,
    this.lastAnswer,
    this.isLoading = false,
    this.error,
  });

  QuizState copyWith({
    String? sessionId,
    int? totalQuestions,
    QuizQuestionModel? currentQuestion,
    QuizAnswerResponse? lastAnswer,
    bool? isLoading,
    String? error,
  }) {
    return QuizState(
      sessionId: sessionId ?? this.sessionId,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      lastAnswer: lastAnswer,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class QuizNotifier extends Notifier<QuizState> {
  @override
  QuizState build() => const QuizState();

  Future<void> startSession(String targetId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(quizRepositoryProvider);
      final result = await repo.startSession(targetId);
      state = state.copyWith(
        sessionId: result.sessionId,
        totalQuestions: result.totalQuestions,
        isLoading: false,
      );
      await fetchCurrentQuestion();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> fetchCurrentQuestion() async {
    if (state.sessionId == null) return;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(quizRepositoryProvider);
      final question = await repo.getCurrentQuestion(state.sessionId!);
      state = state.copyWith(currentQuestion: question, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<QuizAnswerResponse> answer(int selectedAnswer, {String? powerUsed}) async {
    if (state.sessionId == null) throw Exception('No active session');
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = ref.read(quizRepositoryProvider);
      final result = await repo.answerQuestion(
        state.sessionId!,
        selectedAnswer: selectedAnswer,
        powerUsed: powerUsed,
      );
      state = state.copyWith(lastAnswer: result, isLoading: false);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<QuizResultModel> getResult() async {
    if (state.sessionId == null) throw Exception('No active session');
    final repo = ref.read(quizRepositoryProvider);
    return repo.getSessionResult(state.sessionId!);
  }

  void reset() {
    state = const QuizState();
  }
}

final quizProvider = NotifierProvider<QuizNotifier, QuizState>(QuizNotifier.new);
