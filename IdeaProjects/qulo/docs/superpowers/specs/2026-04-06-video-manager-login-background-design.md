# Video Manager + Login Background Video Design

**Tarih:** 2026-04-06
**Branch:** APP-1915
**Scope:** VideoManager singleton + login screen arka plan video + staggered giriş animasyonları + businessCaseSkill

---

## 1. Amaç

Login ekranına premium his katan arka plan video oynatımı eklemek ve projenin ilk video altyapısını (VideoManager) Hardware Manager Pattern'e uygun şekilde kurmak. Şimdilik arka plan video odaklı, ileride genel amaçlı genişletilebilir.

## 2. Paketler

| Paket | Amaç |
|-------|-------|
| `video_player` | Flutter resmi video oynatma paketi |
| `visibility_detector` | Ekran görünürlük takibi — otomatik pause/resume |

## 3. VideoManager (Singleton — Hardware Manager Pattern)

**Konum:** `qulov2/lib/core/services/video_manager.dart`

### 3.1 Pattern

Mevcut Hardware Manager Pattern'e uygun:
- Private constructor: `VideoManager._()`
- Singleton: `static final VideoManager instance = VideoManager._()`
- `WidgetsBindingObserver` mixin — app lifecycle dinleme

### 3.2 API

```dart
class VideoManager with WidgetsBindingObserver {
  VideoManager._();
  static final VideoManager instance = VideoManager._();

  /// Asset path → controller cache
  final Map<String, VideoPlayerController> _controllers = {};

  /// Hangi controller'lar pause öncesinde oynuyordu (resume için)
  final Set<String> _wasPlaying = {};

  /// Controller oluştur veya cache'den al, initialize + loop + mute + play
  Future<VideoPlayerController> acquire(String assetPath);

  /// Pause → dispose → cache'den sil
  Future<void> release(String assetPath);

  /// Tüm controller'ları release et
  Future<void> releaseAll();

  /// Manuel pause/resume
  void pause(String assetPath);
  void resume(String assetPath);
}
```

### 3.3 Bellek Kuralları

- **Max 1 aktif video:** Yeni `acquire()` çağrısında mevcut controller varsa önce release edilir
- **Acquire sırası:** `VideoPlayerController.asset()` → `initialize()` → `setLooping(true)` → `setVolume(0.0)` → `play()`
- **Release sırası:** `pause()` → `dispose()` → cache'den sil (dispose öncesi pause ZORUNLU)
- **App paused/inactive:** Tüm aktif controller'lar pause, `_wasPlaying` set'e eklenir
- **App resumed:** Sadece `_wasPlaying` set'indeki controller'lar resume edilir
- **WidgetsBindingObserver:** `init()` ile register, `releaseAll()` ile unregister

### 3.4 Init/Teardown

```dart
/// App başlangıcında çağrılır (main.dart veya app.dart)
void init() {
  WidgetsBinding.instance.addObserver(this);
}

/// Gerekirse cleanup
void teardown() {
  releaseAll();
  WidgetsBinding.instance.removeObserver(this);
}
```

## 4. Login Screen Video Entegrasyonu

**Dosya:** `qulov2/lib/features/auth/screens/login_screen.dart`

### 4.1 Widget Tree

```
Stack (Positioned.fill)
  ├── BackgroundVideo (tam ekran, FittedBox + BoxFit.cover)
  │     └── VideoPlayer widget (controller'dan)
  ├── Container (black, opacity: ~0.3) — form okunurluğu overlay
  ├── Mevcut CustomPaint gradient daireler (AppScaffold showBackground: true)
  └── Mevcut Form (SingleChildScrollView → Column) — staggered animasyonlu
```

### 4.2 Video Lifecycle

- `initState()` → `VideoManager.instance.acquire('assets/videos/mock.mp4')` → setState
- `dispose()` → `VideoManager.instance.release('assets/videos/mock.mp4')`
- İlk frame yüklenene kadar solid dark background gösterilir (flicker önleme)
- `ValueListenableBuilder` ile controller.value.isInitialized dinlenir

### 4.3 Overlay

- `Container(color: Colors.black.withOpacity(0.3))` — video görünür ama form okunabilir
- Mevcut gradient daireler (CustomPaint) overlay'ın üstünde kalır

## 5. Staggered Giriş Animasyonları

### 5.1 Choreography

| Sıra | Eleman | Delay | Animasyon | Curve |
|------|--------|-------|-----------|-------|
| 1 | Logo (SVG) | 0ms | fade-in + scale (0.8→1.0) | easeOutCubic |
| 2 | App adı + hoşgeldin text | 100ms | fade-in + slide-up (20px) | easeOutCubic |
| 3 | Email TextField | 200ms | fade-in + slide-up (20px) | easeOutCubic |
| 4 | Password TextField | 300ms | fade-in + slide-up (20px) | easeOutCubic |
| 5 | Forgot password + Login butonu | 400ms | fade-in + slide-up (20px) | easeOutCubic |
| 6 | Divider + Register linki | 500ms | fade-in | easeOutCubic |

### 5.2 Implementasyon

- `TickerProviderStateMixin` eklenir (`_LoginScreenState`'e)
- Tek `AnimationController` — duration: 1200ms
- Her eleman için `CurvedAnimation` + `Interval` (staggered timing)
- Video `isInitialized` olduktan sonra `_animController.forward()` çağrılır
- `FadeTransition` + `SlideTransition` combo (her eleman için)

## 6. pubspec.yaml Değişiklikleri

```yaml
dependencies:
  video_player: ^2.9.3      # (veya güncel sürüm)
  visibility_detector: ^0.4.0+2

flutter:
  assets:
    - assets/videos/         # YENİ — video dosyaları
```

## 7. businessCaseSkill

**Konum:** `.claude/skills/businessCaseSkills/video-player-guard.md`

**Amaç:** Video player ile ilgili geliştirme yapılırken otomatik tetiklenen kurallar:
- VideoManager singleton dışında doğrudan VideoPlayerController kullanımı YASAK
- Dispose öncesi pause zorunlu
- Loop + mute varsayılan (arka plan videoları için)
- Max 1 aktif video kuralı
- Asset boyutu uyarısı (>50MB ise sıkıştırma önerisi)

**Tetikleyiciler:** video, video_player, VideoManager, background video, arka plan video

## 8. Kapsam Dışı (İleride)

- Network video oynatma (URL'den stream)
- Inline video player (chat'te video paylaşımı)
- Full-screen video player
- Video thumbnail oluşturma
- Video sıkıştırma/dönüştürme
