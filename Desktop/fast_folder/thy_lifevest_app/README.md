# THY Lifevest Uygulaması

THY Lifevest projesi takip uygulaması - Flutter ile geliştirilmiş modern mobil uygulama.

## 📱 Proje Hakkında

Bu uygulama, THY Lifevest projelerinin takibini yapmak için geliştirilmiş bir Flutter uygulamasıdır. Clean Architecture prensiplerine uygun olarak tasarlanmış ve modern Flutter geliştirme pratiklerini kullanmaktadır.

## 🏗️ Mimari Yapı

Proje, Clean Architecture ve Feature-First yaklaşımı kullanılarak organize edilmiştir:

```
lib/
├── core/                    # Çekirdek bileşenler
│   ├── app_button/         # Özel buton bileşenleri
│   ├── constant/           # Sabitler ve konfigürasyonlar
│   ├── error/              # Hata yönetimi
│   ├── extension/          # Extension metodları
│   ├── init/               # Dependency injection
│   ├── keys/               # Widget anahtarları
│   ├── navigation/         # Navigasyon yönetimi
│   ├── shared/             # Paylaşılan bileşenler
│   ├── theme/              # Tema konfigürasyonları
│   └── utils/              # Yardımcı araçlar
├── feature/                # Özellik modülleri
│   ├── auth/               # Kimlik doğrulama
│   ├── bluetooth/          # Bluetooth bağlantı
│   ├── home/               # Ana sayfa
│   ├── inventory/          # Envanter işlemleri
│   ├── rfid/               # RFID ayarları
│   └── helper/             # Yardımcı özellikler
├── product/                # Ürün spesifik bileşenler
├── ui_kit/                 # UI bileşen kütüphanesi
├── app.dart                # Ana uygulama widget'ı
└── main.dart               # Uygulama giriş noktası
```

## 🛠️ Teknolojiler

### Ana Teknolojiler
- **Flutter**: ^3.7.2
- **Dart**: ^3.7.2

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern ile state yönetimi
- **hydrated_bloc**: ^10.0.0 - Kalıcı state yönetimi

### Dependency Injection
- **get_it**: ^8.0.3 - Service locator pattern

### Network & API
- **dio**: ^5.8.0+1 - HTTP client
- **retrofit**: ^4.4.2 - Type-safe HTTP client

### Code Generation
- **freezed**: ^3.0.6 - Immutable sınıflar ve union types
- **json_serializable**: ^6.9.5 - JSON serialization
- **build_runner**: ^2.4.15 - Code generation runner

### UI & UX
- **flutter_svg**: ^2.1.0 - SVG desteği
- **cached_network_image**: ^3.4.1 - Görsel önbellekleme
- **flutter_localizations**: Çoklu dil desteği

### Utilities
- **dartz**: ^0.10.1 - Functional programming
- **path_provider**: ^2.1.5 - Dosya yolu yönetimi
- **intl**: Uluslararasılaştırma

## 📋 İsimlendirme Standardı

### 🏷️ Envanter/Sayım İşlemleri Kuralları
Projede "sayım" ile ilgili tüm işlemler için **"inventory"** keyword'ü kullanılmalıdır:

#### Dosya İsimlendirme
```
✅ DOĞRU:
inventory_page.dart
inventory_cubit.dart
inventory_state.dart
inventory_repository.dart

❌ YANLIŞ:
counting_page.dart
sayim_page.dart
```

#### Sınıf İsimlendirme
```dart
✅ DOĞRU:
class InventoryPage extends StatefulWidget
class InventoryCubit extends Cubit<InventoryState>
class InventoryRepository

❌ YANLIŞ:
class CountingPage extends StatefulWidget
class SayimCubit extends Cubit<CountingState>
```

#### Navigation & Constants
```dart
✅ DOĞRU:
static const inventoryPage = '/InventoryPage';
NavigationConstants.inventoryPage

❌ YANLIŞ:
static const countingPage = '/CountingPage';
NavigationConstants.sayimPage
```

