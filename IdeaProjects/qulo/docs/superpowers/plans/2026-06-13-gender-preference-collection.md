# Gender Preference Collection — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Signup'a `gender_pref` step ekle ve Profile Setup Gate'e 3. hard gate koşulu (gender_pref_set_at IS NULL) ekleyerek hem yeni hem mevcut "hiç sorulmamış" kullanıcıları yakala.

**Architecture:** Profile Setup Gate'in (2026-06-12 spec, 2026-06-13 shipped) router redirect mantığı `user.setupComplete` getter'ı üzerine kurulu. Bu getter'a `genderPrefSetAt != null` koşulu eklenince gate otomatik yakalar. DB'ye `gender_pref_set_at TIMESTAMPTZ` field eklenir; tüm production user'lar NULL ile başlar (test admin backfill ile dolu). Mevcut `gender_pref` enum kolonu (DEFAULT `'BOTH'`) korunur — schema kırılma yok.

**Tech Stack:**
- DB: Supabase Postgres (migration via Supabase MCP)
- Server: Node.js + Express + TypeScript + Zod (repo: `qulo-server`)
- Mobile: Flutter + Riverpod + go_router + json_serializable (repo: `qulov2`)
- i18n: 16 dil, `feedback_localization_required` kuralı + i18n-guardian skill
- Review: `/server-review` + `/flutter-review` skill'leri

**Spec:** [`docs/superpowers/specs/2026-06-13-gender-preference-collection-design.md`](../specs/2026-06-13-gender-preference-collection-design.md)

---

## Phase 1 — DB Migration

### Task 1: Migration 030 — `gender_pref_set_at` Field

**Files:**
- Apply via Supabase MCP (`mcp__claude_ai_Supabase__apply_migration`)
- Migration name: `030_gender_pref_required`
- Project ref: `vtntrtozgoyhjdvvurkj` (Qulo production)

- [ ] **Step 1: SQL'i hazırla**

```sql
-- Migration 030: gender_pref bilinçli seçim işareti
-- "Hiç sorulmamış default BOTH" ile "bilinçli BOTH" ayrımı için

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS gender_pref_set_at TIMESTAMPTZ;

-- Test admin hesapları gate'e takılmasın (TikTok seed user'lar dahil)
UPDATE users
SET gender_pref_set_at = NOW()
WHERE is_test_admin = true;

-- Partial index: sadece NULL kohort gate filter için sorgulanıyor
CREATE INDEX IF NOT EXISTS idx_users_gender_pref_set_at_null
  ON users(gender_pref_set_at)
  WHERE gender_pref_set_at IS NULL;
```

- [ ] **Step 2: Supabase MCP ile uygula**

```
mcp__claude_ai_Supabase__apply_migration
  project_id: vtntrtozgoyhjdvvurkj
  name: 030_gender_pref_required
  query: <yukarıdaki SQL>
```

Expected: success, no error.

- [ ] **Step 3: Doğrulama — kolon eklendi mi?**

```sql
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'users' AND column_name = 'gender_pref_set_at';
```

Çalıştırma: `mcp__claude_ai_Supabase__execute_sql` ile, project_id ile aynı.
Expected: 1 row, `data_type = timestamp with time zone`, `is_nullable = YES`, `column_default = NULL`.

- [ ] **Step 4: Doğrulama — test admin backfill çalıştı mı?**

```sql
SELECT COUNT(*) AS total_admins,
       COUNT(gender_pref_set_at) AS backfilled
FROM users
WHERE is_test_admin = true;
```

Expected: `total_admins = backfilled` (hepsi dolu).

- [ ] **Step 5: Doğrulama — production user'lar NULL mu?**

```sql
SELECT COUNT(*) AS total_real_users,
       COUNT(gender_pref_set_at) AS already_set
FROM users
WHERE is_test_admin = false AND is_deleted = false;
```

Expected: `already_set = 0` (hiçbiri seçim yapmamış).

- [ ] **Step 6: Index var mı?**

```sql
SELECT indexname FROM pg_indexes
WHERE tablename = 'users' AND indexname = 'idx_users_gender_pref_set_at_null';
```

Expected: 1 row.

Migration commit gerekmiyor — Supabase MCP direkt apply ediyor, migration tarihi otomatik kaydedilir.

---

