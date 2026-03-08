import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/providers/question_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  const QuestionsScreen({super.key});

  @override
  ConsumerState<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(questionProvider.notifier).fetchQuestions());
  }

  void _showAddDialog() {
    final textCtrl = TextEditingController();
    final a1 = TextEditingController();
    final a2 = TextEditingController();
    final a3 = TextEditingController();
    final a4 = TextEditingController();
    int correctAnswer = 1;

    final nav = ref.read(navigationServiceProvider);
    nav.showAppDialog(
      CustomDialog(
        name: 'add_question',
        builder: (_) => StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            title: Text(context.tr('add_question')),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: textCtrl, decoration: InputDecoration(labelText: context.tr('question'))),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(controller: a1, decoration: InputDecoration(labelText: '${context.tr('correct_answer')} 1')),
                  TextField(controller: a2, decoration: InputDecoration(labelText: '${context.tr('correct_answer')} 2')),
                  TextField(controller: a3, decoration: InputDecoration(labelText: '${context.tr('correct_answer')} 3')),
                  TextField(controller: a4, decoration: InputDecoration(labelText: '${context.tr('correct_answer')} 4')),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<int>(
                    initialValue: correctAnswer,
                    items: List.generate(4, (i) => DropdownMenuItem(value: i + 1, child: Text('Answer ${i + 1}'))),
                    onChanged: (v) => setDialogState(() => correctAnswer = v ?? 1),
                    decoration: InputDecoration(labelText: context.tr('correct_answer')),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => nav.closeOverlay(),
                child: Text(context.tr('cancel')),
              ),
              TextButton(
                onPressed: () async {
                  final questions = ref.read(questionProvider).valueOrNull ?? [];
                  final wasBelow = questions.length < AppConstants.minQuestions;
                  final result = await ref.read(questionProvider.notifier).createQuestion({
                    'order_num': questions.length + 1,
                    'question_text': textCtrl.text,
                    'correct_answer': correctAnswer,
                    'answer_1': a1.text,
                    'answer_2': a2.text,
                    'answer_3': a3.text,
                    'answer_4': a4.text,
                  });
                  nav.closeOverlay();

                  // Show celebration if user just reached minimum questions
                  if (wasBelow && questions.length + 1 >= AppConstants.minQuestions) {
                    result.when(
                      success: (_) => _showCelebrationDialog(),
                      failure: (_) {},
                    );
                  }
                },
                child: Text(context.tr('save')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCelebrationDialog() {
    final nav = ref.read(navigationServiceProvider);
    nav.showAppDialog(
      CustomDialog(
        name: 'question_celebration',
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.md),
              Icon(Icons.celebration, size: 64, color: AppColors.primary),
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.tr('question_nudge_celebration_title'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    nav.closeOverlay();
                    ref.read(navigationServiceProvider).go(RouteNames.discover);
                  },
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                  child: Text(context.tr('question_nudge_celebration_button')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(questionProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('my_questions'),
      padding: EdgeInsets.zero,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryDark,
        onPressed: () {
          final questions = questionsAsync.valueOrNull ?? [];
          if (questions.length >= AppConstants.maxQuestions) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.tr('max_questions'))),
            );
            return;
          }
          _showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
      isLoading: questionsAsync is AsyncLoading,
      body: questionsAsync.when(
        loading: () => const SizedBox.shrink(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (questions) {
          if (questions.isEmpty) {
            return Center(
              child: Text(context.tr('min_questions'), style: theme.textTheme.bodyLarge),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            itemCount: questions.length,
            itemBuilder: (_, i) {
              final q = questions[i];
              return Card(
                color: theme.colorScheme.surface,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primarySurface,
                    child: Text('${q.orderNum}', style: TextStyle(color: AppColors.primary)),
                  ),
                  title: Text(q.questionText, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: () => ref.read(questionProvider.notifier).deleteQuestion(q.orderNum),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
