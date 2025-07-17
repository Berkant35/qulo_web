# Tabul Dashboard

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)

Modern, responsive ve Clean Architecture prensiplerini takip eden Flutter Web dashboard template'i.

## 🚀 Özellikler

### ✨ UI/UX
- 🌙 **Light/Dark Mode** - Otomatik sistem tema desteği
- 📱 **Responsive Design** - Mobile, tablet ve desktop optimizasyonu
- 🎨 **Material 3 Design** - Modern tasarım sistemi
- 🎯 **Component Library** - Yeniden kullanılabilir UI bileşenleri
- ⚡ **Instant Navigation** - Animasyonsuz, state-based navigation

### 🏗️ Architecture
- 🧩 **Clean Architecture** - Katmanlı mimari yapısı
- 🔄 **BLoC/Cubit Pattern** - Predictable state management
- 🌐 **State-Based Navigation** - Hızlı içerik değişimi sistemi
- 💉 **Dependency Injection** - GetIt service locator
- 🛡️ **Error Handling** - Comprehensive hata yönetimi

### 🚀 Navigation System
- ⚡ **Zero Animation** - Anlık sayfa geçişleri
- 🔄 **State-Based Routing** - Sadece content değişimi
- 🌐 **URL Support** - SEO ve bookmark desteği
- 📱 **Responsive Navigation** - Desktop sidebar + Mobile drawer

### 🛠️ Developer Experience
- 📝 **Type Safety** - Dart'ın güçlü tip sistemi
- 🔧 **Hot Reload** - Anlık kod değişiklikleri
- 📋 **Linting** - Kod kalitesi kontrolleri
- 📚 **Documentation** - Kapsamlı dokümantasyon
- 🧪 **Testing Ready** - Test altyapısı hazır

## 🛠️ Teknoloji Stack

| Kategori | Teknoloji |
|----------|-----------|
| **Framework** | Flutter Web |
| **Language** | Dart |
| **Architecture** | Clean Architecture |
| **State Management** | flutter_bloc (Cubit/Bloc) |
| **Routing** | go_router |
| **DI Container** | get_it |
| **HTTP Client** | dio |
| **Responsive** | responsive_framework |
| **Charts** | fl_chart |
| **Storage** | shared_preferences |
| **Icons** | font_awesome_flutter |

## 📋 Gereksinimler

### Sistem Gereksinimleri
- **Flutter**: 3.24.0 veya üzeri
- **Dart**: 3.5.0 veya üzeri
- **Web Browser**: Chrome 90+, Firefox 88+, Safari 14+, Edge 90+

### Development Ortamı
```bash
flutter --version
# Flutter 3.24.0 • channel stable
# Dart 3.5.0 • DevTools 2.37.2
```

## 🚀 Kurulum

### 1. Repository'yi Clone Edin
```bash
git clone [repository-url]
cd tabul_dashboard
```

### 2. Dependencies'leri Yükleyin
```bash
flutter pub get
```

### 3. Web Sunucusunu Başlatın
```bash
flutter run -d chrome
```

### 4. Production Build
```bash
flutter build web --release --web-renderer canvaskit
```

## 📁 Proje Yapısı

```
lib/
├── core/                           # Core functionality
│   ├── constants/                  # App constants, breakpoints
│   │   ├── app_constants.dart     # App-wide constants
│   │   ├── breakpoints.dart       # Responsive breakpoints
│   │   └── constants.dart         # Barrel exports
│   ├── error/                     # Error handling
│   │   └── failures.dart         # Custom failure classes
│   ├── network/                   # HTTP client
│   │   └── dio_client.dart       # Dio configuration
│   ├── theme/                     # Theme system
│   │   ├── app_colors.dart       # Color palette
│   │   ├── app_typography.dart   # Typography system
│   │   ├── app_spacing.dart      # Spacing constants
│   │   ├── app_shadows.dart      # Shadow definitions
│   │   ├── app_theme.dart        # Main theme config
│   │   ├── theme_cubit.dart      # Theme state management
│   │   └── theme.dart            # Barrel exports
│   └── injection_container.dart   # Dependency injection
├── features/                      # Feature modules
│   └── dashboard/                 # Dashboard feature
│       ├── data/                 # Data layer
│       ├── domain/               # Domain layer
│       └── presentation/         # Presentation layer
│           └── pages/
│               └── dashboard_page.dart
├── shared/                        # Shared components
│   ├── components/               # Reusable UI components
│   │   └── app_button.dart      # Button component
│   ├── widgets/                 # Common widgets
│   └── utils/                   # Utility functions
├── routing/                      # Routing configuration
│   ├── route_names.dart         # Route constants
│   └── app_router.dart          # GoRouter setup
└── main.dart                     # App entry point
```

