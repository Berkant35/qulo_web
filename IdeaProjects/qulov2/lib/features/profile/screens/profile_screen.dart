import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/diamond_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../routing/route_names.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchMe();
      ref.read(diamondProvider.notifier).fetchBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final diamonds = ref.watch(diamondProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('profile')),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goNamed(RouteNames.settings),
          ),
        ],
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          if (user == null) return const Center(child: Text('No user data'));
          final photos = user.photos ?? [];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: photos.isNotEmpty
                        ? CachedNetworkImage(imageUrl: photos.first, fit: BoxFit.cover)
                        : Container(
                            color: AppColors.purpleSurface,
                            child: const Icon(Icons.person, size: 80),
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  '${user.name ?? ''} ${user.surname ?? ''}, ${user.age ?? ''}',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (user.city != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(user.city!, style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                ],
                const SizedBox(height: AppSpacing.lg),
                diamonds.when(
                  data: (bal) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _DiamondChip(icon: Icons.diamond, color: AppColors.green, count: bal.green),
                      const SizedBox(width: AppSpacing.lg),
                      _DiamondChip(icon: Icons.diamond, color: AppColors.purple, count: bal.purple),
                    ],
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: AppSpacing.lg),
                LinearProgressIndicator(
                  value: user.profileCompletion / 100,
                  backgroundColor: AppColors.outline,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('${user.profileCompletion}% ${context.tr('complete')}', style: theme.textTheme.labelSmall),
                const SizedBox(height: AppSpacing.xl),
                _MenuItem(icon: Icons.edit, title: context.tr('edit_profile'), onTap: () => context.goNamed(RouteNames.editProfile)),
                _MenuItem(icon: Icons.quiz, title: context.tr('my_questions'), onTap: () => context.goNamed(RouteNames.questions)),
                _MenuItem(icon: Icons.diamond, title: context.tr('diamonds'), onTap: () => context.goNamed(RouteNames.diamonds)),
                _MenuItem(icon: Icons.flight, title: context.tr('passport'), onTap: () => context.goNamed(RouteNames.passport)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DiamondChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int count;
  const _DiamondChip({required this.icon, required this.color, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text('$count', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.purple),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
