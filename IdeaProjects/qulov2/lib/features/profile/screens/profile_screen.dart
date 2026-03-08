import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/diamond_icon.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../providers/user_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../routing/route_names.dart';
import '../widgets/photo_grid.dart';
import '../widgets/badge_bar.dart';
import '../widgets/detail_chips.dart';

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

  String _genderPrefLabel(BuildContext context, String? pref) {
    switch (pref) {
      case 'MAN':
        return context.tr('men');
      case 'WOMAN':
        return context.tr('women');
      case 'BOTH':
        return context.tr('both');
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('profile'),
      actions: [
        IconButton(
          icon: QIcon(QIcons.icSettings, color: theme.colorScheme.onSurfaceVariant, size: 24),
          onPressed: () => ref.read(navigationServiceProvider).go(RouteNames.settings),
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
                // ─── Photo Grid ───
                PhotoGridFull(
                  photos: photos.map<String?>((e) => e).toList(),
                  onSlotTap: (_) => ref.read(navigationServiceProvider).go(RouteNames.editProfile),
                ),
                const SizedBox(height: AppSpacing.lg),

                // ─── Name, Age ───
                Text(
                  '${user.name ?? ''}, ${user.age ?? ''}',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                if (user.city != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QIcon(QIcons.icMapPin, color: theme.colorScheme.onSurfaceVariant, size: 16),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        user.city!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),

                // ─── Badge Bar ───
                BadgeBar(
                  user: user,
                  onClaimReward: (level) async {
                    final result = await ref.read(userProvider.notifier).claimBadgeReward(level);
                    result.when(
                      success: (data) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.tr('badge_reward_claimed'))),
                        );
                      },
                      failure: (_) {},
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ─── About Me Card ───
                _SectionCard(
                  title: context.tr('about_me'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.editProfile),
                  child: Text(
                    user.bio != null && user.bio!.isNotEmpty
                        ? user.bio!
                        : context.tr('hint_add_bio'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: user.bio != null && user.bio!.isNotEmpty
                          ? null
                          : theme.hintColor,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // ─── Details Card ───
                _SectionCard(
                  title: context.tr('details'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.editDetails),
                  child: DetailChips(
                    user: user,
                    onTap: () => ref.read(navigationServiceProvider).go(RouteNames.editDetails),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // ─── Preferences Card ───
                _SectionCard(
                  title: context.tr('preferences'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.editProfile),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      if (user.genderPref != null)
                        _PrefChip(
                          iconPath: QIcons.icGenderPref,
                          label: _genderPrefLabel(context, user.genderPref),
                        ),
                      if (user.agePrefMin != null && user.agePrefMax != null)
                        _PrefChip(
                          iconPath: QIcons.icAgeRange,
                          label: '${user.agePrefMin} - ${user.agePrefMax}',
                        ),
                      if (user.matchRadiusKm != null)
                        _PrefChip(
                          iconPath: QIcons.icMapPin,
                          label: '${user.matchRadiusKm} km',
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // ─── Menu Items ───
                _MenuItem(
                  iconPath: QIcons.icPencil,
                  title: context.tr('edit_profile'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.editProfile),
                ),
                _MenuItem(
                  iconPath: QIcons.icHelpCircle,
                  title: context.tr('my_questions'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.questions),
                ),
                _MenuItem(
                  iconWidget: const DiamondIcon.purple(size: 24),
                  title: context.tr('diamonds'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.diamonds),
                ),
                _MenuItem(
                  iconPath: QIcons.icPlane,
                  title: context.tr('passport'),
                  onTap: () => ref.read(navigationServiceProvider).go(RouteNames.passport),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Section Card ───

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onTap;

  const _SectionCard({
    required this.title,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                QIcon(QIcons.icChevronRight, color: theme.hintColor, size: 20),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

// ─── Pref Chip ───

class _PrefChip extends StatelessWidget {
  final String iconPath;
  final String label;

  const _PrefChip({
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondarySurface,
        border: Border.all(color: AppColors.secondary.withAlpha(77)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          QIcon(iconPath, size: 14, color: AppColors.secondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Menu Item ───

class _MenuItem extends StatelessWidget {
  final String? iconPath;
  final Widget? iconWidget;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    this.iconPath,
    this.iconWidget,
    required this.title,
    required this.onTap,
  }) : assert(iconPath != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: ListTile(
        leading: iconWidget ?? QIcon(iconPath!, color: AppColors.primary, size: 24),
        title: Text(title),
        trailing: QIcon(QIcons.icChevronRight, color: theme.hintColor, size: 20),
        onTap: onTap,
      ),
    );
  }
}
