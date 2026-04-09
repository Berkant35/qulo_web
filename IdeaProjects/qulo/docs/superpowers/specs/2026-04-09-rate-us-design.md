# Rate Us / App Review — Tasarım Dokümanı

**Tarih:** 2026-04-09
**Branch:** APP-1915

## Özet

Qulo uygulamasına native in-app review özelliği eklenmesi. Akıllı tetikleme ile kullanıcının duygusal zirvede olduğu anlarda (match kutlaması sonrası) native store review dialog'u gösterilir. Ek olarak Settings ekranında kalıcı "Rate Us" butonu bulunur.

## Kararlar

| Karar | Seçim | Gerekçe |
|-------|-------|---------|
| Tetikleme stratejisi | Akıllı tetikleme | Olumlu deneyim anlarında yakalama, en yüksek dönüşüm |
| Review UI | Native store dialog | Basit, platform-optimized, tek adım |
| Tetikleme anı | Match kutlaması sonrası | Duygusal zirve noktası |
| Tekrar politikası | Max 3 kez, 14 gün cooldown | Agresif olmadan ısrarcı |
| Settings butonu | Legal bölümünün altında | Kullanıcı istediği zaman erişebilir |
| Mimari yaklaşım | Hybrid (Local + Analytics) | Basit implementasyon + davranış verisi |

## Mimari

### Yeni Dosyalar

- `core/services/app_review_manager.dart` — Singleton manager (Hardware Manager Pattern)
- `features/settings/widgets/rate_us_tile.dart` — Settings'teki kalıcı buton

### Mevcut Dosya Değişiklikleri

- `match_celebration_screen.dart` — Kutlama sonrası review tetikleme
- `core/services/analytics_manager.dart` — 3 yeni event
- `pubspec.yaml` — `in_app_review` paketi
- `settings_screen.dart` — Rate Us tile ekleme
- Tüm i18n dosyaları (14 dil) — review string'leri

### Paket

- `in_app_review` — Native iOS/Android store review dialog

## AppReviewManager

Singleton, Hardware Manager Pattern'e uygun. `in_app_review` paketini sarar, SharedPreferences ile state yönetir.

### SharedPreferences State

| Key | Tip | Default | Açıklama |
|-----|-----|---------|----------|
| `qulo_app_review_shown_count` | int | 0 | Kaç kez gösterildi (max 3) |
| `qulo_app_review_last_shown` | String (ISO date) | null | Son gösterim tarihi |
| `qulo_app_review_completed` | bool | false | 3. gösterim sonrası true |

### Karar Mantığı: `shouldShowReview()`

```
1. completed == true → gösterme
2. shown_count >= 3 → gösterme (completed = true yap)
3. last_shown ile şimdi arası < 14 gün → gösterme
4. Platform isAvailable() → false ise gösterme
5. Hepsi geçerse → göster
```

### Public API

```dart
class AppReviewManager {
  // Singleton
  static final AppReviewManager instance = AppReviewManager._();

  // Akıllı tetikleme (cooldown + sayaç kontrolü yapar)
  Future<void> tryShowReview({required String trigger});

  // Settings'ten çağrı (cooldown kontrolü YAPMAZ)
  Future<void> requestReviewFromSettings();
}
```

## Tetikleme Akışı

### Match Kutlaması Sonrası

```
MatchCelebrationScreen
  → Kullanıcı "Start Chat" veya "Go Back" butonuna basar
  → Navigasyon işlemi ÖNCE yapılır (kullanıcı beklemez)
  → AppReviewManager.tryShowReview(trigger: 'match_celebration') çağrılır
  → shouldShowReview() kontrol eder
  → true ise native dialog gösterilir + analytics loglanır
  → false ise sessizce atlanır
```

**Navigasyon önce yapılır** çünkü native review dialog overlay olarak çalışır, arkadaki ekranı bloklamaz. Kullanıcı kutlama ekranında takılı kalmaz.

