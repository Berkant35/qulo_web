# Profile Detail Screen — Design Spec

## Overview

Qulo'da başka kullanıcıların detaylı profilini görüntülemek için full-screen scroll profil ekranı. Şu an sadece discover kartlarında minimal bilgi (ilk fotoğraf, isim, yaş, şehir, soru bilgisi) gösteriliyor — bu ekran tüm fotoğrafları, bio'yu, kişisel detayları ve soru bilgilerini tek bir scrollable sayfada sunacak.

## Erişim Noktaları

Profil detay ekranına şu context'lerden erişilebilecek:

| Context | Tetikleyici | Action Butonları |
|---------|------------|------------------|
| **Discover kartı** | Karta tap | "Soruları Çöz" + Reject |
| **Matches listesi** | Match avatarına tap | "Mesaj Gönder" |
| **Chat ekranı** | Üstteki profil header'a tap | "Mesaj Gönder" |
| **Quiz sonuç ekranı** | Profil avatarına tap | "Soruları Çöz" veya "Mesaj Gönder" (match durumuna göre) |

## API

### Yeni Endpoint: `GET /users/:id/profile`

Discover response'u şişirmemek için ayrı bir endpoint. Sadece profil açıldığında çağrılır.

**Response:**

```json
{
  "user_id": "uuid",
  "name": "Sarah",
  "age": 26,
  "bio": "Love hiking and traveling",
  "city": "Beyoglu",
  "country": "Turkey",
  "photos": ["url1", "url2", "url3"],
  "distance_km": 3.5,
  "relationship_goal": "SERIOUS",
  "is_online": false,
  "last_seen_at": "2026-03-17T10:30:00Z",
  "profile_completion": 80,
  "is_boosted": true,
  "details": {
    "height": 165,
    "zodiac": "Libra",
    "job": "Graphic Designer",
    "school": "Mimar Sinan University",
    "smoking": "NO",
    "alcohol": "SOMETIMES",
    "pets": "Cat",
    "music_type": "Jazz",
    "personality": "Creative and curious"
  },
  "question_info": {
    "count": 4,
    "categories": ["Music", "Travel", "Food"],
    "avg_difficulty": "medium",
    "languages": ["tr", "en"]
  }
}
```

