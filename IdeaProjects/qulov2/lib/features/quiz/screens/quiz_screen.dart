import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../providers/quiz_provider.dart';
import '../widgets/answer_button.dart';
import '../widgets/power_bar.dart';
import '../widgets/quiz_timer.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final String targetId;
  const QuizScreen({super.key, required this.targetId});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(quizProvider.notifier).startSession(widget.targetId));
  }

  @override
  void dispose() {
    ref.read(quizProvider.notifier).reset();
    super.dispose();
  }

  Future<void> _answer(int index) async {
    final result = await ref.read(quizProvider.notifier).answer(index);
    if (!mounted) return;
    result.when(
      success: (data) {
        if (data.sessionStatus == 'COMPLETED') {
          _showResult(matched: true);
        } else if (data.sessionStatus == 'FAILED') {
          _showResult(matched: false);
        } else if (data.awaitingAnswer != true) {
          ref.read(quizProvider.notifier).fetchCurrentQuestion();
        }
      },
      failure: (_) {},
    );
  }

  Future<void> _showResult({required bool matched}) async {
    final nav = ref.read(navigationServiceProvider);
    await nav.showAppDialog(
      InfoDialog(
        name: 'quiz_result',
        title: matched ? context.tr('quiz_match') : context.tr('quiz_failed'),
        message: matched ? context.tr('quiz_match_desc') : context.tr('quiz_failed_desc'),
        iconWidget: Icon(
          matched ? Icons.favorite : Icons.close,
          color: matched ? AppColors.secondary : AppColors.error,
          size: 48,
        ),
      ),
    );
    if (mounted) {
      nav.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);
    final theme = Theme.of(context);
    final question = quiz.currentQuestion;

    return AppScaffold(
      title: question != null
          ? '${question.questionNumber}/${question.totalQuestions}'
          : '',
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => ref.read(navigationServiceProvider).pop(),
      ),
      padding: EdgeInsets.zero,
      body: quiz.isLoading || question == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizTimer(
                    seconds: question.timeLimitSeconds,
                    onTimeout: () => _answer(0),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    question.questionText,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  ...question.answers.map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: AnswerButton(
                          text: a.text,
                          onTap: () => _answer(a.index),
                        ),
                      )),
                  const Spacer(),
                  PowerBar(
                    sessionId: quiz.sessionId!,
                    hasHint: question.hasHint,
                  ),
                ],
              ),
            ),
    );
  }
}
