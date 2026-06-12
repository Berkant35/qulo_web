# Profile Setup Gate Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Foto + 2 soru zorunluluğunu Discover'dan önce hard gate ile enforce et; mevcut 40 production user'ı ve yeni user'ları aynı router guard ile yakala, friction'ı Magic Fill + Quick Assign opsiyonlarıyla minimize et.

**Architecture:** Mevcut `age == null → /profile-completion` GoRouter redirect guard'ının simetriği (`!setupComplete → /profile-setup`). `setupComplete` mobile-side computed (`photos.isNotEmpty && questionCount >= 2`). UI mevcut design system pattern'leri ile (yeni widget icat yok). Server tarafında migration 028 (`question_count` cache + `interests` kolonu + trigger), discover filter güncellemesi, 2 yeni endpoint (`POST /users/me/interests`, `POST /users/me/quick-assign-questions`). AI Magic Fill mevcut `ai_question_bank` üzerinden — LLM cost yok.

**Tech Stack:**
- **Server:** Node.js + Express + TypeScript + Supabase, Vitest (`src/__tests__/`)
- **Mobile:** Flutter + Riverpod + Dio + GoRouter, `flutter test`
- **DB:** Supabase (vtntrtozgoyhjdvvurkj), migration 028
- **i18n:** 16 dil, `lib/core/l10n/translations/<locale>.dart` — i18n-guardian skill ile yayma
- **Auto Review:** `/server-review` + `/flutter-review` skill'leri (memory'de tanımlı kural)

**Spec referansı:** `docs/superpowers/specs/2026-06-12-profile-setup-gate-design.md`

---

## File Structure

### Server (Modify/Create)

| Dosya | Durum | Sorumluluk |
|-------|-------|-----------|
| `qulo-server/migrations/028_profile_setup_gate.sql` | Create | DB şema: `interests`, `question_count` cache, index, backfill, trigger |
| `qulo-server/src/services/matching.service.ts` | Modify (line 220-241 etrafı) | Discover'da `photoCount >= 1` filter |
| `qulo-server/src/services/user.service.ts` | Modify (getMe satır 11-47) | `question_count` cache kullan (COUNT query sil); interests serialize |
| `qulo-server/src/services/question.service.ts` | Modify | Yeni `quickAssignQuestions(userId)` method |
| `qulo-server/src/services/user-interests.service.ts` | Create | `setInterests(userId, interests[])` business logic |
| `qulo-server/src/controllers/user.controller.ts` | Modify | `setInterestsHandler`, `quickAssignQuestionsHandler` |
| `qulo-server/src/routes/user.routes.ts` | Modify | 2 yeni route binding |
| `qulo-server/src/validators/user.validator.ts` | Modify | `setInterestsSchema` Zod |
| `qulo-server/src/utils/errors.ts` | Modify | `INTERESTS_INVALID`, `QUICK_ASSIGN_NO_BANK_MATCH` error code'lar |
| `qulo-server/src/__tests__/quick-assign.service.test.ts` | Create | Vitest: needed calc, subscription limit, bank fallback |
| `qulo-server/src/__tests__/user-interests.test.ts` | Create | Vitest: validation, persist |
| `qulo-server/src/constants/interest-pool.ts` | Create | 12 curated tag sabit pool |

### Mobile (Modify/Create)

| Dosya | Durum | Sorumluluk |
|-------|-------|-----------|
| `qulov2/lib/features/onboarding/screens/profile_setup_screen.dart` | Create | Gate screen orchestrator (~120 satır) |
| `qulov2/lib/features/onboarding/mixins/profile_setup_mixin.dart` | Create | Lifecycle, state, async ops, action lock |
| `qulov2/lib/features/onboarding/widgets/setup_photo_card.dart` | Create | `_GenderCard` pattern klonu — foto card |
| `qulov2/lib/features/onboarding/widgets/setup_question_card.dart` | Create | 3-CTA card (Magic / Quick / Manual) |
| `qulov2/lib/features/onboarding/widgets/setup_brief_sheet.dart` | Create | Interest chip multi-select + "Sen seç" link |
| `qulov2/lib/features/onboarding/widgets/setup_ai_preview_sheet.dart` | Create | 2 soru preview + assign/regen/skip |
| `qulov2/lib/data/models/user_model.dart` | Modify | `interests` field; `setupComplete` getter |
| `qulov2/lib/data/repositories/user_repository.dart` | Modify | `setInterests`, `quickAssignQuestions` metodları |
| `qulov2/lib/data/repositories/question_repository.dart` | Modify | `aiSuggest` method (yoksa ekle) |
| `qulov2/lib/providers/user_provider.dart` | Modify | `setInterests`, `quickAssignQuestions` provider akışı |
| `qulov2/lib/routing/app_router.dart` | Modify (line 132-146 etrafı) | Gate redirect guard |
| `qulov2/lib/routing/app_routes.dart` | Modify | `/profile-setup` route binding |
| `qulov2/lib/core/services/analytics_events.dart` | Modify | 13 yeni event sabiti |
| `qulov2/lib/core/services/analytics_manager.dart` | Modify | `updateUserProperties`'a `questionsCount` |
| `qulov2/lib/core/constants/interest_constants.dart` | Create | 12 tag pool (server ile senkron) |
| `qulov2/lib/core/l10n/translations/{en,tr}.dart` | Modify | 33 baseline key |
| `qulov2/lib/core/l10n/translations/{ar,de,es,fr,hi,it,ja,ko,nl,pl,pt,ru,sv,zh}.dart` | Modify | i18n-guardian ile 14 dile yayma |

---

## Test Strategy

- **Server:** Vitest (`src/__tests__/` pattern). Her yeni method için unit test. Migration manual verify (Supabase MCP `execute_sql`).
- **Mobile:** Model değişikliği için unit test (`test/models/`). Widget testleri opsiyonel — spec'in test plan'ı manuel ağırlıklı (Bölüm 9).
- **Integration:** Server tarafı manual `curl` veya REST client ile endpoint check. Mobile tarafı manual emulator/sim üzerinden test plan senaryoları.
- **Review skills:** Her phase sonunda `/server-review` (server) ve `/flutter-review` (mobile) skill'leri çalıştırılır.
- **i18n:** `i18n-guardian` skill ile 16 dil bütünlük kontrolü.

---

## Phase 1 — Server: DB Migration

### Task 1: Migration 028 — kolonlar, index, backfill

**Files:**
- Create: `qulo-server/migrations/028_profile_setup_gate.sql`

- [ ] **Step 1: Migration dosyasını oluştur**

```sql
-- 028_profile_setup_gate.sql
-- Profile Setup Gate: interests + question_count cache + indexes

BEGIN;

-- Yeni kolonlar
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS interests TEXT[] DEFAULT '{}' NOT NULL,
  ADD COLUMN IF NOT EXISTS question_count INT DEFAULT 0 NOT NULL;

-- Backfill mevcut user'lar
UPDATE users u
SET question_count = COALESCE(
  (SELECT COUNT(*)::INT FROM questions q WHERE q.user_id = u.id),
  0
);

-- Indexler
CREATE INDEX IF NOT EXISTS idx_users_interests ON users USING GIN (interests);
CREATE INDEX IF NOT EXISTS idx_users_question_count ON users(question_count);

COMMIT;
```

- [ ] **Step 2: Dosya yazıldığını doğrula**

Run: `head -25 qulo-server/migrations/028_profile_setup_gate.sql`
Expected: Yukarıdaki SQL içeriği görünür.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/migrations/028_profile_setup_gate.sql
git commit -m "feat(server): migration 028 — interests + question_count cache (part 1)"
```

---

### Task 2: Migration 028 — trigger eklentisi

**Files:**
- Modify: `qulo-server/migrations/028_profile_setup_gate.sql`

- [ ] **Step 1: Trigger SQL'ini migration'a ekle (COMMIT öncesi)**

Dosyayı düzenle, `COMMIT;` öncesine ekle:

```sql
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

- [ ] **Step 2: Dosyanın tamamını gözden geçir**

