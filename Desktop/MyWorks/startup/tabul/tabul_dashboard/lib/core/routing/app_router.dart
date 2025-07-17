import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../shared/components/layout/main_layout.dart';
import 'route_names.dart';

/// Ana uygulama router'ı
/// GoRouter kullanarak deklaratif routing
class AppRouter {
  AppRouter._();

  /// Router instance
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: _errorBuilder,
    redirect: _redirect,
  );

  /// Router getter
  static GoRouter get router => _router;

  /// Route definitions
  static final List<RouteBase> _routes = [
    // Login route
    GoRoute(
      path: AppRoutes.login,
      name: AppRouteNames.login,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),

    // Dashboard ana route - tüm dashboard sayfaları state-based
    GoRoute(
      path: AppRoutes.dashboard,
      name: AppRouteNames.dashboard,
      builder: (context, state) => const MainLayout(),
    ),

    // 404 Not found route
    GoRoute(
      path: AppRoutes.notFound,
      name: AppRouteNames.notFound,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const Placeholder(child: Text('404 - Page Not Found')),
      ),
    ),
  ];

  /// Error builder
  static Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hata'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Sayfa bulunamadı',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Aradığınız sayfa mevcut değil: ${state.fullPath}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.dashboard),
              child: const Text('Ana Sayfaya Dön'),
            ),
          ],
        ),
      ),
    );
  }

  /// Global redirect logic
  static String? _redirect(BuildContext context, GoRouterState state) {
    // Authentication kontrolü burada yapılabilir
    // Örnek:
    // final isAuthenticated = AuthService.isAuthenticated();
    // if (!isAuthenticated && !state.path.startsWith('/auth')) {
    //   return AppRoutes.login;
    // }

    return null; // No redirect
  }

  // ==================== NAVIGATION METHODS ====================

  /// Navigate to dashboard
  static void goToDashboard(BuildContext context) {
    context.go(AppRoutes.dashboard);
  }

  /// Navigate to analytics
  static void goToAnalytics(BuildContext context) {
    context.go(AppRoutes.analytics);
  }

  /// Navigate to reports
  static void goToReports(BuildContext context) {
    context.go(AppRoutes.reports);
  }

  /// Navigate to settings
  static void goToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }

  /// Navigate to profile
  static void goToProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  /// Navigate back
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.dashboard);
    }
  }

  /// Navigate with replacement
  static void goWithReplacement(BuildContext context, String location) {
    context.pushReplacement(location);
  }

  /// Navigate and clear stack
  static void goAndClearStack(BuildContext context, String location) {
    while (context.canPop()) {
      context.pop();
    }
    context.go(location);
  }

  /// Push named route
  static void pushNamed(BuildContext context, String name, {Object? extra}) {
    context.pushNamed(name, extra: extra);
  }

  /// Push route with parameters
  static void pushWithParams(
    BuildContext context,
    String location, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    Object? extra,
  }) {
    context.push(location, extra: extra);
  }

  // ==================== UTILITY METHODS ====================

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    return lastMatch.route.name;
  }

  /// Get current location
  static String getCurrentLocation(BuildContext context) {
    return GoRouterState.of(context).fullPath ?? '/';
  }

  /// Check if current route is
  static bool isCurrentRoute(BuildContext context, String routeName) {
    return getCurrentRouteName(context) == routeName;
  }

  /// Get route parameters
  static Map<String, String> getPathParameters(BuildContext context) {
    return GoRouterState.of(context).pathParameters;
  }

  /// Get query parameters
  static Map<String, String> getQueryParameters(BuildContext context) {
    return GoRouterState.of(context).uri.queryParameters;
  }

  /// Get extra object
  static T? getExtra<T>(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    return extra is T ? extra : null;
  }

  // ==================== ROUTE GUARDS ====================

  /// Authentication guard
  static bool authGuard(BuildContext context) {
    // Authentication kontrol logic
    // return AuthService.isAuthenticated();
    return true; // Placeholder
  }

  /// Admin guard
  static bool adminGuard(BuildContext context) {
    // Admin rol kontrol logic
    // return AuthService.isAdmin();
    return true; // Placeholder
  }

  /// Permission guard
  static bool permissionGuard(BuildContext context, String permission) {
    // Permission kontrol logic
    // return AuthService.hasPermission(permission);
    return true; // Placeholder
  }

  // ==================== DEEP LINKING ====================

  /// Handle deep link
  static void handleDeepLink(String link) {
    // Deep link handling logic
    final Uri uri = Uri.parse(link);
    final String path = uri.path;

    // Route to appropriate page based on path
    if (path.startsWith('/dashboard')) {
      // Handle dashboard deep link
    } else if (path.startsWith('/analytics')) {
      // Handle analytics deep link
    }
    // Add more deep link handlers
  }

  /// Generate deep link
  static String generateDeepLink(String route, {Map<String, String>? params}) {
    final Uri uri = Uri(path: route, queryParameters: params);
    return uri.toString();
  }

  // ==================== BROWSER HISTORY ====================

  /// Refresh current page
  static void refresh(BuildContext context) {
    final location = getCurrentLocation(context);
    context.go(location);
  }

  /// Set page title (for web)
  static void setPageTitle(String title) {
    // Web page title setting
    // SystemChrome.setApplicationSwitcherDescription(
    //   ApplicationSwitcherDescription(
    //     label: title,
    //     primaryColor: Theme.of(context).primaryColor.value,
    //   ),
    // );
  }
}
