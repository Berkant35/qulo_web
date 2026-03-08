import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../providers/user_provider.dart';

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
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
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
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.brightness_6, color: theme.colorScheme.onSurfaceVariant),
              title: Text(context.tr('theme')),
              trailing: SegmentedButton<AppThemeMode>(
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
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: theme.colorScheme.onSurfaceVariant),
              title: Text(
                context.tr('logout'),
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(
                      context.tr('logout'),
                    ),
                    content: Text(
                      context.tr('logout_confirm'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: Text(
                          context.tr('cancel'),
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: Text(
                          context.tr('logout'),
                          style: const TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ref.read(authProvider.notifier).logout();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: AppColors.error),
              title: Text(
                context.tr('delete_account'),
                style: const TextStyle(color: AppColors.error),
              ),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(
                      context.tr('delete_account'),
                    ),
                    content: Text(
                      context.tr('delete_account_desc'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: Text(
                          context.tr('cancel'),
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: Text(
                          context.tr('delete'),
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
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
