# Gender Preference Collection — Profile Setup Gate Genişletmesi

**Tarih:** 2026-06-13
**Branch hedefi:** APP-1915
**Durum:** Design (brainstorming çıktısı)
**Etkilenen katmanlar:** Mobile (qulov2), Server (qulo-server), DB (Supabase)
**Bağlı spec:** [2026-06-12-profile-setup-gate-design.md](2026-06-12-profile-setup-gate-design.md)

---

## 1. Problem ve Hedef

Discover'da herkesin "BOTH" gibi davranmasının kökeni: signup akışında `gender_pref` **hiç sorulmuyor**. DB'de field var (`gender_pref` enum: `MAN | WOMAN | BOTH`, default `'BOTH'`), server-side matching filter doğru çalışıyor (`matching.service.ts:146` — `gender_pref !== "BOTH"` ise filtre uyguluyor), ama mobile signup `register_screen_mixin.dart` (6 step: name → birthday → gender → location → email → terms) tercih sormuyor. Sonuç: tüm yeni kayıtlar DB default `'BOTH'` ile başlıyor, profile edit'ten manuel değiştirilmediği sürece discover'da herkesi görüyorlar.

**Tespit:** Mevcut `gender_pref` field "kullanıcı bilinçli seçti" mi yoksa "hiç sorulmadı default mu" ayrımını taşımıyor. Bu sebeple sadece UI'da soru sormak yetmez — bilinçli `BOTH` ile default `BOTH` ayrılamaz.

**Hedef:** Yeni kullanıcılarda signup'ta gender_pref'i sor, mevcut tüm "hiç sorulmamış" kullanıcıları Profile Setup Gate (2026-06-12 shipped) içinde yakala. `BOTH` seçeneği bilinçli bir seçim olarak korunur (biseksüel/pânseksüel kohort), sadece default olmaktan çıkar. Profile Setup Gate'in mevcut foto + soru kart pattern'inin **simetriği** olarak 3. kart eklenir — yeni mimari icat edilmez.

---

## 2. Mimari Karar — Profile Setup Gate'e 3. Hard Gate Koşulu

Profile Setup Gate'in router redirect logic'ine ek koşul:

```dart
if (isAuth && user.age != null && state.matchedLocation != '/profile-setup') {
  final hasPhoto = (user.photos?.isNotEmpty ?? false);
  final hasQuestions = user.questionCount >= 2;
  final hasGenderPref = user.genderPrefSetAt != null;  // YENİ
  if (!hasPhoto || !hasQuestions || !hasGenderPref) return '/profile-setup';
}
```

`gender_pref_set_at` field DB'ye eklenir — "bilinçli seçim ne zaman yapıldı" işareti. NULL ise gate yakalar, dolu ise geçer. Tüm mevcut kullanıcılar (40+) NULL ile başlar (backfill yok, geçmişte hiç sorulmadı).

**Reddedilen alternatifler:**
- **Ayrı gate screen** — Profile Setup Gate yeni shipped (2026-06-13), simetri bozulur, ek deep-link patolojisi, redundant router branch
- **Sadece signup'a step ekleme** — mevcut 40+ kullanıcı default `BOTH` ile kalır, kullanıcı kararı "hem yeni hem mevcut" gateline aykırı
- **Discover screen içinde inline modal** — `flutter-review` 200-satır kuralı ihlali, deep-link race, conditional render kalitesi düşük
- **`gender_pref` kolonunu NULLABLE yapıp default kaldırma** — eski kayıtların değeri kaybolur, production data riski; iki state (`gender_pref` + `_set_at`) ayırması daha temiz

---

## 3. DB Migration — `030_gender_pref_required.sql`

