import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz_model.dart';
import 'auth/current_user_prov.dart';

export '../models/permission/permission_manager.dart';

final switchProvider =
    StateNotifierProvider<SwitchProvider, bool>((_) => SwitchProvider(false));

final groupFilterProvider =
    StateNotifierProvider<GroupFilterProvider, bool>((_) => GroupFilterProvider(false));

class GroupFilterProvider extends StateNotifier<bool> {
  GroupFilterProvider(bool state) : super(state);

  void switchState() {
    state = !state;
  }
}
class SwitchProvider extends StateNotifier<bool> {
  SwitchProvider(bool state) : super(state);

  void switchState() {
    state = !state;
  }
}

final quizProvider = StateNotifierProvider<QuizProvider, QuizModel>(
  (_) => QuizProvider(QuizModel(quizes: [])),
);

final currentQuestionProv = StateNotifierProvider<CurQusProv, Question?>(
  (_) => CurQusProv(null),
);

class CurQusProv extends StateNotifier<Question?> {
  CurQusProv(Question? state) : super(state);

  setQuestion(Question question) {
    state = question;
  }

  reset() {
    state = null;
  }
}

final isCurrentQuizdone = StateNotifierProvider<IsDoneProv, bool>(
  (_) => IsDoneProv(false),
);

class IsDoneProv extends StateNotifier<bool> {
  IsDoneProv(bool state) : super(state);

  done() {
    state = true;
  }

  reset() {
    state = false;
  }
}

final selectedQuizProvider =
    StateNotifierProvider<SelectedQuizeProvider, Quize?>(
  (_) => SelectedQuizeProvider(null),
);

class SelectedQuizeProvider extends StateNotifier<Quize?> {
  SelectedQuizeProvider(Quize? state) : super(state);

  void assignQuiz(Quize quiz) {
    state = quiz;
  }

  void reset() {
    state = null;
  }
}

class QuizProvider extends StateNotifier<QuizModel> {
  QuizProvider(QuizModel state) : super(state);
  void addNewQuiz(WidgetRef ref, {required String quizName}) {
    try {
      var tempstate = state;
      tempstate.quizes.add(Quize(quizname: quizName, questions: []));
      state = tempstate;
      saveToSharedPref(ref);
    } catch (e) {
      logger.d(e.toString());
    }
  }

  void assign() {
    state = state.copyWith(assigned: true);
  }

  void removeAssign() {
    state = state.copyWith(assigned: false);
  }

  void addNewQuestionToQuiz(WidgetRef ref,
      {required Quize quiz, required Question question}) {
    try {
      var tempstate = state;
      for (Quize q in tempstate.quizes) {
        if (q.quizname == quiz.quizname) {
          q.questions.add(question);
        }
      }
      state = tempstate;
      saveToSharedPref(ref);
    } catch (e) {
      logger.d(e.toString());
    }
  }

  void reset() {
    state = QuizModel(quizes: []);
  }

  void update(QuizModel quizModel, WidgetRef ref) {
    state = quizModel;
    saveToSharedPref(ref);
  }

  void removeQuiz(WidgetRef ref, {required String quizName}) {
    var tempquizlist = state.quizes;
    tempquizlist.removeWhere((quiz) => quiz.quizname == quizName);
    state = state.copyWith(quizes: tempquizlist);
    saveToSharedPref(ref);
  }

  void removeQuestion(WidgetRef ref,
      {required String quizName, required String questionName}) {
    try {
      var tempstate =
          state.quizes.firstWhere((element) => element.quizname == quizName);
      tempstate.questions
          .removeWhere((question) => question.question == questionName);
      state.quizes
          .firstWhere((element) => element.quizname == quizName)
          .copyWith(
              questions: tempstate.questions, quizname: tempstate.quizname);
      saveToSharedPref(ref);
    } catch (e) {
      logger.d(e.toString());
    }
  }

  saveToSharedPref(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String encodedMap = state.toRawJson();
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(quizModel: state);
    sharedPreferences.setString('quizes', encodedMap);
  }

  Future<bool> loadQuizes(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? quizes = sharedPreferences.getString('quizes');
    if (quizes != null) {
      var quizModel = QuizModel.fromRawJson(quizes);
      state = quizModel;
    }
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(quizModel: state);
    return true;
  }
}
