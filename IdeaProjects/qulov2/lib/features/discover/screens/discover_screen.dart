import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/match_provider.dart';
import '../../../routing/route_names.dart';
import '../widgets/profile_card.dart';

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
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (discover) {
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
                            'Soruları Çöz',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
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