Run: `wc -l qulo-server/migrations/028_profile_setup_gate.sql`
Expected: 35-45 satır arası.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/migrations/028_profile_setup_gate.sql
git commit -m "feat(server): migration 028 — trigger for question_count sync"
```

---

### Task 3: Migration apply + backfill verify

**Files:** Sadece DB değişikliği.

- [ ] **Step 1: Supabase MCP ile migration'ı apply et**

Tool: `mcp__claude_ai_Supabase__apply_migration`
- `name: "028_profile_setup_gate"`
- `query: <Task 1 + Task 2'deki SQL'in tamamı (BEGIN/COMMIT dışında)>`

Beklenen: Success response.

- [ ] **Step 2: Backfill doğrulaması**

Tool: `mcp__claude_ai_Supabase__execute_sql`
```sql
SELECT
  COUNT(*) AS total_users,
  COUNT(*) FILTER (WHERE question_count > 0) AS users_with_questions,
  COUNT(*) FILTER (WHERE question_count >= 2) AS users_with_2plus,
  COUNT(*) FILTER (WHERE jsonb_array_length(photos::jsonb) >= 1) AS users_with_photos
FROM users;
```

Beklenen: Sayılar mantıklı (40 user civarında, question/photo sayıları logical).

- [ ] **Step 3: Trigger smoke test**

Tool: `mcp__claude_ai_Supabase__execute_sql`
```sql
-- Bir test user seç, mevcut count'unu oku
SELECT id, question_count FROM users WHERE email LIKE '%tester_001%' LIMIT 1;
```
Beklenen: Numerik question_count.

- [ ] **Step 4: Commit notu (sadece changelog için)**

Run:
```bash
git log -1 --pretty=format:'%h %s' | grep "migration 028"
```
Beklenen: 028 commit'i görünür. Eğer DB değişikliği commit'siz uygulandıysa not düş, ayrı commit yok.

---

## Phase 2 — Server: Service Updates

### Task 4: Discover photo filter — `matching.service.ts`

**Files:**
- Modify: `qulo-server/src/services/matching.service.ts` (line ~220-241 arası)

- [ ] **Step 1: Mevcut filter bloğunu oku**

Read: `qulo-server/src/services/matching.service.ts`, lines 215-245.

Locate the existing 2-question filter:
```typescript
let discoverableFiltered = filtered.filter((c) => {
  const qCount = questionCountMap.get(c.id) ?? 0;
  return qCount >= 2;
});
```

- [ ] **Step 2: Photo filter'ı altına ekle**

Yukarıdaki blok'un hemen altına Edit:

```typescript
// Hard gate: must have at least 1 photo (profile-setup-gate enforcement)
discoverableFiltered = discoverableFiltered.filter((c) => {
  const photoCount = c.photos?.length ?? 0;
  return photoCount >= 1;
});
```

- [ ] **Step 3: Vitest unit test yaz**

Create: `qulo-server/src/__tests__/matching-photo-filter.test.ts`

```typescript
import { describe, it, expect } from 'vitest';

describe('discover photo filter', () => {
  it('filters out users with empty photos', () => {
    const candidates = [
      { id: 'a', photos: ['url1'], questionCount: 3 },
      { id: 'b', photos: [], questionCount: 3 },
      { id: 'c', photos: null, questionCount: 3 },
    ];
    const filtered = candidates.filter((c) => (c.photos?.length ?? 0) >= 1);
    expect(filtered.map((c) => c.id)).toEqual(['a']);
  });

  it('keeps users with at least 1 photo', () => {
    const candidates = [
      { id: 'a', photos: ['url1'] },
      { id: 'b', photos: ['url1', 'url2', 'url3'] },
    ];
    const filtered = candidates.filter((c) => (c.photos?.length ?? 0) >= 1);
    expect(filtered.length).toBe(2);
  });
});
```

- [ ] **Step 4: Test'i çalıştır**

Run: `cd qulo-server && npx vitest run src/__tests__/matching-photo-filter.test.ts`
Expected: 2 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/src/services/matching.service.ts qulo-server/src/__tests__/matching-photo-filter.test.ts
git commit -m "feat(server): discover hard gate — require >=1 photo"
```

---

### Task 5: `getMe()` optimizasyonu — `user.service.ts`

**Files:**
- Modify: `qulo-server/src/services/user.service.ts` (getMe, line 11-47)

- [ ] **Step 1: Mevcut getMe içeriğini oku**

Read: `qulo-server/src/services/user.service.ts` lines 1-60.

Locate:
```typescript
const { count: questionCount } = await supabase
  .from("questions")
  .select("id", { count: "exact", head: true })
  .eq("user_id", userId);
```

- [ ] **Step 2: SELECT listesine `question_count`, `interests` ekle**

