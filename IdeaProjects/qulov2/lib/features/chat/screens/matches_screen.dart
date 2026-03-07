import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../providers/match_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../routing/route_names.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(matchListProvider.notifier).fetchMatches());
  }

  @override
  Widget build(BuildContext context) {
    final matchesAsync = ref.watch(matchListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('matches'))),
      body: matchesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (matches) {
          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: AppColors.onSurfaceVariant),
                  const SizedBox(height: AppSpacing.lg),
                  Text(context.tr('no_matches'), style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Text(context.tr('start_swiping'), style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            itemCount: matches.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final m = matches[i];
              final u = m.user;
              final photo = u?.photos?.isNotEmpty == true ? u!.photos!.first : null;
              return ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: photo != null ? CachedNetworkImageProvider(photo) : null,
                  child: photo == null ? const Icon(Icons.person) : null,
                ),
                title: Text(u?.name ?? 'Unknown'),
                subtitle: Text(u?.city ?? '', style: theme.textTheme.bodySmall),
                trailing: u?.isOnline == true
                    ? Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success))
                    : null,
                onTap: () => context.goNamed(RouteNames.chat, pathParameters: {'matchId': m.matchId}),
              );
            },
          );
        },
      ),
    );
  }
}
