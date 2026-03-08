import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/diamond_icon.dart';
import '../../../core/l10n/l10n.dart';

class PurchasePackage {
  final int amount;
  final String price;

  const PurchasePackage({required this.amount, required this.price});
}

const kDiamondPackages = [
  PurchasePackage(amount: 50, price: '\$0.99'),
  PurchasePackage(amount: 150, price: '\$2.49'),
  PurchasePackage(amount: 400, price: '\$4.99'),
  PurchasePackage(amount: 1000, price: '\$9.99'),
  PurchasePackage(amount: 2500, price: '\$19.99'),
  PurchasePackage(amount: 6000, price: '\$39.99'),
];

/// Index of the "Best Value" package (0-based, tier 3 = index 2)
const _bestValueIndex = 2;

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
        childAspectRatio: 0.85,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: kDiamondPackages.length,
      itemBuilder: (context, index) {
        final pkg = kDiamondPackages[index];
        final isBestValue = index == _bestValueIndex;
        return _PackageCard(
          package: pkg,
          isBestValue: isBestValue,
          onTap: () => onPurchase?.call(pkg),
        );
      },
    );
  }
}

class _PackageCard extends StatelessWidget {
  final PurchasePackage package;
  final bool isBestValue;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
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
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DiamondIcon.purple(size: 28, showGlow: false),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${package.amount}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      package.price,
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
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
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
