/// Uygulama genel sabitleri
/// Version, URL, configuration ve diğer sabit değerler
class AppConstants {
  AppConstants._();

  // ==================== APP INFO ====================

  /// Uygulama adı
  static const String appName = 'Tabul Dashboard';

  /// Uygulama versiyonu
  static const String appVersion = '1.0.0';

  /// Build number
  static const String buildNumber = '1';

  /// Package name
  static const String packageName = 'com.tabul.dashboard';

  /// Uygulama açıklaması
  static const String appDescription =
      'Tabul Projesi için geliştirilmiş responsive web dashboard uygulaması';

  // ==================== URLs ====================

  /// Base API URL
  static const String baseApiUrl = 'https://api.tabul.com/v1';

  /// Base web URL
  static const String baseWebUrl = 'https://tabul.com';

  /// Support URL
  static const String supportUrl = 'https://support.tabul.com';

  /// Privacy policy URL
  static const String privacyPolicyUrl = 'https://tabul.com/privacy';

  /// Terms of service URL
  static const String termsOfServiceUrl = 'https://tabul.com/terms';

  /// Help center URL
  static const String helpCenterUrl = 'https://help.tabul.com';

  // ==================== API ENDPOINTS ====================

  /// Authentication endpoints
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String registerEndpoint = '/auth/register';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';

  /// User endpoints
  static const String userProfileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/update';
  static const String changePasswordEndpoint = '/user/change-password';

  /// Dashboard endpoints
  static const String dashboardDataEndpoint = '/dashboard/data';
  static const String analyticsEndpoint = '/analytics';
  static const String reportsEndpoint = '/reports';

  // ==================== STORAGE KEYS ====================

  /// Local storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_preference';
  static const String languageKey = 'language_preference';
  static const String onboardingKey = 'onboarding_completed';
  static const String settingsKey = 'app_settings';

  // ==================== TIMEOUTS ====================

  /// HTTP timeouts (seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;

  /// Cache timeouts (minutes)
  static const int shortCacheTimeout = 5;
  static const int mediumCacheTimeout = 30;
  static const int longCacheTimeout = 60;

  /// Session timeout (minutes)
  static const int sessionTimeout = 120;

  /// Auto-refresh interval (seconds)
  static const int autoRefreshInterval = 300; // 5 minutes

  // ==================== PAGINATION ====================

  /// Default page size
  static const int defaultPageSize = 20;

  /// Maximum page size
  static const int maxPageSize = 100;

  /// Minimum page size
  static const int minPageSize = 5;

  // ==================== VALIDATION ====================

  /// Password minimum length
  static const int minPasswordLength = 8;

  /// Password maximum length
  static const int maxPasswordLength = 128;

  /// Username minimum length
  static const int minUsernameLength = 3;

  /// Username maximum length
  static const int maxUsernameLength = 50;

  /// Email maximum length
  static const int maxEmailLength = 254;

  /// Name maximum length
  static const int maxNameLength = 100;

  // ==================== FILE UPLOAD ====================

  /// Maximum file size (MB)
  static const int maxFileSize = 10;

  /// Allowed image extensions
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp'
  ];

  /// Allowed document extensions
  static const List<String> allowedDocumentExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx'
  ];

  // ==================== ANALYTICS ====================

  /// Google Analytics tracking ID
  static const String? gaTrackingId = null; // Production'da doldurulacak

  /// Firebase Analytics events
  static const String loginEvent = 'login';
  static const String logoutEvent = 'logout';
  static const String pageViewEvent = 'page_view';
  static const String buttonClickEvent = 'button_click';
  static const String errorEvent = 'error';

  // ==================== FEATURE FLAGS ====================

  /// Feature flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableOfflineMode = false;
  static const bool enableDeveloperMode = false;

  // ==================== ANIMATIONS ====================

  /// Animation durations (milliseconds)
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;

  /// Page transition duration
  static const int pageTransitionDuration = 250;

  /// Loading animation duration
  static const int loadingAnimationDuration = 1500;

  // ==================== LOCALIZATION ====================

  /// Supported languages
  static const List<String> supportedLanguages = ['tr', 'en'];

  /// Default language
  static const String defaultLanguage = 'tr';

  /// Fallback language
  static const String fallbackLanguage = 'en';

  // ==================== ENVIRONMENT ====================

  /// Environment type
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Is debug mode
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: true);

  /// Is production mode
  static const bool isProduction = environment == 'production';

  /// Is development mode
  static const bool isDevelopment = environment == 'development';

  // ==================== ERROR MESSAGES ====================

  /// Generic error messages
  static const String genericErrorMessage =
      'Bir hata oluştu. Lütfen tekrar deneyin.';
  static const String networkErrorMessage =
      'İnternet bağlantınızı kontrol edin.';
  static const String timeoutErrorMessage = 'İşlem zaman aşımına uğradı.';
  static const String unauthorizedErrorMessage =
      'Oturum süreniz doldu. Lütfen tekrar giriş yapın.';
  static const String forbiddenErrorMessage =
      'Bu işlem için yetkiniz bulunmuyor.';
  static const String notFoundErrorMessage = 'Aradığınız sayfa bulunamadı.';
  static const String serverErrorMessage =
      'Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyin.';

  // ==================== SUCCESS MESSAGES ====================

  /// Generic success messages
  static const String loginSuccessMessage = 'Başarıyla giriş yaptınız.';
  static const String logoutSuccessMessage = 'Çıkış işlemi tamamlandı.';
  static const String saveSuccessMessage = 'Değişiklikler kaydedildi.';
  static const String deleteSuccessMessage = 'Silme işlemi tamamlandı.';
  static const String updateSuccessMessage = 'Güncelleme tamamlandı.';

  // ==================== REGEX PATTERNS ====================

  /// Email validation regex
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Phone number regex (Turkish format)
  static const String phoneRegex = r'^(\+90|0)?[5][0-9]{9}$';

  /// Password strength regex (en az 1 büyük, 1 küçük harf, 1 rakam)
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  // ==================== STORAGE KEYS ====================

  /// Dashboard cache keys
  static const String dashboardCacheKey = 'dashboard_cache';
  static const String metricCardsCacheKey = 'metric_cards_cache';
  static const String chartDataCacheKey = 'chart_data_cache';
  static const String recentActivitiesCacheKey = 'recent_activities_cache';

  // ==================== UTILITY METHODS ====================

  /// Full API URL oluştur
  static String getApiUrl(String endpoint) {
    return '$baseApiUrl$endpoint';
  }

  /// Environment'a göre URL al
  static String getEnvironmentUrl() {
    switch (environment) {
      case 'production':
        return 'https://api.tabul.com/v1';
      case 'staging':
        return 'https://staging-api.tabul.com/v1';
      default:
        return 'https://dev-api.tabul.com/v1';
    }
  }

  /// Debug log'u kontrol et
  static bool get shouldShowDebugLogs => isDebug || isDevelopment;
}
