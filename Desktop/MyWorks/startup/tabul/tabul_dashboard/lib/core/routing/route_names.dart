/// Route paths ve names sabitleri
/// Uygulama içi navigation için kullanılacak route tanımları
class AppRoutes {
  AppRoutes._();

  // ==================== ROUTE PATHS ====================

  /// Dashboard route
  static const String dashboard = '/';

  /// Analytics route
  static const String analytics = '/analytics';

  /// Reports route
  static const String reports = '/reports';

  /// Settings route
  static const String settings = '/settings';

  /// Profile route
  static const String profile = '/profile';

  /// Not found route
  static const String notFound = '/404';

  // ==================== AUTHENTICATION ROUTES ====================

  /// Login route
  static const String login = '/login';

  /// Register route
  static const String register = '/register';

  /// Forgot password route
  static const String forgotPassword = '/forgot-password';

  /// Reset password route
  static const String resetPassword = '/reset-password';

  // ==================== ADMIN ROUTES ====================

  /// Admin dashboard
  static const String adminDashboard = '/admin';

  /// User management
  static const String userManagement = '/admin/users';

  /// System settings
  static const String systemSettings = '/admin/settings';

  // ==================== UTILITY METHODS ====================

  /// Tüm route'ları list olarak döndür
  static List<String> get allRoutes => [
        dashboard,
        analytics,
        reports,
        settings,
        profile,
        login,
        register,
        forgotPassword,
        resetPassword,
        adminDashboard,
        userManagement,
        systemSettings,
        notFound,
      ];

  /// Route'un geçerli olup olmadığını kontrol et
  static bool isValidRoute(String route) {
    return allRoutes.contains(route);
  }

  /// Route'un public olup olmadığını kontrol et (auth gerektirmez)
  static bool isPublicRoute(String route) {
    const publicRoutes = [
      login,
      register,
      forgotPassword,
      resetPassword,
    ];
    return publicRoutes.contains(route);
  }

  /// Route'un admin route'u olup olmadığını kontrol et
  static bool isAdminRoute(String route) {
    return route.startsWith('/admin');
  }
}

/// Route names sabitleri
/// Named navigation için kullanılacak
class AppRouteNames {
  AppRouteNames._();

  // ==================== MAIN ROUTES ====================

  /// Dashboard route name
  static const String dashboard = 'dashboard';

  /// Analytics route name
  static const String analytics = 'analytics';

  /// Reports route name
  static const String reports = 'reports';

  /// Settings route name
  static const String settings = 'settings';

  /// Profile route name
  static const String profile = 'profile';

  /// Not found route name
  static const String notFound = 'notFound';

  // ==================== AUTH ROUTES ====================

  /// Login route name
  static const String login = 'login';

  /// Register route name
  static const String register = 'register';

  /// Forgot password route name
  static const String forgotPassword = 'forgotPassword';

  /// Reset password route name
  static const String resetPassword = 'resetPassword';

  // ==================== ADMIN ROUTES ====================

  /// Admin dashboard route name
  static const String adminDashboard = 'adminDashboard';

  /// User management route name
  static const String userManagement = 'userManagement';

  /// System settings route name
  static const String systemSettings = 'systemSettings';

  // ==================== UTILITY METHODS ====================

  /// Tüm route name'leri list olarak döndür
  static List<String> get allRouteNames => [
        dashboard,
        analytics,
        reports,
        settings,
        profile,
        login,
        register,
        forgotPassword,
        resetPassword,
        adminDashboard,
        userManagement,
        systemSettings,
        notFound,
      ];

  /// Route name'in geçerli olup olmadığını kontrol et
  static bool isValidRouteName(String routeName) {
    return allRouteNames.contains(routeName);
  }
}

/// Route parameters
/// Dynamic route parametreleri için
class AppRouteParams {
  AppRouteParams._();

  // ==================== COMMON PARAMETERS ====================

  /// ID parameter
  static const String id = 'id';

  /// User ID parameter
  static const String userId = 'userId';

  /// Report ID parameter
  static const String reportId = 'reportId';

  /// Category parameter
  static const String category = 'category';

  /// Type parameter
  static const String type = 'type';

  /// Tab parameter
  static const String tab = 'tab';

  /// Page parameter
  static const String page = 'page';

  /// Limit parameter
  static const String limit = 'limit';

  // ==================== QUERY PARAMETERS ====================

  /// Search query parameter
  static const String search = 'search';

  /// Sort parameter
  static const String sort = 'sort';

  /// Order parameter (asc/desc)
  static const String order = 'order';

  /// Filter parameter
  static const String filter = 'filter';

  /// Date range start
  static const String dateStart = 'dateStart';

  /// Date range end
  static const String dateEnd = 'dateEnd';

  // ==================== UTILITY METHODS ====================

  /// Query string oluştur
  static String buildQueryString(Map<String, dynamic> params) {
    if (params.isEmpty) return '';

    final queryParams = params.entries
        .where((entry) => entry.value != null)
        .map((entry) =>
            '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    return queryParams.isNotEmpty ? '?$queryParams' : '';
  }

  /// Path parameter'leri replace et
  static String replacePathParams(String path, Map<String, String> params) {
    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll(':$key', value);
    });
    return result;
  }
}
