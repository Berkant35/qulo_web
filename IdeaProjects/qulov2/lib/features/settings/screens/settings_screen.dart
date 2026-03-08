import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/providers/auth_provider.dart';
import 'package:qulo_v2/providers/locale_provider.dart';
import 'package:qulo_v2/providers/theme_provider.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/providers/user_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('settings'),
      padding: EdgeInsets.zero,
      body: ListView(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: ListTile(
              leading: Icon(Icons.language, color: theme.colorScheme.onSurfaceVariant),
              title: Text(
                context.tr('language'),
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              trailing: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'tr', label: Text('TR')),
                  ButtonSegment(value: 'en', label: Text('EN')),
                ],
                selected: {locale.languageCode},
                onSelectionChanged: (s) {
                  ref.read(localeProvider.notifier).setLocale(Locale(s.first));
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.brightness_6, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.lg),
                    Text(context.tr('theme'), style: theme.textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<AppThemeMode>(
                    segments: [
                      ButtonSegment(value: AppThemeMode.system, label: Text(context.tr('theme_system'))),
                      ButtonSegment(value: AppThemeMode.light, label: Text(context.tr('theme_light'))),
                      ButtonSegment(value: AppThemeMode.dark, label: Text(context.tr('theme_dark'))),
                    ],
                    selected: {ref.watch(themeProvider)},
                    onSelectionChanged: (s) {
                      ref.read(themeProvider.notifier).setThemeMode(s.first);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: theme.colorScheme.onSurfaceVariant),
              title: Text(
                context.tr('logout'),
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onTap: () async {
                final nav = ref.read(navigationServiceProvider);
                final confirm = await nav.showAppDialog<bool>(
                  ConfirmDialog(
                    name: 'logout',
                    title: context.tr('logout'),
                    message: context.tr('logout_confirm'),
                    confirmText: context.tr('logout'),
                  ),
                );
                if (confirm == true) {
                  await ref.read(authProvider.notifier).logout();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: AppColors.error),
              title: Text(
                context.tr('delete_account'),
                style: const TextStyle(color: AppColors.error),
              ),
              onTap: () async {
                final nav = ref.read(navigationServiceProvider);
                final confirm = await nav.showAppDialog<bool>(
                  ConfirmDialog(
                    name: 'delete_account',
                    title: context.tr('delete_account'),
                    message: context.tr('delete_account_desc'),
                    confirmText: context.tr('delete'),
                    isDestructive: true,
                  ),
                );
                if (confirm == true) {
                  await ref.read(userProvider.notifier).deleteAccount();
                  await ref.read(authProvider.notifier).logout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
