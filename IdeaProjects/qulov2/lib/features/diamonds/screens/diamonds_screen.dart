import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
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
    final response = await ref.read(diamondProvider.notifier).fetchHistory();
    if (mounted) setState(() { _history = response.items; _loadingHistory = false; });
  }

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(diamondProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('diamonds'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            balance.when(
              data: (bal) => Row(
                children: [
                  Expanded(child: _BalanceCard(label: context.tr('green_diamonds'), count: bal.green, color: AppColors.green)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: _BalanceCard(label: context.tr('purple_diamonds'), count: bal.purple, color: AppColors.purple)),
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
              Text(context.tr('no_transactions'), style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant))
            else
              ...(_history.map((tx) => ListTile(
                    dense: true,
                    leading: Icon(
                      tx.amount > 0 ? Icons.add_circle : Icons.remove_circle,
                      color: tx.amount > 0 ? AppColors.green : AppColors.error,
                    ),
                    title: Text(tx.reason),
                    subtitle: Text(tx.type),
                    trailing: Text(
                      '${tx.amount > 0 ? '+' : ''}${tx.amount}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: tx.amount > 0 ? AppColors.green : AppColors.error,
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
  const _BalanceCard({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Icon(Icons.diamond, color: color, size: 32),
            const SizedBox(height: AppSpacing.sm),
            Text('$count', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color, fontWeight: FontWeight.bold)),
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
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
    return OutlinedButton(
      onPressed: () {},
      child: Text('$amount  $price'),
    );
  }
}