## Phase 2 — Server (qulo-server)

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulo-server`

### Task 2: `getMe()` Response — `gender_pref_set_at` Select Listesine Ekle

**Files:**
- Modify: `src/services/user.service.ts:11-41` (getMe metodu)

- [ ] **Step 1: Mevcut select'i incele**

Read `src/services/user.service.ts` lines 11-41. Hatırlatma: `gender_pref` select listesinde line 15'te var, `gender_pref_set_at` eklenecek.

- [ ] **Step 2: Select string'i güncelle**

`src/services/user.service.ts:15` — `getMe()` select listesinde `gender_pref,` yanına `gender_pref_set_at,` ekle.

Old:
```typescript
"id, email, name, surname, bio, age, gender, gender_pref, match_radius_km, age_pref_min, age_pref_max, city, country, locale, lat, lng, photos, profile_completion, green_diamonds, purple_diamonds, is_online, last_seen_at, push_token, email_verified, passport_city, passport_lat, passport_lng, boost_until, like_received_count, times_shown_count, badge_rewards_claimed, preferred_languages, completion_rewards_claimed, relationship_goal, subscription_plan, subscription_expires_at, daily_swipes_used, daily_swipes_reset_at, daily_undos_used, strict_language_mode, interests, question_count, created_at",
```

New:
```typescript
"id, email, name, surname, bio, age, gender, gender_pref, gender_pref_set_at, match_radius_km, age_pref_min, age_pref_max, city, country, locale, lat, lng, photos, profile_completion, green_diamonds, purple_diamonds, is_online, last_seen_at, push_token, email_verified, passport_city, passport_lat, passport_lng, boost_until, like_received_count, times_shown_count, badge_rewards_claimed, preferred_languages, completion_rewards_claimed, relationship_goal, subscription_plan, subscription_expires_at, daily_swipes_used, daily_swipes_reset_at, daily_undos_used, strict_language_mode, interests, question_count, created_at",
```

- [ ] **Step 3: TypeScript build kontrolü**

```bash
npx tsc --noEmit
```

Expected: PASS (sadece select string değişti, ek tip değişikliği yok).

- [ ] **Step 4: Commit (henüz yapma — Task 5'e kadar Phase 2 commit'i tek seferde)**

Phase 2 sonunda tek commit. Şimdi devam et.

---

### Task 3: `updateProfile()` — `gender_pref` Geldiğinde `set_at` Refresh

**Files:**
- Modify: `src/services/user.service.ts:44-86` (updateProfile metodu)

- [ ] **Step 1: Mevcut updateProfile path'ini oku**

Read `src/services/user.service.ts:44-86`. Mevcut path direkt `.update(data)` yapıyor. Service-side ek alan ekleme yapmak için sandbox object'e geç.

- [ ] **Step 2: `updateProfile` metodunu güncelle**

`src/services/user.service.ts` updateProfile metodunda old:
```typescript
async updateProfile(userId: string, data: UpdateProfileInput) {
  const { data: user, error } = await supabase
    .from("users")
    .update(data)
    .eq("id", userId)
    .eq("is_deleted", false)
    .select(
```

New:
```typescript
async updateProfile(userId: string, data: UpdateProfileInput) {
  // gender_pref geldiyse set_at'i server-side stamp et (client'tan manipüle edilemez)
  const updates: Record<string, unknown> = { ...data };
  if ((data as { gender_pref?: string }).gender_pref !== undefined) {
    updates.gender_pref_set_at = new Date().toISOString();
  }

  const { data: user, error } = await supabase
    .from("users")
    .update(updates)
    .eq("id", userId)
    .eq("is_deleted", false)
    .select(
```

- [ ] **Step 3: Validator'a `gender_pref` ekle**

`src/validators/user.validator.ts` updateProfileSchema'ya field ekle.

Old (lines 5-21):
```typescript
export const updateProfileSchema = z.object({
  name: z.string().trim().min(1).max(50).optional(),
  surname: z.string().trim().min(1).max(50).optional(),
  bio: z.string().trim().max(500).optional(),
  match_radius_km: z.number().int().min(5).max(500).optional(),
  age_pref_min: z.number().int().min(18).max(99).optional(),
  age_pref_max: z.number().int().min(18).max(99).optional(),
  city: z.string().trim().max(100).optional(),
  country: z.string().max(100).optional(),
  locale: z.enum(SUPPORTED_LOCALES as unknown as [string, ...string[]]).optional(),
  relationship_goal: z.enum(["SERIOUS", "FRIENDSHIP", "NOT_SURE"]).optional(),
  preferred_languages: z.array(z.enum(["tr", "en", "de", "fr", "ar", "ru", "es"])).min(1).max(7).optional(),
  strict_language_mode: z.boolean().optional(),
}).refine(
  (data) => !data.age_pref_min || !data.age_pref_max || data.age_pref_min <= data.age_pref_max,
  { message: "age_pref_min must be less than or equal to age_pref_max", path: ["age_pref_max"] },
);
```

New (sadece `gender_pref` satırı eklendi):
```typescript
export const updateProfileSchema = z.object({
  name: z.string().trim().min(1).max(50).optional(),
  surname: z.string().trim().min(1).max(50).optional(),
  bio: z.string().trim().max(500).optional(),
  gender_pref: z.enum(["MAN", "WOMAN", "BOTH"]).optional(),
  match_radius_km: z.number().int().min(5).max(500).optional(),
  age_pref_min: z.number().int().min(18).max(99).optional(),
  age_pref_max: z.number().int().min(18).max(99).optional(),
  city: z.string().trim().max(100).optional(),
  country: z.string().max(100).optional(),
  locale: z.enum(SUPPORTED_LOCALES as unknown as [string, ...string[]]).optional(),
  relationship_goal: z.enum(["SERIOUS", "FRIENDSHIP", "NOT_SURE"]).optional(),
  preferred_languages: z.array(z.enum(["tr", "en", "de", "fr", "ar", "ru", "es"])).min(1).max(7).optional(),
  strict_language_mode: z.boolean().optional(),
}).refine(
  (data) => !data.age_pref_min || !data.age_pref_max || data.age_pref_min <= data.age_pref_max,
  { message: "age_pref_min must be less than or equal to age_pref_max", path: ["age_pref_max"] },
);
```

- [ ] **Step 4: TypeScript build kontrolü**

```bash
npx tsc --noEmit
```

Expected: PASS.

---

### Task 4: `registerSchema` + `register()` — Signup'ta gender_pref Optional Kabul

**Files:**
- Modify: `src/validators/auth.validator.ts:3-17` (registerSchema)
- Modify: `src/services/auth.service.ts:14-86` (register metodu, insert object)

- [ ] **Step 1: registerSchema'ya `gender_pref` ekle**

`src/validators/auth.validator.ts` old (lines 3-17):
```typescript
export const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  name: z.string().trim().min(1),
  surname: z.string().trim().min(1),
  age: z.number().int().min(18).max(99),
  gender: z.enum(["MAN", "WOMAN", "OTHER"]),
  locale: z.enum(["tr", "en"]).default("tr"),
  lat: z.number().min(-90).max(90).optional(),
  lng: z.number().min(-180).max(180).optional(),
  referral_code: z.string().min(1).max(10).optional(),
  tos_accepted: z.literal(true, {
    errorMap: () => ({ message: "Terms of Service must be accepted" }),
  }),
});
```

New (gender_pref ekleniyor — eski client'lar göndermez, opsiyonel):
```typescript
export const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  name: z.string().trim().min(1),
  surname: z.string().trim().min(1),
  age: z.number().int().min(18).max(99),
  gender: z.enum(["MAN", "WOMAN", "OTHER"]),
  gender_pref: z.enum(["MAN", "WOMAN", "BOTH"]).optional(),
  locale: z.enum(["tr", "en"]).default("tr"),
  lat: z.number().min(-90).max(90).optional(),
  lng: z.number().min(-180).max(180).optional(),
  referral_code: z.string().min(1).max(10).optional(),
  tos_accepted: z.literal(true, {
    errorMap: () => ({ message: "Terms of Service must be accepted" }),
  }),
});
```

- [ ] **Step 2: `auth.service.ts register()` — insert objesine `gender_pref` + `gender_pref_set_at` ekle**

`src/services/auth.service.ts` register metodunda insert objesini güncelle. Mevcut (lines 42-55):
```typescript
const { data: user, error } = await supabase
    .from("users")
    .insert({
      email,
      password_hash: passwordHash,
      name: data.name,
      surname: data.surname,
      age: data.age,
      gender: data.gender,
      locale: data.locale,
      verify_token: verifyTokenHash,
      token_expires_at: tokenExpiresAt,
      email_verified: false,
      referral_code: referralCode,
      ...(data.lat != null && data.lng != null ? { lat: data.lat, lng: data.lng } : {}),
    })