## 🎨 Theme System

### Color Palette
```dart
// Primary Colors
AppColors.primary        // #1976D2 (Blue)
AppColors.secondary      // #7C4DFF (Purple)
AppColors.accent         // #FF9800 (Orange)

// Semantic Colors
AppColors.success        // #4CAF50 (Green)
AppColors.warning        // #FF9800 (Orange)
AppColors.error         // #F44336 (Red)
AppColors.info          // #00BCD4 (Cyan)
```

### Typography
```dart
// Headings
AppTypography.h1        // 32px, Bold
AppTypography.h2        // 28px, Bold
AppTypography.h3        // 24px, SemiBold

// Body Text
AppTypography.bodyLarge    // 16px, Regular
AppTypography.bodyMedium   // 14px, Regular
AppTypography.bodySmall    // 12px, Regular
```

### Responsive Breakpoints
```dart
// Device Types
mobile: ≤600px
tablet: 601px-1024px
desktop: >1024px

// Usage
context.deviceType == DeviceType.mobile
ResponsiveBreakpoints.of(context).isMobile
```

## 🧩 Component Kullanımı

### AppButton Component
```dart
// Primary Button
AppButton(
  text: 'Save Changes',
  onPressed: () => _saveData(),
  variant: AppButtonVariant.primary,
  size: AppButtonSize.medium,
)

// Loading Button
AppButton(
  text: 'Processing...',
  onPressed: null,
  isLoading: true,
  variant: AppButtonVariant.primary,
)

// Icon Button
AppButton(
  text: 'Download',
  icon: Icons.download,
  onPressed: () => _download(),
  variant: AppButtonVariant.secondary,
)
```

### Theme Toggle
```dart
// Theme Switch
BlocBuilder<ThemeCubit, ThemeState>(
  builder: (context, state) {
    return Switch(
      value: state.isDarkMode,
      onChanged: (value) => context.read<ThemeCubit>().toggleTheme(),
    );
  },
)
```

## 🔧 Development Guidelines

### Navigation Architecture ⚡

#### State-Based Navigation System
```dart
// MainLayout - Tek layout, sadece content değişir
class MainLayout extends StatefulWidget {
  String _currentRoute = AppRoutes.dashboard;
  
  // Sidebar navigation - NO context.go()!
  onNavigate: (route) {
    setState(() {
      _currentRoute = route;  // Sadece state değişir
    });
  }
  
  // Content switch
  Widget _getContentForRoute(String route) {
    switch (route) {
      case AppRoutes.dashboard: return DashboardContent();
      case AppRoutes.analytics: return AnalyticsContent();
      // ...
    }
  }
}
```

#### Router Configuration
```dart
// GoRouter - Sadece tek route gerekli
static final List<RouteBase> _routes = [
  GoRoute(
    path: AppRoutes.dashboard,
    builder: (context, state) => const MainLayout(), // Animation yok!
  ),
];
```

### Clean Architecture Katmanları

#### 1. Presentation Layer
```dart
// Pages
class DashboardPage extends StatelessWidget {
  // UI implementation
}

// Cubits/Blocs
class DashboardCubit extends Cubit<DashboardState> {
  // State management
}
```

#### 2. Domain Layer
```dart
// Entities
class Dashboard {
  final String id;
  final String title;
  // Business logic
}

// Use Cases
class GetDashboardData {
  Future<Either<Failure, Dashboard>> call();
}
```

