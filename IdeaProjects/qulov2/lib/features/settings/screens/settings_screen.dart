import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/locale_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../providers/user_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('settings'))),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.tr('language')),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.tr('logout')),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(context.tr('logout')),
                  content: Text(context.tr('logout_confirm')),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.tr('cancel'))),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: Text(context.tr('logout'))),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(authProvider.notifier).logout();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: AppColors.error),
            title: Text(context.tr('delete_account'), style: TextStyle(color: AppColors.error)),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(context.tr('delete_account')),
                  content: Text(context.tr('delete_account_desc')),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.tr('cancel'))),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(context.tr('delete'), style: TextStyle(color: AppColors.error)),
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
        ],
      ),
    );
  }
}
