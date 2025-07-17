import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/theme/theme.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routing/route_names.dart';

/// Responsive dashboard sidebar navigation component
///
/// Features:
/// - Collapsible sidebar for different screen sizes
/// - Navigation menu items with icons
/// - Active state indication
/// - Support for mobile drawer and desktop persistent sidebar
class AppSidebar extends StatefulWidget {
  final bool isCollapsed;
  final ValueChanged<bool>? onToggleCollapse;
  final ValueChanged<String>? onNavigate;

  const AppSidebar({
    super.key,
    this.isCollapsed = false,
    this.onToggleCollapse,
    this.onNavigate,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  String _currentRoute = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentRoute = GoRouterState.of(context).uri.path;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isCollapsed = widget.isCollapsed || responsive.isMobile;

    return Container(
      width: isCollapsed ? 64 : 240,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(isCollapsed),
          Expanded(
            child: _buildNavigationMenu(isCollapsed),
          ),
          _buildFooter(isCollapsed),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isCollapsed) {
    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? AppSpacing.sm : AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              FontAwesomeIcons.chartLine,
              color: Colors.white,
              size: 16,
            ),
          ),
          if (!isCollapsed) ...[
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Tabul',
                style: AppTypography.h4.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          if (!isCollapsed && widget.onToggleCollapse != null)
            IconButton(
              icon: const Icon(Icons.menu_open, size: 20),
              onPressed: () => widget.onToggleCollapse?.call(true),
              tooltip: 'Collapse sidebar',
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu(bool isCollapsed) {
    final menuItems = _getMenuItems();

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: isCollapsed ? AppSpacing.xs : AppSpacing.sm,
      ),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) {
        final item = menuItems[index];
        if (item.isDivider) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
              horizontal: isCollapsed ? 0 : AppSpacing.sm,
            ),
            child: Divider(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
          );
        }
        return const SizedBox(height: AppSpacing.xs);
      },
      itemBuilder: (context, index) {
        final item = menuItems[index];
        if (item.isDivider) return const SizedBox.shrink();

        return _buildMenuItem(item, isCollapsed);
      },
    );
  }

  Widget _buildMenuItem(SidebarMenuItem item, bool isCollapsed) {
    final isActive = _isRouteActive(item.route);
    final hasSubmenu = item.submenu?.isNotEmpty ?? false;

    return Tooltip(
      message: isCollapsed ? item.title : '',
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: hasSubmenu ? null : () => _navigateToRoute(item.route),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isCollapsed ? AppSpacing.sm : AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 18,
                    color: isActive
                        ? AppColors.primary
                        : AppColors.textSecondaryLight,
                  ),
                  if (!isCollapsed) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        item.title,
                        style: AppTypography.bodyMedium.copyWith(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textPrimaryLight,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (hasSubmenu)
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isCollapsed) {
    return Container(
      padding: EdgeInsets.all(isCollapsed ? AppSpacing.sm : AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isCollapsed && widget.onToggleCollapse != null)
            Expanded(
              child: TextButton.icon(
                onPressed: () => widget.onToggleCollapse?.call(true),
                icon: const Icon(Icons.keyboard_arrow_left, size: 16),
                label: const Text('Collapse'),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ),
          if (isCollapsed && widget.onToggleCollapse != null)
            IconButton(
              onPressed: () => widget.onToggleCollapse?.call(false),
              icon: const Icon(Icons.keyboard_arrow_right, size: 20),
              tooltip: 'Expand sidebar',
            ),
        ],
      ),
    );
  }

  List<SidebarMenuItem> _getMenuItems() {
    return [
      SidebarMenuItem(
        title: 'Dashboard',
        icon: FontAwesomeIcons.house,
        route: '/dashboard',
      ),
      SidebarMenuItem(
        title: 'Analytics',
        icon: FontAwesomeIcons.chartLine,
        route: '/analytics',
      ),
      SidebarMenuItem(
        title: 'Reports',
        icon: FontAwesomeIcons.fileLines,
        route: '/reports',
      ),
      SidebarMenuItem.divider(),
      SidebarMenuItem(
        title: 'Users',
        icon: FontAwesomeIcons.users,
        route: '/users',
      ),
      SidebarMenuItem(
        title: 'Settings',
        icon: FontAwesomeIcons.gear,
        route: '/settings',
      ),
      SidebarMenuItem(
        title: 'Profile',
        icon: FontAwesomeIcons.user,
        route: '/profile',
      ),
    ];
  }

  bool _isRouteActive(String route) {
    if (route.isEmpty) return false;
    return _currentRoute == route || _currentRoute.startsWith('$route/');
  }

  void _navigateToRoute(String route) {
    if (route.isNotEmpty) {
      // Eğer onNavigate callback varsa onu kullan, yoksa normal navigation yap
      if (widget.onNavigate != null) {
        widget.onNavigate!(route);
      } else {
        context.go(route);
      }
    }
  }
}

/// Sidebar menu item model
class SidebarMenuItem {
  final String title;
  final IconData icon;
  final String route;
  final List<SidebarMenuItem>? submenu;
  final bool isDivider;

  const SidebarMenuItem({
    required this.title,
    required this.icon,
    required this.route,
    this.submenu,
    this.isDivider = false,
  });

  const SidebarMenuItem.divider()
      : title = '',
        icon = Icons.horizontal_rule,
        route = '',
        submenu = null,
        isDivider = true;
}