#### UI Metinleri
```dart
✅ DOĞRU:
'Envanter İşlemleri'
'Envanter Yönetimi'
'Envanter Raporu'

❌ YANLIŞ:
'Sayım İşlemleri'
'Counting Operations'
```

#### Değişken & Method İsimleri
```dart
✅ DOĞRU:
List<InventoryItem> inventoryList;
int inventoryCount;
void updateInventory()

❌ YANLIŞ:
List<CountingItem> countingList;
int sayimCount;
void updateCounting()
```

## 🎯 Widget Geliştirme Kuralları

### 📏 Sayfa Boyutu Sınırlaması
- **Her sayfa maksimum 200 satır** olmalıdır
- Büyük sayfalar küçük widget'lara bölünmelidir
- Karmaşık widget'lar ayrı dosyalarda tanımlanmalıdır
- Widget'lar tekrar kullanılabilir olmalıdır

### 📝 String Management Kuralları (Zorunlu)
- **Tüm string değerleri app_strings.dart dosyasında tanımlanmalıdır**
- **Hard-coded string'ler yasaktır**
- **AppStrings sınıfından string değerleri alınmalıdır**
- **UI metinleri, hata mesajları, label'lar app_strings.dart'ta olmalıdır**

```dart
// ❌ YANLIŞ - Hard-coded string
Text("Bluetooth Connection")
AppButton.filled(text: "Connect")

// ✅ DOĞRU - AppStrings kullanımı
Text(AppStrings.bluetoothConnection)
AppButton.filled(text: AppStrings.connect)
```

### 🏗️ Widget Creation Kuralları (Zorunlu)
- **Ayrı widget oluştururken StatelessWidget veya StatefulWidget kullanılmalıdır**
- **Function widget'lar yasaktır**
- **Private widget'lar da StatelessWidget/StatefulWidget olmalıdır**
- **Widget'lar const constructor ile oluşturulmalıdır**

```dart
// ❌ YANLIŞ - Function widget
Widget _buildHeader() {
  return Container(child: Text("Header"));
}

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
```

### 🔧 Extension Kullanımı (Zorunlu)
Projede bulunan extension'lar **mutlaka** kullanılmalıdır:

#### Gap Extension'ları
```dart
// ✅ DOĞRU
context.gap16
context.gap24W

// ❌ YANLIŞ
SizedBox(height: 16)
SizedBox(width: 24)
```

#### String Extension'ları
```dart
// ✅ DOĞRU
string.getValueOrDefault
string.isEmpty

// ❌ YANLIŞ
string ?? ""
string == null || string.isEmpty
```

#### Generic Extension'ları
```dart
// ✅ DOĞRU
value.isNull
value.isNotNull

// ❌ YANLIŞ
value == null
value != null
```

#### Widget Extension'ları
```dart
// ✅ DOĞRU
myWidget.toSliver

// ❌ YANLIŞ
SliverToBoxAdapter(child: myWidget)
```

#### 📱 Context Extensions
- `context.arguments` - Route argümanları
- `context.isKeyboardOpen` - Klavye durumu kontrolü
- `context.hasErrorFormState` - Form hata durumu

### 🏗️ Widget Bölme Örneği

```dart
// ✅ DOĞRU: Ana sayfa (200 satır altı)
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return AppResponsiveScaffold(
      body: Column(
        children: [
          _HeaderSection(),
          context.gap16, // ✅ Extension kullanımı
          _InventoryListSection(),
          context.gap24,
          _ActionButtonsSection(),
        ],
      ),
    );
  }
}

// Alt widget'lar ayrı sınıflar/dosyalar
class _InventoryListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Inventory list içeriği
    );
  }
}
```

## 📡 BLE (Bluetooth Low Energy) Sistemi

