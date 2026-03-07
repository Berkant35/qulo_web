import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/l10n/l10n.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('discover'), style: theme.textTheme.headlineSmall?.copyWith(
          color: AppColors.purple, fontWeight: FontWeight.bold,
        )),
        centerTitle: true,
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (discover) {
          if (discover.cards.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.explore_off, size: 64, color: AppColors.onSurfaceVariant),
                  const SizedBox(height: AppSpacing.lg),
                  Text(context.tr('no_more_profiles'), style: theme.textTheme.titleMedium),
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
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ActionButton(
                      icon: Icons.close,
                      color: AppColors.error,
                      onTap: () async {
                        await ref.read(discoverProvider.notifier).swipe(
                          targetId: card.userId,
                          action: 'REJECT',
                        );
                      },
                    ),
                    _ActionButton(
                      icon: Icons.favorite,
                      color: AppColors.green,
                      size: 72,
                      onTap: () {
                        context.goNamed(RouteNames.quiz, pathParameters: {'targetId': card.userId});
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
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
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
          color: Colors.white,
          border: Border.all(color: color, width: 2),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 8)],
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
}
