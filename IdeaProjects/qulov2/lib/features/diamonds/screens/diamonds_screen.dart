import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/diamond_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../data/models/diamond_model.dart';

class DiamondsScreen extends ConsumerStatefulWidget {
  const DiamondsScreen({super.key});

  @override
  ConsumerState<DiamondsScreen> createState() => _DiamondsScreenState();
}

class _DiamondsScreenState extends ConsumerState<DiamondsScreen> {
  List<DiamondTransaction> _history = [];
  bool _loadingHistory = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(diamondProvider.notifier).fetchBalance();
      _loadHistory();
    });
  }

  Future<void> _loadHistory() async {
    setState(() => _loadingHistory = true);
    final result = await ref.read(diamondProvider.notifier).fetchHistory();
    if (mounted) {
      result.when(
        success: (response) => setState(() { _history = response.items; _loadingHistory = false; }),
        failure: (_) => setState(() => _loadingHistory = false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(diamondProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('diamonds'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            balance.when(
              data: (bal) => Row(
                children: [
                  Expanded(
                    child: _BalanceCard(
                      label: context.tr('green_diamonds'),
                      count: bal.green,
                      color: AppColors.secondary,
                      borderColor: AppColors.secondary.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _BalanceCard(
                      label: context.tr('purple_diamonds'),
                      count: bal.purple,
                      color: AppColors.primary,
                      borderColor: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Text(context.tr('failed_load_balance')),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(context.tr('purchase_purple'), style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: const [
                _PurchaseChip(amount: 50, price: '\$0.99'),
                _PurchaseChip(amount: 150, price: '\$2.99'),
                _PurchaseChip(amount: 500, price: '\$7.99'),
                _PurchaseChip(amount: 1200, price: '\$14.99'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(context.tr('history'), style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            if (_loadingHistory)
              const Center(child: CircularProgressIndicator())
            else if (_history.isEmpty)
              Text(context.tr('no_transactions'), style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor))
            else
              ...(_history.map((tx) => ListTile(
                    dense: true,
                    leading: Icon(
                      tx.amount > 0 ? Icons.add_circle : Icons.remove_circle,
                      color: tx.amount > 0 ? AppColors.success : AppColors.error,
                    ),
                    title: Text(tx.reason),
                    subtitle: Text(tx.type),
                    trailing: Text(
                      '${tx.amount > 0 ? '+' : ''}${tx.amount}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: tx.amount > 0 ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ))),
          ],
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final Color borderColor;
  const _BalanceCard({required this.label, required this.count, required this.color, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Icon(Icons.diamond, color: color, size: 32),
          const SizedBox(height: AppSpacing.sm),
          Text('$count', style: theme.textTheme.headlineMedium?.copyWith(color: color, fontWeight: FontWeight.bold)),
          Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _PurchaseChip extends StatelessWidget {
  final int amount;
  final String price;
  const _PurchaseChip({required this.amount, required this.price});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.diamond, color: AppColors.primary, size: 18),
              const SizedBox(width: AppSpacing.xs),
              Text('$amount', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: AppSpacing.sm),
              Text(price, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
