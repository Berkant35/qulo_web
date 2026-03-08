import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/q_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/q_icon.dart';
import '../../../core/l10n/l10n.dart';
import '../../../data/models/diamond_model.dart';
import '../../../data/models/subscription_model.dart';
import '../../../providers/diamond_provider.dart';
import '../../../providers/subscription_provider.dart';
import '../../../routing/route_names.dart';
import '../widgets/diamond_balance_card.dart';
import '../widgets/subscription_banner.dart';
import '../widgets/purchase_grid.dart';

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
        success: (response) => setState(() {
          _history = response.items;
          _loadingHistory = false;
        }),
        failure: (_) => setState(() => _loadingHistory = false),
      );
    }
  }

  void _onViewPlans() {
    context.pushNamed(RouteNames.subscription);
  }

  void _onPurchase(PurchasePackage package) {
    // TODO: Trigger RevenueCat purchase flow
  }

  void _onSeeAllHistory() {
    // TODO: Navigate to full transaction history screen
  }

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(diamondProvider);
    final subAsync = ref.watch(subscriptionProvider);
    final theme = Theme.of(context);

    return AppScaffold(
      title: context.tr('diamonds'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Balance Card
            balance.when(
              data: (bal) => DiamondBalanceCard(
                greenCount: bal.green,
                purpleCount: bal.purple,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Center(
                child: Text(
                  context.tr('failed_load_balance'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // 2. Subscription Banner
            subAsync.when(
              data: (sub) => SubscriptionBanner(
                subscription: sub,
                onViewPlans: _onViewPlans,
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => SubscriptionBanner(
                subscription: SubscriptionInfo.free(),
                onViewPlans: _onViewPlans,
              ),
            ),

            const SizedBox(height: AppSpacing.sectionGap),

            // 3. Purchase Section Header
            Text(
              context.tr('purchase_purple'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 4. Purchase Grid
            PurchaseGrid(onPurchase: _onPurchase),

            const SizedBox(height: AppSpacing.sectionGap),

            // 5. Transaction History Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('history'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_history.length > 5)
                  GestureDetector(
                    onTap: _onSeeAllHistory,
                    child: Text(
                      context.tr('see_all'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // 6. Transaction History List (last 5)
            if (_loadingHistory)
              const Center(child: CircularProgressIndicator())
            else if (_history.isEmpty)
              Text(
                context.tr('no_transactions'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              )
            else
              ..._history.take(5).map(
                    (tx) => _TransactionTile(transaction: tx),
                  ),

            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final DiamondTransaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = transaction.amount > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: ListTile(
          dense: true,
          leading: QIcon(
            isPositive ? QIcons.icPlusCircle : QIcons.icMinusCircle,
            color: isPositive ? AppColors.success : AppColors.error,
          ),
          title: Text(transaction.reason),
          subtitle: Text(
            transaction.type,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Text(
            '${isPositive ? '+' : ''}${transaction.amount}',
            style: theme.textTheme.titleSmall?.copyWith(
              color: isPositive ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