## Settings Entegrasyonu

Legal bölümünün altına eklenir:

```
Legal
  ├─ Terms of Service
  ├─ Privacy Policy
  └─ Rate Us ⭐
Account
  ├─ Blocked Users
  ...
```

### Rate Us Tile Davranışı

- Tıklanınca `AppReviewManager.requestReviewFromSettings()` çağrılır
- Cooldown/sayaç kontrolü **yapmaz** (kullanıcı bilinçli olarak tıklıyor)
- `appReviewPrompted` event'i loglanır (`trigger: settings`)
- `in_app_review` `isAvailable()` false dönerse → `url_launcher` ile store sayfası açılır (fallback)

## Analytics

| Event | Params | Ne Zaman |
|-------|--------|----------|
| `appReviewPrompted` | `trigger`, `shown_count` | Dialog gösterildiğinde |
| `appReviewDismissed` | `trigger` | Kullanıcı dismiss ettiğinde |
| `appReviewCompleted` | `trigger` | Kullanıcı değerlendirdiğinde |

**Not:** `in_app_review` paketi iOS'ta dismiss/complete ayrımını garanti etmiyor (Apple kısıtlaması). `requestReview()` çağrıldığında `appReviewPrompted` loglanır. `completed` flag'i 3. gösterim sonrası true olur (sonuçtan bağımsız).

## i18n

Tüm 14 dile çeviri yapılacak:

| Dil | `rate_us` | `rate_us_subtitle` |
|-----|-----------|-------------------|
| en | Rate Us | Love Qulo? Leave us a review! |
| tr | Bizi Değerlendir | Qulo'yu seviyor musun? Bize yorum bırak! |
| de | Bewerte uns | Liebst du Qulo? Hinterlasse uns eine Bewertung! |
| fr | Évaluez-nous | Vous aimez Qulo? Laissez-nous un avis ! |
| es | Califícanos | ¿Te gusta Qulo? ¡Déjanos una reseña! |
| it | Valutaci | Ti piace Qulo? Lasciaci una recensione! |
| pt | Avalie-nos | Gosta do Qulo? Deixe-nos uma avaliação! |
| pl | Oceń nas | Lubisz Qulo? Zostaw nam opinię! |
| ru | Оцените нас | Нравится Qulo? Оставьте отзыв! |
| ko | 평가하기 | Qulo가 마음에 드시나요? 리뷰를 남겨주세요! |
| ja | 評価する | Quloが気に入りましたか？レビューを書いてください！ |
| zh | 评价我们 | 喜欢Qulo吗？给我们留下评价吧！ |
| ar | قيّمنا | هل تحب Qulo؟ اترك لنا تقييمًا! |
| hi | हमें रेट करें | क्या आपको Qulo पसंद है? हमें रिव्यू दें! |
| sv | Betygsätt oss | Gillar du Qulo? Lämna en recension! |

## Edge Cases

### Platform Farklılıkları
- **iOS:** `requestReview()` yılda 3 kez gösterebilir (Apple kısıtı). 3 max + 14 gün cooldown uyumlu
- **Android:** Google'ın kendi kotasına tabi. Ek kısıtlama gerekmez
- **`isAvailable()` false:** Settings'te fallback olarak store URL, akıllı tetiklemede sessizce atlanır

### Logout/Hesap Değişikliği
- Review state cihaza bağlı, hesaba değil — logout'ta sıfırlanmaz
- Bilinçli karar: aynı cihazda farklı hesapla bile fazla rahatsız etmeyiz

### Hata Durumları
- `in_app_review` exception → try-catch ile sessizce logla, kullanıcı etkilenmez
- SharedPreferences yazma hatası → sonraki sefere ertelenir, kritik değil

### Uygulama İlk Açılışı
- Taze kurulumda: count=0, completed=false, last_shown=null
- null last_shown → cooldown kontrolü atlanır → ilk uygun anda gösterilebilir
