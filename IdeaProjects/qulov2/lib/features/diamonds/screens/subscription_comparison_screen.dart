import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../core/l10n/l10n.dart';
import '../../../providers/subscription_provider.dart';

class SubscriptionComparisonScreen extends ConsumerWidget {
  const SubscriptionComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subAsync = ref.watch(subscriptionProvider);
    final currentPlan = subAsync.valueOrNull;

    return AppScaffold(
      title: context.tr('sub_choose_plan'),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const QIcon(QIcons.icX, size: 20),
        ),
      ],
      padding: EdgeInsets.zero,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: Column(
          children: [
            // Free plan
            _PlanCard(
              planKey: null,
              nameKey: 'sub_plan_free',
              priceKey: 'sub_price_free',
              features: const [
                _FeatureItem(icon: QIcons.icCompass, key: 'sub_free_swipes'),
                _FeatureItem(icon: QIcons.icEye, key: 'sub_free_ads'),
              ],
              isRecommended: false,
              isCurrent: currentPlan?.isFree ?? true,
              onSubscribe: null,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Plus plan
            _PlanCard(
              planKey: 'plus',
              nameKey: 'sub_plan_plus',
              priceKey: 'sub_price_plus',
              features: const [
                _FeatureItem(icon: QIcons.icCompass, key: 'sub_plus_swipes'),
                _FeatureItem(icon: QIcons.icGem, key: 'sub_plus_diamonds'),
                _FeatureItem(icon: QIcons.icSkipForward, key: 'sub_plus_undos'),
                _FeatureItem(icon: QIcons.icZap, key: 'sub_plus_boost'),
                _FeatureItem(icon: QIcons.icEye, key: 'sub_plus_no_ads'),
                _FeatureItem(icon: QIcons.icUser, key: 'sub_plus_badge'),
              ],
              isRecommended: false,
              isCurrent: currentPlan?.isPlus ?? false,
              onSubscribe: () => _handlePurchase(context, ref, 'plus'),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Premium plan
            _PlanCard(
              planKey: 'premium',
              nameKey: 'sub_plan_premium',
              priceKey: 'sub_price_premium',
              features: const [
                _FeatureItem(icon: QIcons.icCompass, key: 'sub_premium_swipes'),
                _FeatureItem(icon: QIcons.icGem, key: 'sub_premium_diamonds'),
                _FeatureItem(
                    icon: QIcons.icSkipForward, key: 'sub_premium_undos'),
                _FeatureItem(icon: QIcons.icZap, key: 'sub_premium_boost'),
                _FeatureItem(icon: QIcons.icEye, key: 'sub_premium_who_viewed'),
                _FeatureItem(icon: QIcons.icEye, key: 'sub_premium_no_ads'),
                _FeatureItem(icon: QIcons.icUser, key: 'sub_premium_badge'),
              ],
              isRecommended: true,
              isCurrent: currentPlan?.isPremium ?? false,
              onSubscribe: () => _handlePurchase(context, ref, 'premium'),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Restore purchases
            AppButton(
              label: context.tr('sub_restore_purchases'),
              variant: AppButtonVariant.text,
              onPressed: () => _handleRestore(context, ref),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePurchase(
    BuildContext context,
    WidgetRef ref,
    String plan,
  ) async {
    // RevenueCat purchase will be triggered here
    // For now this is a placeholder until packages are fetched
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('sub_purchase_coming_soon'))),
    );
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    await ref.read(subscriptionProvider.notifier).restorePurchases();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.tr('sub_restore_done'))),
      );
    }
  }
}

class _FeatureItem {
  final String icon;
  final String key;

  const _FeatureItem({required this.icon, required this.key});
}

class _PlanCard extends StatelessWidget {
  final String? planKey;
  final String nameKey;
  final String priceKey;
  final List<_FeatureItem> features;
  final bool isRecommended;
  final bool isCurrent;
  final VoidCallback? onSubscribe;

  const _PlanCard({
    required this.planKey,
    required this.nameKey,
    required this.priceKey,
    required this.features,
    required this.isRecommended,
    required this.isCurrent,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: isRecommended ? AppColors.primary : AppColors.border,
          width: isRecommended ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recommended badge
          if (isRecommended)
            Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              decoration: const BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusLg - 2),
                  topRight: Radius.circular(AppSpacing.radiusLg - 2),
                ),
              ),
              child: Text(
                context.tr('sub_recommended'),
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan name + price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr(nameKey),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      context.tr(priceKey),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isRecommended
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Features
                ...features.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        QIcon(
                          f.icon,
                          size: 18,
                          color: isRecommended
                              ? AppColors.primary
                              : AppColors.secondary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            context.tr(f.key),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Button or current plan badge
                if (isCurrent)
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Text(
                      context.tr('sub_current_plan'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else if (onSubscribe != null)
                  AppButton(
                    label: context.tr('get_started'),
                    onPressed: onSubscribe,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
