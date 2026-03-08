import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_loading_widget.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/core/widgets/q_icon.dart';
import 'package:qulo_v2/data/models/ai_suggestion_model.dart';
import 'package:qulo_v2/features/questions/widgets/ai_suggestion_card.dart';
import 'package:qulo_v2/providers/ai_suggestion_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';

class QuestionEasyModeScreen extends ConsumerStatefulWidget {
  const QuestionEasyModeScreen({super.key});

  @override
  ConsumerState<QuestionEasyModeScreen> createState() =>
      _QuestionEasyModeScreenState();
}

class _QuestionEasyModeScreenState
    extends ConsumerState<QuestionEasyModeScreen> {
  String? _selectedCategory;

  @override
  void dispose() {
    // Clear suggestions when leaving
    super.dispose();
  }

  void _fetchByCategory(String category) {
    setState(() => _selectedCategory = category);
    final locale = Localizations.localeOf(context).languageCode;
    ref.read(aiSuggestionProvider.notifier).fetchSuggestions(
          category: category,
          locale: locale,
        );
  }

  void _fetchByProfile() {
    setState(() => _selectedCategory = null);
    final locale = Localizations.localeOf(context).languageCode;
    ref.read(aiSuggestionProvider.notifier).fetchSuggestions(
          profileBased: true,
          locale: locale,
        );
  }

  void _selectSuggestion(AiSuggestionModel suggestion) {
    ref.read(navigationServiceProvider).push(
      RouteNames.questionCreate,
      extra: suggestion,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final suggestionsAsync = ref.watch(aiSuggestionProvider);

    return AppScaffold(
      title: context.tr('ai_suggest_title'),
      padding: EdgeInsets.zero,
      body: CustomScrollView(
        slivers: [
          // Category chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('ai_suggest_category'),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: AppConstants.questionCategories.map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return FilterChip(
                        selected: isSelected,
                        label: Text(
                            context.tr('question_category_$cat')),
                        onSelected: (_) => _fetchByCategory(cat),
                        selectedColor: AppColors.primarySurface,
                        checkmarkColor: AppColors.primary,
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Profile-based button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _fetchByProfile,
                      icon: QIcon(QIcons.icWand, size: 18, color: AppColors.primary),
                      label: Text(context.tr('ai_suggest_profile')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider
          const SliverToBoxAdapter(
            child: Divider(height: 1, color: AppColors.border),
          ),

          // Results
          suggestionsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: AppLoadingWidget.large()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tr('error'),
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      e.toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            data: (suggestions) {
              if (suggestions.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QIcon(QIcons.icWand, size: 48, color: AppColors.textHint),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          context.tr('ai_suggest_empty'),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                sliver: SliverList.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (_, i) => AiSuggestionCard(
                    suggestion: suggestions[i],
                    onSelect: () => _selectSuggestion(suggestions[i]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
