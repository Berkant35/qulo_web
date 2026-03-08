import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/user_provider.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('profile'),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurfaceVariant),
          onPressed: () => context.goNamed(RouteNames.settings),
        ),
      ],
      padding: EdgeInsets.zero,
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
                // Photo Card
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: photos.isNotEmpty
                        ? CachedNetworkImage(imageUrl: photos.first, fit: BoxFit.cover)
                        : Container(
                            color: theme.colorScheme.surface,
                            child: Icon(Icons.person, size: 80, color: theme.hintColor),
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // User Info
                Text(
                  '${user.name ?? ''} ${user.surname ?? ''}, ${user.age ?? ''}',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (user.city != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(user.city!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
                const SizedBox(height: AppSpacing.lg),

                // Stat Cards — 2x2 Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.2,
                  children: [
                    _StatCard(icon: Icons.favorite, value: '${user.likeReceivedCount}', label: context.tr('likes'), color: AppColors.primary),
                    _StatCard(icon: Icons.visibility, value: '${user.timesShownCount}', label: context.tr('views'), color: AppColors.secondary),
                    _StatCard(icon: Icons.diamond, value: '${user.purpleDiamonds}', label: context.tr('purple_diamonds'), color: AppColors.primary),
                    _StatCard(icon: Icons.diamond, value: '${user.greenDiamonds}', label: context.tr('green_diamonds'), color: AppColors.secondary),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Profile Completion
                LinearProgressIndicator(
                  value: user.profileCompletion / 100,
                  backgroundColor: theme.colorScheme.outline,
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text('${user.profileCompletion}% ${context.tr('complete')}', style: theme.textTheme.labelSmall),
                const SizedBox(height: AppSpacing.xl),

                // Menu Items
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
                Text(label, style: TextStyle(color: theme.hintColor, fontSize: 11), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
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
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: theme.hintColor),
        onTap: onTap,
      ),
    );
  }
}