```

New (gender_pref + set_at conditional spread eklendi):
```typescript
const { data: user, error } = await supabase
    .from("users")
    .insert({
      email,
      password_hash: passwordHash,
      name: data.name,
      surname: data.surname,
      age: data.age,
      gender: data.gender,
      locale: data.locale,
      verify_token: verifyTokenHash,
      token_expires_at: tokenExpiresAt,
      email_verified: false,
      referral_code: referralCode,
      ...(data.lat != null && data.lng != null ? { lat: data.lat, lng: data.lng } : {}),
      ...(data.gender_pref
        ? { gender_pref: data.gender_pref, gender_pref_set_at: new Date().toISOString() }
        : {}),
    })
```

- [ ] **Step 3: TypeScript build kontrolü**

```bash
npx tsc --noEmit
```

Expected: PASS.

---

### Task 5: Phase 2 Commit + Push

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulo-server`

- [ ] **Step 1: Build çalışıyor mu?**

```bash
npx tsc --noEmit
```

Expected: PASS.

- [ ] **Step 2: Lint (mevcut convention)**

```bash
npm run lint 2>/dev/null || echo "no lint script"
```

Expected: PASS veya "no lint script".

- [ ] **Step 3: Commit**

```bash
git add src/services/user.service.ts src/services/auth.service.ts src/validators/user.validator.ts src/validators/auth.validator.ts
git commit -m "$(cat <<'EOF'
feat(gender-pref): add gender_pref_set_at field + signup acceptance + update path

- getMe() returns gender_pref_set_at
- updateProfile() stamps set_at on gender_pref change (server-side)
- registerSchema accepts optional gender_pref
- register() persists gender_pref + set_at when provided

Migration 030 applied via Supabase MCP.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

- [ ] **Step 4: Railway auto-deploy için push**

```bash
git push origin main
```

Expected: Railway dashboard'da build başlar (auto-deploy).

- [ ] **Step 5: Production health check (Railway deploy bekle ~2-3dk sonra)**

```bash
curl -s https://qulo-server-production.up.railway.app/ping | head -c 200
```

Expected: `{"pong":true,"version":"...","timestamp":"...","uptime":...}`

---

### Task 6: `/server-review` Skill Çalıştır

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulo-server`

- [ ] **Step 1: Skill'i çağır**

Invoke `Skill` tool with `skill: server-review`. Beklenen kontroller: SOLID, security (gender_pref validation tightening), input validation, authorization (gender_pref güncelleme auth user kendine mi yapıyor — middleware `requireAuth` zaten var), error handling.

- [ ] **Step 2: Bulgu varsa düzelt**

Skill'in çıkardığı her HIGH/CRITICAL finding'i düzelt. Yeni commit:
```bash
git add <changed files>
git commit -m "fix(gender-pref): address server-review findings"
git push origin main
```

LOW/MEDIUM findings için inline değerlendir, gereksizse atla.

---

## Phase 3 — Mobile (qulov2)

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulov2`

### Task 7: UserModel — `genderPrefSetAt` Field

**Files:**
- Modify: `lib/data/models/user_model.dart:1-170` (field + getter güncelleme)

- [ ] **Step 1: UserModel'e `genderPrefSetAt` field ekle**

`lib/data/models/user_model.dart` — `genderPref` field'ının (line ~20) altına ekle:

```dart
@JsonKey(name: 'gender_pref')
final String? genderPref;
@JsonKey(name: 'gender_pref_set_at')
final DateTime? genderPrefSetAt;
```

Constructor parametrelerine de ekle (mevcut pattern'i takip):
```dart
const UserModel({
  ...
  this.genderPref,
  this.genderPrefSetAt,
  ...
});
```

- [ ] **Step 2: `setupComplete` getter'ı güncelle (KRİTİK NOKTA)**

`lib/data/models/user_model.dart:129-130` — mevcut:
```dart
bool get setupComplete =>
    (photos?.isNotEmpty ?? false) && questionCount >= 2;
```

New:
```dart
bool get setupComplete =>
    (photos?.isNotEmpty ?? false) &&
    questionCount >= 2 &&
    genderPrefSetAt != null;
