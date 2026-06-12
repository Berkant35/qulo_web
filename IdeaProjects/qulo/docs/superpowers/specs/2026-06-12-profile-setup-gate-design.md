# Profile Setup Gate — Foto + Soru Zorunluluğu (Hard Gate)

**Tarih:** 2026-06-12
**Branch hedefi:** APP-1915
**Durum:** Design (brainstorming çıktısı)
**Etkilenen katmanlar:** Mobile (qulov2), Server (qulo-server), DB (Supabase)

---

## 1. Problem ve Hedef

Production'da ~40 user (1.5 hafta) onboarding'i tamamlıyor fakat **fotoğraf yüklemeden** ve **soru oluşturmadan** Discover'a düşüyor. Bu iki eksiklik şu sonuçları doğuruyor:

- Kullanıcı kendi profili boş — match alma şansı düşük (aktivasyon zayıf)
- Discover algoritması bu kullanıcıları havuzda görüyor ama soft banner geçilebildiği için kalite düşük profil havuza dahil oluyor
- Soru-cevap mekaniğinin temeli (`AppConstants.minQuestions = 2`) zaten 2 soru gerektiriyor ama enforcement yumuşak (banner) — kullanıcı yine de swipe edebiliyor

**Hedef:** Foto ve soru eşiğini hard gate'e dönüştürmek; hem yeni hem mevcut 40 user için tek noktada (Discover öncesi) zorla tamamlatmak. Az kod, mevcut design dili, mevcut pattern'ler (`age == null` router guard'ının simetriği). Friction'ı en aza indirmek için **AI Magic Fill + Quick Assign** opsiyonları sunulur.

---

## 2. Mimari Karar — GoRouter Redirect Guard (`age == null` pattern'inin simetriği)

Yeni screen `ProfileSetupGateScreen` `onboarding` feature'ı altına eklenir. Mevcut `age == null → /profile-completion` redirect guard'ının altına ek koşul:

```dart
if (isAuth && user.age != null && state.matchedLocation != '/profile-setup') {
  final hasPhoto = (user.photos?.isNotEmpty ?? false);
  final hasQuestions = user.questionCount >= 2;
  if (!hasPhoto || !hasQuestions) return '/profile-setup';
}
```

`setupComplete` field **mobile-side computed** — server'a yeni alan eklemiyoruz. `userProvider.refresh()` foto upload veya question create sonrası otomatik tetikleniyor (mevcut pattern), router redirect re-evaluate olur.

**Reddedilen alternatifler:**
- Discover screen içinde conditional render — iki sorumluluk karışır, deep-link patolojisi, 200-satır kuralı ihlal riski
- MainShell wrapper — bottom nav'ı tamamen kapatır, Profile/Settings'e erişim engellenir, agresif

---

## 3. Eşikler ve Akış

### Eşikler
- **Min foto:** 1
- **Min soru:** 2 (mevcut `AppConstants.minQuestions` korunuyor)

### Gate Screen Akışı
Tek full-screen `AppScaffold` + iki paralel görev card'ı:

```
Header: "Birkaç adım kaldı" + alt subtitle
  ┌─ Foto Card (Setup Card)
  │    icon + title + subtitle + CTA "Foto Ekle"
  │    Tamamlanınca: yeşil check_circle (mevcut _GenderCard pattern)
  └─ Soru Card (üç yol)
       ✨ Sihirli Doldur (primary gradient) → BriefSheet
       ⚡ Hemen Ata (secondary outlined) → quick-assign
       Kendim Oluştur (text link) → mevcut /questions/create flow
       Tamamlanınca: "2 soru hazır" + edit ikonu
```

İkisi de tamamlanınca → `userProvider.refresh()` → router redirect → otomatik `/discover`.

### "Sen seç, ben uğraşmayayım" yolu
- **BriefSheet altında text link:** Interests boş bırakılır → server demografik fallback ile 2 soru üretir → preview sheet → assign
- **Preview sheet altında text link:** Aynı şekilde bank fallback ile direkt assign
- **"Hemen Ata" CTA:** Brief sheet'i hiç görmeden tek tap → quick-assign endpoint → 2 soru direkt atama

Friction tamamen opsiyonel: kullanıcı 5 saniyede gate'i geçebilir (tek tap foto + tek tap Hemen Ata).

---

## 4. UI — Mevcut Design Sistem Pattern'leri

Yeni widget icat edilmez; mevcut `_GenderCard`, `AppButton`, `FilterChip`, `ListBottomSheetWidget`, `PremiumSuggestionSheet` pattern'leri kopyalanır.

### Reuse Tablosu

| Pattern | Yeniden kullanım |
|---------|------------------|
| `AppScaffold` | Page kabı (maxWidth 560, pagePadding 16, gradient bg) |
| `_GenderCard` pattern | `_SetupCard` (foto) + `_SetupQuestionCard` (soru) |
| `AppButton` (primary/secondary/text) | Sihirli Doldur / Hemen Ata / Kendim Oluştur |
| `FilterChip` (onboarding language page) | Interest chip grid |
| `ListBottomSheetWidget` | Foto kaynak seçici (kamera/galeri) |
| `PremiumSuggestionSheet` stili | BriefSheet + AI Preview Sheet (drag handle, close, hero, CTA hierarchy) |
| `ProfileCompletionMixin` pattern | `ProfileSetupMixin` (state, lifecycle, async operasyon yönetimi) |
| `image_picker_manager` | Foto seçimi |
| `user_repository.uploadPhoto` | Foto upload |

### Yeni Dosyalar (Mobile)

- `lib/features/onboarding/screens/profile_setup_screen.dart` (~120 satır)
- `lib/features/onboarding/widgets/setup_photo_card.dart` (~80 satır)
- `lib/features/onboarding/widgets/setup_question_card.dart` (~100 satır)
- `lib/features/onboarding/widgets/setup_brief_sheet.dart` (~140 satır)
- `lib/features/onboarding/widgets/setup_ai_preview_sheet.dart` (~120 satır)
- `lib/features/onboarding/mixins/profile_setup_mixin.dart` (~200 satır)
- `lib/routing/app_router.dart` (mevcut, redirect güncelleme)
- `lib/data/models/user_model.dart` (mevcut, `interests` field eklenir)

### Design Tokens (mevcut, hardcode YASAK)

| Element | Token |
|---------|-------|
| Card padding | `AppSpacing.lg` (16) |
| Card border radius | `AppSpacing.radiusMd` (12) |
| Selected border | `appColors.primary`, 2px |
| Selected bg | `appColors.primarySurface` (10% mor) |
| Glow shadow | `primary.withAlpha(20%)`, blurRadius 12 |
| Title | `headlineMedium` (20px, 600w) |
| Card title | `titleLarge` (16px, 600w) |
| Card subtitle | `bodyMedium` + `textSecondary` |
| Skip link | `bodyMedium` + `onSurfaceVariant` |
| Primary button | `primaryButtonGradient` |
| Animation | 200ms card, 300ms sheet |

---

## 5. Server Etkisi

### 5.1 Migration `028_profile_setup_gate.sql`

```sql
-- Yeni kolonlar
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS interests TEXT[] DEFAULT '{}' NOT NULL,
  ADD COLUMN IF NOT EXISTS question_count INT DEFAULT 0 NOT NULL;

-- Backfill mevcut user'lar (40 user dahil)
UPDATE users u
SET question_count = (SELECT COUNT(*) FROM questions q WHERE q.user_id = u.id);

-- Indexler
CREATE INDEX IF NOT EXISTS idx_users_interests ON users USING GIN (interests);
CREATE INDEX IF NOT EXISTS idx_users_question_count ON users(question_count);

-- Trigger: questions insert/delete → users.question_count cache sync
CREATE OR REPLACE FUNCTION sync_user_question_count() RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE users SET question_count = question_count + 1 WHERE id = NEW.user_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE users SET question_count = GREATEST(question_count - 1, 0) WHERE id = OLD.user_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_user_question_count ON questions;
CREATE TRIGGER trg_sync_user_question_count
  AFTER INSERT OR DELETE ON questions
  FOR EACH ROW EXECUTE FUNCTION sync_user_question_count();
```

`question_count` cache eklemenin sebebi: `getMe()` artık her çağrıda `COUNT(*)` query'si yapıyor (audit:user.service.ts:33-36). Gate aktif olunca `getMe()` daha sık çağrılacak → cache zorunlu.

### 5.2 Yeni Endpoint: `POST /api/v1/users/me/interests`

```typescript
// Body
{ interests: string[] }   // 0-12 arası, curated pool

// Response
{ success: true, interests: string[] }
```

`user.validator.ts`'ye `setInterestsSchema` eklenir (Zod, max 12, curated enum). `user.controller.ts`'ye `setInterestsHandler`. Auth + `generalLimiter` middleware.

### 5.3 Yeni Endpoint: `POST /api/v1/users/me/quick-assign-questions`

```typescript
// Body: yok
// Response
{ assignedCount: number, assignedQuestionIds: string[] }
```

**Server akışı (`question.service.ts` içine yeni method):**
1. User'ın mevcut question count'unu çek
2. `needed = Math.max(0, 2 - currentCount)` — sadece eksik kadar ekle
3. Subscription limit kontrolü (`subscriptionService.getLimits().maxQuestions`)
4. `aiSuggestService.suggest({ profile_based: true, count: needed, locale: user.locale })` çağır
5. Sonuçları sıra ile `questions` tablosuna INSERT (order_num = currentCount + i + 1)
6. Trigger otomatik question_count'u günceller
7. Response döndür

**MAX_QUESTIONS_REACHED edge case:** `needed = 0` olursa endpoint 200 + `{ assignedCount: 0 }` döndürür, mobile bunu "zaten yeterli" olarak göster.

### 5.4 Mevcut Endpoint Genişletme — `POST /api/v1/questions/ai-suggest`

Mevcut endpoint korunur. Magic Fill akışı bunu çağırır. Body: `{ profile_based: true, count: 2, locale }`. Preview döner, mobile onayladıktan sonra **mobile** mevcut `POST /questions/me` endpoint'ine 2 ardışık çağrı yapar.

Server tarafı değişikliği YOK. Sadece mobile entegrasyon.

### 5.5 Discover Filter Güncellemesi (`matching.service.ts`)

`matching.service.ts:220-241` arasındaki question filter'ın yanına:

```typescript
// Hard gate: must have 1+ photo
discoverableFiltered = discoverableFiltered.filter((c) => {
  const photoCount = c.photos?.length ?? 0;
  return photoCount >= 1;
});
```

Tek nokta — discover query duplicate'i yok (audit doğruladı).

### 5.6 `users.service.getMe()` Optimizasyonu

`question_count` artık cache kolonu — `getMe()` içindeki `COUNT(*) FROM questions` query'si silinir, select listesine `question_count` eklenir. Response field adı **kırılmaz** — mobile'a hala `question_count` (snake_case) ve `questionCount` (alias) döner.

### 5.7 Validation, Rate Limit, Error Convention

- **Validation:** Zod schema, mevcut `user.validator.ts` pattern'i
- **Rate limit:** `generalLimiter` (100/min) — quick-assign için ek limit gerekmiyor çünkü server-side question bank kullanılıyor (LLM cost yok)
- **Error:** Mevcut `AppError(code, statusCode, message, params)` pattern'i. Yeni error code'lar:
  - `INTERESTS_INVALID` (400)
  - `QUICK_ASSIGN_NO_BANK_MATCH` (404) — bank'te uygun soru bulunamadı

### 5.8 Mevcut Audit Bulgularına Yanıt

| Audit notu | Yanıt |
|------------|-------|
| `question_count` cache yok, on-demand COUNT | **Cache ekleniyor + trigger** (5.1) |
| Discover'da photo filter yok | **Ekleniyor** (5.5) |
| `interests` yok | **Ekleniyor** (5.1) |
| AI Suggest LLM değil, bank | **Mevcut tutuluyor**, LLM yok (cost güvencesi) |
| Subscription max question limit (free: 3) | Quick Assign `needed = 2 - current` ile aşmaz (5.3) |
| Profile completion 16-sinyal formülü | **Dokunulmuyor** — bonus reward sistemi yan etkisi açılmaz |
| profileGuard sadece age check | **Yeni endpoint'ler sadece `requireAuth` altına** — gate dışına çıkmaya gerek yok |
| recalculateProfileCompletion fire-and-forget | Dokunulmuyor, bu spec'in scope dışı |

---

## 6. Locale Keys (16 dil)

**Toplam 33 yeni key × 16 dil = 528 satır locale güncellemesi.** Format: `qulov2/lib/core/l10n/translations/<locale>.dart`. EN + TR baseline aşağıda. Kalan dillere LLM çeviri (i18n-guardian skill).

### Gate Screen
| Key | EN | TR |
|-----|-----|-----|
| `setup_title` | A few steps left | Birkaç adım kaldı |
| `setup_subtitle` | Complete your profile to start matching | Profilini tamamla, eşleşmen başlasın |
| `setup_hint` | In a hurry? Tap Quick Assign | Acelen mi var? Hemen Ata seç |
| `setup_photo_title` | Add your photo | Fotoğrafını ekle |
| `setup_photo_subtitle` | No one can see you without a photo | Fotoğrafsız kimse seni göremez |
| `setup_photo_cta` | Add Photo | Foto Ekle |
| `setup_photo_done` | Photo added | Fotoğraf hazır |
| `setup_photo_picker_camera` | Take a Photo | Kameradan Çek |
| `setup_photo_picker_gallery` | Choose from Gallery | Galeriden Seç |
| `setup_photo_permission_denied` | Permission denied. Go to Settings to grant. | İzin reddedildi. Ayarlardan izin ver. |
| `setup_photo_upload_error` | Couldn't upload, try again | Yükleme başarısız, tekrar dene |
| `setup_question_title` | Prepare your questions | Sorularını hazırla |
| `setup_question_subtitle` | 2 questions needed to start matching | Eşleşmek için 2 soru gerekli |
| `setup_question_magic_cta` | ✨ Magic Fill | ✨ Sihirli Doldur |
| `setup_question_quick_cta` | ⚡ Quick Assign | ⚡ Hemen Ata |
| `setup_question_manual_cta` | Create Myself | Kendim Oluştur |
| `setup_question_done` | 2 questions ready | 2 soru hazır |
| `setup_quick_assign_error` | Couldn't assign questions | Soru atayamadık |
| `setup_exit_confirm_title` | Exit setup? | Çıkış yapayım mı? |
| `setup_exit_confirm_body` | You'll be logged out. Photos and questions you added stay saved. | Çıkış yapacaksın. Eklediklerin kayıtlı kalır. |
| `setup_exit_confirm_stay` | Stay | Kal |
| `setup_exit_confirm_logout` | Log Out | Çıkış Yap |
| `setup_completing` | Almost ready... | Neredeyse hazır... |

### Brief Sheet
| Key | EN | TR |
|-----|-----|-----|
| `brief_sheet_title` | I'll create 2 questions for you | Senin için 2 soru üreteceğim |
| `brief_sheet_hint` | Pick a few interests (min 1, 3 recommended) | Birkaç ilgi alanı seç (min 1, 3 önerilen) |
| `brief_sheet_generate_cta` | Generate My Questions → | Sorularımı Üret → |
| `brief_sheet_skip_link` | You choose, I won't bother | Sen seç, ben uğraşmayayım |

### Interest Tag Pool (12 sabit)
| Key | EN | TR |
|-----|-----|-----|
| `interest_music` | Music | Müzik |
| `interest_movies` | Movies | Sinema |
| `interest_sports` | Sports | Spor |
| `interest_career` | Career | Kariyer |
| `interest_relationships` | Relationships | İlişki |
| `interest_travel` | Travel | Seyahat |
| `interest_food` | Food | Yemek |
| `interest_books` | Books | Kitap |
| `interest_gaming` | Gaming | Oyun |
| `interest_art` | Art | Sanat |
| `interest_fitness` | Fitness | Fitness |
| `interest_personality` | Personality | Kişilik |

### AI Preview Sheet
| Key | EN | TR |
|-----|-----|-----|
| `preview_sheet_title` | Here are your 2 questions | İşte 2 sorun |
| `preview_sheet_assign_cta` | Assign My Questions | Sorularımı Ata |
| `preview_sheet_regen_cta` | Regenerate | Yeniden Üret |
| `preview_sheet_skip_link` | You choose, I won't bother | Sen seç, ben uğraşmayayım |
| `preview_sheet_error` | Couldn't generate, try again | Üretemedim, tekrar dene |

i18n-guardian skill plan aşamasında tüm dillere yayar.

---

## 7. Analytics Events

`analytics_events.dart`'a eklenecek event'ler (mevcut convention):

```dart
static const String setupGateView = 'setup_gate_view';
static const String setupPhotoStart = 'setup_photo_start';
static const String setupPhotoSuccess = 'setup_photo_success';
static const String setupPhotoFail = 'setup_photo_fail';
static const String setupMagicFillStart = 'setup_magic_fill_start';
static const String setupMagicFillAssign = 'setup_magic_fill_assign';
static const String setupMagicFillRegen = 'setup_magic_fill_regen';
static const String setupMagicFillSkip = 'setup_magic_fill_skip';
static const String setupQuickAssign = 'setup_quick_assign';
static const String setupManualCreate = 'setup_manual_create';
static const String setupComplete = 'setup_complete';
static const String setupExitAttempt = 'setup_exit_attempt';
static const String setupExitConfirm = 'setup_exit_confirm';
```

`AnalyticsManager.updateUserProperties` çağrısına `questionsCount` field'ı eklenir (mevcut çağrıda eksik — audit notu).

Drop-off ölçümü: `setupGateView` ile `setupComplete` arasındaki funnel. Hangi CTA'nın daha çok kullanıldığı: `setupMagicFillAssign`, `setupQuickAssign`, `setupManualCreate` oranı.

---

## 8. Edge Case Matrisi (Audit Tabanlı)

| # | Edge Case | Çözüm |
|---|-----------|-------|
| 1 | Profile completion mixin'in agresif back logout pattern'i | Gate'te `PopScope canPop: false` + back tap'inde **confirm dialog** (`setup_exit_confirm_*`). Aksi halde mevcut pattern session kaybına yol açar. |
| 2 | `userProvider` race (fetchMe in-flight + redirect) | Mevcut `copyWithPrevious` korur. Gate'te ek olarak `isProcessing` action lock state — concurrent CTA tap engellenir. |
| 3 | `getMe()` performance (her çağrıda COUNT) | Migration 028 cache + trigger |
| 4 | Foto upload permission denied | `ImagePickerPermissionException` catch → snackbar + "Ayarlara Git" CTA |
| 5 | AI bank kuraklığı (filter'a uyan soru yok) | Server fallback: gender drop → age drop. Mobile: `preview_sheet_error` snackbar + "Hemen Ata" veya "Kendim Oluştur" yönlendirmesi |
| 6 | Free tier max question limit (3) | Quick Assign `needed = 2 - current_count` ile mevcut sınırı aşmaz |
| 7 | Concurrent foto + quick assign tap | `isProcessing` state lock |
| 8 | Mevcut 40 user'a etki | Bir sonraki app açılışında otomatik gate. Push notif kampanyası ayrı story (backlog) |
| 9 | Deep link replay | Mevcut `pendingDeepLinkProvider` setup_complete sonrası replay, ek kod yok |
| 10 | Profile completion % formülü | **Dokunulmuyor** — bonus reward sistemi yan etkisi açılmaz |
| 11 | Yeni endpoint'ler profileGuard'a takılır mı? | Sadece `requireAuth` altına — gate dışına çıkmaya gerek yok |
| 12 | Photo filter eklenince mevcut fotosuz user'lar discover havuzundan düşer | Bilinçli karar (kullanıcı kuralı). Push notif kampanyası ayrı story (backlog) — sessiz disappearance riski uyarılır |

---

## 9. Test Plan

| Senaryo | Beklenen |
|---------|----------|
| Yeni user signup → age complete → gate açılır | ✓ |
| Mevcut user (0 foto, 0 soru) login → gate açılır | ✓ |
| Mevcut user (0 foto, 3 soru) login → gate açılır (foto eksik) | ✓ |
| Mevcut user (1 foto, 1 soru) login → gate açılır (soru eksik) | ✓ |
| Mevcut user (1 foto, 2 soru) login → discover (gate yok) | ✓ |
| Gate'te foto ekle + magic fill assign → otomatik discover | ✓ |
| Gate'te quick assign → 2 soru ata + foto ekle → discover | ✓ |
| Brief sheet "sen seç" → demografik fallback ile 2 soru | ✓ |
| Free tier user 2 soru yazmış, quick assign tap → 1 soru daha ekle (limit aşımı yok) | ✓ |
| Back tuşu → confirm dialog → "Kal" → gate'te kal | ✓ |
| Back tuşu → confirm dialog → "Çıkış" → logout + login | ✓ |
| Fotosuz user (gate'e yakalanmış) **diğer user'ların discover havuzunda görünmüyor** | ✓ |
| App background → foreground → permission re-check | ✓ |
| 16 dil string testi (i18n-guardian) | ✓ |
| Mobile-server desync (foto upload başarılı, server cache geç) | ✓ (copyWithPrevious + auto refresh) |

---

## 10. Rollout Sırası

1. **Server tarafı:** Migration 028 → backfill → trigger → discover photo filter → `quick-assign-questions` endpoint → `interests` endpoint → `getMe()` cache optimizasyonu
2. **Server review:** `/server-review` skill (otomatik, mevcut kural)
3. **Mobile tarafı:** UserModel'e `interests` ekle → profile_setup_screen + widget'lar + mixin → router guard → analytics events
4. **Locale:** 16 dile 33 key (i18n-guardian skill ile EN/TR baseline + LLM çeviri)
5. **Flutter review:** `/flutter-review` skill (otomatik, mevcut kural)
6. **Test:** Manual test plan + 16 dil i18n kontrolü
7. **TestFlight + Internal track:** Yayın
8. **Backlog (bu spec dışı):** Mevcut 40 user'a "Profilini tamamla" push notif kampanyası (`setup_complete=false` segment)

---

## 11. Scope Out — Bilinçli Dışarıda Bırakılanlar

- **Bio zorunluluğu:** Aktivasyon için kritik değil, ileride değerlendirilir
- **Push notif kampanyası:** Ayrı story (rollout backlog item)
- **Interest → match score bonus:** Şimdilik sadece data toplama, ileride algoritma genişlemesi
- **AI prompt LLM upgrade:** `ai_question_bank` yeterli, LLM cost bu sürümde gerekmez
- **Profile completion % formülü değişimi:** Bonus reward sistemi yan etkisi açılmaz
- **Quiz/Chat tab'lerinde gate:** Sadece Discover blok edilir; diğer tab'lerden eksik tamamlanabilir
- **Bottom nav gizleme:** Gate full-screen ama bottom nav görünür kalır (kullanıcı Profile/Settings'e gidebilir — gate router-side zaten Discover'a izin vermiyor)

---

## 12. Memory Hatırlatmaları (Bu Spec'i Hazırlarken Uygulanan Kurallar)

- [Mevcut pattern'i yeniden kullan](../../../memory/feedback_reuse_existing_patterns.md) — `age == null` router guard + `_GenderCard` + `PremiumSuggestionSheet` + `ProfileCompletionMixin`
- [Localization zorunlu](../../../memory/feedback_localization_required.md) — 33 key × 16 dil, hardcode yasak
- [Edge case'leri araştır](../../../memory/feedback_no_assumptions_monorepo.md) — Server + Mobile audit'leri spec'i besledi (varsayım yok)
- [Otomatik Review](../../../memory/feedback_auto_review.md) — `/server-review` + `/flutter-review` rollout adımlarında
- [i18n-guardian businessCaseSkill](../../../memory/feedback_business_case_skills.md) — 16 dil yayım otomatik

---

**Sıradaki adım:** Bu spec onaylandıktan sonra `superpowers:writing-plans` skill'i ile implementation plan oluşturulur.