### ✅ Response Command Mapping Fixed (07 Haziran 2025)
**Durum**: Response Command Mapping **TAM DÜZELTİLDİ** 🎯

Bu tarihte kritik BLE communication sorunu çözülmüş ve EPC detection sistemi mükemmel çalışır hale gelmiştir:
- ✅ **Response Command Mapping**: Request + 1 = Response kuralı uygulandı
- ✅ **Real-time EPC Detection**: **92 tag** başarıyla detect edildi 
- ✅ **Tag Buffer Processing**: Tam çalışır durumda
- ✅ **Command-Response Synchronization**: Perfect mapping
- ✅ **Pending Command System**: Enhanced with expected response codes

**Kritik Fix Details**:
- `0xE0` request → `0xE1` response (Tag buffer)
- `0x82` request → `0x83` response (Inventory start) 
- `0x8C` request → `0x8D` response (Inventory stop)
- Pending command system updated with proper response expectations

**Test Sonuçları**: 92 EPC tag başarıyla detect edildi ve parse edildi 🏆

### ✅ Inventory System Checkpoint (06 Haziran 2025)
**Durum**: Start/Stop Inventory **TAM ÇALIŞIR DURUMDA** 🎯

Bu tarihte inventory sistemi başarılı bir şekilde tamamlanmış ve test edilmiştir:
- ✅ **Start inventory**: Tamamen çalışıyor
- ✅ **Stop inventory**: Tamamen çalışıyor  
- ✅ **Real-time tag detection**: Çalışıyor
- ✅ **BLE communication**: Enhanced chunking ile stable
- ✅ **UI state management**: Tam senkronizasyon

**Kritik Success Factors**:
- 20-byte BLE chunking + 25ms delay
- Factory pattern dependency injection
- Lazy initialization strategy
- Enhanced Uint8List extensions

**Checkpoint Dokümantasyonu**: [`docs/INVENTORY_SYSTEM_CHECKPOINT.md`](docs/INVENTORY_SYSTEM_CHECKPOINT.md)

### BLE Mimarisi Özeti
```
UI Layer (HomeAutoConnect, BluetoothPage)
    ↓
State Management (AppBluetoothCubit)
    ↓
Preferences (BlePref - SharedPreferences)
    ↓
Flutter Blue Plus (BLE Hardware Interface)
```

### Ana BLE Bileşenleri

#### 🔄 AppBluetoothCubit
- **Görev**: BLE state management ve iş mantığı
- **Sorumluluklar**: 
  - Cihaz tarama ve bağlantı yönetimi
  - Local preferences ile senkronizasyon
  - Connection state listening
  - Error handling

#### 🏠 HomeAutoConnect Widget  
- **Görev**: Ana sayfada otomatik bağlantı UI'ı
- **States**:
  - Hidden: Kayıtlı cihaz yok
  - Auto Connect: Kayıtlı cihaz var, bağlantı yok
  - Connected: Aktif bağlantı var

#### 📱 BluetoothPage
- **Görev**: Manuel cihaz tarama ve bağlantı
- **Özellikler**: Device scanning, connection management, refresh

### BLE State Fields

```dart
// Aktif bağlı cihaz
BluetoothDevice? connectedDevice
String? connectedDeviceName

// Son kayıtlı cihaz (preferences'dan)
BluetoothDevice? byLocaleDevice  
String? byLocaleDeviceName

// Connection durumu
UIStateStatus status
BluetoothConnectionState? bleConnectionState
```

### 💾 Preferences Yönetimi

```dart
abstract class BlePref {
  Future<bool> saveBleDeviceName(String deviceName);
  Future<bool> saveBleDeviceAddress(String deviceAddress);
  Future<String?> getBleDeviceName();
  Future<String?> getBleDeviceAddress();
}
```

## 📚 Dokümantasyon Sistemi

### Dokümantasyon Dosyaları