```

Router guard `app_router.dart:149-162` zaten `user.setupComplete` üzerinden çalışır → ek değişiklik gerekmez. Tek noktadan kontrol.

- [ ] **Step 3: build_runner regenerate**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: `user_model.g.dart` regenerate edilir, `_$UserModelFromJson` + `_$UserModelToJson` yeni field'ı içerir.

- [ ] **Step 4: Build hatası var mı?**

```bash
flutter analyze lib/data/models/user_model.dart
```

Expected: no errors.

---

### Task 8: `SetupGenderPrefCard` Widget Oluştur

**Files:**
- Create: `lib/features/onboarding/widgets/setup_gender_pref_card.dart` (~110 satır)

- [ ] **Step 1: Widget dosyasını oluştur**

`lib/features/onboarding/widgets/setup_gender_pref_card.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:qulo/core/extensions/build_context_extensions.dart';
import 'package:qulo/core/themes/app_colors.dart';
import 'package:qulo/core/themes/app_spacing.dart';

class SetupGenderPrefCard extends StatelessWidget {
  const SetupGenderPrefCard({
    super.key,
    required this.selectedValue,
    required this.isProcessing,
    required this.onSelect,
  });

  final String? selectedValue;
  final bool isProcessing;
  final ValueChanged<String> onSelect;

  bool get isComplete => selectedValue != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isComplete
            ? context.appColors.primarySurface
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isComplete
              ? context.appColors.primary
              : context.appColors.border,
          width: isComplete ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people_outline,
                color: isComplete
                    ? context.appColors.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.get('setup_gender_pref_title'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isComplete
                          ? l10n.get('setup_gender_pref_done')
                          : l10n.get('setup_gender_pref_subtitle'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isComplete)
                Icon(Icons.check_circle, color: context.appColors.primary),
            ],
          ),
          if (!isComplete) ...[
            const SizedBox(height: AppSpacing.md),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'MAN',
                  label: Text(l10n.get('setup_gender_pref_men')),
                  icon: const Icon(Icons.male),
                ),
                ButtonSegment(
                  value: 'WOMAN',
                  label: Text(l10n.get('setup_gender_pref_women')),
                  icon: const Icon(Icons.female),
                ),
                ButtonSegment(
                  value: 'BOTH',
                  label: Text(l10n.get('setup_gender_pref_both')),
                  icon: const Icon(Icons.transgender),
                ),
              ],
              selected: selectedValue != null ? {selectedValue!} : {},
              emptySelectionAllowed: true,
              onSelectionChanged: isProcessing
                  ? null
                  : (set) {
                      if (set.isNotEmpty) onSelect(set.first);
                    },
            ),
          ],
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Lint**

```bash
flutter analyze lib/features/onboarding/widgets/setup_gender_pref_card.dart
```

Expected: no errors.

---

### Task 9: `profile_setup_screen.dart` — 3. Kart Entegrasyonu

**Files:**
- Modify: `lib/features/onboarding/screens/profile_setup_screen.dart:41-96` (state + card list)
- Modify: `lib/features/onboarding/mixins/profile_setup_mixin.dart` (handler ekleme)

- [ ] **Step 1: Setup screen state'ine gender_pref selected ekle**

`lib/features/onboarding/screens/profile_setup_screen.dart` — `_ProfileSetupScreenState` içine ekle:

```dart
String? _selectedGenderPref; // null = henüz seçilmedi
bool _isSubmittingGenderPref = false;
```

- [ ] **Step 2: gender_pref handler ekle**

Mevcut `UserRepository.updateProfile(Map<String, dynamic> data)` signature (`lib/data/repositories/user_repository.dart:28-36`) — PATCH `/users/me` body olarak flexible map alıyor. Aynı dosya state class'ına metot ekle:

```dart
Future<void> _handleGenderPrefSelect(String value) async {
  if (_isSubmittingGenderPref) return;
  setState(() {
    _selectedGenderPref = value;
    _isSubmittingGenderPref = true;
  });

  final result = await ref
      .read(userRepositoryProvider)
      .updateProfile({'gender_pref': value});

  if (!mounted) return;

  result.when(
    success: (_) async {
      await ref.read(userProvider.notifier).refresh();
      AnalyticsManager.instance.logEvent(
        AnalyticsEvents.setupGenderPrefSelected,
        params: {'value': value, 'entry_point': 'gate'},
      );
    },
    failure: (f) {
      setState(() => _selectedGenderPref = null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).get('setup_gender_pref_error')),
        ),
      );
    },
  );

  if (mounted) setState(() => _isSubmittingGenderPref = false);
}
```