```sql
-- "Bilinçli seçim ne zaman yapıldı" işareti
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS gender_pref_set_at TIMESTAMPTZ;

-- NOT: backfill YOK. Geçmişte hiç sorulmadı; bilinçli seçim diyemeyiz.
-- Tüm production user'lar NULL → gate yakalar.

-- Test admin'ler gate'e takılmasın
UPDATE users SET gender_pref_set_at = NOW()
WHERE is_test_admin = true;

-- Partial index: sadece NULL kohortu için (gate filter, küçük index)
CREATE INDEX IF NOT EXISTS idx_users_gender_pref_set_at_null
  ON users(gender_pref_set_at) WHERE gender_pref_set_at IS NULL;
```

**Tasarım kararları:**
- `gender_pref` kolonu (enum, NOT NULL, DEFAULT `'BOTH'`) korunur — schema kırılma yok
- TIMESTAMPTZ tercih, BOOLEAN değil — analytics + ileride audit log entegrasyonu için
- DEFAULT yok — server explicit `NOW()` yazıyor; default `NOW()` koymak "set" vs "unset" ayrımını bozar
- Partial index — sadece NULL kohortu sorgulanıyor, küçük ve hızlı
- Fake profile seeding (2026-06-11 spec, henüz ship edilmemiş) implement edildiğinde script `gender_pref_set_at = NOW()` yazsın — bu spec o spec'i blokken etmez, sadece koordinasyon notu

---

## 4. Server Etkisi

### 4.1 `getMe()` Response — `user.service.ts:33-60`

Mevcut select listesine `gender_pref_set_at` eklenir:

```typescript
"id, email, name, ..., gender, gender_pref, gender_pref_set_at, ..."
```

Mobile model `genderPrefSetAt: DateTime?` olarak alır. Eski client'lar yeni field'ı görmezden gelir → backwards compat tam.

### 4.2 Profile Update — `user.service.ts updateProfile()`

Mevcut `gender_pref` update path'i her zaman `set_at`'i refresh eder:

```typescript
if (body.gender_pref !== undefined) {
  updates.gender_pref = body.gender_pref;
  updates.gender_pref_set_at = new Date().toISOString();
}
```

Profile edit'ten değiştirme = bilinçli seçim. İdempotent (aynı değer set edilirse de `set_at` refresh, sorun yok).

`user.validator.ts updateProfileSchema` mevcut `gender_pref: z.enum(["MAN", "WOMAN", "BOTH"]).optional()` korunur, ek validation gerekmez.

### 4.3 Signup Endpoint — `auth.service.ts register()` + `auth.validator.ts`

Validator update:

```typescript
// auth.validator.ts registerSchema
gender_pref: z.enum(["MAN", "WOMAN", "BOTH"]).optional()
```

Service insert path:

```typescript
const insertData: any = { ..., gender, locale, lat, lng };
if (body.gender_pref) {
  insertData.gender_pref = body.gender_pref;
  insertData.gender_pref_set_at = new Date().toISOString();
}
```

**Backwards compat:** Eski mobile client (yeni step yok) `gender_pref` göndermez → `set_at` NULL kalır → bir sonraki açılışta gate yakalar. Sıfır breaking change.

### 4.4 Matching Filter — Değişiklik YOK

`matching.service.ts:146` mevcut hâliyle çalışır:

```typescript
if (user.gender_pref && user.gender_pref !== "BOTH") {
  query = query.eq("gender", user.gender_pref);
}
```

Logic doğru — bilinçli `BOTH` seçen kullanıcı filtresiz havuz görür, bu istenilen davranış. `MAN` veya `WOMAN` seçen filter uygular.

### 4.5 Discover Pool — Gate-only Enforcement

Profile Setup Gate'in foto/soru için seçtiği simetri korunur: mobile gate yakalar, server pool filter eklenmez. Eski mobile client bypass etse bile (teorik) havuzda kalır. Gate yeterli.

### 4.6 Error Convention, Rate Limit

Yeni endpoint yok → ek error code yok. Mevcut `gender_pref` validation hatası `VALIDATION_ERROR` (400) ile döner. Rate limit gerekli değil — `PATCH /users/me` zaten `generalLimiter` altında.

