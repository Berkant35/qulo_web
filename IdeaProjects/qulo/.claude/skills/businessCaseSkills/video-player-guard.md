---
name: video-player-guard
description: Video player geliştirmelerinde VideoManager kullanımını zorunlu kılar, bellek güvenliği kurallarını uygular
type: business-case
triggers:
  - video
  - video_player
  - VideoManager
  - background video
  - arka plan video
  - BackgroundVideo
---

# Video Player Guard

## Kurallar

### 1. Singleton Zorunluluğu
- `VideoPlayerController` ASLA doğrudan oluşturulmaz — her zaman `VideoManager.instance.acquire()` kullanılır
- Feature'lardan `import 'package:video_player/video_player.dart'` YASAK (sadece widget layer hariç)
- Video widget'ları `BackgroundVideo` widget'ını kullanmalı veya `VideoManager` üzerinden controller almalı

### 2. Lifecycle Kuralları
- **Dispose öncesi pause ZORUNLU** — `release()` bunu garanti eder, manuel yapılmaz
- Widget `dispose()` → `VideoManager.instance.release(assetPath)` çağırmalı
- `initState()` → `acquire()`, `dispose()` → `release()` çifti her zaman eşleşmeli

### 3. Bellek Güvenliği
- Max 1 aktif video kuralı — `acquire()` otomatik uygular
- App lifecycle (pause/resume) VideoManager tarafından otomatik yönetilir
- `VisibilityDetector` ile ekran görünürlük takibi önerilir

### 4. Asset Kuralları
- Video dosyaları `assets/videos/` altında olmalı
- 50MB üzeri video dosyası → sıkıştırma önerisi sun
- `pubspec.yaml`'da `- assets/videos/` satırı olmalı

### 5. Varsayılanlar (Arka Plan Video)
- `setLooping(true)` — her zaman
- `setVolume(0.0)` — her zaman (arka plan videoları sessiz)
- `BoxFit.cover` — tam ekran kaplama

## Kontrol Listesi
Yeni video feature'ı eklerken:
- [ ] VideoManager.acquire/release kullanılıyor mu?
- [ ] Widget dispose'da release çağrılıyor mu?
- [ ] Asset pubspec.yaml'da tanımlı mı?
- [ ] Video boyutu 50MB altında mı?
- [ ] VisibilityDetector ile görünürlük takibi var mı?
