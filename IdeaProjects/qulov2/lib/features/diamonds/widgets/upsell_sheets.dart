import 'package:flutter/material.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/diamond_icon.dart';
import 'purchase_grid.dart';

// ─── Premium Upsell Sheet ───
// Used for: onboarding upsell, first match upsell
class PremiumUpsellSheet extends StatelessWidget {
  final bool isFirstMatch;
  final VoidCallback? onPlusTap;
  final VoidCallback? onPremiumTap;
  final VoidCallback? onDismiss;

  const PremiumUpsellSheet({
    super.key,
    this.isFirstMatch = false,
    this.onPlusTap,
    this.onPremiumTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.lg,
        AppSpacing.pagePadding,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textHint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Icon
          const DiamondIcon.purple(size: 48),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            isFirstMatch
                ? context.tr('first_match_congrats')
                : context.tr('premium_cta'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Subtitle
          Text(
            isFirstMatch
                ? context.tr('want_more_matches')
                : context.tr('unlock_unlimited'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Feature highlights
          _FeatureRow(
            icon: Icons.all_inclusive,
            text: context.tr('sub_premium_swipes'),
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.diamond_outlined,
            text: context.tr('sub_premium_diamonds'),
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.undo,
            text: context.tr('sub_premium_undos'),
          ),
          const SizedBox(height: AppSpacing.md),
          _FeatureRow(
            icon: Icons.bolt,
            text: context.tr('sub_premium_boost'),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Plus button
          AppButton(
            label: '${context.tr('sub_plan_plus')} — ${context.tr('sub_price_plus')}',
            variant: AppButtonVariant.secondary,
            onPressed: onPlusTap,
          ),
          const SizedBox(height: AppSpacing.md),

          // Premium button
          AppButton(
            label: '${context.tr('sub_plan_premium')} — ${context.tr('sub_price_premium')}',
            onPressed: onPremiumTap,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Maybe later
          GestureDetector(
            onTap: onDismiss ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                context.tr('maybe_later'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: AppSpacing.xxl,
          height: AppSpacing.xxl,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

// ─── Consumable Upsell Sheet ───
// Used for: diamond empty, boost need
class ConsumableUpsellSheet extends StatelessWidget {
  final bool isBoostNeed;
  final ValueChanged<PurchasePackage>? onPurchase;
  final VoidCallback? onDismiss;

  const ConsumableUpsellSheet({
    super.key,
    this.isBoostNeed = false,
    this.onPurchase,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.lg,
        AppSpacing.pagePadding,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textHint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Icon
          const DiamondIcon.purple(size: 48),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            context.tr('diamonds_empty'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Subtitle
          Text(
            context.tr('get_diamonds'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Purchase grid
          PurchaseGrid(onPurchase: onPurchase),
          const SizedBox(height: AppSpacing.xl),

          // Maybe later
          GestureDetector(
            onTap: onDismiss ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                context.tr('maybe_later'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Swipe Limit Sheet ───
// Used for: daily swipe limit reached
class SwipeLimitSheet extends StatelessWidget {
  final VoidCallback? onUpgrade;
  final VoidCallback? onDismiss;

  const SwipeLimitSheet({
    super.key,
    this.onUpgrade,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.lg,
        AppSpacing.pagePadding,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textHint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.swipe,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            context.tr('swipe_limit_reached'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Subtitle
          Text(
            context.tr('unlock_unlimited'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Upgrade button
          AppButton(
            label: context.tr('upgrade_now'),
            onPressed: onUpgrade,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Maybe later
          GestureDetector(
            onTap: onDismiss ?? () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Text(
                context.tr('maybe_later'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