`userRepositoryProvider` mevcut, `lib/providers/api_provider.dart` içinde tanımlı. `AnalyticsManager.instance` mevcut singleton pattern (Task 14'teki event constant burada kullanılır).

- [ ] **Step 3: Card list'e 3. kartı ekle**

`profile_setup_screen.dart:70-96` arası, mevcut iki kart sonrasına:

Old:
```dart
SetupPhotoCard(...),
const SizedBox(height: AppSpacing.md),
SetupQuestionCard(...),
```

New:
```dart
SetupPhotoCard(...),
const SizedBox(height: AppSpacing.md),
SetupQuestionCard(...),
const SizedBox(height: AppSpacing.md),
SetupGenderPrefCard(
  selectedValue: user?.genderPrefSetAt != null ? user!.genderPref : _selectedGenderPref,
  isProcessing: _isSubmittingGenderPref,
  onSelect: _handleGenderPrefSelect,
),
```

(`user` mevcut local variable, `_isSubmittingGenderPref` ve `_handleGenderPrefSelect` az önce eklenenler.)

- [ ] **Step 4: Import ekle**

`profile_setup_screen.dart` top of file:
```dart
import 'package:qulo/features/onboarding/widgets/setup_gender_pref_card.dart';
```

- [ ] **Step 5: Lint**

```bash
flutter analyze lib/features/onboarding/screens/profile_setup_screen.dart
```

Expected: no errors.

---

### Task 10: `RegisterStepGenderPref` Widget (Signup için)

**Files:**
- Create: `lib/features/auth/widgets/register_step_gender_pref.dart` (~125 satır)

Pattern referansı: `lib/features/auth/widgets/register_step_gender.dart` — `_GenderCard` private widget + `AppButton` + `AppLocalizations.of(context)`. Tam simetrik widget yazıyoruz.

- [ ] **Step 1: Widget oluştur**

`lib/features/auth/widgets/register_step_gender_pref.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/app_localizations.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';

class RegisterStepGenderPref extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String> onSelected;
  final String? errorText;
  final VoidCallback onContinue;

  const RegisterStepGenderPref({
    super.key,
    this.selectedValue,
    required this.onSelected,
    this.errorText,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.get('register_gender_pref_title'),
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.get('register_gender_pref_subtitle'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _PrefCard(
            label: l10n.get('register_gender_pref_men'),
            icon: Icons.male,
            isSelected: selectedValue == 'MAN',
            onTap: () => onSelected('MAN'),
          ),
          const SizedBox(height: AppSpacing.md),
          _PrefCard(
            label: l10n.get('register_gender_pref_women'),
            icon: Icons.female,
            isSelected: selectedValue == 'WOMAN',
            onTap: () => onSelected('WOMAN'),
          ),
          const SizedBox(height: AppSpacing.md),
          _PrefCard(
            label: l10n.get('register_gender_pref_both'),
            icon: Icons.transgender,
            isSelected: selectedValue == 'BOTH',
            onTap: () => onSelected('BOTH'),
          ),
          if (errorText != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.appColors.error,
              ),
            ),
          ],
          const Spacer(),
          AppButton(
            label: l10n.get('register_gender_pref_continue'),
            onPressed: selectedValue == null ? null : onContinue,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _PrefCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PrefCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: isSelected ? context.appColors.primarySurface : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected ? context.appColors.primary : Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.appColors.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? context.appColors.primary : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 28,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isSelected
                          ? context.appColors.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: context.appColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
```

Bu pattern `RegisterStepGender` widget'ının birebir simetriği — `_GenderCard` private widget'ı `_PrefCard` olarak çoğaltıldı, `selectedValue == null` ise continue button disabled.

- [ ] **Step 2: Lint**

```bash
flutter analyze lib/features/auth/widgets/register_step_gender_pref.dart
```

Expected: no errors.

---

### Task 11: `register_screen_mixin.dart` — Step Sırası + State + Validate + Register Body

**Files:**
- Modify: `lib/features/auth/mixins/register_screen_mixin.dart:13, 66-116, 201-242`

- [ ] **Step 1: `totalSteps` 6 → 7**

Old (line 13):
```dart
static const totalSteps = 6;  // Steps 0-5: Name, Birthday, Gender, Location, Email, Terms
```

New:
```dart
static const totalSteps = 7;  // Steps 0-6: Name, Birthday, Gender, GenderPref, Location, Email, Terms
```

- [ ] **Step 2: `genderPref` state'i ekle**

Mixin class içinde `gender` field'ının yanına (mevcut convention'a göre nerede ise):

```dart
String? genderPref;
String? genderPrefError;
```

- [ ] **Step 3: `validateCurrentStep()` switch'i güncelle**

Old (lines 66-116) içinde case 3-5'leri kaydır + yeni case 3 ekle:

New:
```dart
bool validateCurrentStep() {
  final l10n = AppLocalizations.of(context);

  switch (currentStep) {
    case 0:  // Name & Surname
      final nameErr =
          nameCtrl.text.trim().isEmpty ? l10n.get('field_required') : null;
      final surnameErr =
          surnameCtrl.text.trim().isEmpty ? l10n.get('field_required') : null;
      setState(() {
        nameError = nameErr;
        surnameError = surnameErr;
      });
      return nameErr == null && surnameErr == null;

    case 1:  // Birthday
      String? err;
      if (birthday == null) {
        err = l10n.get('field_required');
      } else if (calculateAge() < 18) {
        err = l10n.get('must_be_18');
      }
      setState(() => birthdayError = err);
      return err == null;

    case 2:  // Gender
      final err = gender == null ? l10n.get('field_required') : null;
      setState(() => genderError = err);
      return err == null;

    case 3:  // GenderPref (YENİ)
      final err = genderPref == null ? l10n.get('field_required') : null;
      setState(() => genderPrefError = err);
      return err == null;

    case 4:  // Location (eski case 3)
      return true;

    case 5:  // Email & Password (eski case 4)
      final emailErr = _emailValidator(emailCtrl.text.trim());
      final passErr = _passwordValidator(passwordCtrl.text);
      setState(() {
        emailError = emailErr;
        passwordError = passErr;
      });
      return emailErr == null && passErr == null;

    case 6:  // Terms (eski case 5)
      final err = !termsAccepted ? l10n.get('must_accept_terms') : null;
      setState(() => termsError = err);
      return err == null;

    default:
      return false;
  }
}
```

- [ ] **Step 4: `register()` body'sine `gender_pref` ekle**

Old (lines 201-242):
```dart
final result = await ref.read(authProvider.notifier).register(
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text,
      name: nameCtrl.text.trim(),
      surname: surnameCtrl.text.trim(),
      age: calculateAge(),
      gender: gender!,
      lat: lat,
      lng: lng,
      locale: Localizations.localeOf(context).languageCode,
    );
```

New (genderPref parametresi eklendi):
```dart
final result = await ref.read(authProvider.notifier).register(
      email: emailCtrl.text.trim(),
      password: passwordCtrl.text,
      name: nameCtrl.text.trim(),
      surname: surnameCtrl.text.trim(),
      age: calculateAge(),
      gender: gender!,
      genderPref: genderPref!,
      lat: lat,
      lng: lng,
      locale: Localizations.localeOf(context).languageCode,
    );
```

- [ ] **Step 5: `register()` `goToStep(4)` error handling — email error sonrası adım numarası**

Old switch içinde `EMAIL_ALREADY_EXISTS` case'i:
```dart
if (errorCode == 'EMAIL_ALREADY_EXISTS') {
  setState(() => emailError = l10n.errorMessage(errorCode));
  goToStep(4);
}
```

