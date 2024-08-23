import '../../../models/quiz_model.dart';
import '../../../prov/quiz_provider.dart';
import '../../widgets/buttons/cp_button_2.dart';
import '../../../utils/consts.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';

class QuizSetup extends ConsumerWidget {
  const QuizSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var quizes = ref.watch(quizProvider);
    var selectedQuiz = ref.watch(selectedQuizProvider);
    final inst = L10n.inst(context);
    return CpButtonWithIcon2(
        iconWidget: (selectedQuiz != null)
            ? const Icon(
                Icons.check,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
        onPressed: () async {
          await showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext context, first, last) {
                return PickAQuizDialog(quizModel: quizes);
              });
        },
        child: Text(inst.game_ui_choose_quiz));
  }
}

class PickAQuizDialog extends ConsumerStatefulWidget {
  const PickAQuizDialog({Key? key, required this.quizModel}) : super(key: key);
  final QuizModel quizModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickAQuizDialog();
}

class _PickAQuizDialog extends ConsumerState<PickAQuizDialog> {
  QuizModel get quizModel => widget.quizModel;
  Color chosen = CpColors.button1Color;
  Color unchosen = CpColors.button2Color;

  reusableAnswerGen(String option, String value, Question question) {
    return ListTile(
      leading: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: option == question.correctAnswer ? chosen : unchosen),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(option)),
      title: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    ref.watch(selectedQuizProvider);
    return Material(
      child: Consumer(
        builder: (context, ref, child) => Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: ListView(
                  padding: const EdgeInsets.only(top: defPaddingSize * 4.5),
                  children: (quizModel.quizes.isNotEmpty)
                      ? [
                          ...quizModel.quizes.map((quiz) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defPaddingSize),
                                child: ExpansionTile(
                                  leading: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(selectedQuizProvider.notifier)
                                            .assignQuiz(quiz);
                                        ref
                                            .read(quizProvider.notifier)
                                            .assign();
                                      },
                                      icon: Icon(
                                          ref.read(selectedQuizProvider) != null
                                              ? ref.read(selectedQuizProvider) ==
                                                      quiz
                                                  ? Icons.check_box
                                                  : Icons
                                                      .check_box_outline_blank
                                              : Icons.check_box_outline_blank,
                                          color: ref.read(
                                                      selectedQuizProvider) !=
                                                  null
                                              ? ref.read(selectedQuizProvider) ==
                                                      quiz
                                                  ? chosen
                                                  : unchosen
                                              : unchosen)),
                                  title: Text(quiz.quizname),
                                  children: quiz.questions.map((question) {
                                    return ListTile(
                                        leading: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: chosen),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child:
                                                Text(question.correctAnswer)),
                                        title: Text(question.question));
                                  }).toList(),
                                ));
                          }).toList(),
                        ].joinWidgetList(
                          (index) => const SizedBox(
                            height: defPaddingSize * 2,
                          ),
                        )
                      : [
                          Center(
                            child: Text(inst.quiz_warning),
                          )
                        ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CpButton2(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(inst.ok))
              ],
            )
          ],
        ),
      ),
    );
  }
}
