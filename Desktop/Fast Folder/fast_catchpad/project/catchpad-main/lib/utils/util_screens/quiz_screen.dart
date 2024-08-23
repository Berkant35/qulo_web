import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';

import '../../models/quiz_model.dart';
import '../../prov/quiz_provider.dart';
import '../../ui/widgets/buttons/cp_button_1.dart';
import '../../ui/widgets/buttons/cp_button_2.dart';
import '../../ui/widgets/default_bg.dart';
import '../consts.dart';
import '../cp_colors.dart';
import '../l10n/l10n.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var quizes = ref.watch(quizProvider);
    final inst = L10n.inst(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(inst.profile_screen_saved_quizes),
      ),
      body: DefaultBg(
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        List<Quize> quizList = quizes.quizes;
                        final quiz = quizList.removeAt(oldIndex);

                        quizList.insert(newIndex, quiz);
                        List<Quize> newQuizList = [];
                        newQuizList.addAll(quizList);
                        ref
                            .read(quizProvider.notifier)
                            .update(QuizModel(quizes: newQuizList), ref);
                      },
                      children: quizes.quizes
                          .map((quiz) => Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                        onPressed: (context) {
                                          ref
                                              .read(quizProvider.notifier)
                                              .removeQuiz(
                                                  quizName: quiz.quizname, ref);
                                        },
                                        backgroundColor: gameErrorColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: inst.remove),
                                  ],
                                ),

                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: InkWell(
                                  onTap: () {
                                    if (Platform.isIOS) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  QuestionsScreen(
                                                      title: quiz.quizname,
                                                      quiz: quiz)));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuestionsScreen(
                                                      title: quiz.quizname,
                                                      quiz: quiz)));
                                    }
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: Card(
                                        //color:Colors.lightBlueAccent.shade100.withOpacity(0.2),
                                        elevation: 9,
                                        clipBehavior: Clip.hardEdge,
                                        color: CpColors.defBgColor,
                                        margin: const EdgeInsets.all(7),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                defPaddingSize)),
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: defPaddingSize * 2),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  FontAwesomeIcons.filePen,
                                                  color: CpColors.cpYellow,
                                                ),
                                                Text('  ' + quiz.quizname),
                                              ],
                                            ))),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                TextButton(
                    onPressed: () async {
                      List<String>? addedQuiz = await showTextInputDialog(
                          context: context,
                          cancelLabel: inst.cancel,
                          okLabel: inst.add_quiz,
                          title: inst.add_quiz,
                          style: AdaptiveStyle.material,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: CpColors.bgGC2),
                              child: child,
                            );
                          },
                          textFields: [const DialogTextField()]);
                      if (addedQuiz != null) {
                        ref
                            .read(quizProvider.notifier)
                            .addNewQuiz(quizName: addedQuiz.first, ref);
                      }
                    },
                    child: Text(inst.add_quiz))
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({required this.title, required this.quiz, Key? key})
      : super(key: key);
  final String title;
  final Quize quiz;

  @override
  Widget build(BuildContext context) {
    Color chosen = CpColors.button1Color;
    Color unchosen = CpColors.button2Color;

    final inst = L10n.inst(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: DefaultBg(
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Consumer(builder: (context, ref, widget) {
              var quizes = ref.watch(quizProvider);
              ref.watch(switchProvider);
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: ReorderableListView(
                        onReorder: (oldIndex, newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex = newIndex - 1;
                          }
                          List<Question> questionList =
                              List.from(quiz.questions);
                          final question = questionList.removeAt(oldIndex);

                          questionList.insert(newIndex, question);
                          List<Question> newQuestionList = [];
                          newQuestionList.addAll(questionList);
                          var tempquizes = QuizModel(quizes: quizes.quizes);
                          tempquizes.quizes
                              .firstWhere((q) => q.quizname == quiz.quizname)
                              .copyWith(questions: newQuestionList);
                          ref
                              .read(quizProvider.notifier)
                              .update(tempquizes, ref);
                          ref.read(switchProvider.notifier).switchState();
                        },
                        children: quiz.questions
                            .map((question) => Slidable(
                                  key: UniqueKey(),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                          onPressed: (context) {
                                            ref
                                                .read(quizProvider.notifier)
                                                .removeQuestion(
                                                    quizName: title,
                                                    questionName:
                                                        question.question,
                                                    ref);
                                            ref
                                                .read(switchProvider.notifier)
                                                .switchState();
                                          },
                                          backgroundColor: gameErrorColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: inst.remove),
                                    ],
                                  ),

                                  // The child of the Slidable is what the user sees when the
                                  // component is not dragged.
                                  child: ExpansionTile(
                                    title: Row(
                                      children: [
                                        const Icon(
                                            FontAwesomeIcons.fileCircleQuestion,
                                            color: CpColors.cpYellow),
                                        Text(question.question),
                                      ].joinWidgetList(
                                          (index) => const SizedBox(width: 10)),
                                    ),
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      reusableAnswerGen(
                                          'A', question.a, question),
                                      reusableAnswerGen(
                                          'B', question.b, question),
                                      reusableAnswerGen(
                                          'C', question.c, question),
                                      reusableAnswerGen(
                                          'D', question.d, question),
                                    ],
                                  ),
                                ))
                            .toList()),
                  ),
                  TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AddQuestionDialog(
                              title: title,
                              quiz: quiz,
                            );
                          },
                        );
                        ref.read(switchProvider.notifier).switchState();
                      },
                      child: Text(inst.add_question))
                ],
              );
            }),
          ),
        )),
      ),
    );
  }
}