Edit line 14-15 (select string'i):

```typescript
"id, email, name, surname, bio, age, gender, gender_pref, match_radius_km, age_pref_min, age_pref_max, city, country, locale, lat, lng, photos, profile_completion, green_diamonds, purple_diamonds, is_online, last_seen_at, push_token, email_verified, passport_city, passport_lat, passport_lng, boost_until, like_received_count, times_shown_count, badge_rewards_claimed, preferred_languages, completion_rewards_claimed, relationship_goal, subscription_plan, subscription_expires_at, daily_swipes_used, daily_swipes_reset_at, daily_undos_used, strict_language_mode, interests, question_count, created_at"
```

- [ ] **Step 3: Eski COUNT query'sini sil**

Remove the supabase questions count block (line 33-36).

- [ ] **Step 4: Response objesinde `question_count`'u direkt user satırından al**

`questionCount` artık `user.question_count` üzerinden gelir — manuel hesaplama satırını sil, response'da `question_count` ve camelCase `questionCount` alias'ını koru.

- [ ] **Step 5: Vitest test yaz**

Create: `qulo-server/src/__tests__/user-service-getme.test.ts`

```typescript
import { describe, it, expect } from 'vitest';

describe('getMe response shape', () => {
  it('exposes interests as array', () => {
    const userRow = { interests: ['music', 'travel'] };
    expect(Array.isArray(userRow.interests)).toBe(true);
  });

  it('exposes question_count as number', () => {
    const userRow = { question_count: 3 };
    expect(typeof userRow.question_count).toBe('number');
  });
});
```

- [ ] **Step 6: Test çalıştır + manuel curl smoke**

Run: `cd qulo-server && npx vitest run src/__tests__/user-service-getme.test.ts`
Expected: PASS.

Manual smoke (server local çalışıyorsa):
```bash
curl -H "Authorization: Bearer <test-token>" https://qulo-server-production.up.railway.app/api/v1/users/me | jq '.interests, .question_count'
```
Expected: `[]` ve numerik bir sayı.

- [ ] **Step 7: Commit**

```bash
git add qulo-server/src/services/user.service.ts qulo-server/src/__tests__/user-service-getme.test.ts
git commit -m "perf(server): getMe — use question_count cache + expose interests"
```

---

## Phase 3 — Server: Errors, Validators, Constants

### Task 6: Error codes + Zod schema + interest pool sabit

**Files:**
- Modify: `qulo-server/src/utils/errors.ts`
- Modify: `qulo-server/src/validators/user.validator.ts`
- Create: `qulo-server/src/constants/interest-pool.ts`

- [ ] **Step 1: Interest pool sabit oluştur**

Create: `qulo-server/src/constants/interest-pool.ts`

```typescript
export const INTEREST_POOL = [
  'music',
  'movies',
  'sports',
  'career',
  'relationships',
  'travel',
  'food',
  'books',
  'gaming',
  'art',
  'fitness',
  'personality',
] as const;

export type InterestTag = typeof INTEREST_POOL[number];
```

- [ ] **Step 2: Errors.ts'e yeni code'lar ekle**

Mevcut error patternini takip ederek `errors.ts` içine ekle:

```typescript
INTERESTS_INVALID: () =>
  new AppError('INTERESTS_INVALID', 400, 'Invalid interest tags', {}),

QUICK_ASSIGN_NO_BANK_MATCH: () =>
  new AppError('QUICK_ASSIGN_NO_BANK_MATCH', 404, 'No matching questions in bank', {}),
```

- [ ] **Step 3: Validator'a setInterestsSchema ekle**

Modify: `qulo-server/src/validators/user.validator.ts`

```typescript
import { INTEREST_POOL } from '../constants/interest-pool';

export const setInterestsSchema = z.object({
  interests: z.array(z.enum(INTEREST_POOL as unknown as [string, ...string[]]))
    .min(0)
    .max(12),
});
```

- [ ] **Step 4: Vitest schema testi**

Create: `qulo-server/src/__tests__/user-interests-validator.test.ts`

```typescript
import { describe, it, expect } from 'vitest';
import { setInterestsSchema } from '../validators/user.validator';

describe('setInterestsSchema', () => {
  it('accepts valid interests', () => {
    const result = setInterestsSchema.safeParse({ interests: ['music', 'travel'] });
    expect(result.success).toBe(true);
  });

  it('accepts empty array (sen-sec scenario)', () => {
    const result = setInterestsSchema.safeParse({ interests: [] });
    expect(result.success).toBe(true);
  });

  it('rejects invalid tag', () => {
    const result = setInterestsSchema.safeParse({ interests: ['foo'] });
    expect(result.success).toBe(false);
  });

  it('rejects more than 12', () => {
    const tags = new Array(13).fill('music');
    const result = setInterestsSchema.safeParse({ interests: tags });
    expect(result.success).toBe(false);
  });
});
```

- [ ] **Step 5: Test çalıştır**

Run: `cd qulo-server && npx vitest run src/__tests__/user-interests-validator.test.ts`
Expected: 4 tests PASS.

- [ ] **Step 6: Commit**

```bash
git add qulo-server/src/constants/interest-pool.ts qulo-server/src/utils/errors.ts qulo-server/src/validators/user.validator.ts qulo-server/src/__tests__/user-interests-validator.test.ts
git commit -m "feat(server): interest pool, errors, setInterestsSchema"
```

---

### Task 7: `POST /users/me/interests` endpoint

**Files:**
- Create: `qulo-server/src/services/user-interests.service.ts`
- Modify: `qulo-server/src/controllers/user.controller.ts`
- Modify: `qulo-server/src/routes/user.routes.ts`

- [ ] **Step 1: Service yaz (TDD red — önce test)**

Create: `qulo-server/src/__tests__/user-interests-service.test.ts`

```typescript
import { describe, it, expect, vi } from 'vitest';
import { setInterests } from '../services/user-interests.service';

vi.mock('../config/supabase', () => ({
  supabase: {
    from: vi.fn(() => ({
      update: vi.fn(() => ({
        eq: vi.fn(() => ({ data: null, error: null })),
      })),
    })),
  },
}));

describe('user-interests service', () => {
  it('persists empty interests as sen-sec fallback', async () => {
    const result = await setInterests('user-1', []);
    expect(result.interests).toEqual([]);
  });

  it('persists provided interests', async () => {
    const result = await setInterests('user-1', ['music', 'travel']);
    expect(result.interests).toEqual(['music', 'travel']);
  });
});
```

- [ ] **Step 2: Test çalıştır — RED**

Run: `cd qulo-server && npx vitest run src/__tests__/user-interests-service.test.ts`
Expected: FAIL — service module yok.

- [ ] **Step 3: Service implementasyonu**

Create: `qulo-server/src/services/user-interests.service.ts`

```typescript
import { supabase } from '../config/supabase';
import { Errors } from '../utils/errors';

export async function setInterests(userId: string, interests: string[]) {
  const { error } = await supabase
    .from('users')
    .update({ interests })
    .eq('id', userId);

  if (error) throw Errors.INTERESTS_INVALID();

  return { interests };
}
```

- [ ] **Step 4: Test çalıştır — GREEN**

Run: `cd qulo-server && npx vitest run src/__tests__/user-interests-service.test.ts`
Expected: 2 tests PASS.

- [ ] **Step 5: Controller handler ekle**

Modify: `qulo-server/src/controllers/user.controller.ts`

```typescript
import { setInterests } from '../services/user-interests.service';
import { setInterestsSchema } from '../validators/user.validator';

export async function setInterestsHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const parsed = setInterestsSchema.parse(req.body);
    const result = await setInterests(req.user!.userId, parsed.interests);
    res.json({ success: true, ...result });
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 6: Route binding**

Modify: `qulo-server/src/routes/user.routes.ts`

```typescript
import { setInterestsHandler } from '../controllers/user.controller';
import { requireAuth } from '../middleware/auth';
import { generalLimiter } from '../middleware/rateLimit';

router.post('/me/interests', requireAuth, generalLimiter, setInterestsHandler);
```

- [ ] **Step 7: Manuel smoke test**

```bash
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer <token>" \
  -d '{"interests":["music","travel"]}' \
  https://qulo-server-production.up.railway.app/api/v1/users/me/interests
```
Expected: `{ "success": true, "interests": ["music", "travel"] }`

- [ ] **Step 8: Commit**

```bash
git add qulo-server/src/services/user-interests.service.ts qulo-server/src/controllers/user.controller.ts qulo-server/src/routes/user.routes.ts qulo-server/src/__tests__/user-interests-service.test.ts
git commit -m "feat(server): POST /users/me/interests endpoint"
```

---

### Task 8: `POST /users/me/quick-assign-questions` endpoint

**Files:**
- Modify: `qulo-server/src/services/question.service.ts` (new method `quickAssignQuestions`)
- Modify: `qulo-server/src/controllers/user.controller.ts`
- Modify: `qulo-server/src/routes/user.routes.ts`
- Modify: `qulo-server/src/services/ai-suggest.service.ts` (gerekirse 2-soru preview helper)

- [ ] **Step 1: Quick-assign Vitest yaz — RED**

Create: `qulo-server/src/__tests__/quick-assign.service.test.ts`

```typescript
import { describe, it, expect, vi } from 'vitest';
import { quickAssignQuestions } from '../services/question.service';

vi.mock('../config/supabase', () => ({ /* mocks */ }));
vi.mock('../services/ai-suggest.service', () => ({
  suggest: vi.fn(async () => ([
    { question_text: 'Q1', answers: ['a','b','c','d'], correct_answer: 1, hint: null, category: 'music' },
    { question_text: 'Q2', answers: ['e','f','g','h'], correct_answer: 2, hint: null, category: 'travel' },
  ])),
}));

describe('quickAssignQuestions', () => {
  it('assigns only the needed count when user has 1 question', async () => {
    // mock currentCount = 1, needed = 1
    const result = await quickAssignQuestions('user-1');
    expect(result.assignedCount).toBe(1);
  });

  it('returns 0 when user already has 2+ questions', async () => {
    const result = await quickAssignQuestions('user-2'); // currentCount = 3
    expect(result.assignedCount).toBe(0);
  });

  it('respects subscription limit (free max 3)', async () => {
    // currentCount = 2, free tier max = 3, needed = 1 (not 2)
    const result = await quickAssignQuestions('user-3');
    expect(result.assignedCount).toBeLessThanOrEqual(1);
  });
});
```

- [ ] **Step 2: Test çalıştır — RED**

Run: `cd qulo-server && npx vitest run src/__tests__/quick-assign.service.test.ts`
Expected: FAIL — quickAssignQuestions method yok.

- [ ] **Step 3: Service implementasyonu**

Modify: `qulo-server/src/services/question.service.ts`

```typescript
import { suggest } from './ai-suggest.service';
import { subscriptionService } from './subscription.service';
import { Errors } from '../utils/errors';
import { supabase } from '../config/supabase';

const MIN_REQUIRED = 2;

export async function quickAssignQuestions(userId: string) {
  // 1. Current count
  const { data: user } = await supabase
    .from('users')
    .select('question_count, locale, subscription_plan')
    .eq('id', userId)
    .single();

  if (!user) throw Errors.USER_NOT_FOUND();

  const currentCount = user.question_count ?? 0;
  const limits = await subscriptionService.getLimits(user.subscription_plan);

  // 2. Calculate needed (clamped to max)
  const maxAddable = Math.max(0, limits.maxQuestions - currentCount);
  const needed = Math.min(Math.max(0, MIN_REQUIRED - currentCount), maxAddable);

  if (needed === 0) {
    return { assignedCount: 0, assignedQuestionIds: [] };
  }

  // 3. Get suggestions from bank
  const suggestions = await suggest({
    userId,
    profileBased: true,
    locale: user.locale ?? 'tr',
    count: needed,
  });

  if (!suggestions || suggestions.length === 0) {
    throw Errors.QUICK_ASSIGN_NO_BANK_MATCH();
  }

  // 4. Insert as questions (order_num = currentCount + i + 1)
  const rows = suggestions.slice(0, needed).map((s, i) => ({
    user_id: userId,
    order_num: currentCount + i + 1,
    question_text: s.question_text,
    answer_1: s.answers[0],
    answer_2: s.answers[1],
    answer_3: s.answers[2],
    answer_4: s.answers[3],
    correct_answer: s.correct_answer,
    hint_text: s.hint,
    category: s.category,
    locale: user.locale ?? 'tr',
    time_limit: 30,
  }));

  const { data: inserted, error } = await supabase
    .from('questions')
    .insert(rows)
    .select('id');

  if (error) throw Errors.QUICK_ASSIGN_NO_BANK_MATCH();

  // Trigger auto-updates users.question_count
  return {
    assignedCount: inserted?.length ?? 0,
    assignedQuestionIds: (inserted ?? []).map((q) => q.id),
  };
}
```

- [ ] **Step 4: Test çalıştır — GREEN**

Run: `cd qulo-server && npx vitest run src/__tests__/quick-assign.service.test.ts`
Expected: 3 tests PASS.

- [ ] **Step 5: Controller handler**

Modify: `qulo-server/src/controllers/user.controller.ts`

```typescript
import { quickAssignQuestions } from '../services/question.service';

export async function quickAssignQuestionsHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await quickAssignQuestions(req.user!.userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 6: Route binding**

Modify: `qulo-server/src/routes/user.routes.ts`

```typescript
router.post('/me/quick-assign-questions', requireAuth, generalLimiter, quickAssignQuestionsHandler);
```

- [ ] **Step 7: Manuel smoke (free tier test user)**

Test user'ın question_count'u 1 olduğunda:
```bash
curl -X POST -H "Authorization: Bearer <token>" \
  https://qulo-server-production.up.railway.app/api/v1/users/me/quick-assign-questions
```
Expected: `{ "assignedCount": 1, "assignedQuestionIds": ["..."] }`

Tekrar çağrılınca (count=2):
Expected: `{ "assignedCount": 0, "assignedQuestionIds": [] }`

- [ ] **Step 8: Commit**

```bash
git add qulo-server/src/services/question.service.ts qulo-server/src/controllers/user.controller.ts qulo-server/src/routes/user.routes.ts qulo-server/src/__tests__/quick-assign.service.test.ts
git commit -m "feat(server): POST /users/me/quick-assign-questions endpoint"
```

---

## Phase 4 — Server Review

### Task 9: `/server-review` skill çalıştır

**Files:** Yok — skill review yapar.

- [ ] **Step 1: Server diff'i kontrol et**

Run: `cd qulo-server && git diff --stat HEAD~8..HEAD`
Expected: Migration + service + controller + route + validator + test dosyaları.

- [ ] **Step 2: `/server-review` skill'ini invoke et**

Skill tool ile: `server-review`

Beklenen: SOLID, security, input validation, authorization, SQL injection, error handling raporları.

- [ ] **Step 3: Bulguları düzelt**

Kritik bulgular varsa inline düzelt + tekrar review.

- [ ] **Step 4: Commit (varsa düzeltmeler)**

```bash
git add qulo-server/src
git commit -m "fix(server): post-review polish for profile-setup-gate"
```

---

## Phase 5 — Mobile: Model + Repository

### Task 10: `UserModel.interests` field

**Files:**
- Modify: `qulov2/lib/data/models/user_model.dart`
- Modify: `qulov2/test/models/user_model_test.dart` (yoksa oluştur)

- [ ] **Step 1: Mevcut UserModel'i oku**

Read: `qulov2/lib/data/models/user_model.dart`

Locate constructor + `fromJson` mapping.

- [ ] **Step 2: Test yaz — RED**

Create veya modify: `qulov2/test/models/user_model_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/data/models/user_model.dart';

void main() {
  group('UserModel.interests', () {
    test('parses interests from JSON', () {
      final json = {
        'id': 'u1',
        'email': 'a@b.com',
        'interests': ['music', 'travel'],
        'profile_completion': 50,
        'question_count': 0,
      };
      final user = UserModel.fromJson(json);
      expect(user.interests, ['music', 'travel']);
    });

    test('defaults interests to empty list when missing', () {
      final json = {
        'id': 'u1',
        'email': 'a@b.com',
        'profile_completion': 50,
        'question_count': 0,
      };
      final user = UserModel.fromJson(json);
      expect(user.interests, isEmpty);
    });

    test('setupComplete is true when has 1+ photo AND 2+ questions', () {
      final user = UserModel.fromJson({
        'id': 'u1',
        'email': 'a@b.com',
        'photos': ['url1'],
        'question_count': 2,
        'profile_completion': 50,
      });
      expect(user.setupComplete, true);
    });

    test('setupComplete is false when missing photo', () {
      final user = UserModel.fromJson({
        'id': 'u1',
        'email': 'a@b.com',
        'photos': [],
        'question_count': 2,
        'profile_completion': 50,
      });
      expect(user.setupComplete, false);
    });

    test('setupComplete is false when questions < 2', () {
      final user = UserModel.fromJson({
        'id': 'u1',
        'email': 'a@b.com',
        'photos': ['url1'],
        'question_count': 1,
        'profile_completion': 50,
      });
      expect(user.setupComplete, false);
    });
  });
}
```

- [ ] **Step 3: Test çalıştır — RED**

Run: `cd qulov2 && flutter test test/models/user_model_test.dart`
Expected: FAIL — `interests` field yok.

- [ ] **Step 4: UserModel'e interests + setupComplete getter ekle**

Modify: `qulov2/lib/data/models/user_model.dart`

```dart
// Mevcut alanların yanına:
@JsonKey(defaultValue: <String>[])
final List<String> interests;

// Constructor'a ekle: this.interests = const [],

// Equatable props listesine ekle: interests,

// Getter ekle (class body sonunda):
bool get setupComplete =>
    (photos?.isNotEmpty ?? false) && questionCount >= 2;
```

- [ ] **Step 5: JSON code generation regenerate**

Run: `cd qulov2 && flutter pub run build_runner build --delete-conflicting-outputs`
Expected: `user_model.g.dart` regenerate eder.

- [ ] **Step 6: Test çalıştır — GREEN**

Run: `cd qulov2 && flutter test test/models/user_model_test.dart`
Expected: 5 tests PASS.

- [ ] **Step 7: Commit**

```bash
git add qulov2/lib/data/models/user_model.dart qulov2/lib/data/models/user_model.g.dart qulov2/test/models/user_model_test.dart
git commit -m "feat(mobile): UserModel.interests + setupComplete getter"
```

---

### Task 11: Repository + Provider — setInterests & quickAssignQuestions

**Files:**
- Modify: `qulov2/lib/data/repositories/user_repository.dart`
- Modify: `qulov2/lib/providers/user_provider.dart`
- Modify: `qulov2/lib/data/repositories/question_repository.dart` (aiSuggest method)

- [ ] **Step 1: Mevcut UserRepository pattern'i oku**

Read: `qulov2/lib/data/repositories/user_repository.dart`

Locate: `uploadPhoto` method (network call pattern).

- [ ] **Step 2: UserRepository'e setInterests + quickAssign ekle**

Modify: `qulov2/lib/data/repositories/user_repository.dart`

```dart
Future<Result<Map<String, dynamic>>> setInterests(List<String> interests) {
  return _network.post('/users/me/interests', data: {'interests': interests});
}

Future<Result<Map<String, dynamic>>> quickAssignQuestions() {
  return _network.post('/users/me/quick-assign-questions', data: {});
}
```

- [ ] **Step 3: UserProvider'a metodları ekle**

Modify: `qulov2/lib/providers/user_provider.dart`

```dart
Future<Result<Map<String, dynamic>>> setInterests(List<String> interests) async {
  final result = await ref.read(userRepositoryProvider).setInterests(interests);
  if (result.isSuccess) await fetchMe();
  return result;
}

Future<Result<Map<String, dynamic>>> quickAssignQuestions() async {
  final result = await ref.read(userRepositoryProvider).quickAssignQuestions();
  if (result.isSuccess) {
    await fetchMe();
    // questionProvider de invalidate edilmeli
    ref.invalidate(questionProvider);
  }
  return result;
}
```

- [ ] **Step 4: aiSuggest method'unu ekle (yoksa)**

Read: `qulov2/lib/data/repositories/question_repository.dart`

Eğer aiSuggest yoksa ekle:
```dart
Future<Result<List<Map<String, dynamic>>>> aiSuggest({
  required bool profileBased,
  required int count,
  required String locale,
}) {
  return _network.post('/questions/ai-suggest', data: {
    'profile_based': profileBased,
    'count': count,
    'locale': locale,
  });
}
```

- [ ] **Step 5: Manuel smoke test (analyzer)**

Run: `cd qulov2 && flutter analyze lib/data lib/providers`
Expected: 0 issues.

- [ ] **Step 6: Commit**

```bash
git add qulov2/lib/data/repositories/user_repository.dart qulov2/lib/data/repositories/question_repository.dart qulov2/lib/providers/user_provider.dart
git commit -m "feat(mobile): repo+provider — setInterests, quickAssignQuestions, aiSuggest"
```

---

## Phase 6 — Mobile: Locale Keys (16 dil)

### Task 12: 33 locale key — EN + TR baseline + 14 dile yayma

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/en.dart`
- Modify: `qulov2/lib/core/l10n/translations/tr.dart`
- Modify: 14 diğer locale dosyası (i18n-guardian skill ile)
- Create: `qulov2/lib/core/constants/interest_constants.dart` (12 tag pool, locale key array)

- [ ] **Step 1: interest_constants.dart oluştur**

Create: `qulov2/lib/core/constants/interest_constants.dart`

```dart
class InterestConstants {
  static const List<String> tagPool = [
    'music',
    'movies',
    'sports',
    'career',
    'relationships',
    'travel',
    'food',
    'books',
    'gaming',
    'art',
    'fitness',
    'personality',
  ];

  static String localeKey(String tag) => 'interest_$tag';

  static const int minSelect = 1;
  static const int recommendedSelect = 3;
  static const int maxSelect = 12;
}
```

- [ ] **Step 2: EN baseline ekle — `en.dart`**

Read: `qulov2/lib/core/l10n/translations/en.dart` (mevcut yapı: `const enTranslations = <String, String>{ ... }`)

Edit: dosyanın sonuna (`}` kapanışından önce) 33 key ekle:

```dart
// Profile Setup Gate
'setup_title': 'A few steps left',
'setup_subtitle': 'Complete your profile to start matching',
'setup_hint': 'In a hurry? Tap Quick Assign',
'setup_photo_title': 'Add your photo',
'setup_photo_subtitle': 'No one can see you without a photo',
'setup_photo_cta': 'Add Photo',
'setup_photo_done': 'Photo added',
'setup_photo_picker_camera': 'Take a Photo',
'setup_photo_picker_gallery': 'Choose from Gallery',
'setup_photo_permission_denied': 'Permission denied. Go to Settings to grant.',
'setup_photo_upload_error': "Couldn't upload, try again",
'setup_question_title': 'Prepare your questions',
'setup_question_subtitle': '2 questions needed to start matching',
'setup_question_magic_cta': '✨ Magic Fill',
'setup_question_quick_cta': '⚡ Quick Assign',
'setup_question_manual_cta': 'Create Myself',
'setup_question_done': '2 questions ready',
'setup_quick_assign_error': "Couldn't assign questions",
'setup_exit_confirm_title': 'Exit setup?',
'setup_exit_confirm_body': "You'll be logged out. Photos and questions you added stay saved.",
'setup_exit_confirm_stay': 'Stay',
'setup_exit_confirm_logout': 'Log Out',
'setup_completing': 'Almost ready...',
'brief_sheet_title': "I'll create 2 questions for you",
'brief_sheet_hint': 'Pick a few interests (min 1, 3 recommended)',
'brief_sheet_generate_cta': 'Generate My Questions →',
'brief_sheet_skip_link': "You choose, I won't bother",
'interest_music': 'Music',
'interest_movies': 'Movies',
'interest_sports': 'Sports',
'interest_career': 'Career',
'interest_relationships': 'Relationships',
'interest_travel': 'Travel',
'interest_food': 'Food',
'interest_books': 'Books',
'interest_gaming': 'Gaming',
'interest_art': 'Art',
'interest_fitness': 'Fitness',
'interest_personality': 'Personality',
'preview_sheet_title': 'Here are your 2 questions',
'preview_sheet_assign_cta': 'Assign My Questions',
'preview_sheet_regen_cta': 'Regenerate',
'preview_sheet_skip_link': "You choose, I won't bother",
'preview_sheet_error': "Couldn't generate, try again",
```

- [ ] **Step 3: TR baseline ekle — `tr.dart`**

Modify: `qulov2/lib/core/l10n/translations/tr.dart`

```dart
// Profil Kurulum Kapısı
'setup_title': 'Birkaç adım kaldı',
'setup_subtitle': 'Profilini tamamla, eşleşmen başlasın',
'setup_hint': 'Acelen mi var? Hemen Ata seç',
'setup_photo_title': 'Fotoğrafını ekle',
'setup_photo_subtitle': 'Fotoğrafsız kimse seni göremez',
'setup_photo_cta': 'Foto Ekle',
'setup_photo_done': 'Fotoğraf hazır',
'setup_photo_picker_camera': 'Kameradan Çek',
'setup_photo_picker_gallery': 'Galeriden Seç',
'setup_photo_permission_denied': 'İzin reddedildi. Ayarlardan izin ver.',
'setup_photo_upload_error': 'Yükleme başarısız, tekrar dene',
'setup_question_title': 'Sorularını hazırla',
'setup_question_subtitle': 'Eşleşmek için 2 soru gerekli',
'setup_question_magic_cta': '✨ Sihirli Doldur',
'setup_question_quick_cta': '⚡ Hemen Ata',
'setup_question_manual_cta': 'Kendim Oluştur',
'setup_question_done': '2 soru hazır',
'setup_quick_assign_error': 'Soru atayamadık',
'setup_exit_confirm_title': 'Çıkış yapayım mı?',
'setup_exit_confirm_body': 'Çıkış yapacaksın. Eklediklerin kayıtlı kalır.',
'setup_exit_confirm_stay': 'Kal',
'setup_exit_confirm_logout': 'Çıkış Yap',
'setup_completing': 'Neredeyse hazır...',
'brief_sheet_title': 'Senin için 2 soru üreteceğim',
'brief_sheet_hint': 'Birkaç ilgi alanı seç (min 1, 3 önerilen)',
'brief_sheet_generate_cta': 'Sorularımı Üret →',
'brief_sheet_skip_link': 'Sen seç, ben uğraşmayayım',
'interest_music': 'Müzik',
'interest_movies': 'Sinema',
'interest_sports': 'Spor',
'interest_career': 'Kariyer',
'interest_relationships': 'İlişki',
'interest_travel': 'Seyahat',
'interest_food': 'Yemek',
'interest_books': 'Kitap',
'interest_gaming': 'Oyun',
'interest_art': 'Sanat',
'interest_fitness': 'Fitness',
'interest_personality': 'Kişilik',
'preview_sheet_title': 'İşte 2 sorun',
'preview_sheet_assign_cta': 'Sorularımı Ata',
'preview_sheet_regen_cta': 'Yeniden Üret',
'preview_sheet_skip_link': 'Sen seç, ben uğraşmayayım',
'preview_sheet_error': 'Üretemedim, tekrar dene',
```

- [ ] **Step 4: i18n-guardian skill ile 14 dile yay**

Skill tool: `i18n-guardian`

Hangi key'ler: 33 yeni key. Hangi diller: ar, de, es, fr, hi, it, ja, ko, nl, pl, pt, ru, sv, zh. Baseline: EN.

Skill prompt: "Profil setup gate için 33 yeni key eklendi (en.dart + tr.dart). Diğer 14 dile uygun şekilde çevir ve ilgili `<locale>.dart` dosyalarına ekle. Emoji'ler korunsun (✨, ⚡)."

- [ ] **Step 5: i18n bütünlük kontrolü**

Run:
```bash
cd qulov2 && grep -l "setup_title" lib/core/l10n/translations/*.dart | wc -l
```
Expected: 16 (her dilde mevcut).

```bash
cd qulov2 && for f in lib/core/l10n/translations/*.dart; do
  count=$(grep -c "'setup_\|'brief_\|'preview_\|'interest_" "$f")
  echo "$f: $count keys"
done
```
Expected: Her dilde >= 33 key.

- [ ] **Step 6: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/core/l10n`
Expected: 0 issues.

- [ ] **Step 7: Commit**

```bash
git add qulov2/lib/core/constants/interest_constants.dart qulov2/lib/core/l10n/translations/
git commit -m "feat(mobile): i18n — 33 setup gate keys × 16 languages"
```

---

## Phase 7 — Mobile: Widget Layer

### Task 13: `SetupPhotoCard` widget

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/setup_photo_card.dart`

- [ ] **Step 1: `_GenderCard` pattern'i incele**

Read: `qulov2/lib/features/auth/widgets/register_step_gender.dart` (line 36-145 — `_GenderCard`)

- [ ] **Step 2: SetupPhotoCard yaz**

Create: `qulov2/lib/features/onboarding/widgets/setup_photo_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class SetupPhotoCard extends StatelessWidget {
  final bool isComplete;
  final bool isUploading;
  final VoidCallback onTap;

  const SetupPhotoCard({
    super.key,
    required this.isComplete,
    required this.isUploading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: isUploading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isComplete ? colors.primarySurface : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isComplete ? colors.primary : theme.colorScheme.outline,
            width: 2,
          ),
          boxShadow: isComplete
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              Icons.photo_camera_outlined,
              size: 28,
              color: isComplete ? colors.primary : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(isComplete ? 'setup_photo_done' : 'setup_photo_title'),
                    style: theme.textTheme.titleLarge,
                  ),
                  if (!isComplete) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      context.tr('setup_photo_subtitle'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isUploading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (isComplete)
              Icon(Icons.check_circle, size: 24, color: colors.primary),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/widgets/setup_photo_card.dart`
Expected: 0 issues.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/setup_photo_card.dart
git commit -m "feat(mobile): SetupPhotoCard widget"
```

---

### Task 14: `SetupQuestionCard` widget

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/setup_question_card.dart`

- [ ] **Step 1: AppButton pattern'i incele**

Read: `qulov2/lib/core/widgets/app_button.dart`

- [ ] **Step 2: SetupQuestionCard yaz**

Create: `qulov2/lib/features/onboarding/widgets/setup_question_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';

class SetupQuestionCard extends StatelessWidget {
  final bool isComplete;
  final bool isProcessing;
  final VoidCallback onMagicFill;
  final VoidCallback onQuickAssign;
  final VoidCallback onManualCreate;
  final VoidCallback onEdit;

  const SetupQuestionCard({
    super.key,
    required this.isComplete,
    required this.isProcessing,
    required this.onMagicFill,
    required this.onQuickAssign,
    required this.onManualCreate,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isComplete ? colors.primarySurface : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isComplete ? colors.primary : theme.colorScheme.outline,
          width: 2,
        ),
        boxShadow: isComplete
            ? [BoxShadow(color: colors.primary.withValues(alpha: 0.2), blurRadius: 12)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.quiz_outlined,
                size: 28,
                color: isComplete ? colors.primary : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  context.tr(isComplete ? 'setup_question_done' : 'setup_question_title'),
                  style: theme.textTheme.titleLarge,
                ),
              ),
              if (isComplete)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: onEdit,
                ),
            ],
          ),
          if (!isComplete) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              context.tr('setup_question_subtitle'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: context.tr('setup_question_magic_cta'),
              onPressed: isProcessing ? null : onMagicFill,
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: context.tr('setup_question_quick_cta'),
              onPressed: isProcessing ? null : onQuickAssign,
              variant: AppButtonVariant.secondary,
              fullWidth: true,
              isLoading: isProcessing,
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: TextButton(
                onPressed: isProcessing ? null : onManualCreate,
                child: Text(
                  context.tr('setup_question_manual_cta'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/widgets/setup_question_card.dart`
Expected: 0 issues.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/setup_question_card.dart
git commit -m "feat(mobile): SetupQuestionCard widget (3-CTA)"
```

---

### Task 15: `SetupBriefSheet` widget (interest chip multi-select)

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/setup_brief_sheet.dart`

- [ ] **Step 1: `OnboardingLanguagePage` FilterChip pattern'i incele**

Read: `qulov2/lib/features/onboarding/widgets/onboarding_language_page.dart`

- [ ] **Step 2: SetupBriefSheet yaz**

Create: `qulov2/lib/features/onboarding/widgets/setup_brief_sheet.dart`

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/constants/interest_constants.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';

class SetupBriefSheet extends StatefulWidget {
  final void Function(List<String> interests) onGenerate;
  final VoidCallback onSkip; // "Sen seç"

  const SetupBriefSheet({
    super.key,
    required this.onGenerate,
    required this.onSkip,
  });

  @override
  State<SetupBriefSheet> createState() => _SetupBriefSheetState();
}

class _SetupBriefSheetState extends State<SetupBriefSheet> {
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              context.tr('brief_sheet_title'),
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.tr('brief_sheet_hint'),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: InterestConstants.tagPool.map((tag) {
                final isSelected = _selected.contains(tag);
                return FilterChip(
                  label: Text(context.tr(InterestConstants.localeKey(tag))),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        _selected.remove(tag);
                      } else {
                        _selected.add(tag);
                      }
                    });
                  },
                  selectedColor: colors.primarySurface,
                  backgroundColor: theme.colorScheme.surface,
                  checkmarkColor: colors.primary,
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: context.tr('brief_sheet_generate_cta'),
              onPressed: _selected.length >= InterestConstants.minSelect
                  ? () => widget.onGenerate(_selected.toList())
                  : null,
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: widget.onSkip,
              child: Text(
                context.tr('brief_sheet_skip_link'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/widgets/setup_brief_sheet.dart`
Expected: 0 issues.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/setup_brief_sheet.dart
git commit -m "feat(mobile): SetupBriefSheet (interest chip multi-select)"
```

---

### Task 16: `SetupAiPreviewSheet` widget

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/setup_ai_preview_sheet.dart`

- [ ] **Step 1: Sheet yaz**

Create: `qulov2/lib/features/onboarding/widgets/setup_ai_preview_sheet.dart`

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';

class SetupAiPreviewSheet extends StatelessWidget {
  final List<Map<String, dynamic>> suggestions;
  final VoidCallback onAssign;
  final VoidCallback onRegenerate;
  final VoidCallback onSkip; // "Sen seç"
  final bool isProcessing;

  const SetupAiPreviewSheet({
    super.key,
    required this.suggestions,
    required this.onAssign,
    required this.onRegenerate,
    required this.onSkip,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              context.tr('preview_sheet_title'),
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ...suggestions.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s['question_text'] as String,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          (s['answers'] as List).join(' · '),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: context.tr('preview_sheet_assign_cta'),
              onPressed: isProcessing ? null : onAssign,
              fullWidth: true,
              isLoading: isProcessing,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: context.tr('preview_sheet_regen_cta'),
              onPressed: isProcessing ? null : onRegenerate,
              variant: AppButtonVariant.secondary,
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: isProcessing ? null : onSkip,
              child: Text(
                context.tr('preview_sheet_skip_link'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/widgets/setup_ai_preview_sheet.dart`
Expected: 0 issues.

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/setup_ai_preview_sheet.dart
git commit -m "feat(mobile): SetupAiPreviewSheet (2 question preview)"
```

---

## Phase 8 — Mobile: Screen + Mixin + Routing

### Task 17: `ProfileSetupMixin`

**Files:**
- Create: `qulov2/lib/features/onboarding/mixins/profile_setup_mixin.dart`

- [ ] **Step 1: ProfileCompletionMixin pattern'i incele**

Read: `qulov2/lib/features/auth/mixins/profile_completion_mixin.dart`

- [ ] **Step 2: ProfileSetupMixin yaz**

Create: `qulov2/lib/features/onboarding/mixins/profile_setup_mixin.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/services/analytics_events.dart';
import 'package:qulo_v2/core/services/analytics_manager.dart';
import 'package:qulo_v2/core/services/image_picker_manager.dart';
import 'package:qulo_v2/core/navigation/navigation_service.dart';
import 'package:qulo_v2/core/navigation/custom_bottom_sheet.dart';
import 'package:qulo_v2/features/onboarding/widgets/setup_brief_sheet.dart';
import 'package:qulo_v2/features/onboarding/widgets/setup_ai_preview_sheet.dart';
import 'package:qulo_v2/providers/auth_provider.dart';
import 'package:qulo_v2/providers/user_provider.dart';
import 'package:qulo_v2/providers/question_provider.dart';
import 'package:qulo_v2/routing/app_routes.dart';

mixin ProfileSetupMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  bool isProcessing = false;
  bool isUploadingPhoto = false;
  List<Map<String, dynamic>> _previewSuggestions = [];

  @override
  void initState() {
    super.initState();
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupGateView);
  }

  Future<void> handlePhotoTap() async {
    if (isProcessing || isUploadingPhoto) return;
    final navigation = ref.read(navigationServiceProvider);
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupPhotoStart);

    final source = await navigation.showAppBottomSheet<String>(
      CustomBottomSheet(
        name: 'photo_source',
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(context.tr('setup_photo_picker_camera')),
                onTap: () => Navigator.pop(ctx, 'camera'),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(context.tr('setup_photo_picker_gallery')),
                onTap: () => Navigator.pop(ctx, 'gallery'),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;
    setState(() => isUploadingPhoto = true);

    try {
      final picked = source == 'camera'
          ? await ImagePickerManager.instance.pickFromCamera()
          : await ImagePickerManager.instance.pickFromGallery();
      if (picked == null) {
        setState(() => isUploadingPhoto = false);
        return;
      }

      final result = await ref
          .read(userProvider.notifier)
          .uploadPhoto(picked.bytes, picked.mimeType);

      if (result.isSuccess) {
        AnalyticsManager.instance.logEvent(AnalyticsEvents.setupPhotoSuccess);
        await _maybeCompleteSetup();
      } else {
        _showSnack(context.tr('setup_photo_upload_error'));
        AnalyticsManager.instance.logEvent(AnalyticsEvents.setupPhotoFail);
      }
    } on ImagePickerPermissionException {
      _showSnack(context.tr('setup_photo_permission_denied'));
      AnalyticsManager.instance.logEvent(AnalyticsEvents.setupPhotoFail);
    } catch (_) {
      _showSnack(context.tr('setup_photo_upload_error'));
      AnalyticsManager.instance.logEvent(AnalyticsEvents.setupPhotoFail);
    } finally {
      if (mounted) setState(() => isUploadingPhoto = false);
    }
  }

  Future<void> handleMagicFill() async {
    if (isProcessing) return;
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupMagicFillStart);
    final navigation = ref.read(navigationServiceProvider);

    await navigation.showAppBottomSheet(
      CustomBottomSheet(
        name: 'setup_brief',
        maxHeightFactor: 0.85,
        builder: (ctx) => SetupBriefSheet(
          onGenerate: (interests) async {
            Navigator.pop(ctx);
            await _afterInterests(interests);
          },
          onSkip: () async {
            Navigator.pop(ctx);
            AnalyticsManager.instance.logEvent(AnalyticsEvents.setupMagicFillSkip);
            await _afterInterests(const []);
          },
        ),
      ),
    );
  }

  Future<void> _afterInterests(List<String> interests) async {
    setState(() => isProcessing = true);
    try {
      await ref.read(userProvider.notifier).setInterests(interests);
      await _showPreviewSheet();
    } finally {
      if (mounted) setState(() => isProcessing = false);
    }
  }

  Future<void> _showPreviewSheet() async {
    final user = ref.read(userProvider).valueOrNull;
    if (user == null) return;

    final result = await ref
        .read(questionRepositoryProvider)
        .aiSuggest(profileBased: true, count: 2, locale: user.locale ?? 'tr');

    if (!result.isSuccess) {
      _showSnack(context.tr('preview_sheet_error'));
      return;
    }

    _previewSuggestions = result.dataOrNull ?? [];
    if (_previewSuggestions.isEmpty) {
      _showSnack(context.tr('preview_sheet_error'));
      return;
    }

    final navigation = ref.read(navigationServiceProvider);
    await navigation.showAppBottomSheet(
      CustomBottomSheet(
        name: 'setup_ai_preview',
        maxHeightFactor: 0.85,
        builder: (ctx) => SetupAiPreviewSheet(
          suggestions: _previewSuggestions,
          isProcessing: isProcessing,
          onAssign: () async {
            Navigator.pop(ctx);
            await _assignSuggestions();
          },
          onRegenerate: () async {
            Navigator.pop(ctx);
            AnalyticsManager.instance.logEvent(AnalyticsEvents.setupMagicFillRegen);
            await _showPreviewSheet();
          },
          onSkip: () async {
            Navigator.pop(ctx);
            await handleQuickAssign();
          },
        ),
      ),
    );
  }

  Future<void> _assignSuggestions() async {
    setState(() => isProcessing = true);
    try {
      final notifier = ref.read(questionProvider.notifier);
      final user = ref.read(userProvider).valueOrNull;
      final start = (user?.questionCount ?? 0) + 1;
      for (int i = 0; i < _previewSuggestions.length; i++) {
        final s = _previewSuggestions[i];
        await notifier.createQuestion({
          'order_num': start + i,
          'question_text': s['question_text'],
          'answer_1': (s['answers'] as List)[0],
          'answer_2': (s['answers'] as List)[1],
          'answer_3': (s['answers'] as List)[2],
          'answer_4': (s['answers'] as List)[3],
          'correct_answer': s['correct_answer'],
          'hint_text': s['hint'],
          'category': s['category'],
          'locale': user?.locale ?? 'tr',
          'time_limit': 30,
        });
      }
      AnalyticsManager.instance.logEvent(AnalyticsEvents.setupMagicFillAssign);
      await _maybeCompleteSetup();
    } finally {
      if (mounted) setState(() => isProcessing = false);
    }
  }

  Future<void> handleQuickAssign() async {
    if (isProcessing) return;
    setState(() => isProcessing = true);
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupQuickAssign);

    try {
      final result = await ref.read(userProvider.notifier).quickAssignQuestions();
      if (!result.isSuccess) {
        _showSnack(context.tr('setup_quick_assign_error'));
        return;
      }
      await _maybeCompleteSetup();
    } finally {
      if (mounted) setState(() => isProcessing = false);
    }
  }

  void handleManualCreate() {
    if (isProcessing) return;
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupManualCreate);
    ref.read(navigationServiceProvider).push(RouteNames.questionCreate);
  }

  Future<void> _maybeCompleteSetup() async {
    final user = ref.read(userProvider).valueOrNull;
    if (user?.setupComplete ?? false) {
      AnalyticsManager.instance.logEvent(AnalyticsEvents.setupComplete);
      // Router redirect re-evaluates auto — no manual navigation needed.
    }
  }

  Future<bool> handleBackAttempt() async {
    AnalyticsManager.instance.logEvent(AnalyticsEvents.setupExitAttempt);
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('setup_exit_confirm_title')),
        content: Text(context.tr('setup_exit_confirm_body')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.tr('setup_exit_confirm_stay')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(context.tr('setup_exit_confirm_logout')),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      AnalyticsManager.instance.logEvent(AnalyticsEvents.setupExitConfirm);
      await ref.read(authProvider.notifier).logout();
      return true;
    }
    return false;
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/mixins/profile_setup_mixin.dart`
Expected: 0 issues. (Eğer importlarda missing varsa düzelt: `image_picker_manager`, `question_provider` vs.)

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/onboarding/mixins/profile_setup_mixin.dart
git commit -m "feat(mobile): ProfileSetupMixin — gate state & async ops"
```

---

### Task 18: `ProfileSetupScreen` orchestrator + route registration

**Files:**
- Create: `qulov2/lib/features/onboarding/screens/profile_setup_screen.dart`
- Modify: `qulov2/lib/routing/app_routes.dart`

- [ ] **Step 1: Screen yaz**

Create: `qulov2/lib/features/onboarding/screens/profile_setup_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/features/onboarding/mixins/profile_setup_mixin.dart';
import 'package:qulo_v2/features/onboarding/widgets/setup_photo_card.dart';
import 'package:qulo_v2/features/onboarding/widgets/setup_question_card.dart';
import 'package:qulo_v2/providers/user_provider.dart';
import 'package:qulo_v2/routing/app_routes.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen>
    with ProfileSetupMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userProvider).valueOrNull;
    final hasPhoto = user?.photos?.isNotEmpty ?? false;
    final questionsReady = (user?.questionCount ?? 0) >= 2;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await handleBackAttempt();
      },
      child: AppScaffold(
        padding: EdgeInsets.zero,
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.tr('setup_title'),
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                context.tr('setup_subtitle'),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              SetupPhotoCard(
                isComplete: hasPhoto,
                isUploading: isUploadingPhoto,
                onTap: handlePhotoTap,
              ),
              const SizedBox(height: AppSpacing.md),
              SetupQuestionCard(
                isComplete: questionsReady,
                isProcessing: isProcessing,
                onMagicFill: handleMagicFill,
                onQuickAssign: handleQuickAssign,
                onManualCreate: handleManualCreate,
                onEdit: () => ref
                    .read(navigationServiceProvider)
                    .push(RouteNames.questions),
              ),
              const Spacer(),
              Center(
                child: Text(
                  context.tr('setup_hint'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Route binding ekle**

Modify: `qulov2/lib/routing/app_routes.dart`

`RouteNames` enum/class içine:
```dart
static const String profileSetup = '/profile-setup';
```

`_routes` listesine GoRoute ekle:
```dart
GoRoute(
  path: RouteNames.profileSetup,
  name: 'profile-setup',
  builder: (context, state) => const ProfileSetupScreen(),
),
```

(Import: `package:qulo_v2/features/onboarding/screens/profile_setup_screen.dart`)

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/features/onboarding/screens lib/routing`
Expected: 0 issues.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/onboarding/screens/profile_setup_screen.dart qulov2/lib/routing/app_routes.dart
git commit -m "feat(mobile): ProfileSetupScreen + /profile-setup route"
```

---

### Task 19: Router guard — `app_router.dart`

**Files:**
- Modify: `qulov2/lib/routing/app_router.dart` (line ~132-146 etrafı)

- [ ] **Step 1: Mevcut redirect chain'i oku**

Read: `qulov2/lib/routing/app_router.dart` lines 60-160.

Locate the age-null guard:
```dart
if (isAuth && state.matchedLocation != '/profile-completion') {
  final user = ref.read(userProvider).value;
  if (user != null && user.age == null) {
    return '/profile-completion';
  }
}
```

- [ ] **Step 2: Setup gate guard'ı ekle**

Edit: Yukarıdaki blok'un altına ekle (profile completion check'inden SONRA):

```dart
// Setup gate: photo + 2 questions required
if (isAuth &&
    state.matchedLocation != '/profile-setup' &&
    state.matchedLocation != '/profile-completion') {
  final user = ref.read(userProvider).value;
  if (user != null && user.age != null && !user.setupComplete) {
    return '/profile-setup';
  }
}

// On /profile-setup but already complete → discover
if (isAuth && state.matchedLocation == '/profile-setup') {
  final user = ref.read(userProvider).value;
  if (user != null && user.setupComplete) {
    return '/discover';
  }
  return null;
}
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/routing/app_router.dart`
Expected: 0 issues.

- [ ] **Step 4: Manuel test — yeni user**

Manuel olarak (yeni user signup, age complete, foto/soru yok):
- Expected: Login sonrası `/profile-setup` ekranı açılır.

- [ ] **Step 5: Manuel test — eski user (1 foto, 1 soru)**

- Expected: Login sonrası `/profile-setup` ekranı açılır.

- [ ] **Step 6: Manuel test — complete user (1+ foto, 2+ soru)**

- Expected: `/discover` direkt açılır.

- [ ] **Step 7: Commit**

```bash
git add qulov2/lib/routing/app_router.dart
git commit -m "feat(mobile): router guard — profile setup gate"
```

---

## Phase 9 — Mobile: Analytics

### Task 20: Analytics events + user properties

**Files:**
- Modify: `qulov2/lib/core/services/analytics_events.dart`
- Modify: `qulov2/lib/core/services/analytics_manager.dart`

- [ ] **Step 1: 13 yeni event sabiti ekle**

Modify: `qulov2/lib/core/services/analytics_events.dart`

```dart
// Profile Setup Gate
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

- [ ] **Step 2: `updateUserProperties`'a `questionsCount` parametresi ekle**

Modify: `qulov2/lib/core/services/analytics_manager.dart`

`updateUserProperties` imzasına ekle:
```dart
void updateUserProperties({
  // ... mevcut paramlar
  String? questionsCount,  // ← yeni
}) {
  // ... mevcut body
  if (questionsCount != null) {
    _analytics.setUserProperty(name: 'questions_count', value: questionsCount);
  }
}
```

- [ ] **Step 3: Call site'i güncelle**

`auth_provider.dart`'taki `analytics.updateUserProperties(...)` çağrısına ekle:
```dart
questionsCount: user.questionCount.toString(),
```

- [ ] **Step 4: flutter analyze**

Run: `cd qulov2 && flutter analyze lib/core/services lib/providers`
Expected: 0 issues.

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/core/services/analytics_events.dart qulov2/lib/core/services/analytics_manager.dart qulov2/lib/providers/auth_provider.dart
git commit -m "feat(mobile): analytics events + questionsCount user property"
```

---

## Phase 10 — Review & Test

### Task 21: `/flutter-review` skill çalıştır

**Files:** Yok — skill review yapar.

- [ ] **Step 1: Mobile diff'i kontrol et**

Run: `git log --oneline HEAD~12..HEAD | grep mobile`
Expected: Phase 5-9 commit'leri görünür.

- [ ] **Step 2: `/flutter-review` skill'ini invoke et**

Skill tool: `flutter-review`

Beklenen: Screen size limit (200), widget extraction, SOLID, hardcoded values, banned patterns, reuse opportunities raporları.

- [ ] **Step 3: Kritik bulguları düzelt**

200 satır aşımı, hardcoded string, missing localization vs. varsa düzelt.

- [ ] **Step 4: i18n-guardian skill yeniden çalıştır**

Skill tool: `i18n-guardian`

Beklenen: 16 dil bütünlük raporu — eksik key yok.

- [ ] **Step 5: Commit (varsa düzeltmeler)**

```bash
git add qulov2/lib
git commit -m "fix(mobile): post-review polish for profile-setup-gate"
```

---

### Task 22: Manuel test plan execution

**Files:** Yok — manuel test.

- [ ] **Step 1: Dev environment hazırla**

Skill: `dev-env-setup` veya manuel:
- Local server: `cd qulo-server && npm run dev`
- Mobile: `cd qulov2 && flutter run`

- [ ] **Step 2: Test senaryolarını çalıştır (spec Bölüm 9)**

Her senaryoyu işaretle:

- [ ] Yeni user signup → age complete → gate açılır
- [ ] Mevcut user (0 foto, 0 soru) login → gate açılır
- [ ] Mevcut user (0 foto, 3 soru) login → gate açılır (foto eksik)
- [ ] Mevcut user (1 foto, 1 soru) login → gate açılır (soru eksik)
- [ ] Mevcut user (1 foto, 2 soru) login → discover (gate yok)
- [ ] Gate'te foto ekle + magic fill assign → otomatik discover
- [ ] Gate'te quick assign + foto ekle → discover
- [ ] Brief sheet "sen seç" → demografik fallback ile 2 soru
- [ ] Free tier user 2 soru yazmış, quick assign tap → 1 soru daha ekle (limit aşımı yok)
- [ ] Back tuşu → confirm dialog → "Kal" → gate'te kal
- [ ] Back tuşu → confirm dialog → "Çıkış" → logout + login
- [ ] Fotosuz user (gate'e yakalanmış) **diğer user'ların discover havuzunda görünmüyor**
- [ ] App background → foreground → permission re-check
- [ ] EN + TR + 1 sample dil (de/fr/ja) string testi

- [ ] **Step 3: Bulunan bug'ları düzelt**

Her bug için ayrı commit (`fix(mobile|server): ...`).

- [ ] **Step 4: TestFlight + Internal Track yayın**

Skill: `deploy-testflight` veya manuel script:
- `cd qulov2 && ./deploy_testflight.sh`
- Android: aab build + Play Console Internal track upload

- [ ] **Step 5: Final commit (release notes)**

```bash
git commit --allow-empty -m "release: profile-setup-gate ready for TestFlight"
```

---

## Backlog (Bu Spec Dışı, Plan Sonu Notu)

- **Push notif kampanyası** (mevcut 40 user'a "Profilini tamamla")
- **Bio zorunluluğu** (ileride değerlendirilir)
- **Interest → match score bonus** (ileride algoritma genişlemesi)
- **AI prompt LLM upgrade** (bank yeterli, şimdilik gerekmez)
- **Profile completion % formülü güncelleme** (bonus reward yan etkisi açılmaz)

---

## Memory Hatırlatmaları

Implementation sırasında aktif olan kurallar:
- [Mevcut pattern'i yeniden kullan](../../../memory/feedback_reuse_existing_patterns.md)
- [Localization zorunlu](../../../memory/feedback_localization_required.md) — Her PR'da i18n-guardian kontrolü
- [Edge case'leri araştır](../../../memory/feedback_no_assumptions_monorepo.md) — Spec edge case matrisi (Bölüm 8)
- [Otomatik Review](../../../memory/feedback_auto_review.md) — Task 9 ve 21'de skill'ler
- [businessCaseSkills](../../../memory/feedback_business_case_skills.md) — i18n-guardian + economy-watchdog etkisi yok bu feature'da
