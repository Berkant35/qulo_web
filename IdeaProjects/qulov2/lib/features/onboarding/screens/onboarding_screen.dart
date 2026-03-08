import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../routing/route_names.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  List<_PageData> _getPages(BuildContext context) => [
    _PageData(
      icon: Icons.favorite,
      title: context.tr('onboarding_title_1'),
      subtitle: context.tr('onboarding_sub_1'),
    ),
    _PageData(
      icon: Icons.quiz,
      title: context.tr('onboarding_title_2'),
      subtitle: context.tr('onboarding_sub_2'),
    ),
    _PageData(
      icon: Icons.person,
      title: context.tr('onboarding_title_3'),
      subtitle: context.tr('onboarding_sub_3'),
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pages = _getPages(context);
    final isLast = _page == pages.length - 1;

    return AppScaffold(
      padding: EdgeInsets.zero,
      body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: pages.length,
                itemBuilder: (_, i) => _buildPage(theme, pages[i]),
              ),
            ),
            _buildIndicators(pages.length),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pagePadding),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLast) {
                      context.goNamed(RouteNames.discover);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(isLast ? context.tr('get_started') : context.tr('next')),
                ),
              ),
            ),
            if (!isLast)
              TextButton(
                onPressed: () => context.goNamed(RouteNames.discover),
                child: Text(context.tr('skip')),
              ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
    );
  }

  Widget _buildPage(ThemeData theme, _PageData p) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(p.icon, size: 80, color: AppColors.primary),
          const SizedBox(height: AppSpacing.xl),
          Text(p.title,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          Text(p.subtitle,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildIndicators(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          width: i == _page ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: i == _page ? AppColors.primary : AppColors.textHint,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        ),
      ),
    );
  }
}

class _PageData {
  final IconData icon;
  final String title;
  final String subtitle;
  const _PageData(
      {required this.icon, required this.title, required this.subtitle});
}
