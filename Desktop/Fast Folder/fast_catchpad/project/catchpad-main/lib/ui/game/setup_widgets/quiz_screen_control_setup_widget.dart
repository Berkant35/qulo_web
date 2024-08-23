// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:catchpad/managers/static_game_manager.dart';
import 'package:catchpad/models/quiz_model.dart';
import 'package:catchpad/prov/quiz_provider.dart';
import 'package:catchpad/utils/consts.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreenWidget extends ConsumerStatefulWidget {
  const QuizScreenWidget(
      {Key? key,
      required this.max,
      required this.questions,
      required this.quiz,
      required this.audioPlayer,
      required this.devs,
      required this.game})
      : super(key: key);
  final int max;
  final Quize quiz;
  final List<Question> questions;
  final List<DiscoveredDevice> devs;
  final audioPlayer;
  final game;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizScreenWidgetState();
}

class _QuizScreenWidgetState extends ConsumerState<QuizScreenWidget> {
  Color chosen = CpColors.button1Color;
  Color unchosen = CpColors.button2Color;
  int i = 0;
  int get max => widget.max;
  Quize get quiz => widget.quiz;
  List<DiscoveredDevice> get devs => widget.devs;
  List<Question> get questions => widget.questions;
  get audioPlayer => widget.audioPlayer;

  reusableAnswerGen(
    String option,
    String value,
    Question question,
  ) {
    return Expanded(
      child: ListTile(
        leading: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: /* option == question.correctAnswer ? chosen :  */ unchosen),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Text(option)),
        onTap: () async {
          if (option == question.correctAnswer) {
            audioPlayer.playSuccess();
            EasyLoading.showToast(option + '!',
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.bottom);
            await Future.delayed(const Duration(seconds: 1));
            if (i < max) {
              for (var dev in devs) {
                StaticGameManager.sendIsCommand(
                  dev.id,
                  ref: ref,
                );
              }
              i++;
              ref.read(currentQuestionProv.notifier).setQuestion(questions[i]);
            } else {
              ref.read(isCurrentQuizdone.notifier).done();
            }
            setState(() {});
          }
        },
        title: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question question = questions[i];
    final inst = L10n.inst(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Quiz: ' + quiz.quizname),
          const SizedBox(height: defPaddingSize),
          Container(
            padding: const EdgeInsets.all(defPaddingSize),
            decoration: BoxDecoration(
                color: const Color(0xFF333846).withOpacity(0.8),
                borderRadius: BorderRadius.circular(defPaddingSize)),
            child: Text(inst.question + ': ' + question.question),
          ),
          const SizedBox(height: defPaddingSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              reusableAnswerGen('A', question.a, question),
              reusableAnswerGen('B', question.b, question)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              reusableAnswerGen('C', question.c, question),
              reusableAnswerGen('D', question.d, question)
            ],
          ),
        ],
      ),
    );
  }
}
