import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';

class RegisterStepLocation extends StatelessWidget {
  final bool locationGranted;
  final bool isRequesting;
  final String? errorText;
  final VoidCallback onRequestLocation;
  final VoidCallback onContinue;
  final VoidCallback onSkip;

  const RegisterStepLocation({
    super.key,
    required this.locationGranted,
    required this.isRequesting,
    this.errorText,
    required this.onRequestLocation,
    required this.onContinue,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.get('step_location'),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.get('step_location_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Center(
            child: Icon(
              locationGranted ? Icons.check_circle : Icons.location_on_outlined,
              size: 96,
              color: locationGranted ? AppColors.success : AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (locationGranted)
            Center(
              child: Text(
                l10n.get('location_granted'),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
          if (errorText != null && !locationGranted) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
              ),
            ),
            if (errorText == l10n.get('location_permission_denied_forever') ||
                errorText == l10n.get('location_service_disabled'))
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: TextButton(
                  onPressed: () => Geolocator.openAppSettings(),
                  child: Text(l10n.get('open_settings')),
                ),
              ),
          ],
          const Spacer(),
          if (!locationGranted)
            AppButton(
              label: l10n.get('enable_location'),
              onPressed: isRequesting ? null : onRequestLocation,
              isLoading: isRequesting,
            ),
          if (locationGranted)
            AppButton(
              label: l10n.get('continue_btn'),
              onPressed: onContinue,
            ),
          const SizedBox(height: AppSpacing.sm),
          if (!locationGranted)
            Center(
              child: TextButton(
                onPressed: onSkip,
                child: Text(
                  l10n.get('location_skip'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
