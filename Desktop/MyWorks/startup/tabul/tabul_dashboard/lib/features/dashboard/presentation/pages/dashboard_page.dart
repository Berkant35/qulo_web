import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../../shared/components/components.dart';

/// Dashboard ana sayfası
///
/// Basit layout wrapper ile placeholder content
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      title: 'Dashboard',
      child: const DashboardPageContent(),
    );
  }
}

/// Dashboard page içeriği - sadece content kısmı
class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildDashboardContent(context);
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Cards Row
          _buildKPICards(context),

          const SizedBox(height: AppSpacing.xl),

          // Charts Section
          _buildChartsSection(context),

          const SizedBox(height: AppSpacing.xl),

          // Recent Activity
          _buildRecentActivity(context),
        ],
      ),
    );
  }

  Widget _buildKPICards(BuildContext context) {
    final cards = [
      _KPICardData(
        title: 'Total Users',
        value: '12,543',
        change: '+12%',
        isPositive: true,
        icon: FontAwesomeIcons.users,
        color: AppColors.primary,
      ),
      _KPICardData(
        title: 'Revenue',
        value: '\$45,623',
        change: '+8%',
        isPositive: true,
        icon: FontAwesomeIcons.dollarSign,
        color: AppColors.success,
      ),
      _KPICardData(
        title: 'Orders',
        value: '1,234',
        change: '-3%',
        isPositive: false,
        icon: FontAwesomeIcons.cartShopping,
        color: AppColors.warning,
      ),
      _KPICardData(
        title: 'Conversion',
        value: '3.2%',
        change: '+0.5%',
        isPositive: true,
        icon: FontAwesomeIcons.chartLine,
        color: AppColors.info,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final isTablet = constraints.maxWidth > 600;

        int crossAxisCount;
        if (isDesktop) {
          crossAxisCount = 4;
        } else if (isTablet) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 2.5,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) => _buildKPICard(context, cards[index]),
        );
      },
    );
  }

  Widget _buildKPICard(BuildContext context, _KPICardData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.getTextSecondaryColor(
                        Theme.of(context).brightness == Brightness.dark),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: data.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    data.icon,
                    size: 16,
                    color: data.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.value,
                  style: AppTypography.h4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextPrimaryColor(
                        Theme.of(context).brightness == Brightness.dark),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (data.isPositive ? AppColors.success : AppColors.error)
                            .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.change,
                    style: AppTypography.captionSmall.copyWith(
                      color:
                          data.isPositive ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics Overview',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimaryColor(
                Theme.of(context).brightness == Brightness.dark),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.chartLine,
                    size: 48,
                    color: AppColors.getTextSecondaryColor(
                        Theme.of(context).brightness == Brightness.dark),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Charts will be implemented here',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.getTextSecondaryColor(
                          Theme.of(context).brightness == Brightness.dark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final activities = [
      'New user registered: john.doe@email.com',
      'Order #1234 completed successfully',
      'Payment received: \$299.99',
      'New product added: "Premium Widget"',
      'User feedback received: 5 stars',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.getTextPrimaryColor(
                Theme.of(context).brightness == Brightness.dark),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: activities
                  .map((activity) => _buildActivityItem(context, activity))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, String activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              activity,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.getTextPrimaryColor(
                    Theme.of(context).brightness == Brightness.dark),
              ),
            ),
          ),
          Text(
            '2 min ago',
            style: AppTypography.captionSmall.copyWith(
              color: AppColors.getTextSecondaryColor(
                  Theme.of(context).brightness == Brightness.dark),
            ),
          ),
        ],
      ),
    );
  }
}

/// KPI Card data model
class _KPICardData {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const _KPICardData({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });
}