New (email step artık 5):
```dart
if (errorCode == 'EMAIL_ALREADY_EXISTS') {
  setState(() => emailError = l10n.errorMessage(errorCode));
  goToStep(5);
}
```

- [ ] **Step 6: Lint**

```bash
flutter analyze lib/features/auth/mixins/register_screen_mixin.dart
```

Expected: no errors.

---

### Task 12: `register_screen.dart` — PageView'a Step Ekle

**Files:**
- Modify: `lib/features/auth/screens/register_screen.dart:62-136` (PageView children)

- [ ] **Step 1: PageView children listesine `RegisterStepGenderPref` ekle**

Mevcut sıra (lines 62-136): Name, Birthday, Gender, Location, Email, Terms.
Yeni sıra: Name, Birthday, Gender, **GenderPref**, Location, Email, Terms.

`RegisterStepGender` `children` array'inde sonraki item'dan hemen önce, yeni step ekle:

```dart
// Step 2: Gender
RegisterStepGender(
  selectedGender: gender,
  onGenderSelected: (g) {
    setState(() {
      gender = g;
      genderError = null;
    });
  },
  errorText: genderError,
  onContinue: nextStep,
),
// Step 3: GenderPref (YENİ)
RegisterStepGenderPref(
  selectedValue: genderPref,
  errorText: genderPrefError,
  onSelected: (v) {
    setState(() {
      genderPref = v;
      genderPrefError = null;
    });
  },
  onContinue: nextStep,
),
// Step 4: Location (eski Step 3)
RegisterStepLocation(...),
...
```

- [ ] **Step 2: Import ekle**

```dart
import 'package:qulo/features/auth/widgets/register_step_gender_pref.dart';
```

- [ ] **Step 3: Lint**

```bash
flutter analyze lib/features/auth/screens/register_screen.dart
```

Expected: no errors.

---

### Task 13: `authProvider.register` Signature Güncelle (genderPref parametresi)

**Files:**
- Modify: `lib/providers/auth_provider.dart:172-214` (AuthNotifier.register)
- Modify: `lib/data/repositories/auth_repository.dart:12-41` (AuthRepository.register)

- [ ] **Step 1: AuthNotifier.register'a `genderPref` parametre ekle**

`lib/providers/auth_provider.dart:172-214` — old:

```dart
Future<Result<RegisterResponse>> register({
  required String email,
  required String password,
  required String name,
  required String surname,
  required int age,
  required String gender,
  double? lat,
  double? lng,
  String locale = 'tr',
}) async {
  AnalyticsManager.instance.logEvent(AnalyticsEvents.authRegisterStart, params: {
    AnalyticsEvents.paramMethod: 'email',
  });
  state = state.copyWith(isLoading: true, failure: null);
  final result = await ref.read(authRepositoryProvider).register(
    email: email,
    password: password,
    name: name,
    surname: surname,
    age: age,
    gender: gender,
    lat: lat,
    lng: lng,
    locale: locale,
  );
```

New (genderPref parametresi eklendi, repository çağrısına da geçildi):

```dart
Future<Result<RegisterResponse>> register({
  required String email,
  required String password,
  required String name,
  required String surname,
  required int age,
  required String gender,
  required String genderPref,
  double? lat,
  double? lng,
  String locale = 'tr',
}) async {
  AnalyticsManager.instance.logEvent(AnalyticsEvents.authRegisterStart, params: {
    AnalyticsEvents.paramMethod: 'email',
  });
  state = state.copyWith(isLoading: true, failure: null);
  final result = await ref.read(authRepositoryProvider).register(
    email: email,
    password: password,
    name: name,
    surname: surname,
    age: age,
    gender: gender,
    genderPref: genderPref,
    lat: lat,
    lng: lng,
    locale: locale,
  );
```

- [ ] **Step 2: AuthRepository.register signature + body güncelle**

`lib/data/repositories/auth_repository.dart:12-41` — old:

```dart
@override
Future<Result<RegisterResponse>> register({
  required String email,
  required String password,
  required String name,
  required String surname,
  required int age,
  required String gender,
  double? lat,
  double? lng,
  String locale = 'tr',
}) async {
  try {
    final response = await _service.register({
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'age': age,
      'gender': gender,
      'locale': locale,
      'tos_accepted': true,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
    return Success(response);
  } on DioException catch (e) {
    return Failure(e.toAppFailure());
  }
}
```

