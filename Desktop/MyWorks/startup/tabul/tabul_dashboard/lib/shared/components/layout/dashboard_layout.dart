import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/theme/theme.dart';
import '../../../core/constants/constants.dart';
import 'app_header.dart';
import 'app_sidebar.dart';

/// Main dashboard layout wrapper
///
/// Features:
/// - Responsive layout for mobile, tablet, and desktop
/// - Collapsible sidebar navigation
/// - Header with search, notifications, user menu
/// - Main content area with proper spacing
/// - Mobile drawer navigation
class DashboardLayout extends StatefulWidget {
  final Widget child;
  final String? title;
  final Widget? floatingActionButton;

  const DashboardLayout({
    super.key,
    required this.child,
    this.title,
    this.floatingActionButton,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool _isSidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppHeader(
        onMenuPressed: () {
          if (responsive.isMobile) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        showMenuButton: responsive.isMobile,
      ),
      drawer: responsive.isMobile ? _buildMobileDrawer() : null,
      body: responsive.isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: widget.child,
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          // Sidebar
          AppSidebar(
            isCollapsed: _isSidebarCollapsed,
            onToggleCollapse: (collapsed) {
              setState(() {
                _isSidebarCollapsed = collapsed;
              });
            },
          ),
          // Main content
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page title
          if (widget.title != null) ...[
            _buildPageHeader(),
            const SizedBox(height: AppSpacing.lg),
          ],
          // Main content
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title!,
                style: AppTypography.h2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _getPageSubtitle(),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        _buildPageActions(),
      ],
    );
  }

  Widget _buildPageActions() {
    // Override this in specific pages if needed
    return const SizedBox.shrink();
  }

  String _getPageSubtitle() {
    final now = DateTime.now();
    final formattedDate = '${_getMonthName(now.month)} ${now.day}, ${now.year}';
    return 'Welcome back! Here\'s what\'s happening today, $formattedDate';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'John Doe',
                    style: AppTypography.h4.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation
            Expanded(
              child: AppSidebar(
                isCollapsed: false,
                onToggleCollapse: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extended dashboard layout with additional features for specific pages
class ExtendedDashboardLayout extends DashboardLayout {
  final List<Widget>? pageActions;
  final Widget? breadcrumb;

  const ExtendedDashboardLayout({
    super.key,
    required super.child,
    super.title,
    super.floatingActionButton,
    this.pageActions,
    this.breadcrumb,
  });

  @override
  State<ExtendedDashboardLayout> createState() =>
      _ExtendedDashboardLayoutState();
}

class _ExtendedDashboardLayoutState extends State<ExtendedDashboardLayout> {
  bool _isSidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppHeader(
        onMenuPressed: () {
          if (responsive.isMobile) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        showMenuButton: responsive.isMobile,
      ),
      drawer: responsive.isMobile ? _buildMobileDrawer() : null,
      body: responsive.isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: widget.child,
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Row(
        children: [
          // Sidebar
          AppSidebar(
            isCollapsed: _isSidebarCollapsed,
            onToggleCollapse: (collapsed) {
              setState(() {
                _isSidebarCollapsed = collapsed;
              });
            },
          ),
          // Main content
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          if (widget.breadcrumb != null) ...[
            widget.breadcrumb!,
            const SizedBox(height: AppSpacing.md),
          ],
          // Page title and actions
          if (widget.title != null) ...[
            _buildPageHeader(),
            const SizedBox(height: AppSpacing.lg),
          ],
          // Main content
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title!,
                style: AppTypography.h2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _getPageSubtitle(),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (widget.pageActions != null) ...[
          const SizedBox(width: AppSpacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.pageActions!,
          ),
        ],
      ],
    );
  }

  String _getPageSubtitle() {
    final now = DateTime.now();
    final formattedDate = '${_getMonthName(now.month)} ${now.day}, ${now.year}';
    return 'Welcome back! Here\'s what\'s happening today, $formattedDate';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'John Doe',
                    style: AppTypography.h4.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation
            Expanded(
              child: AppSidebar(
                isCollapsed: false,
                onToggleCollapse: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
