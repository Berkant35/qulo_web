import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/providers/passport_provider.dart';

class PassportScreen extends ConsumerStatefulWidget {
  const PassportScreen({super.key});

  @override
  ConsumerState<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends ConsumerState<PassportScreen> with LoadingMixin {
  final _cityCtrl = TextEditingController();

  @override
  void dispose() {
    _cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passport = ref.watch(passportProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('passport'),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.flight, size: 64, color: AppColors.primary),
            const SizedBox(height: AppSpacing.lg),
            Text(
              passport.isActive ? '${context.tr('passport_active')}: ${passport.city}' : context.tr('passport_explore'),
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${context.tr('passport_cost')}: ${AppConstants.passportCostPurple}',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (!passport.isActive) ...[
              TextField(
                controller: _cityCtrl,
                decoration: InputDecoration(
                  labelText: context.tr('city'),
                  prefixIcon: const Icon(Icons.location_city),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => withLoading(() async {
                            final city = _cityCtrl.text.trim();
                            if (city.isEmpty) return;
                            await ref.read(passportProvider.notifier).activate(city: city, lat: 0, lng: 0);
                          }),
                  child: isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(context.tr('activate_passport')),
                ),
              ),
            ] else
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: isLoading
                      ? null
                      : () => withLoading(() => ref.read(passportProvider.notifier).deactivate()),
                  child: Text(context.tr('deactivate')),
                ),
              ),
          ],
        ),
    );
  }
}
