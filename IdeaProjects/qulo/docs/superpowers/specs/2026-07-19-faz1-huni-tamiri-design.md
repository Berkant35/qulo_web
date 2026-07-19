# Faz 1 — Huni Hızlı Tamiri + Ölçüm Altyapısı (v2.0.6)

> Kaynak: `docs/roadmap/2026-07-19-retention-onboarding-phases.md` — "Ortak Bağlam" + "FAZ 1".
> Oluşturma: 2026-07-19. Durum: onaylandı (tasarım), spec review bekliyor.
> Hedef: reklam öncesi huni tamiri — carousel'i öne al, social-first giriş, paywall'ı ertele, funnel ölçümünü başlat.

## Amaç

Reklamdan gelen kullanıcı uygulamayı **anlamadan** kayıt hunisine giriyor; carousel + paywall auth/setup gate'lerinin arkasında kalıyor; funnel ölçümü yok. Bu faz mevcut parçaların **yerini/sırasını** değiştirir (büyük yeniden tasarım yok) ve funnel event'lerini ekler.

## Kararlar (brainstorming, kilitli)

1. **Pre-auth akış:** Carousel → yeni social-first landing ekranı.
2. **Dil persist:** Seçim local saklanır, auth sonrası flush edilir.
3. **Paywall tetiği:** Carousel sonu kaldırılır → ilk eşleşme sonrasına taşınır (tek seferlik).
4. **Analytics katmanı:** Hibrit — tüm funnel Firebase'e; auth sonrası event'ler ayrıca server `flow_events`'e.

## Yeni açılış akışı

```
splash (/)
  └─ [YENİ guard] onboarding_v2_seen == false && !authenticated?
        └─ /onboarding (carousel — AUTH ÖNCESİ)
             ├─ Skip → onboarding_v2_seen=true → /auth/landing
             └─ "Başla" → dilleri LOCAL kaydet (pending_languages)
                          → onboarding_v2_seen=true → /auth/landing
                          (paywall YOK)
  └─ /auth/landing (YENİ social-first ekran)
        ├─ Google/Apple → socialLogin → [profile-completion gate] → /discover
        └─ "E-posta ile devam" → /auth/login (register linki içinde kalır)
  └─ [mevcut auth+setup guard'ları] → /discover
        └─ auth olunca: pending_languages varsa PUT /users/me/languages → temizle
        └─ İLK EŞLEŞME olunca: premium sheet bir kez (flag) → paywall_shown event
```

---

## 1.3 — Carousel'i auth öncesine alma + dil persist

### Mevcut durum (keşif, doğrulanmış)
- Carousel `_MainShell.initState` → `_checkOnboarding` (`qulov2/lib/routing/app_routes.dart:398-409`) ile, tüm auth+setup guard'ları geçildikten SONRA imperatif `push` ile açılıyor.
- Flag okuma: `onboarding_v2_seen` (primary) + `onboarding_questions_seen` (legacy). Yazma: mixin `_markSeen` (`onboarding_screen_mixin.dart:133-137`).
- Dil seçimi carousel sayfa 5 (`onboarding_language_page.dart`); `onStart()` (`onboarding_screen_mixin.dart:106-116`) → `userLanguagesProvider.save()` → `UserRepository.setUserLanguages()` → `PUT /users/me/languages` (`user_repository.dart:227-236`) — **JWT zorunlu**, auth öncesi 401.

### Değişiklikler