**Kurallar:**
- Auth gerekli (JWT Bearer token)
- Deleted/banned kullanıcılar için 404
- `is_online` ve `last_seen_at` sadece match olan kullanıcılar için döner (privacy), diğerleri için null
- `distance_km` server-side hesaplanır (requester'ın konumu / passport konumu kullanılır)
- `weight` response'a dahil edilmez (privacy — sadece kendi profilinde görünür)

## Ekran Layout

Full-screen, scrollable. Üstte fotoğraf galerisi, altında bilgi bölümleri.

### 1. Fotoğraf Galerisi (ekranın ~60%'ı)

- `PageView` ile horizontal navigation
- **Tap zones:** Sağ yarı = sonraki, sol yarı = önceki
- **Swipe:** Horizontal swipe ile de geçiş (discover'da swipe kart için ayrılmış olduğundan, sadece profil detay ekranında aktif)
- **Dot indicator:** Üstte, fotoğraf sayısı kadar dot
- **Fotoğraf sayısı badge:** Sağ üst köşede "1/4" formatında
- **Geri butonu:** Sol üst köşede X ikonu, `context.pop()` ile geri döner
- Fotoğraf yoksa placeholder avatar

### 2. Temel Bilgiler

Fotoğrafın hemen altında, padding ile:

- **İsim + Yaş:** `"Sarah, 26"` — bold, büyük font
- **Konum + Mesafe:** `"Beyoglu • 3.5 km"` — secondary color, icon ile
- **Relationship Goal:** Badge/chip — SERIOUS (kırmızı kalp), FRIENDSHIP (yeşil el), NOT_SURE (sarı soru işareti)
- **Online durumu:** Sadece match olan kullanıcılarda — yeşil dot "Online" veya "Son görülme: 2 saat önce"
- **Boost indicator:** Zap ikonu, boosted ise göster

### 3. Bio / Hakkında

- `"Hakkında"` section header
- Bio metni, max 500 karakter
- Bio yoksa bu bölüm gizlenir

### 4. Detaylar Grid

Chip/tag tarzı, wrap layout (`Wrap` widget). Sadece doldurulmuş alanlar gösterilir.

| Alan | İkon | Format |
|------|------|--------|
| Boy | 📏 ruler | "180 cm" |
| Burç | ♈ zodiac | "Libra" |
| Meslek | 💼 briefcase | "Graphic Designer" |
| Okul | 🎓 graduation | "Mimar Sinan Uni" |
| Sigara | 🚬 cigarette | "Hayır" / "Evet" / "Bazen" |
| Alkol | 🍷 wine | "Hayır" / "Evet" / "Bazen" |
| Evcil Hayvan | 🐾 paw | "Cat" |
| Müzik | 🎵 music | "Jazz" |
| Kişilik | ✨ sparkle | "Creative and curious" |

Hiçbir detay doldurulmamışsa bu bölüm tamamen gizlenir.

### 5. Soru Bilgisi

Discover kartındaki soru bilgisi bölümüne benzer tasarım:

- Soru sayısı chip'i
- Zorluk badge'i (easy/medium/hard/legendary)
- Kategori chip'leri (horizontal scroll)
- Dil chip'leri (bayrak emoji ile)

Bu bölüm sadece discover ve quiz context'lerinde gösterilir, chat/match context'inde gösterilmez (zaten eşleşmişler).

### 6. Action Butonları

Ekranın altında sabit (sticky bottom bar), context'e göre değişir:

**Discover context:**
- Primary: "Soruları Çöz" (büyük, filled button)
- Secondary: X (reject) butonu (outline, sol tarafta)

**Match/Chat context:**
- Primary: "Mesaj Gönder" (büyük, filled button)

**Quiz sonuç context:**
- Match olduysa: "Mesaj Gönder"
- Match olmadıysa: "Soruları Çöz"

### 7. Report / Block

Action butonlarının üstünde, küçük text button:
- "Bildir veya Engelle" — tıklayınca bottom sheet açılır
- Seçenekler: Report (sebep seçimi) / Block

## Navigation

### Route Tanımı

```
Route: /profile-detail/:userId
Name: RouteNames.profileDetail
Extra params: ProfileDetailArgs (context, preloaded data)
```

### ProfileDetailArgs Model

```dart
class ProfileDetailArgs {
  final ProfileDetailContext context; // discover, match, chat, quizResult
  final String userId;
  final String? matchId;          // match/chat context için
  final String? firstPhotoUrl;    // hero animation placeholder
  final ProfileCardModel? preloadedCard; // discover'dan geliyorsa
}
```

### Context Enum

```dart
enum ProfileDetailContext {
  discover,   // discover kartından
  match,      // matches listesinden
  chat,       // chat ekranından
  quizResult, // quiz sonucundan
}
```

## State Management

### Provider

```dart
// Profile detail verisi
final profileDetailProvider = FutureProvider.family<PublicProfileModel, String>((ref, userId) async {
  return ref.read(userRepositoryProvider).getPublicProfile(userId);
});
```

### Veri Akışı

1. Ekran açılır → `ProfileDetailArgs` okunur
2. `preloadedCard` varsa (discover'dan) → hemen temel bilgileri göster
3. `profileDetailProvider` ile detayları çek → detaylar yüklenir
4. Loading state: Fotoğraf + temel bilgiler görünür, detaylar shimmer/skeleton
5. Error state: Retry butonu

### Caching

- Provider `autoDispose` değil — aynı kullanıcının profili tekrar açılırsa cache'ten gelir
- Discover'da swipe edilip geri alınan kullanıcı için cache invalidate edilmez

## Dosya Yapısı

```
lib/features/profile_detail/
├── screens/
│   └── profile_detail_screen.dart       # Orchestration (~150 satır)
├── widgets/
│   ├── profile_photo_gallery.dart       # Fotoğraf galerisi + tap zones
│   ├── profile_basic_info.dart          # İsim, yaş, konum, goal
│   ├── profile_bio_section.dart         # Hakkında bölümü
│   ├── profile_details_grid.dart        # Detay chip'leri
│   ├── profile_question_info.dart       # Soru bilgisi (discover'dan re-use)
│   ├── profile_action_bar.dart          # Sticky bottom action butonları
│   └── profile_report_button.dart       # Report/block
├── models/
│   └── profile_detail_args.dart         # Navigation args + context enum
└── providers/
    └── profile_detail_provider.dart     # API çağrısı + state
```

## Backend Değişiklikleri

### Yeni Endpoint

`GET /users/:id/profile`

**Controller:** `user.controller.ts` → `getPublicProfile`
**Service:** `user.service.ts` → `getPublicProfile(requesterId, targetId)`

**Logic:**
1. Target user'ı DB'den çek (users + user_details join)
2. Deleted/banned kontrolü → 404
3. Distance hesapla (requester location vs target location, PostGIS)
4. Match kontrolü → match varsa `is_online` ve `last_seen_at` dahil et
5. Question info çek (count, categories, avg_difficulty, languages)
6. `weight` hariç tut
7. Response oluştur ve döndür

**Route:** `user.routes.ts` → `router.get('/:id/profile', auth, userController.getPublicProfile)`

### Flutter API Client

`user_service.dart` → yeni method:
```dart
@GET('/users/{id}/profile')
Future<PublicProfileModel> getPublicProfile(@Path('id') String userId);
```

### Yeni Model: `PublicProfileModel`

Server response'una karşılık gelen Flutter model. `ProfileCardModel`'den farklı olarak detayları da içerir.

## Privacy Kuralları

- `weight` hiçbir zaman başkalarına gösterilmez
- `is_online` ve `last_seen_at` sadece match olan kullanıcılara gösterilir
- `email`, `surname`, `password_hash` gibi hassas alanlar response'a dahil edilmez
- `phone`, `push_token` gibi cihaz bilgileri dahil edilmez
- Blocked kullanıcıların profili görüntülenemez → 404

## Edge Cases

- **Kullanıcı hiç fotoğraf yüklememişse:** Placeholder avatar göster
- **Bio boşsa:** Hakkında bölümü gizle
- **Hiç detay doldurulmamışsa:** Detaylar grid'i gizle
- **Soru yoksa:** Soru bilgisi bölümü gizle (ama bu discover'da zaten minimum 2 soru zorunlu)
- **Kullanıcı silinmişse:** 404 + "Kullanıcı bulunamadı" ekranı
- **Network hatası:** Retry butonu ile tekrar dene
- **Çok yavaş connection:** Shimmer loading state, fotoğraflar progressive load