New (genderPref parametresi + HTTP body'de `gender_pref`):

```dart
@override
Future<Result<RegisterResponse>> register({
  required String email,
  required String password,
  required String name,
  required String surname,
  required int age,
  required String gender,
  required String genderPref,
  double? lat,
  double? lng,
  String locale = 'tr',
}) async {
  try {
    final response = await _service.register({
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
      'age': age,
      'gender': gender,
      'gender_pref': genderPref,
      'locale': locale,
      'tos_accepted': true,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
    return Success(response);
  } on DioException catch (e) {
    return Failure(e.toAppFailure());
  }
}
```

- [ ] **Step 3: AuthRepository interface (`AuthRepositoryInterface`) varsa signature'ı da güncelle**

Genelde repository pattern interface kullanır. Eğer `lib/data/repositories/auth_repository.dart` ya da yakın bir dosyada `abstract class AuthRepositoryInterface` varsa, register signature'ına `required String genderPref` ekle.

```bash
grep -rn "abstract class AuthRepository" lib/
```

Bulduğun yerde aynı şekilde parametre ekle.

- [ ] **Step 4: Lint**

```bash
flutter analyze lib/providers/auth_provider.dart lib/data/repositories/auth_repository.dart
```

Expected: 0 errors.

---

### Task 14: Analytics Events — 2 Yeni Event

**Files:**
- Modify: `lib/core/services/analytics_events.dart:374-388` (setup gate section'a ekle)

- [ ] **Step 1: Event constant'larını ekle**

`lib/core/services/analytics_events.dart` setup gate bölümüne (line 388 civarı) ekle:

```dart
// ─── Gender Preference Collection (2) ──────────────────────────────
static const String signupGenderPrefSelected = 'signup_gender_pref_selected';
static const String setupGenderPrefSelected = 'setup_gender_pref_selected';
```

Bu event'ler Task 9'da (`_handleGenderPrefSelect`) ve Task 11'in `validateCurrentStep` case 3'ünde çağrılır. Task 11'in onSelected handler'ında ek event log:

```dart
onSelected: (v) {
  setState(() {
    genderPref = v;
    genderPrefError = null;
  });
  ref.read(analyticsManagerProvider).logEvent(
    AnalyticsEvents.signupGenderPrefSelected,
    params: {'value': v, 'entry_point': 'signup'},
  );
},
```

- [ ] **Step 2: Lint**

```bash
flutter analyze lib/core/services/analytics_events.dart
```

Expected: no errors.

---

### Task 15: Phase 3 Build + Commit

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulov2`

- [ ] **Step 1: build_runner regenerate (tekrar — auth provider'da freezed varsa)**

```bash
dart run build_runner build --delete-conflicting-outputs
```

Expected: no errors.

- [ ] **Step 2: Full analyze**

```bash
flutter analyze lib/
```

Expected: 0 errors.

- [ ] **Step 3: Commit (locale öncesi)**

```bash
git add lib/data/models/ lib/features/auth/ lib/features/onboarding/ lib/core/services/analytics_events.dart lib/routing/
git commit -m "$(cat <<'EOF'
feat(gender-pref): add signup step + Profile Setup Gate 3rd card

- UserModel: gender_pref_set_at field + setupComplete includes it
- Profile Setup Gate: SetupGenderPrefCard as 3rd hard gate
- Signup: new step (gender → genderPref → location), totalSteps 6→7
- Analytics: signupGenderPrefSelected + setupGenderPrefSelected events
- Router guard: no change — setupComplete getter handles it

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Phase 4 — Localization (16 dil)

### Task 16: EN + TR Baseline (13 key × 2 dil)

**Files:**
- Modify: `lib/core/l10n/translations/en.dart`
- Modify: `lib/core/l10n/translations/tr.dart`

- [ ] **Step 1: EN keys ekle**

`lib/core/l10n/translations/en.dart` dosyasında map'e ekle:

```dart
'register_gender_pref_title': 'Who are you looking for?',
'register_gender_pref_subtitle': 'This helps us show you the right matches',
'register_gender_pref_men': 'Men',
'register_gender_pref_women': 'Women',
'register_gender_pref_both': 'Both',
'register_gender_pref_continue': 'Continue',
'setup_gender_pref_title': 'Choose who you want to match with',
'setup_gender_pref_subtitle': "Without this, we show everyone — discover won't feel right",
'setup_gender_pref_men': 'Men',
'setup_gender_pref_women': 'Women',
'setup_gender_pref_both': 'Both',
'setup_gender_pref_done': 'Preference saved',
'setup_gender_pref_error': "Couldn't save, try again",
```

- [ ] **Step 2: TR keys ekle**

`lib/core/l10n/translations/tr.dart`:

```dart
'register_gender_pref_title': 'Kimi arıyorsun?',
'register_gender_pref_subtitle': 'Bu sayede doğru kişileri sana göstereceğiz',
'register_gender_pref_men': 'Erkek',
'register_gender_pref_women': 'Kadın',
'register_gender_pref_both': 'Her ikisi',
'register_gender_pref_continue': 'Devam et',
'setup_gender_pref_title': 'Kiminle eşleşmek istediğini seç',
'setup_gender_pref_subtitle': 'Seçmezsen herkes karşına çıkar — bu kötü deneyim',
'setup_gender_pref_men': 'Erkek',
'setup_gender_pref_women': 'Kadın',
'setup_gender_pref_both': 'Her ikisi',
'setup_gender_pref_done': 'Tercihin kaydedildi',
'setup_gender_pref_error': 'Kaydedemedik, tekrar dene',
```

- [ ] **Step 3: Build kontrolü**

```bash
flutter analyze lib/core/l10n/
```

Expected: 0 errors.

---

### Task 17: i18n-guardian Skill — 14 Dile Yayım

**Files:**
- Modify: `lib/core/l10n/translations/{de,fr,es,it,pt,ru,ar,zh,ja,ko,hi,nl,pl,id}.dart` (14 dil)

- [ ] **Step 1: i18n-guardian skill çağır**

Invoke `Skill` tool with `skill: i18n-guardian`. Skill EN baseline'dan 13 key'i 14 dile LLM ile çevirir.

- [ ] **Step 2: Çeviriler eklendi mi doğrula**

```bash
grep -l "register_gender_pref_title" lib/core/l10n/translations/
```

Expected: 16 dosya (en + tr + 14 dil).

- [ ] **Step 3: Build**

```bash
flutter analyze lib/core/l10n/
```

Expected: 0 errors.

- [ ] **Step 4: Locale commit**

```bash
git add lib/core/l10n/translations/
git commit -m "$(cat <<'EOF'
i18n(gender-pref): 13 keys × 16 languages for signup step + gate card

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Phase 5 — Review + Test

### Task 18: `/flutter-review` Skill

- [ ] **Step 1: Skill'i çağır**

Invoke `Skill` tool with `skill: flutter-review`. Beklenen kontroller: 200-satır screen kuralı, widget extraction, hardcode string yokluğu, SegmentedButton convention'u, banned patterns, mevcut SetupCard pattern'iyle simetri.

- [ ] **Step 2: Bulgu varsa düzelt + commit**

HIGH/CRITICAL findings için düzelt, commit:
```bash
git add <changed files>
git commit -m "fix(gender-pref): address flutter-review findings"
```

---

### Task 19: Manual Test Plan

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulov2`

- [ ] **Step 1: iOS Simulator'da test et**

```bash
flutter run -d ios --dart-define=ENV=dev
```

Test senaryoları (spec Section 8):

| # | Senaryo | Beklenen | Sonuç |
|---|---------|----------|-------|
| 1 | Yeni email signup → gender_pref step görünür → seçim → gate'te 3. kart check'li | PASS | [ ] |
| 2 | Yeni Apple/Google signup → gate'te 3. kart eksik → seç → discover | PASS | [ ] |
| 3 | Mevcut user (BOTH default) login → gate'te 3. kart eksik → seç → discover | PASS | [ ] |
| 4 | Mevcut user gate'te `MAN` seç → discover'da sadece erkekler | PASS | [ ] |
| 5 | Mevcut user gate'te `BOTH` seç (bilinçli) → discover'da herkes | PASS | [ ] |
| 6 | Profile edit'ten gender_pref görüntüle → locked UI (mevcut davranış korunmuş) | PASS | [ ] |
| 7 | Test admin login → gate atlanır (backfill ile set_at dolu) | PASS | [ ] |
| 8 | Connection loss anında kart submit → error snackbar | PASS | [ ] |
| 9 | Eski mobile client signup simülasyonu → gate'te yakalar | PASS | [ ] |
| 10 | Back tuşu gate'te → confirm dialog | PASS | [ ] |
| 11 | Signup step back tap → gender step'e döner, state korunur | PASS | [ ] |
| 12 | i18n: TR + EN + DE 3 dilde signup step + gate kartı doğru gösterilir | PASS | [ ] |

- [ ] **Step 2: Android emulator'da test et**

```bash
flutter run -d emulator --dart-define=ENV=dev
```

Aynı senaryolar.

- [ ] **Step 3: Backend logs check**

Railway logs (veya `qulo-server` local):
- `POST /auth/register` → `gender_pref` body'de geliyor mu?
- `PATCH /users/me` → `gender_pref` set ediliyor mu, `set_at` stamp ediliyor mu?

Supabase'de doğrula:
```sql
SELECT id, email, gender_pref, gender_pref_set_at
FROM users
WHERE created_at > NOW() - INTERVAL '1 hour'
ORDER BY created_at DESC
LIMIT 5;
```

Expected: yeni test signup'ların `gender_pref_set_at` dolu.

---

### Task 20: Git Push + TestFlight

**Working directory:** `/Users/berkantcalikusu/IdeaProjects/qulo/qulov2`

- [ ] **Step 1: Final analyze**

```bash
flutter analyze lib/
```

Expected: 0 errors.

- [ ] **Step 2: Push to feature branch**

```bash
git push origin APP-1915
```

(Veya feat/gender-pref-collection gibi yeni branch oluştur, kullanıcı tercihine göre.)

- [ ] **Step 3: TestFlight build (kullanıcı manuel tetikleyebilir)**

`deploy-testflight` skill'i kullanıcı tarafından tetiklenir (otomatik değil). Plan tamamlandıktan sonra:

```
Skill: deploy-testflight
```

veya manuel:
```bash
./deploy_testflight.sh
```

---

## Phase 6 — Post-Ship Doğrulama

### Task 21: Production Sanity Check

- [ ] **Step 1: 24 saat sonra production analytics check**

Firebase Analytics → Events → filter:
- `signup_gender_pref_selected` — yeni signup'lardan event geliyor mu?
- `setup_gender_pref_selected` — mevcut user'ların gate'te yaptığı seçim event'i geliyor mu?

Distribution kontrolü: MAN/WOMAN/BOTH oranı (bilinçli BOTH oranı discover quality metriği).

- [ ] **Step 2: Supabase production sorgu**

```sql
SELECT
  COUNT(*) AS total_active,
  COUNT(gender_pref_set_at) AS opted_in,
  ROUND(100.0 * COUNT(gender_pref_set_at) / COUNT(*), 1) AS opt_in_pct
FROM users
WHERE is_deleted = false AND is_test_admin = false
  AND last_seen_at > NOW() - INTERVAL '7 days';
```

Expected: opt_in_pct artan trend (aktif user'lar gate'i geçtikçe).

- [ ] **Step 3: Memory update**

Memory'ye yeni "shipped feature" ekle:

```
- [Gender Preference Collection](project_qulo_gender_pref_collection_shipped.md) — Signup step + Profile Setup Gate 3rd card, migration 030, server + mobile shipped <tarih>
```

---

## Spec Coverage Doğrulama

| Spec Section | Plan Task |
|--------------|-----------|
| §2 Mimari karar (router guard 3. koşul) | Task 7 (setupComplete getter) |
| §3 Migration 030 + backfill + index | Task 1 |
| §4.1 getMe response | Task 2 |
| §4.2 updateProfile set_at | Task 3 |
| §4.3 register schema + insert | Task 4 |
| §4.4 matching filter (no change) | — (no task needed) |
| §4.5 discover pool gate-only | — (no task needed) |
| §5.1 UserModel field | Task 7 |
| §5.2 router guard | Task 7 (via setupComplete) |
| §5.3 SetupGenderPrefCard + 3. kart | Task 8 + Task 9 |
| §5.4 Signup yeni step | Task 10 + Task 11 + Task 12 + Task 13 |
| §5.5 Social login step yok | — (eklenmiyor, mevcut akış) |
| §5.6 Profile edit no change | — (no task — locked UI korunur) |
| §5.7 Analytics events | Task 14 |
| §6 Locale 13 key × 16 dil | Task 16 + Task 17 |
| §7 Edge case matrisi | Task 19 manual test plan'da |
| §8 Test plan | Task 19 |
| §9 Rollout sırası | Phase 1-6 sırası |
| §10 Scope out | — (zaten yapılmıyor) |

Tüm spec section'ları plan'da karşılanıyor.

---

**Plan complete.** Hazır olduğunda execution'a geçilir.
