import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/theme/theme.dart';
import '../../../core/constants/constants.dart';
// import '../app_button.dart';

/// Responsive dashboard header component
///
/// Features:
/// - App logo and title
/// - Theme toggle button
/// - User profile menu
/// - Notifications badge
/// - Responsive design (mobile, tablet, desktop)
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final bool showMenuButton;

  const AppHeader({
    super.key,
    this.onMenuPressed,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      leading: showMenuButton && responsive.isMobile
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
            )
          : null,
      title: _buildTitle(context, responsive),
      actions: _buildActions(context, responsive),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildTitle(
      BuildContext context, ResponsiveBreakpointsData responsive) {
    if (responsive.isMobile && showMenuButton) {
      return Text(
        'Tabul',
        style: AppTypography.h3.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(width: AppSpacing.sm),
        Text(
          'Tabul Dashboard',
          style: AppTypography.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions(
      BuildContext context, ResponsiveBreakpointsData responsive) {
    final actions = <Widget>[];

    if (!responsive.isMobile) {
      // Search bar for tablet and desktop
      actions.add(
        Container(
          width: 200,
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              prefixIcon: const Icon(Icons.search, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
            ),
          ),
        ),
      );
    }

    // Notifications
    actions.add(
      _buildNotificationButton(context),
    );

    // Spacer - theme toggle removed
    actions.add(const SizedBox(width: AppSpacing.sm));

    // User profile
    actions.add(
      _buildUserProfile(context, responsive),
    );

    actions.add(const SizedBox(width: AppSpacing.sm));

    return actions;
  }

  Widget _buildNotificationButton(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.bell, size: 18),
          onPressed: () {
            // TODO: Show notifications
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications clicked')),
            );
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile(
      BuildContext context, ResponsiveBreakpointsData responsive) {
    if (responsive.isMobile) {
      return IconButton(
        icon: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(
            FontAwesomeIcons.user,
            size: 14,
            color: AppColors.primary,
          ),
        ),
        onPressed: () => _showUserMenu(context),
      );
    }

    return PopupMenuButton<String>(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(
                FontAwesomeIcons.user,
                size: 14,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  'Admin',
                  style: AppTypography.captionSmall.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
            ),
          ],
        ),
      ),
      onSelected: (value) => _handleUserMenuAction(context, value),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text('Profile'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: Icon(FontAwesomeIcons.gear),
            title: Text('Settings'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(FontAwesomeIcons.rightFromBracket),
            title: Text('Logout'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ListTile(
            leading: const Icon(FontAwesomeIcons.user),
            title: const Text('Profile'),
            onTap: () => _handleUserMenuAction(context, 'profile'),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.gear),
            title: const Text('Settings'),
            onTap: () => _handleUserMenuAction(context, 'settings'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rightFromBracket),
            title: const Text('Logout'),
            onTap: () => _handleUserMenuAction(context, 'logout'),
          ),
          SizedBox(
              height: MediaQuery.of(context).padding.bottom + AppSpacing.md),
        ],
      ),
    );
  }

  void _handleUserMenuAction(BuildContext context, String action) {
    Navigator.of(context).pop(); // Close menu if it's a bottom sheet

    switch (action) {
      case 'profile':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile clicked')),
        );
        break;
      case 'settings':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings clicked')),
        );
        break;
      case 'logout':
        // TODO: Implement logout
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout clicked')),
        );
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
