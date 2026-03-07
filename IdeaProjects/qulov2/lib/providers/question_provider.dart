import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/question_model.dart';
import 'api_provider.dart';

class QuestionNotifier extends AsyncNotifier<List<QuestionModel>> {
  @override
  Future<List<QuestionModel>> build() async => [];

  Future<void> fetchQuestions() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(questionRepositoryProvider).getMyQuestions());
  }

  Future<void> createQuestion(Map<String, dynamic> data) async {
    final repo = ref.read(questionRepositoryProvider);
    await repo.createQuestion(data);
    await fetchQuestions();
  }

  Future<void> updateQuestion(int orderNum, Map<String, dynamic> data) async {
    final repo = ref.read(questionRepositoryProvider);
    await repo.updateQuestion(orderNum, data);
    await fetchQuestions();
  }

  Future<void> deleteQuestion(int orderNum) async {
    final repo = ref.read(questionRepositoryProvider);
    await repo.deleteQuestion(orderNum);
    await fetchQuestions();
  }
}

final questionProvider = AsyncNotifierProvider<QuestionNotifier, List<QuestionModel>>(QuestionNotifier.new);
