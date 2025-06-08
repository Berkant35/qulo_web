# THY Lifevest - Project Structure Documentation

## 📁 Proje Dizin Yapısı

```
thy_lifevest_app/
├── lib/
│   ├── app.dart                    # Ana uygulama widget'ı
│   ├── main.dart                   # Uygulama giriş noktası
│   │
│   ├── core/                       # 🏗️ Çekirdek bileşenler
│   │   ├── app_button/            # Özel buton bileşenleri
│   │   ├── constant/              # Sabitler ve konfigürasyonlar
│   │   │   ├── app_strings.dart   # Tüm UI metinleri (MERKEZI)
│   │   │   ├── app_ble_settings.dart
│   │   │   └── theme/
│   │   ├── error/                 # Hata yönetimi
│   │   ├── extension/             # Extension metodları
│   │   │   ├── string_extension.dart
│   │   │   ├── generic_extension.dart
│   │   │   └── context_extension.dart
│   │   ├── init/                  # Dependency injection
│   │   │   └── injection_container.dart
│   │   ├── keys/                  # Widget anahtarları
│   │   ├── navigation/            # Navigasyon yönetimi
│   │   ├── preferences/           # Local storage interfaces
│   │   │   ├── i_pref.dart       # IPref sealed class
│   │   │   ├── ble_pref.dart     # Bluetooth preferences
│   │   │   └── auth_pref.dart    # Auth preferences
│   │   ├── shared/               # Paylaşılan UI bileşenleri
│   │   ├── theme/                # Tema konfigürasyonları
│   │   │   ├── app_colors.dart
│   │   │   ├── app_text_styles.dart
│   │   │   └── app_theme.dart
│   │   └── utils/                # Yardımcı araçlar
│   │
│   ├── feature/                   # 🚀 Özellik modülleri (Feature-First)
│   │   ├── auth/                 # Kimlik doğrulama
│   │   │   ├── bloc/
│   │   │   │   ├── cubit/
│   │   │   │   └── state/
│   │   │   └── view/
│   │   │       └── splash_page.dart
│   │   │
│   │   ├── bluetooth/            # 📡 Bluetooth bağlantı yönetimi
│   │   │   ├── bloc/
│   │   │   │   ├── cubit/
│   │   │   │   │   └── app_bluetooth_cubit.dart
│   │   │   │   └── state/
│   │   │   │       └── app_bluetooth_state.dart
│   │   │   └── view/
│   │   │       └── bluetooth_page.dart
│   │   │
│   │   ├── home/                 # 🏠 Ana sayfa
│   │   │   ├── bloc/
│   │   │   ├── view/
│   │   │   │   └── home_page.dart
│   │   │   └── widgets/
│   │   │       ├── home_auto_connect.dart    # BLE otomatik bağlantı
│   │   │       ├── home_header_widget.dart
│   │   │       └── menu_card_widget.dart
│   │   │
│   │   ├── inventory/            # 📋 Envanter işlemleri
│   │   │   ├── view/
│   │   │   └── inventory_page.dart
│   │   │
│   │   ├── reader/               # 📖 RFID okuyucu
│   │   │   └── view/
│   │   │       └── rfid_settings_page.dart
│   │   │
│   │   └── helper/               # 🛠️ Yardımcı özellikler
│   │       └── view/
│   │           └── no_found_route.dart
│   │
│   ├── ui_kit/                   # 🎨 UI bileşen kütüphanesi
│   │   └── responsive_scaffold.dart
│   │
│   ├── product/                  # 📦 Ürün spesifik bileşenler
│   │
│   └── docs/                     # 📚 Dokümantasyon
│       ├── BLE_FLOW_DOCUMENTATION.md
│       └── PROJECT_STRUCTURE.md
│
├── test/                         # 🧪 Test dosyaları
├── android/                      # 🤖 Android konfigürasyonu
├── ios/                          # 🍎 iOS konfigürasyonu
├── pubspec.yaml                  # 📦 Paket bağımlılıkları
├── .cursorrules                  # 🎯 Geliştirme kuralları
└── README.md                     # 📖 Proje dökümanı
```

## 🏗️ Mimari Prensipler

### Clean Architecture Katmanları

```
┌─────────────────────────────────────────────────────────────┐
│                     PRESENTATION LAYER                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Pages     │  │   Widgets   │  │   Cubits    │        │
│  │             │  │             │  │             │        │
│  │ • HomePage  │  │ • AutoConn. │  │ • BleCubit  │        │
│  │ • BleePage  │  │ • MenuCard  │  │ • HomeCubit │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   States    │  │ Interfaces  │  │   Models    │        │
│  │             │  │             │  │             │        │
│  │ • BleState  │  │ • IPref     │  │ • Failure   │        │
│  │ • HomeState │  │ • IRepo     │  │ • Device    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                       DATA LAYER                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ Preferences │  │  External   │  │   Services  │        │
│  │             │  │   APIs      │  │             │        │
│  │ • BlePref   │  │ • FlutterBLE│  │ • Navigation│        │
│  │ • AuthPref  │  │ • Network   │  │ • GetIt     │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Feature-First Yaklaşımı

Her özellik kendi klasöründe organize edilir:

### Feature Klasör Yapısı
```
feature_name/
├── bloc/                    # State management
│   ├── cubit/
│   │   └── feature_cubit.dart
│   └── state/
│       └── feature_state.dart
├── model/                   # Veri modelleri
├── repository/              # Veri katmanı (opsiyonel)
├── view/                    # Ana sayfalar
│   └── feature_page.dart
└── widgets/                 # Özellik-spesifik widget'lar
    └── feature_widget.dart
