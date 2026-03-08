import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/diamond_icon.dart';
import '../../../core/l10n/l10n.dart';

class DiamondBalanceCard extends StatelessWidget {
  final int greenCount;
  final int purpleCount;

  const DiamondBalanceCard({
    super.key,
    required this.greenCount,
    required this.purpleCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Row(
        children: [
          Expanded(
            child: _BalanceSection(
              icon: const DiamondIcon.purple(size: 36),
              count: purpleCount,
              label: context.tr('purple_diamonds'),
              color: AppColors.primary,
            ),
          ),
          Container(
            width: 1,
            height: 56,
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          Expanded(
            child: _BalanceSection(
              icon: const DiamondIcon.green(size: 36),
              count: greenCount,
              label: context.tr('green_diamonds'),
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  final Widget icon;
  final int count;
  final String label;
  final Color color;

  const _BalanceSection({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        icon,
        const SizedBox(height: AppSpacing.sm),
        Text(
          '$count',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