#### 3. Data Layer
```dart
// Models
class DashboardModel extends Dashboard {
  factory DashboardModel.fromJson(Map<String, dynamic> json);
}

// Repositories
class DashboardRepositoryImpl implements DashboardRepository {
  // Data implementation
}
```

### State Management
```dart
// Cubit State
sealed class DashboardState {}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;
  DashboardLoaded(this.dashboard);
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
```

## 🧪 Testing

### Test Çalıştırma
```bash
# Tüm testler
flutter test

# Coverage ile
flutter test --coverage

# Specific test
flutter test test/unit/core/theme/theme_cubit_test.dart
```

### Test Yapısı
```
test/
├── unit/              # Unit tests
│   ├── core/         # Core functionality tests
│   └── features/     # Feature tests
├── widget/           # Widget tests
├── integration/      # Integration tests
└── golden/          # Golden file tests
```

## 📈 Performance

### Web Performance
- **First Contentful Paint**: <1.8s
- **Largest Contentful Paint**: <2.5s
- **Cumulative Layout Shift**: <0.1
- **First Input Delay**: <100ms

### Build Size
- **Initial bundle**: ~2MB
- **Lazy chunks**: <500KB each
- **Images**: WebP optimized
- **Fonts**: WOFF2 optimized

## 🔧 Configuration

### Environment Variables
```bash
# .env file
API_BASE_URL=https://api.tabul.com
APP_ENV=development
SENTRY_DSN=your_sentry_dsn
GOOGLE_ANALYTICS_ID=your_ga_id
```

### Build Flavors
```bash
# Development
flutter run --flavor development

# Staging  
flutter run --flavor staging

# Production
flutter build web --release --flavor production
```

## 📚 Documentation

- **[PRD.md](./PRD.md)** - Product Requirements Document
- **[.cursorrules](./.cursorrules)** - Development Rules
- **[API Documentation](./docs/API.md)** - API Integration Guide
- **[Component Library](./docs/COMPONENTS.md)** - UI Components Guide

## 🤝 Contributing

### Development Workflow
1. Feature branch oluştur: `git checkout -b feature/new-feature`
2. Değişiklikleri commit et: `git commit -m 'feat: add new feature'`
3. Branch'i push et: `git push origin feature/new-feature`
4. Pull Request oluştur

### Commit Convention
```
type(scope): description

Types: feat, fix, docs, style, refactor, test, chore
Scope: feature name or module name

Examples:
feat(dashboard): implement responsive layout
fix(theme): resolve dark mode issue
docs(readme): update installation guide
```

### Code Review Checklist
- [ ] Clean Architecture principles
- [ ] Naming conventions
- [ ] Theme system usage
- [ ] Responsive design
- [ ] Error handling
- [ ] Documentation
- [ ] Tests

## 📱 Responsive Design

### Mobile (≤600px)
- Single column layout
- Bottom navigation
- Touch-optimized interactions
- Drawer navigation

### Tablet (601px-1024px)
- Two column layout
- Sidebar navigation
- Optimized for touch and mouse
- Adaptive content sizing

### Desktop (>1024px)
- Multi-column layout
- Persistent sidebar
- Mouse and keyboard optimized
- Full feature access

## 🚀 Deployment

### Production Build
```bash
flutter build web --release --web-renderer canvaskit
```

### Hosting Options
- **Firebase Hosting**
- **Netlify**
- **Vercel**
- **AWS S3 + CloudFront**
- **Custom Server**

### Performance Optimization
- Tree shaking enabled
- Code splitting implemented
- Asset optimization
- Caching strategies

## 🔐 Security

- XSS protection
- CSRF protection
- Secure headers
- Input validation
- Authentication ready
- Route guards

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/org/tabul_dashboard/issues)
- **Discussions**: [GitHub Discussions](https://github.com/org/tabul_dashboard/discussions)
- **Documentation**: [Wiki](https://github.com/org/tabul_dashboard/wiki)

## 📄 License

Bu proje [MIT License](LICENSE) altında lisanslanmıştır.

---

**🌟 Bu template'i beğendiyseniz star vermeyi unutmayın!**

Made with ❤️ by Tabul Team