```

## 📋 State Management Sistemi

### BLoC/Cubit Pattern
```dart
// 1. State sınıfı (Freezed ile)
@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState({
    @Default(UIStateStatus.idle) UIStateStatus status,
    @Default([]) List<Model> items,
    Failure? failure,
  }) = _ExampleState;
}

// 2. Cubit sınıfı
class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit() : super(const ExampleState());
  
  void methodName() {
    emit(state.copyWith(status: UIStateStatus.loading));
    // Business logic
  }
}

// 3. UI'da kullanım
BlocBuilder<ExampleCubit, ExampleState>(
  builder: (context, state) {
    return Widget();
  },
)
```

## 🎯 Dependency Injection

### GetIt Service Locator Pattern
```dart
// injection_container.dart
final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core dependencies
  await _initCoreModules();
  
  // Feature dependencies
  _initAuthFeature();
  _initBluetoothFeature();
  _initHomeFeature();
}
```

## 🎨 UI Kit Sistemi

### AppTextStyles (Zorunlu Kullanım)
```dart
// Mevcut style'lar
AppTextStyles.px8w400     // 8px, FontWeight.w400
AppTextStyles.px14w600    // 14px, FontWeight.w600
AppTextStyles.px16w500    // 16px, FontWeight.w500
// ... diğer kombinasyonlar

// Kullanım
Text(
  AppStrings.title,
  style: AppTextStyles.px16w600,
)
```

### AppColors Sistemi
```dart
AppColors.primary         // Ana tema rengi
AppColors.secondary       // İkincil renk
AppColors.error          // Hata rengi
AppColors.warning        // Uyarı rengi
AppColors.success        // Başarı rengi
```

## 🔗 Extension Sistemi

### Zorunlu Extension'lar
```dart
// Gap Extensions
context.gap16            // SizedBox(height: 16) yerine
context.gap24W           // SizedBox(width: 24) yerine

// String Extensions
string.getValueOrDefault // string ?? "" yerine
string.isEmpty           // string == null || string.isEmpty yerine

// Generic Extensions
value.isNull             // value == null yerine
value.isNotNull          // value != null yerine

// Widget Extensions
widget.toSliver          // SliverToBoxAdapter wrapper
```

## 📝 String Management Sistemi

### Merkezi String Yönetimi
```dart
// app_strings.dart - TEK KAYNAK
class AppStrings {
  // Kategorize edilmiş string'ler
  static const String title = "Title";
  static const String connect = "Connect";
  static const String error = "Error";
  
  // Hard-coded string'ler YASAK!
}

// Kullanım
Text(AppStrings.title)                    // ✅ DOĞRU
Text("Title")                            // ❌ YANLIŞ
```

## 🏗️ Widget Architecture

### StatelessWidget Kuralı
```dart
// ✅ DOĞRU - StatelessWidget kullanımı
class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(AppStrings.header),
    );
  }
}

// ❌ YANLIŞ - Function widget
Widget _buildHeader() {
  return Container(child: Text("Header"));
}
```

## 🔧 Navigation Sistemi

### Merkezi Navigation
```dart
// navigation_constants.dart
class NavigationConstants {
  static const String homePage = '/HomePage';
  static const String bluetoothPage = '/BluetoothPage';
}

// Kullanım
NavigationService.instance.navigateToPage(
  path: NavigationConstants.homePage,
);
```

## 📱 Responsive Design

### AppResponsiveScaffold
```dart
AppResponsiveScaffold(
  appBar: AppLiveHeader(appHeaderName: AppStrings.title),
  body: content,
  isLoading: state.status.isLoading,
)
```

## 🧪 Test Stratejisi

### Test Tipleri
1. **Unit Tests**: Cubit/Repository logic
2. **Widget Tests**: UI components
3. **Integration Tests**: Full user flows

### Test Klasör Yapısı
```
test/
├── unit/
│   ├── cubit/
│   └── repository/
├── widget/
│   └── feature/
└── integration/
    └── flow/
```

## 📊 Performance Optimizations

### BlocSelector Kullanımı
```dart
// Specific field'ları dinlemek için
BlocSelector<AppBluetoothCubit, AppBluetoothState, bool>(
  selector: (state) => state.status.isLoading,
  builder: (context, isLoading) {
    return LoadingWidget(isLoading: isLoading);
  },
)
```

### Widget Optimization
1. **Const constructors**: Mümkün olduğunca kullan
2. **ListView.builder**: Büyük listeler için
3. **RepaintBoundary**: Expensive widget'lar için
4. **Keys**: Dynamic list'ler için

## 🔐 Security Practices

1. **Environment Variables**: API keys için
2. **Certificate Pinning**: Production'da
3. **Data Encryption**: Sensitive data için
4. **Permissions**: Minimum gerekli

## 📚 Documentation Standards

### Dokümantasyon Türleri
1. **API Documentation**: Code comments ile
2. **Architecture Docs**: Markdown dosyaları
3. **Flow Diagrams**: Mermaid ile
4. **Code Examples**: README'de

### Dokümantasyon Kuralları
- Her major feature için ayrı doküman
- Akış diagramları ile görselleştir
- Code örnekleri ekle
- Güncelleme sorumluluğu belirle 