| Dosya | İçerik |
|-------|--------|
| `docs/BLE_FLOW_DOCUMENTATION.md` | Detaylı BLE akış diagramları ve state management |
| `docs/PROJECT_STRUCTURE.md` | Proje mimarisi ve klasör organizasyonu |
| `README.md` | Genel proje bilgisi ve hızlı başlangıç |
| `.cursorrules` | Geliştirme kuralları ve standartları |

### Dokümantasyon Kuralları

- ✅ **Her major feature için ayrı dokümantasyon**
- ✅ **Mermaid ile akış diagramları**
- ✅ **Türkçe açıklamalar, İngilizce kod örnekleri**
- ✅ **Çalışabilir kod örnekleri**
- ✅ **Platform-specific notlar**

### BLE Flow Dokümantasyonu

Detaylı BLE akışı için: [`docs/BLE_FLOW_DOCUMENTATION.md`](docs/BLE_FLOW_DOCUMENTATION.md)

- 🔄 Uygulama başlatma akışı
- 📡 Cihaz tarama ve bağlantı
- 🔄 Otomatik bağlantı sistemi
- ❌ Error handling ve recovery
- 📱 Platform-specific implementasyonlar

### Proje Yapısı Dokümantasyonu

Detaylı mimari bilgisi için: [`docs/PROJECT_STRUCTURE.md`](docs/PROJECT_STRUCTURE.md)

- 🏗️ Clean Architecture katmanları
- 📁 Feature-first klasör organizasyonu
- 🔧 Dependency injection sistemi
- 🎨 UI Kit ve tema sistemi
- 📝 String management sistemi

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK (^3.7.2)
- Dart SDK (^3.7.2)
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Adımlar

1. **Projeyi klonlayın:**
```bash
git clone [repository-url]
cd thy_lifevest_app
```

2. **Bağımlılıkları yükleyin:**
```bash
flutter pub get
```

3. **Code generation çalıştırın:**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Uygulamayı çalıştırın:**
```bash
flutter run
```

## 📦 Build İşlemleri

### Development Build
```bash
flutter run --debug
```

### Release Build
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🏛️ Mimari Detayları

### Feature-First Yaklaşımı
Her özellik kendi klasöründe organize edilmiştir:
- `view/`: UI bileşenleri
- `bloc/` veya `cubit/`: State management
- `model/`: Veri modelleri
- `repository/`: Veri katmanı

### Core Modülleri
- **Navigation**: Merkezi navigasyon yönetimi
- **Theme**: Uygulama tema sistemi
- **Constants**: Sabitler ve konfigürasyonlar
- **Extensions**: Dart extension metodları
- **Utils**: Yardımcı sınıflar

### State Management Pattern
- BLoC/Cubit pattern kullanılmaktadır
- Hydrated BLoC ile state persistence
- Dependency injection ile loose coupling

## 🎨 UI/UX Özellikleri

- **Responsive Design**: Farklı ekran boyutlarına uyumlu
- **Material Design**: Modern Material Design 3 prensiplerine uygun
- **Türkçe Lokalizasyon**: Tam Türkçe dil desteği
- **Custom Theme**: THY marka renklerine uygun tema sistemi

## 🔧 Geliştirme Araçları

### Code Generation
```bash
# Freezed ve JSON serialization
flutter packages pub run build_runner build

# Watch mode (geliştirme sırasında)
flutter packages pub run build_runner watch
```

### Linting
```bash
flutter analyze
```

### Testing
```bash
flutter test
```

## 📱 Platform Desteği

- ✅ **Android**: API 21+ (Android 5.0+)
- ✅ **iOS**: iOS 12.0+

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje [MIT Lisansı](LICENSE) altında lisanslanmıştır.

## 📞 İletişim

Proje ile ilgili sorularınız için:
- Email: [email@example.com]
- Issue: GitHub Issues bölümünü kullanın

---

**THY Lifevest Team** tarafından ❤️ ile geliştirilmiştir.
