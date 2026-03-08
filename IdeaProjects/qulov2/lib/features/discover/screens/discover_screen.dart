import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/widgets/q_icon.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/providers/match_provider.dart';
import 'package:qulo_v2/providers/user_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';
import 'package:qulo_v2/features/discover/widgets/profile_card.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(discoverProvider.notifier).loadCards());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discoverProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('discover'),
      padding: EdgeInsets.zero,
      isLoading: state is AsyncLoading,
      body: state.when(
        loading: () => const SizedBox.shrink(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (discover) {
          // ─── Question Gate: Blur Lock ───
          final user = ref.watch(userProvider).valueOrNull;
          final hasMinQuestions = (user?.questionCount ?? 0) >= AppConstants.minQuestions;

          if (!hasMinQuestions) {
            final firstCard = discover.cards.isNotEmpty ? discover.cards.first : null;
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.pagePadding),
              child: Stack(
                children: [
                  // Blurred card or placeholder
                  if (firstCard != null)
                    Positioned.fill(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: ProfileCard(card: firstCard),
                      ),
                    )
                  else
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                    ),
                  // Lock overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withAlpha(180),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QIcon(QIcons.icLock, size: 64, color: AppColors.primary),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            context.tr('question_nudge_discover_locked'),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          // Progress bar
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 48),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                                  child: LinearProgressIndicator(
                                    value: ((user?.questionCount ?? 0) / 2).clamp(0.0, 1.0),
                                    minHeight: 10,
                                    backgroundColor: theme.colorScheme.surfaceContainerHigh,
                                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  context.tr('question_nudge_progress')
                                      .replaceAll('{count}', '${user?.questionCount ?? 0}'),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FilledButton.icon(
                            onPressed: () => ref.read(navigationServiceProvider).go(RouteNames.questions),
                            icon: QIcon(QIcons.icPlus, color: theme.colorScheme.onPrimary, size: 18),
                            label: Text(context.tr('question_nudge_add_button')),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (discover.cards.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QIcon(QIcons.icCompassOff, size: 64, color: theme.hintColor),
                  const SizedBox(height: AppSpacing.lg),
                  Text(context.tr('no_more_profiles'), style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => ref.read(discoverProvider.notifier).loadCards(),
                    child: Text(context.tr('refresh')),
                  ),
                ],
              ),
            );
          }
          final card = discover.cards.first;
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Column(
              children: [
                Expanded(child: ProfileCard(card: card)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryButtonGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        ref.read(navigationServiceProvider).go(RouteNames.quiz, params: {'targetId': card.userId});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: Text(
                            context.tr('solve_questions'),
                            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      iconPath: QIcons.icX,
                      iconColor: AppColors.error,
                      backgroundColor: theme.colorScheme.surface,
                      borderColor: AppColors.error,
                      onTap: () async {
                        await ref.read(discoverProvider.notifier).swipe(
                          targetId: card.userId,
                          action: 'REJECT',
                        );
                      },
                    ),
                    _ActionButton(
                      iconPath: QIcons.icHeart,
                      iconColor: AppColors.secondary,
                      backgroundColor: theme.colorScheme.surface,
                      borderColor: AppColors.secondary,
                      size: 72,
                      onTap: () {
                        ref.read(navigationServiceProvider).go(RouteNames.quiz, params: {'targetId': card.userId});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    this.size = 56,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [BoxShadow(color: borderColor.withValues(alpha: 0.2), blurRadius: 8)],
        ),
        child: Center(child: QIcon(iconPath, color: iconColor, size: size * 0.5)),
      ),
    );
  }
}