class AddQuestionDialog extends ConsumerStatefulWidget {
  const AddQuestionDialog({Key? key, required this.title, required this.quiz})
      : super(key: key);
  final String title;
  final Quize quiz;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddQuestionDialogState();
}

class _AddQuestionDialogState extends ConsumerState<AddQuestionDialog> {
  String get quizname => widget.title;
  Quize get quiz => widget.quiz;
  var tempcontroller = TextEditingController();
  var ansa = TextEditingController();
  var ansb = TextEditingController();
  var ansc = TextEditingController();
  var ansd = TextEditingController();
  String? ans;
  Color chosen = CpColors.button1Color;
  Color unchosen = CpColors.button2Color;
  Map<String, Color> colorBtn = {
    'A': CpColors.button2Color,
    'B': CpColors.button2Color,
    'C': CpColors.button2Color,
    'D': CpColors.button2Color
  };
  resetButtonsExcept(String ans) {
    colorBtn.forEach((key, value) {
      if (key != ans) {
        colorBtn[key] = unchosen;
      } else {
        colorBtn[key] = chosen;
      }
    });
    setState(() {});
  }

  reusableWidget(String option) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              ans = option;
              resetButtonsExcept(option);
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: colorBtn[option]),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.1,
                child: Text(option))),
        Padding(
          padding: const EdgeInsets.only(left: defPaddingSize),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
              controller: (option == 'A')
                  ? ansa
                  : (option == 'B')
                      ? ansb
                      : (option == 'C')
                          ? ansc
                          : ansd,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Material(
      child: Consumer(
        builder: (context, ref, child) {
          return Container(
            color: CpColors.bgGC2,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.85,
            child: ListView(
              children: [
                const SizedBox(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(inst.quizes_screen_question_name),
                    const SizedBox(
                      height: defPaddingSize,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defPaddingSize),
                      child: TextFormField(
                        controller: tempcontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    reusableWidget('A'),
                    reusableWidget('B'),
                    reusableWidget('C'),
                    reusableWidget('D'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CpButtonWithIcon2(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(inst.cancel),
                        iconWidget: const Icon(
                          Icons.cancel,
                          color: gameErrorColor,
                        )),
                    CpButton1(
                        onPressed: () async {
                          if (tempcontroller.text.isNotEmpty &&
                              ans != null &&
                              ansa.text.isNotEmpty &&
                              ansb.text.isNotEmpty &&
                              ansc.text.isNotEmpty &&
                              ansd.text.isNotEmpty) {
                            ref
                                .read(quizProvider.notifier)
                                .addNewQuestionToQuiz(
                                    quiz: quiz,
                                    question: Question(
                                        question: tempcontroller.text,
                                        a: ansa.text,
                                        b: ansb.text,
                                        c: ansc.text,
                                        d: ansd.text,
                                        correctAnswer: ans!),
                                    ref);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(inst.add_question)),
                  ],
                ),
                KeyboardVisibilityBuilder(builder: (context, isOpen) {
                  return SizedBox(
                    height:
                        (isOpen) ? MediaQuery.of(context).viewInsets.bottom : 0,
                  );
                }),
              ].joinWidgetList((index) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  )),
            ),
          );
        },
      ),
    );
  }
}