---

## 5. Mobile (Flutter)

### 5.1 UserModel — `lib/data/models/user_model.dart`

```dart
@JsonKey(name: 'gender_pref_set_at')
final DateTime? genderPrefSetAt;
```

`build_runner` ile json_serializable regenerate.

### 5.2 Router Guard — `lib/routing/app_router.dart`

Profile Setup Gate redirect'ine ek koşul (Bölüm 2'deki snippet).

### 5.3 Gate Screen — `profile_setup_screen.dart`'a 3. Kart

Mevcut iki kart (`SetupPhotoCard`, `SetupQuestionCard`) sırasına `SetupGenderPrefCard` eklenir.

**Yeni dosya:** `lib/features/onboarding/widgets/setup_gender_pref_card.dart` (~90 satır)

```
┌─ Gender Pref Card
│    icon (people_outline) + title + subtitle
│    İçerikte 3 SegmentedButton chip: ♂ Erkek | ♀ Kadın | ⚭ Her ikisi
│    Seçim → PATCH /users/me { gender_pref } → set_at otomatik update
│    Tamamlanınca: yeşil check_circle + "Tercihin kaydedildi"
```

**Mevcut profile edit pattern'i kopyalanır** — `lib/features/profile/widgets/edit_profile_preferences_section.dart:32-54` referans (3-button SegmentedButton). Yeniden icat yok.

### 5.4 Signup Step — `register_screen_mixin.dart`

Mevcut 6 step (`totalSteps = 6`) → 7 step. Yeni step `gender` adımından hemen sonra:

```
sıra: name → birthday → gender → gender_pref (YENİ) → location → email → terms
```

**Yeni widget:** `lib/features/auth/widgets/register_gender_pref_step.dart` (~70 satır) — gate'teki `SetupGenderPrefCard`'ın aynı 3-chip pattern'i, register state'e bağlı.

`register()` metoduna gönder:
```dart
'gender_pref': state.selectedGenderPref,  // 'MAN' | 'WOMAN' | 'BOTH'
```

### 5.5 Social Login (Apple/Google) — Step YOK

Apple/Google signup akışı mevcut hâliyle korunur (minimum signup → profile completion → gate). Social login'de gender_pref step **eklenmez** — gate'te 3. kart doldurulur. Tutarlı, tek noktada kontrol.

### 5.6 Profile Edit Davranışı — Değişiklik YOK

`edit_profile_preferences_section.dart` mevcut hâliyle çalışır. Backend her `gender_pref` PATCH'inde `set_at`'i refresh ediyor → kullanıcı edit'ten değiştirirse de gate dışında kalır.

### 5.7 Analytics — `analytics_events.dart`

```dart
static const String signupGenderPrefSelected = 'signup_gender_pref_selected';
static const String setupGenderPrefSelected = 'setup_gender_pref_selected';
```

Properties: `value` (MAN/WOMAN/BOTH), `entry_point` (signup vs gate vs profile_edit).

Distribution analizi: bilinçli BOTH oranı (kohort kalite metriği).

---

## 6. Locale Keys (16 Dil)

EN + TR baseline. Kalan 14 dile **i18n-guardian skill** plan aşamasında yayar.

### Signup Step
| Key | EN | TR |
|-----|-----|-----|
| `register_gender_pref_title` | Who are you looking for? | Kimi arıyorsun? |
| `register_gender_pref_subtitle` | This helps us show you the right matches | Bu sayede doğru kişileri sana göstereceğiz |
| `register_gender_pref_men` | Men | Erkek |
| `register_gender_pref_women` | Women | Kadın |
| `register_gender_pref_both` | Both | Her ikisi |
| `register_gender_pref_continue` | Continue | Devam et |

