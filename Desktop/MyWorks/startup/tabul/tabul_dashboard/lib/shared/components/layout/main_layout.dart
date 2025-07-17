import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routing/route_names.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import 'app_header.dart';
import 'app_sidebar.dart';

/// Ana layout wrapper
/// Sidebar navigation ile content değişimi yapan layout
class MainLayout extends StatefulWidget {
  final Widget? child;

  const MainLayout({
    super.key,
    this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isSidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentRoute = AppRoutes.dashboard;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentRoute = GoRouterState.of(context).uri.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppHeader(
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        showMenuButton: MediaQuery.of(context).size.width <= 600,
      ),
      drawer: MediaQuery.of(context).size.width <= 600
          ? _buildMobileDrawer()
          : null,
      body: MediaQuery.of(context).size.width <= 600
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: AnimatedSwitcher(
        duration: Duration.zero, // Animasyonu kaldır
        child: _getContentForRoute(_currentRoute),
      ),
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
            onNavigate: (route) {
              setState(() {
                _currentRoute = route;
              });
              // Navigation yok - sadece state değişikliği
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
      child: AnimatedSwitcher(
        duration: Duration.zero, // Animasyonu kaldır
        child: _getContentForRoute(_currentRoute),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: AppSidebar(
        isCollapsed: false,
        onNavigate: (route) {
          setState(() {
            _currentRoute = route;
          });
          Navigator.of(context).pop(); // Drawer'ı kapat
          // Navigation yok - sadece state değişikliği
        },
      ),
    );
  }

  /// Route'a göre content döndür
  Widget _getContentForRoute(String route) {
    switch (route) {
      case AppRoutes.dashboard:
      case '/':
        return const DashboardContent();
      case AppRoutes.analytics:
        return _buildPlaceholderContent(
            'Analytics', 'Analytics sayfası yakında...', Icons.analytics);
      case AppRoutes.reports:
        return _buildPlaceholderContent(
            'Reports', 'Raporlar sayfası yakında...', Icons.description);
      case AppRoutes.settings:
        return _buildPlaceholderContent(
            'Settings', 'Ayarlar sayfası yakında...', Icons.settings);
      case AppRoutes.profile:
        return _buildPlaceholderContent(
            'Profile', 'Profil sayfası yakında...', Icons.person);
      default:
        return _buildPlaceholderContent('404', 'Sayfa bulunamadı', Icons.error);
    }
  }

  Widget _buildPlaceholderContent(
      String title, String description, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page title
        Text(
          title,
          style: AppTypography.h2.copyWith(
            color: AppColors.getTextPrimaryColor(
                Theme.of(context).brightness == Brightness.dark),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Content
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 64,
                  color: AppColors.getTextSecondaryColor(
                      Theme.of(context).brightness == Brightness.dark),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  description,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.getTextSecondaryColor(
                        Theme.of(context).brightness == Brightness.dark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Dashboard content widget'ı - DashboardPage'den content kısmını alacağız
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPageContent();
  }
}