**A. Tetik taşıma (imperatif → router guard)**
- `_MainShell.initState`'teki `_checkOnboarding` push'u **kaldırılır** (çift gösterimi önlemek için).
- `onboarding_v2_seen` flag'i splash bootstrap'ında yüklenir ve senkron erişilebilir bir `OnboardingSeenNotifier` (StateNotifier<bool>) ile tutulur (mevcut auth-refresh pattern'iyle simetrik).
- `app_router.dart` redirect zincirine, "auth değil → /auth/login" bloğundan **ÖNCE** guard eklenir:
  - `!onboardingSeen && !authenticated && hedef != /onboarding` → redirect `/onboarding`.
- Router `refreshListenable`'a onboarding notifier eklenir (flag değişince redirect yeniden çalışır).
- `/onboarding` route root navigator'da tam ekran kalır (mevcut).

**B. Dil persist (local → auth sonrası flush)**
- Yeni `PendingLanguagesStore` (SharedPreferences key `pending_languages`, JSON string list). Tek sorumluluk: pending dilleri yaz/oku/temizle.
- Carousel `onStart()`: `userLanguagesProvider.save()` çağrısı yerine `PendingLanguagesStore.write(selectedLanguages)`. (Auth öncesi olduğu için API çağrısı yapılmaz.)
- Flush: `AuthNotifier._postLoginInit()` içinde (login/register/social hepsinin ortak auth-tamamlanma noktası) → `PendingLanguagesStore.read()` boş değilse `UserRepository.setUserLanguages()` çağrılır; **başarılı olursa** key temizlenir (başarısızsa bir sonraki auth'ta tekrar denenir).
- Default seçim: cihaz dili destekli locale ise carousel'de ön-seçili gelir (`AppConstants.supportedQuestionLocales` kontrolü).

### Edge case'ler
- Carousel'den sonra auth olmadan app kapatılır → `pending_languages` kalıcı → sonraki başarılı auth'ta flush. ✓
- Mevcut (zaten authenticated, dili olan) kullanıcı → `onboarding_v2_seen` migration'ı sayesinde carousel görmez → pending yok → flush yok. ✓
- İki flag tutarlılığı: yazma her iki flag'i de set eder; okuma ikisini de kontrol eder (mevcut davranış korunur).

### Skip vs Başla (pre-auth)
- Her ikisi de `onboarding_v2_seen=true` set eder ve `/auth/landing`'e gider.
- **Başla**: dilleri local yazar. **Skip**: dil yazmaz (kullanıcı sayfa 5'e ulaşmadıysa seçim yok).

---

## 1.2 — Social-first landing ekranı

### Mevcut durum (keşif, doğrulanmış)
- `SocialLoginButtons` (`qulov2/lib/features/auth/widgets/social_login_buttons.dart`) — stateless, `onGooglePressed`/`onApplePressed` callback injection. Sadece `login_screen.dart:135`'te kullanılıyor.
- `socialLogin(provider)` logic'i `login_screen_mixin.dart:97-112` → `authProvider.notifier.socialLogin(provider)` (`auth_provider.dart:306-381`).
- Social login sonrası profile-completion gate zaten doğru çalışıyor (`app_router.dart:135-149`), routing değişikliği gerekmez.
- Login ve register ayrı route (`/auth/login`, `/auth/register`).

### Değişiklikler
- **Yeni ekran** `AuthLandingScreen` + `AuthLandingMixin`:
  - `AppScaffold`, <200 satır, logic mixin'de (widget sadece UI orchestration).
  - İçerik: kısa marka başlığı/tagline + `SocialLoginButtons` (yeniden kullanım — Google hep, Apple iOS) + "E-posta ile devam" butonu → `/auth/login`.
- **Loop refactor (zorunlu):** `socialLogin(provider)` şu an sadece `login_screen_mixin`'de. Landing de aynı davranışa ihtiyaç duyduğundan ortak bir `SocialAuthMixin`'e çıkarılır; hem login hem landing bunu kullanır (duplikasyon yok, reuse pattern). `AuthNotifier.socialLogin` ve `SocialLoginButtons` değişmeden kalır.
- **Route:** `/auth/landing` eklenir; unauthenticated + onboarding görüldü durumunda varsayılan hedef landing olur (redirect "auth değil" bloğu `/auth/login` yerine `/auth/landing`'e yönlendirir). Login ekranı çalışmaya devam eder (register/forgot linkleri, e-posta yolu buradan).
- **Register'a social buton eklenmez** — landing zaten social-first yüzey (kapsam sadeliği; roadmap 1.2 "veya auth landing social-first yeniden düzenlenir" seçeneği).

### Localization
- Yeni string'ler: tagline, "Google ile devam", "Apple ile devam", "E-posta ile devam" → 16 dilde (i18n-guardian). Buton metinleri mevcut social key'leri varsa yeniden kullanılır.

---

## 1.4 — Paywall ertelemesi (ilk eşleşme sonrası)

### Mevcut durum (keşif, doğrulanmış)
- `PremiumSuggestionSheet` yalnızca `onStart()` → `_showPremiumSuggestion()` (`onboarding_screen_mixin.dart:118-131`) ile açılıyor; skip'te gösterilmiyor. Sheet kapanınca `/discover`'a gidiyor.
- Sheet RevenueCat üzerinden `subscriptionProvider.purchaseByProductId` kullanıyor; içerik/ürünler değişmiyor.

### Değişiklikler
- `onStart()`'tan `_showPremiumSuggestion()` çağrısı **kaldırılır**. Carousel sonrası paywall yok; akış `/auth/landing`'e gider.
- **Yeni tetik:** kullanıcı **ilk eşleşmesini** yaşadığında `PremiumSuggestionSheet` bir kez gösterilir.
  - Guard: tek seferlik flag `paywall_after_first_match_shown` (SharedPreferences). `true` ise tekrar gösterilmez.
  - Gösterildiğinde `paywall_shown` funnel event'i (trigger='first_match') loglanır (post-auth → Firebase + server).
- **Açık nokta (plan aşamasında doğrulanacak):** match'in client-side tetik noktası. Keşifte match akışı taranmadı. Aday hook'lar: match provider / `new_match` notification handler / matches realtime (`2026-03-25-matches-realtime-design.md` referansı). Plan ilk adımı: bu hook'u tespit et, sheet'i oraya bağla. Sheet, kullanıcı match ekranındayken/döndüğünde uygun bir noktada tetiklenmeli (match kutlama akışını bozmadan).

### Ekonomi etki analizi (economy-impact)
- **Seviye: ORTA (3)** — config değeri değişmiyor (elmas/güç/tier/IAP aynı), sadece tetik zamanı; flag tabanlı, geri alınabilir.
- **Risk:** İmpression düşüşü — eski tetik carousel'i "Başla" ile bitiren herkese; yeni tetik sadece eşleşene. Cold start'ta (Faz 3) ilk eşleşme nadir olabilir → paywall gösterimi düşer. Karşı denge: niyet kalitesi yüksek → conversion artabilir.
- **Karar:** Devam. Ölçüm 1.1'deki `paywall_shown` event'iyle garanti; impression riski Faz 3 ile dengelenecek. (Log: `memory/economy_impact_log.md`.)

---

## 1.1 — Funnel analytics event'leri (hibrit)

### Mevcut durum (keşif, doğrulanmış)
- **`AnalyticsForwarder`** (`qulov2/lib/core/services/analytics_forwarder.dart`) → `POST /analytics/track` → Supabase `flow_events`. **JWT zorunlu** (`analytics.routes.ts`, authMiddleware). Batch, max 50 event, self-disabling. Şu an sadece dialog/sheet open/close forward ediliyor.
- **`AnalyticsManager`** (`qulov2/lib/core/services/analytics_manager.dart`, Firebase) — client-side, **auth öncesi çalışır**. Auth funnel event'leri zaten var (`analytics_events.dart`).

### Tasarım: `FunnelEvents` yardımcısı
İki metotlu ince sarmalayıcı (çağrı yerleri niyet-açık):
- `FunnelEvents.logPreAuth(name, {params})` → sadece `AnalyticsManager.logEvent` (Firebase).
- `FunnelEvents.logAuthed(name, {params})` → `AnalyticsManager.logEvent` + `AnalyticsForwarder.track` (Firebase + server flow_events).

Event adları `AnalyticsEvents` sabitlerine eklenir (hardcode yasak).

### Event listesi

**Pre-auth (Firebase only — `logPreAuth`):**
| Event | Params | Yer |
|---|---|---|
| `onboarding_carousel_page_view` | page_index, page_name | carousel page değişimi |
| `onboarding_carousel_skip` | at_page | skip |
| `onboarding_carousel_complete` | selected_languages | onStart (mevcut `onboardingV2Complete` ile hizala) |
| `auth_landing_view` | — | landing açılış |
| `auth_landing_social_selected` | provider | Google/Apple tıklama |
| `auth_landing_email_selected` | — | "E-posta ile devam" |
| `register_step_view` | step (1..7) | register PageView adım değişimi |
| `email_verification_completed` | — | doğrulama tamamlanma noktası |

**Post-auth (Firebase + server — `logAuthed`):**
| Event | Params | Yer |
|---|---|---|
| `profile_setup_photo_added` | — | profile setup foto |
| `profile_setup_questions_added` | count, method (magic/quick/manual) | profile setup soru |
| `profile_setup_gender_pref_set` | — | profile setup tercih |
| `first_discover_view` | — | ilk discover görüntüleme |
| `first_quiz_start` | — | ilk quiz başlatma |
| `first_quiz_complete` | result | ilk quiz bitirme |
| `paywall_shown` | trigger='first_match' | 1.4 tetik |

Not: `first_*` event'leri tek seferlik flag ile korunur (tekrar loglanmaz). Mevcut `onboardingV2*` event'leri korunur; çakışan varsa tek isimde birleştirilir.

---

## Değişmez kurallar (DoD öncesi)
- Localization: yeni her string 16 dilde (i18n-guardian). Hardcode string yasak.
- Widget/page sadece UI orchestration; logic mixin'de. Screen max ~200 satır. Raw Scaffold yerine `AppScaffold`.
- Dokunulan dosyada kural ihlali/refactor varsa aynı PR'da düzelt (loop refactor — özellikle `socialLogin` extraction).
- `dart analyze` sıfır hata + `/flutter-review` temiz.
- Server tarafı bu fazda **değişmiyor** (analytics endpoint mevcut, auth'lu kullanılıyor). Migration yok.

## Kapsam dışı (Backlog / sonraki fazlar)
- Register 7 adımının yeniden dağıtımı / pre-signup bilgi toplama → **Faz 2**.
- Paywall impression riskinin kalıcı dengesi (cold start / boş discover) → **Faz 3**.
- `/analytics/track`'i anonim'e açma (pre-auth server ölçümü) → Backlog (Faz 1 "hızlı tamir" kapsamını aşar; hibrit çözüm Firebase ile pre-auth'u zaten kapsıyor).

## DoD (roadmap)
`dart analyze` sıfır + `/flutter-review` temiz + funnel event'leri test cihazında doğrulanmış (server'a düştüğü + Firebase'e düştüğü görüldü) + carousel yeni konumda cihazda test (pre-auth, dil flush çalışıyor) + paywall ilk eşleşmede test + 2.0.6 build TestFlight'ta.

## Uygulama sırası (plan için taslak)
1. `FunnelEvents` + event sabitleri (1.1 altyapı — diğerleri buna event basar).
2. `PendingLanguagesStore` + auth sonrası flush (1.3-B).
3. `OnboardingSeenNotifier` + router guard, `_MainShell` push kaldırma (1.3-A).
4. `SocialAuthMixin` extraction + `AuthLandingScreen` + route (1.2).
5. Paywall: `onStart`'tan kaldır + match hook tespiti + first-match trigger (1.4).
6. Event basımlarını tüm noktalara yerleştir (1.1 tamamlama).
7. i18n (16 dil) + `/flutter-review` + `dart analyze` + cihaz testi.
