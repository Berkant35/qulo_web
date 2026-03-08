import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/diamond_icon.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';

enum DiamondTier {
  starter(amount: 50, price: '\$0.99', iconSize: 22, glowRadius: 0),
  popular(amount: 150, price: '\$2.49', iconSize: 26, glowRadius: 8),
  bestValue(amount: 400, price: '\$4.99', iconSize: 30, glowRadius: 14),
  mega(amount: 1000, price: '\$9.99', iconSize: 34, glowRadius: 20),
  ultra(amount: 2500, price: '\$19.99', iconSize: 38, glowRadius: 26),
  vip(amount: 6000, price: '\$39.99', iconSize: 42, glowRadius: 32);

  final int amount;
  final String price;
  final double iconSize;
  final double glowRadius;

  const DiamondTier({
    required this.amount,
    required this.price,
    required this.iconSize,
    required this.glowRadius,
  });
}

class PurchasePackage {
  final DiamondTier tier;

  const PurchasePackage({required this.tier});

  int get amount => tier.amount;
  String get price => tier.price;
}

class PurchaseGrid extends StatelessWidget {
  final ValueChanged<PurchasePackage>? onPurchase;

  const PurchaseGrid({super.key, this.onPurchase});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.78,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: DiamondTier.values.length,
      itemBuilder: (context, index) {
        final tier = DiamondTier.values[index];
        final isBestValue = tier == DiamondTier.bestValue;
        return _PackageCard(
          tier: tier,
          isBestValue: isBestValue,
          onTap: () => onPurchase?.call(PurchasePackage(tier: tier)),
        );
      },
    );
  }
}

class _PackageCard extends StatelessWidget {
  final DiamondTier tier;
  final bool isBestValue;
  final VoidCallback onTap;

  const _PackageCard({
    required this.tier,
    required this.isBestValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isBestValue
                ? AppColors.primary.withValues(alpha: 0.7)
                : theme.colorScheme.outline.withValues(alpha: 0.3),
            width: isBestValue ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.md,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _GlowingDiamond(tier: tier),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${tier.amount}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      tier.price,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isBestValue)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.purpleGradient,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSpacing.radiusMd - 1),
                      topRight: Radius.circular(AppSpacing.radiusMd - 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    context.tr('best_value'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Single diamond with increasing size and glow based on tier
class _GlowingDiamond extends StatelessWidget {
  final DiamondTier tier;

  const _GlowingDiamond({required this.tier});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Center(
        child: Container(
          decoration: tier.glowRadius > 0
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: 0.15 + (tier.index * 0.07),
                      ),
                      blurRadius: tier.glowRadius,
                      spreadRadius: tier.glowRadius * 0.3,
                    ),
                  ],
                )
              : null,
          child: DiamondIcon.purple(
            size: tier.iconSize,
            showGlow: false,
          ),
        ),
      ),
    );
  }
}