### Setup Gate Card
| Key | EN | TR |
|-----|-----|-----|
| `setup_gender_pref_title` | Choose who you want to match with | Kiminle eşleşmek istediğini seç |
| `setup_gender_pref_subtitle` | Without this, we show everyone — discover won't feel right | Seçmezsen herkes karşına çıkar — bu kötü deneyim |
| `setup_gender_pref_men` | Men | Erkek |
| `setup_gender_pref_women` | Women | Kadın |
| `setup_gender_pref_both` | Both | Her ikisi |
| `setup_gender_pref_done` | Preference saved | Tercihin kaydedildi |
| `setup_gender_pref_error` | Couldn't save, try again | Kaydedemedik, tekrar dene |

**Toplam: 13 yeni key × 16 dil = 208 satır locale güncellemesi.**

---

## 7. Edge Case Matrisi

| # | Edge Case | Çözüm |
|---|-----------|-------|
| 1 | Eski mobile client (signup yeni step yok) signup eder | Backend `gender_pref` göndermeyen request'i sorunsuz işler, `set_at` NULL kalır → bir sonraki açılışta gate yakalar. Backwards compat tam. |
| 2 | Social login (Apple/Google) signup'ta gender_pref step yok | Bilinçli: social signup minimum step, gate'te 3. kart doldurulur. Tek noktada kontrol. |
| 3 | Profile edit'te gender_pref aynı değere set edilir | Backend yine `set_at = NOW()` yazar. İdempotent. Bilinçli reconfirm. |
| 4 | Test admin gate'e takılırsa discover bozulur | Migration backfill: `is_test_admin → set_at = NOW()`. Onaylı. |
| 5 | DB'de `gender_pref` NULL olabilir mi? | Hayır, kolon NOT NULL DEFAULT `'BOTH'`. Sadece `set_at` NULL olur. Logic tutarlı. |
| 6 | Gate'te kart submit sırasında connection loss | `isProcessing` state lock + `setup_gender_pref_error` snackbar (mevcut Profile Setup Gate pattern'i) |
| 7 | Yeni signup'ta back tap (gender_pref step) | Mevcut step back pattern korunur — gender step'e geri döner, state kaybı yok |
| 8 | Discover bilinçli BOTH ile yine herkes gösterir | Bilinçli kullanıcı kararı, sistem doğru çalışıyor. Default BOTH ≠ bilinçli BOTH ayrımı bu spec sayesinde sağlanıyor. |
| 9 | Push notif deep link gate aktifken | Mevcut `pendingDeepLinkProvider` setup_complete sonrası replay, ek kod yok |
| 10 | `register_screen_mixin.totalSteps = 6 → 7` progress bar | UI progress otomatik 7 üzerinden hesaplar (mevcut pattern), ek değişiklik yok |
| 11 | Fake profile seeding spec'i (2026-06-11, henüz ship edilmemiş) implement edilirken script `set_at` yazmaz | Bu spec ship olunca seeding script'i de güncellenir (`gender_pref_set_at = NOW()` insert'e ekle) — koordinasyon notu, hard dependency yok |
| 12 | Profile completion % formülü etkilenir mi? | Hayır, `recalculateProfileCompletion()` dokunulmuyor — gender_pref zaten 16-sinyal formülünde değil. Bonus reward sistemi yan etkisi açılmaz. |

---

## 8. Test Plan

| Senaryo | Beklenen |
|---------|----------|
| Yeni email signup → gender_pref step görünür → seçim → gate'te 3. kart check'li | ✓ |
| Yeni Apple/Google signup → gate'te 3. kart eksik → seç → discover | ✓ |
| Mevcut user (BOTH default) login → gate'te 3. kart eksik → seç → discover | ✓ |
| Mevcut user gate'te `MAN` seç → discover'da sadece erkekler | ✓ |
| Mevcut user gate'te `BOTH` seç (bilinçli) → discover'da herkes | ✓ |
| Profile edit'ten gender_pref değiştir → `set_at` refresh, gate'e takılmaz | ✓ |
| Test admin login → gate atlanır (backfill ile `set_at` dolu) | ✓ |
| Connection loss anında kart submit → error snackbar + retry | ✓ |
| 16 dil string testi (i18n-guardian) | ✓ |
| Eski mobile client signup (step yok) → gate'te yakalar | ✓ |
| Back tuşu gate'te → mevcut confirm dialog (Profile Setup Gate pattern) | ✓ |
| Signup step back tap → gender step'e döner, state korunur | ✓ |
| Concurrent gate kart submit (foto + gender_pref aynı anda) | ✓ (`isProcessing` lock) |

---

## 9. Rollout Sırası

1. **Server tarafı:** Migration 030 (Supabase MCP) → backfill (test admin + seeded) → partial index → `getMe()` select listesi güncelle → `updateProfile()` set_at update path → `register()` insert path → `auth.validator` + `user.validator` schema güncellemeleri
2. **Server review:** `/server-review` skill (otomatik, mevcut kural)
3. **Mobile tarafı:** UserModel `genderPrefSetAt` field + json_serializable regenerate → router guard 3. koşul → `SetupGenderPrefCard` widget → `profile_setup_screen` 3. kart entegrasyonu → signup yeni step (`register_gender_pref_step` + `register_screen_mixin` step sırası + `register()` body)
4. **Locale:** 16 dile 13 key (i18n-guardian skill ile EN/TR baseline + LLM çeviri)
5. **Flutter review:** `/flutter-review` skill (otomatik, mevcut kural)
6. **Test:** Manual test plan + 16 dil i18n kontrolü
7. **TestFlight + Internal track:** Yayın

---

## 10. Scope Out — Bilinçli Dışarıda Bırakılanlar

- **Multi-select tercih (men[] + women[] + non_binary[]):** Model değişikliği, MVP scope dışı. Mevcut MAN/WOMAN/BOTH yeterli.
- **NON_BINARY gender enum eklemek:** DB migration + matching filter rewrite gerekir. MVP scope dışı.
- **Push notif kampanyası mevcut BOTH kullanıcılara "tercihini güncelle":** Doğal akış (uygulamayı açtığında gate yakalar) yeterli. Push gereksiz.
- **Profile completion % formülünde gender_pref:** Bonus reward sistemi yan etkisi açılmaz, dokunulmuyor.
- **Discover pool server-side filter (gender_pref_set_at IS NULL kullanıcıları havuzdan çıkar):** Profile Setup Gate ile simetri — sadece mobile gate enforcement. Eski client bypass riski düşük.
- **Profile audit log:** İleride `set_at` analytics'i genişletilirse audit log entegrasyonu açılabilir.

---

## 11. Memory Hatırlatmaları (Bu Spec'i Hazırlarken Uygulanan Kurallar)

- [Mevcut pattern'i yeniden kullan](../../../memory/feedback_reuse_existing_patterns.md) — Profile Setup Gate'in 3. kart simetriği, SegmentedButton edit_profile_preferences_section'dan kopyalandı, router guard `age == null` pattern'i
- [Localization zorunlu](../../../memory/feedback_localization_required.md) — 13 key × 16 dil, hardcode yasak
- [Edge case'leri araştır](../../../memory/feedback_no_assumptions_monorepo.md) — Server + Mobile + DB üç katmanda audit yapıldı: matching filter, signup akışı, DB schema, eski client backwards compat
- [Otomatik Review](../../../memory/feedback_auto_review.md) — `/server-review` + `/flutter-review` rollout adımlarında
- [i18n-guardian businessCaseSkill](../../../memory/feedback_business_case_skills.md) — 16 dil yayım otomatik
- [Supabase MCP](../../../memory/MEMORY.md) — Migration apply Supabase MCP tool ile

---

**Sıradaki adım:** Bu spec onaylandıktan sonra `superpowers:writing-plans` skill'i ile implementation plan oluşturulur.
