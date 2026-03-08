import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/question_provider.dart';

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

    showDialog(
      context: context,
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
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(context.tr('cancel'))),
            TextButton(
              onPressed: () async {
                final questions = ref.read(questionProvider).valueOrNull ?? [];
                await ref.read(questionProvider.notifier).createQuestion({
                  'order_num': questions.length + 1,
                  'question_text': textCtrl.text,
                  'correct_answer': correctAnswer,
                  'answer_1': a1.text,
                  'answer_2': a2.text,
                  'answer_3': a3.text,
                  'answer_4': a4.text,
                });
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(context.tr('save')),
            ),
          ],
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
      body: questionsAsync.when(

        loading: () => const Center(child: CircularProgressIndicator()),
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
