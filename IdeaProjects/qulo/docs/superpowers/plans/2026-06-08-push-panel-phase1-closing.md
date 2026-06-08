# Push Notification Paneli — Phase 1 Closing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Phase 1 dinamik push notification sistemini canlıda doğrulanmış duruma getir — `PUSH_TYPES`'ı 6 admin-editable tipe daralt + `campaign` için internal type ayrımı + dead locale entry'leri sil + Railway deploy + live override/rollback testi + admin guide.

**Architecture:** `PUSH_TYPES` (admin-editable) ile `INTERNAL_PUSH_TYPES` (`campaign` — body dinamik, paneli atlar) iki ayrı const olarak ayrılır; `AnyPushType` union'ı `sendPush`/`getTemplate`/`NOTIFICATION_CONFIG`'da kullanılır. Validator (`pushTemplateParamsSchema`) sadece `PUSH_TYPES`'a bakar — `campaign` admin panelden editlenemez ama `sendPush('campaign', ...)` çağrıları (`campaign.service.ts`, `weekly-report.service.ts`) çalışmaya devam eder. `notification.service.ts:181-184` zaten `type === 'campaign'` branch'ında `getTemplate`'i bypass ediyor, locale lookup'a hiç düşmüyor — değişiklik gerekmez. Locale dosyalarından (`tr.json`, `en.json`) hiç tetiklenmeyen `quiz_started` + `passport_expired` entry'leri silinir.

**Tech Stack:** TypeScript (ESM) + Vitest + Supabase JS client + Railway auto-deploy (git push to main). Frontend: Yok (sadece backend + admin EJS, EJS değişmiyor).

**Spec:** `docs/superpowers/specs/2026-06-08-push-panel-phase1-closing-design.md`

**Ön koşul:** Phase 1 implementation tamamlanmış (commit `e5ba1e1` → `75fb3d3` qulo-server main branch'inde lokal).

---

## File Plan

### Modify

| Path | What changes |
|---|---|
| `qulo-server/src/services/notification.service.ts` | `PUSH_TYPES` 6 tipe daralt; `INTERNAL_PUSH_TYPES = ['campaign']` ekle; `AnyPushType = PushType \| InternalPushType` union; `NOTIFICATION_CONFIG` `Record<AnyPushType, ...>` (7 entry, quiz_started + passport_expired silinir); `sendPush(type: AnyPushType, ...)`, `getTemplate(type: AnyPushType, ...)`, `loadDefaultTemplate(type: AnyPushType, ...)` signature genişletilir |
| `qulo-server/src/locales/tr.json` | `push.quiz_started` ve `push.passport_expired` entry'leri silinir |
| `qulo-server/src/locales/en.json` | `push.quiz_started` ve `push.passport_expired` entry'leri silinir |
| `qulo-server/docs/admin-push-messages-guide.md` | **Yeni dosya** — 1 sayfa TR admin guide |
| `qulo/docs/marketing/apple-search-ads.md` | "Dinamik Push Sistemi canlıda" satırı eklenir |

### No changes needed (verified)

| Path | Sebep |
|---|---|
| `qulo-server/src/services/campaign.service.ts:141` | `options.title = campaign.push_title` + `params.body = campaign.push_body` zaten doğru — campaign branch'i (sendPush:181) lookup'sız çalışır |
| `qulo-server/src/services/weekly-report.service.ts:23` | `options.title` + `params.body` zaten doğru — aynı şekilde |
| `qulo-server/src/services/chat.service.ts:191` | `pushType: "new_message_image" \| "new_message"` — ikisi de `PushType`'ta, değişiklik yok |
| `qulo-server/src/validators/push-template.validator.ts` | `PUSH_TYPES` import ediyor — otomatik 6'ya daralır, ek değişiklik gerekmez |
| `qulo-server/src/admin/admin.service.ts` `pushTemplateAdminService` | `PUSH_TYPES.map(...)` kullanıyor — otomatik 6 tip döner, signature `PushType` parametreleri zaten doğru (admin sadece editable tipler) |
| `qulo-server/src/admin/admin.controller.ts` | Aynı, validator + service üzerinden çalışır |
| `qulo-server/src/admin/views/push-messages-*.ejs` | UI tarafında değişiklik yok — liste otomatik 6 tip gösterir |
| `qulo-server/migrations/025_push_messages.sql` | Şema değişmiyor |

### Tests

| Path | Coverage |
|---|---|
| `qulo-server/tests/services/notification-getTemplate.test.ts` | Mevcut testler `new_message` kullanıyor — bozulmaz. Yeni 1 case ekle: `quiz_started` artık locale'de yok → null döner |
| `qulo-server/tests/admin/push-messages.test.ts` | Mevcut: `expect(rows.length).toBeGreaterThan(0)` — 6 da > 0, geçer. Yeni 1 case ekle: liste tam olarak 6 tip döner ve `campaign` içermez |

---

## Task 0: Codebase + Production State Audit (read-only)

**Purpose:** Fresh subagent değişiklikten önce mevcut sapmalar, varsayımlar ve production state'i doğrulamalı. Hiçbir dosya değiştirme.

**No commit at end of Task 0.**

- [ ] **Step 1: Confirm PUSH_TYPES current state**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
grep -n "PUSH_TYPES\|INTERNAL_PUSH_TYPES" src/services/notification.service.ts | head -10
```

Expected output (current state — before changes):
- Line 12: `export const PUSH_TYPES = [`
- `quiz_started`, `passport_expired`, `campaign` all 3 present in the array.
- `INTERNAL_PUSH_TYPES` does NOT exist yet.

Eğer farklı görüyorsan dur, mevcut durumu kullanıcıya bildir — başka biri zaten dokunmuş olabilir.

- [ ] **Step 2: Confirm campaign push body is NOT loaded from locale**

Run:
```bash
sed -n '181,210p' src/services/notification.service.ts
```

Expected: Line 181-184 civarında bu blok olmalı:
```ts
if (type === 'campaign' && options?.title) {
  title = options.title;
  body = params.body ?? options.title;
}
```

Bu kanıt, `campaign` push'unun locale lookup'a düşmediği. Yani campaign'ı `PUSH_TYPES`'tan çıkarsak getTemplate çağrısı zaten yapılmıyor, locale entry'sine zaten ihtiyaç yok.

Eğer bu blok yoksa veya farklıysa dur, plan'da varsayım kırılmış — kullanıcıya rapor et.

- [ ] **Step 3: Confirm campaign senders pass options.title**

Run:
```bash
grep -A3 'sendPush.*"campaign"' src/services/campaign.service.ts src/services/weekly-report.service.ts
```

Expected: İki yerde de `options` parametresinde `title:` field'ı var (campaign.service: `title: campaign.push_title`, weekly-report.service: `title: locale === 'tr' ? 'Haftalık Raporun' : 'Weekly Report'`).

Eğer bir tanesi title geçmiyorsa, Task 1 ek bir uyarı veya fallback gerektirebilir — durumu raporla.

- [ ] **Step 4: Confirm locale files have quiz_started + passport_expired**

Run:
```bash
jq '.push | keys' src/locales/tr.json
jq '.push | keys' src/locales/en.json
```

Expected (her ikisi de): `["chat_question_answered", "new_match", "new_match_badge", "new_match_solver", "new_message", "new_message_image", "passport_expired", "quiz_started"]` — 8 key, `campaign` yok (zaten beklenen).

Eğer `campaign` lokal dosyada görünürse plan değişir — kullanıcıya rapor et.

- [ ] **Step 5: Check production push_messages table state**

Use Supabase MCP tool `mcp__claude_ai_Supabase__execute_sql`:
- `project_id`: `vtntrtozgoyhjdvvurkj`
- `query`:
```sql
SELECT type, locale, title IS NOT NULL AS has_title, body IS NOT NULL AS has_body, is_active, updated_at, updated_by
FROM push_messages
ORDER BY type, locale;
```

Expected: 0 rows (henüz hiçbir override yazılmamış) **VEYA** birkaç manuel test override.

Sonucu kaydet — Task 5 (live test) bunu kullanacak (mevcut override varsa silmek veya üzerinden yazmak için).

- [ ] **Step 6: Verify Railway/git current branch state**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git status
git rev-parse --abbrev-ref HEAD
git log --oneline origin/main..HEAD 2>&1 | head -10
```

Expected:
- Branch: `main`
- `git status` → clean working tree (Phase 1 commits done)
- `git log --oneline origin/main..HEAD` → 6 commits beklenen (`e5ba1e1`, `c828f19`, `ec4cba9`, `0507fc9`, `e64f9fe`, `75fb3d3`) — pushlanmamış.

Eğer commits zaten pushlanmışsa (output boş), Phase 1 zaten production'a gitmiş demek. Task 4 (deploy) basitleşir — sadece bu plan'ın yeni commitlerini push'lar.

- [ ] **Step 7: Confirm tests currently pass**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx vitest run tests/services/notification-getTemplate.test.ts tests/admin/push-messages.test.ts
```

Expected: All tests PASS (6 in getTemplate + 7 in push-messages = 13 total).

Eğer fail varsa, Phase 1 implementation eksik veya bozuk — kullanıcıya bildir, Task 1'e geçme.

---

## Task 1: PUSH_TYPES Split + AnyPushType Union

**Files:**
- Modify: `qulo-server/src/services/notification.service.ts`

- [ ] **Step 1: Update PUSH_TYPES + add INTERNAL_PUSH_TYPES + AnyPushType**

Open `qulo-server/src/services/notification.service.ts`. Find lines 12-26 (PUSH_TYPES + PushType + SUPPORTED_LOCALES). Replace this block:

```ts
export const PUSH_TYPES = [
  'new_message',
  'new_message_image',
  'new_match',
  'new_match_solver',
  'new_match_badge',
  'quiz_started',
  'passport_expired',
  'chat_question_answered',
  'campaign',
] as const;

export type PushType = typeof PUSH_TYPES[number];
export const SUPPORTED_LOCALES = ['tr', 'en'] as const;
export type SupportedLocale = typeof SUPPORTED_LOCALES[number];
```

with:

```ts
// Admin-editable push template types (shown in /admin/push-messages panel).
// Validator (pushTemplateParamsSchema) accepts only these.
export const PUSH_TYPES = [
  'new_message',
  'new_message_image',
  'new_match',
  'new_match_solver',
  'new_match_badge',
  'chat_question_answered',
] as const;

export type PushType = typeof PUSH_TYPES[number];

// Internal push types — invoked by sendPush() but NOT editable from the admin panel.
// Body comes from caller params (e.g. campaign.push_body), template lookup is bypassed.
export const INTERNAL_PUSH_TYPES = ['campaign'] as const;
export type InternalPushType = typeof INTERNAL_PUSH_TYPES[number];

// Union accepted by sendPush, getTemplate, and NOTIFICATION_CONFIG.
export type AnyPushType = PushType | InternalPushType;

export const SUPPORTED_LOCALES = ['tr', 'en'] as const;
export type SupportedLocale = typeof SUPPORTED_LOCALES[number];
```

- [ ] **Step 2: Update loadDefaultTemplate signature**

In the same file, find the `loadDefaultTemplate` function (around lines 37-49). Change the `type` parameter type from `PushType` to `AnyPushType`:

```ts
export function loadDefaultTemplate(
  type: AnyPushType,
  locale: SupportedLocale,
): { title: string; body: string } {
```

(The function body stays identical — `locales[safeLocale]?.push?.[type]` works because TS allows indexing with a union of string literals; internal types just return `{ title: '', body: '' }` since they have no locale entry.)

- [ ] **Step 3: Update NOTIFICATION_CONFIG type + remove dead entries**

Find `NOTIFICATION_CONFIG` (around lines 60-70). Replace this block:

```ts
const NOTIFICATION_CONFIG: Record<PushType, NotificationTypeConfig> = {
  new_message:            { category: 'messages' },
  new_message_image:      { category: 'messages' },
  new_match:              { actionUrl: '/matches', category: 'matches', badgeTemplateKey: 'new_match_badge' },
  new_match_solver:       { actionUrl: '/matches', category: 'matches' },
  new_match_badge:        { actionUrl: '/matches', category: 'matches' },
  quiz_started:           { category: 'matches' },
  passport_expired:       { actionUrl: '/profile/passport' },
  campaign:               { category: 'campaigns' },
  chat_question_answered: { category: 'matches' },
};
```

with:

```ts
const NOTIFICATION_CONFIG: Record<AnyPushType, NotificationTypeConfig> = {
  new_message:            { category: 'messages' },
  new_message_image:      { category: 'messages' },
  new_match:              { actionUrl: '/matches', category: 'matches', badgeTemplateKey: 'new_match_badge' },
  new_match_solver:       { actionUrl: '/matches', category: 'matches' },
  new_match_badge:        { actionUrl: '/matches', category: 'matches' },
  chat_question_answered: { category: 'matches' },
  campaign:               { category: 'campaigns' },
};
```

(`quiz_started` and `passport_expired` removed — never sent in code. `campaign` stays, moved to end since it's now classified as internal.)

- [ ] **Step 4: Update getTemplate signature**

Find `getTemplate` static method (around lines 113-144). Change the `type` parameter:

```ts
static async getTemplate(
  type: AnyPushType,
  locale: SupportedLocale,
): Promise<ResolvedTemplate> {
```

(Body unchanged — `loadDefaultTemplate` now also accepts `AnyPushType`, so no internal cast needed.)

- [ ] **Step 5: Update sendPush signature**

Find `sendPush` static method (around line 150). Change the `type` parameter:

```ts
static async sendPush(
  userId: string,
  type: AnyPushType,
  params: Record<string, string> = {},
  data?: Record<string, string>,
  options?: {
    title?: string;
    imageUrl?: string;
    actionUrl?: string;
    actionLabel?: string;
    campaignId?: string;
  },
): Promise<boolean> {
```

- [ ] **Step 6: Update internal cast inside sendPush**

In `sendPush`, find this line (around line 198):

```ts
const resolved = await NotificationService.getTemplate(templateKey as PushType, safeLocale);
```

Replace `as PushType` with `as AnyPushType`:

```ts
const resolved = await NotificationService.getTemplate(templateKey as AnyPushType, safeLocale);
```

- [ ] **Step 7: TypeScript build check**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm run build
```

Expected: No type errors. If errors appear in `campaign.service.ts`, `weekly-report.service.ts`, or `chat.service.ts`, it means the `AnyPushType` union didn't propagate cleanly — re-check Step 5 (sendPush signature).

If type error in `admin.service.ts` (`pushTemplateAdminService`), check that `PUSH_TYPES.map(...)` still works — should, since `PushType` is unchanged in concept (just narrower).

- [ ] **Step 8: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/services/notification.service.ts
git commit -m "refactor(notif): split admin-editable PUSH_TYPES from internal (campaign) — drop dead types"
```

---

## Task 2: Locale File Cleanup

**Files:**
- Modify: `qulo-server/src/locales/tr.json`
- Modify: `qulo-server/src/locales/en.json`

- [ ] **Step 1: Remove quiz_started + passport_expired from tr.json**

Open `qulo-server/src/locales/tr.json`. The file currently is:

```json
{
  "push": {
    "new_message": "{name} size mesaj gonderdi",
    "new_message_image": "{name} size bir fotograf gonderdi",
    "new_match": "Yeni bir eslesme! Birisi tum sorularinizi dogru cozdu",
    "new_match_solver": "Tebrikler! Tum sorulari dogru cozdun, yeni bir eslesmen var!",
    "new_match_badge": "Birisi sorularini {badge} badge ile cozdu! Yeni eslesmen var!",
    "quiz_started": "{name} sorularinizi cozmeye basladi",
    "passport_expired": "Pasaport modunuz sona erdi",
    "chat_question_answered": "Sohbet sorunuz cevaplandi ({result})"
  }
}
```

Replace the entire file contents with:

```json
{
  "push": {
    "new_message": "{name} size mesaj gonderdi",
    "new_message_image": "{name} size bir fotograf gonderdi",
    "new_match": "Yeni bir eslesme! Birisi tum sorularinizi dogru cozdu",
    "new_match_solver": "Tebrikler! Tum sorulari dogru cozdun, yeni bir eslesmen var!",
    "new_match_badge": "Birisi sorularini {badge} badge ile cozdu! Yeni eslesmen var!",
    "chat_question_answered": "Sohbet sorunuz cevaplandi ({result})"
  }
}
```

- [ ] **Step 2: Remove quiz_started + passport_expired from en.json**

Open `qulo-server/src/locales/en.json`. Replace the entire file contents with:

```json
{
  "push": {
    "new_message": "{name} sent you a message",
    "new_message_image": "{name} sent you a photo",
    "new_match": "New match! Someone answered all your questions correctly",
    "new_match_solver": "Congratulations! You answered all questions correctly, you have a new match!",
    "new_match_badge": "Someone solved your quiz with {badge} badge! You have a new match!",
    "chat_question_answered": "Your chat question was answered ({result})"
  }
}
```

- [ ] **Step 3: Verify JSON is valid**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
jq '.push | keys' src/locales/tr.json
jq '.push | keys' src/locales/en.json
```

Expected (her ikisi de):
```json
[
  "chat_question_answered",
  "new_match",
  "new_match_badge",
  "new_match_solver",
  "new_message",
  "new_message_image"
]
```

Tam olarak 6 key. Hiç `quiz_started`, `passport_expired` veya `campaign` görünmemeli.

- [ ] **Step 4: Verify build still passes**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm run build
```

Expected: No errors. Locale dosyaları JSON, TS compile etmez ama dist'e kopyalanır.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/locales/tr.json src/locales/en.json
git commit -m "chore(locales): drop unused push types (quiz_started, passport_expired)"
```

---

## Task 3: Update Tests + Verify All Pass

**Files:**
- Modify: `qulo-server/tests/services/notification-getTemplate.test.ts`
- Modify: `qulo-server/tests/admin/push-messages.test.ts`

- [ ] **Step 1: Add test case for removed type in getTemplate**

Open `qulo-server/tests/services/notification-getTemplate.test.ts`. Find the last `it(...)` block (`'returns null for unknown type with no override'`). After that test, before the closing `});` of `describe`, add this new test:

```ts
  it('returns null for removed type quiz_started (locale entry deleted)', async () => {
    mockSelect({ data: null, error: null });
    // quiz_started was removed from PUSH_TYPES + locale files in Phase 1 closing.
    // Cast bypasses the narrowed type — runtime behavior: no locale entry → no template → null.
    const tpl = await NotificationService.getTemplate('quiz_started' as any, 'tr');
    expect(tpl).toBeNull();
  });
```

- [ ] **Step 2: Run getTemplate tests**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx vitest run tests/services/notification-getTemplate.test.ts
```

Expected: 7 tests PASS (6 original + 1 new).

If `'returns locale default when no override exists'` fails — locale file might be malformed. Re-check Task 2 Step 3.

- [ ] **Step 3: Add test case for exact PUSH_TYPES count in admin list**

Open `qulo-server/tests/admin/push-messages.test.ts`. Find the `describe('pushTemplateAdminService.list (shape)', ...)` block. Inside it, after the existing `it('returns one entry per PUSH_TYPE', ...)` test, before the closing `});` of describe, add:

```ts
  it('returns exactly 6 admin-editable types (no campaign, no quiz_started, no passport_expired)', async () => {
    vi.resetModules();
    vi.doMock('../../src/config/supabase.js', () => ({
      supabase: {
        from: () => ({
          select: () => ({
            eq: () => Promise.resolve({ data: [], error: null }),
          }),
        }),
      },
    }));
    const { pushTemplateAdminService: svc } = await import('../../src/admin/admin.service.js');
    const rows = await svc.list('tr');
    expect(rows.length).toBe(6);
    const types = rows.map((r) => r.type).sort();
    expect(types).toEqual([
      'chat_question_answered',
      'new_match',
      'new_match_badge',
      'new_match_solver',
      'new_message',
      'new_message_image',
    ]);
    expect(types).not.toContain('campaign');
    expect(types).not.toContain('quiz_started');
    expect(types).not.toContain('passport_expired');
  });
```

- [ ] **Step 4: Run admin tests**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx vitest run tests/admin/push-messages.test.ts
```

Expected: 8 tests PASS (7 original + 1 new). If the original `expect(rows.length).toBeGreaterThan(0)` test now returns 6 (still > 0), it still passes.

- [ ] **Step 5: Run full test suite**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx vitest run
```

Expected: All tests pass across all test files. If other test files (campaign tests, chat tests, etc.) fail due to the type changes — STOP, report which test broke. Most likely cause: a test was using `PushType` import + a removed type like `'quiz_started'`.

- [ ] **Step 6: Final build check**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm run build
```

Expected: Clean build, no warnings about removed types.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add tests/services/notification-getTemplate.test.ts tests/admin/push-messages.test.ts
git commit -m "test(notif): cover removed types + verify 6 admin-editable types in panel list"
```

---

## Task 4: Production Deploy to Railway

**Files:** (no new files — pushes Tasks 1-3 commits)

- [ ] **Step 1: Confirm commits ready to push**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git log --oneline origin/main..HEAD
```

Expected: 9 commits (Phase 1's 6 + this plan's 3 — refactor, locale, test). Or only 3 commits if Phase 1 was already pushed (per Task 0 Step 6 result).

If 0 commits → nothing to push, but Phase 1 implementation must already be live. Skip to Step 4.

- [ ] **Step 2: Push to main**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git push origin main
```

Expected: Push succeeds. Railway webhook triggers auto-deploy within seconds.

If push fails due to remote conflict (`! [rejected]`), run `git pull --rebase origin main` first, re-test, then push again. Do NOT force-push.

- [ ] **Step 3: Watch Railway build**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
railway logs --since 5m 2>&1 | tail -80
```

Wait for:
- `Build successful` or similar
- Server startup log (e.g., `Server listening on port 3000` or whatever the server logs at startup)

If build fails: read the error in railway logs. Common cause: missing devDeps for `tsc` — `nixpacks.toml` should have `npm ci --include=dev` (already fixed in commit `814dd5d` per Phase 1 history).

- [ ] **Step 4: Smoke test production endpoints**

Run:
```bash
curl -s -o /dev/null -w "ping: %{http_code}\n" https://qulo-server-production.up.railway.app/ping
curl -s -o /dev/null -w "admin-redirect: %{http_code}\n" https://qulo-server-production.up.railway.app/admin/push-messages?locale=tr
```

Expected:
- `ping: 200` (server healthy)
- `admin-redirect: 302` or `303` (auth gate — redirects to login since no session cookie)

If `admin-redirect: 500` → server error, check Railway logs for stack trace.

- [ ] **Step 5: Verify push_messages table still queryable**

Use Supabase MCP `mcp__claude_ai_Supabase__execute_sql`:
- `project_id`: `vtntrtozgoyhjdvvurkj`
- `query`:
```sql
SELECT COUNT(*) AS total FROM push_messages;
```

Expected: Returns a count (could be 0 from Task 0 finding, or more if Task 0 showed existing rows).

- [ ] **Step 6: No commit (deploy-only task)**

---

## Task 5: Live Override + Rollback Test (manual, requires real device)

**Purpose:** Phase 1'in son success kriterleri. Bu task fiziksel cihaz + admin panel etkileşimi gerektirir — agentic execution değil, **kullanıcı (Berkant) manuel olarak yapacak**. Adımları kullanıcıya rapor et, sonuçları kullanıcıdan al, başarı/başarısızlığı not et.

**Required setup:**
- Berkant'ın gerçek iOS/Android cihazı (Qulo prod build yüklü, push notifications enabled)
- Production admin paneline erişim
- Seed test user `tester_001@qulo.test` (şifre `Test1234!`) ile başka bir cihaz/simülatör — mesaj göndermek için

- [ ] **Step 1: Clear any existing test overrides**

Önce Task 0 Step 5'te bulduğun mevcut `new_message` override'ı varsa onu sil. Supabase MCP:
```sql
DELETE FROM push_messages WHERE type = 'new_message';
```

(Test temiz başlasın diye.) Eğer Task 0'da hiç override yoksa bu adımı atla.

- [ ] **Step 2: Open admin panel**

Browser:
1. `https://qulo-server-production.up.railway.app/admin` → login
2. Sidebar → `🔔 Push Mesajları`
3. **Verify:** Liste **6 tip** gösteriyor:
   - chat_question_answered, new_match, new_match_badge, new_match_solver, new_message, new_message_image
4. Hepsi 🟢 Aktif, hepsi "default" (override yok)

Eğer 6'dan farklı sayı görüyorsan dur — Task 1'de PUSH_TYPES listesi yanlış kalmış olabilir.

- [ ] **Step 3: Write a test override on new_message**

1. `new_message` satırına tıkla → edit sayfası açılır
2. **Title** input'una yaz: `Test override 2026-06-08`
3. **Body** input'una yaz: `{name} sana yeni bir test mesajı gönderdi 👀`
4. `Kaydet` → confirm → sayfa reload olur
5. Liste sayfasına dön: `new_message` satırı artık override metnini ve şu anki tarih/saati gösteriyor olmalı

- [ ] **Step 4: Trigger a real push**

1. Berkant'ın cihazı uyanık ve foreground'da DEĞİL (notification kilit ekranında görünsün diye)
2. Başka bir cihazdan/simülatörden `tester_001@qulo.test` user'ı ile login
3. Berkant'ın user'ı ile zaten bir match olmalı; yoksa seed user'lardan biriyle hızlıca match aç (Berkant'ın sorularını çöz)
4. tester_001 cihazından Berkant'a mesaj gönder
5. **Expected:** Berkant'ın cihazında ~5-15 saniye içinde push gelir, body: `tester_001 sana yeni bir test mesajı gönderdi 👀` (başlık `Test override 2026-06-08`)

Eğer push gelmezse:
- `railway logs --since 2m | grep -iE "sendPush\|getTemplate\|push_messages"` ile log'da error ara
- FCM token user'da var mı kontrol et (Supabase users table)

- [ ] **Step 5: Rollback override**

1. Admin paneli → `new_message` → edit
2. Form'un altındaki `Override'ı tamamen sil` butonuna tıkla → confirm → liste'de "default"a döner
   - (Alternatif: `Default'a dön` butonlarıyla title ve body alanlarını boşalt, `Aktif` checked kalsın, kaydet)
3. Liste sayfasında `new_message` artık "default" gösterir, son düzenlenme = yok

- [ ] **Step 6: Trigger another push (default expected)**

1. tester_001 → Berkant'a ikinci bir mesaj gönder
2. **Expected:** Berkant'ın cihazında push gelir, body: `tester_001 size mesaj gonderdi` (locale default, Türkçe)

Bu rollback'in çalıştığını kanıtlar.

- [ ] **Step 7: Verify clean Railway logs**

Run:
```bash
railway logs --since 10m 2>&1 | grep -iE "getTemplate|push_messages|sendPush" | grep -iE "warn|error|fail"
```

Expected: 0 results (no warnings or errors from the notification path).

Eğer warnings görünürse:
- `push_messages fetch failed` → Supabase service role key veya RLS sorunu
- `No push template for type=` → PUSH_TYPES daralma + sendPush'ta hâlâ eski tip gönderiliyor → kod bug

- [ ] **Step 8: No commit (manual verification only)**

Bu task tamamlandığında 5 başarı kriterinden 2'si (live override + rollback) ✅ olur.

---

## Task 6: Admin User Guide

**Files:**
- Create: `qulo-server/docs/admin-push-messages-guide.md`

- [ ] **Step 1: Write the admin guide**

Create `qulo-server/docs/admin-push-messages-guide.md` with the following content:

```markdown
# Admin Guide — Push Mesajları

## Ne için var

Push notification metinlerini (`new_message`, `new_match` vs.) deploy gerektirmeden değiştirmek için. Admin paneline yazdığın metin **anında** geçerli olur, bir sonraki push yeni metinle gider.

## Nereden açılır

Admin paneline login ol → sol sidebar → **🔔 Push Mesajları**

## Mesaj düzenleme

1. Liste sayfasında bir tip seç (örn. `new_message`) → `Düzenle`
2. `Başlık` veya `Gövde` alanlarına yeni metni yaz
   - Boş bırakırsan dosyadaki orijinal metin geçerli kalır
   - `{name}`, `{badge}`, `{result}` placeholder'larını kullanabilirsin
3. Önizleme bölümünde nasıl görüneceğini gör (placeholder'lar örnek değerlerle dolar)
4. `Kaydet`
5. Değişiklik **anında** geçerli olur — bir sonraki push yeni metinle gider

## Push'u tamamen kapatma

Edit ekranında `Aktif` kutucuğunu kaldır → `Kaydet` → onay penceresi → kabul edersen o tip push **artık hiç gönderilmez**. DB'de bildirim yine kaydedilir ama FCM atlanır.

## Default'a geri dönme

İki yol:
- **Tek alan için:** Input'un altındaki `Default'a dön` linkine tıkla → o alan boşalır → `Kaydet`
- **Tüm override için:** Edit sayfasının altındaki `Override'ı tamamen sil` butonu → confirm → DB satırı silinir

## Dil seçimi

Liste sayfasının üst sağındaki `TR` / `EN` linkleriyle hangi dili düzenlediğini değiştir. Her dil için ayrı override yazılır — TR için yazdığın EN'i etkilemez.

## Hata durumunda

- **DB sorunu çıkarsa:** Sistem otomatik olarak dosyadaki orijinal metni kullanır (`tr.json` / `en.json`)
- **Yanlış placeholder (örn. `{foo}`) yazarsan:** Form `Kaydet`'i reddeder — izinli liste: `{name}`, `{badge}`, `{result}`
- **Push gelmezse:** Önce `Aktif` durumunu kontrol et, sonra Railway log'larında `sendPush` hatası var mı bak

## Hangi tipler editlenebilir

Panelde **6 tip** vardır:

| Tip | Ne zaman tetiklenir | Placeholder'lar |
|---|---|---|
| `new_message` | Sohbette text mesajı geldiğinde | `{name}` (gönderen) |
| `new_message_image` | Sohbette fotoğraf mesajı geldiğinde | `{name}` (gönderen) |
| `new_match` | Senin sorularını biri çözdüğünde (sana giden push) | (yok veya `{badge}` — badge param varsa `new_match_badge` template'i kullanılır) |
| `new_match_solver` | Sen birinin sorularını çözdüğünde (sana giden push) | (yok) |
| `new_match_badge` | `new_match` badge varyantı (otomatik tetiklenir, badge param ile) | `{badge}` |
| `chat_question_answered` | Sohbet sorusu cevaplandığında | `{result}` (doğru/yanlış) |

## Panelde olmayan tipler

- **`campaign`** — Kampanya push'ları (admin/campaigns'ten yönetilir). Body kampanya tarafından dinamik gelir, push template'i editlenmez.
```

- [ ] **Step 2: Verify file created**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
ls -la docs/admin-push-messages-guide.md
wc -l docs/admin-push-messages-guide.md
```

Expected: File exists, ~50-60 lines.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add docs/admin-push-messages-guide.md
git commit -m "docs(admin): push messages user guide (Phase 1)"
git push origin main
```

(Push edilmesi gerekiyor — sadece doc, deploy'a etki etmez ama Railway yine de rebuild yapar; sorun değil.)

---

## Task 7: Marketing Doc Update

**Files:**
- Modify: `qulo/docs/marketing/apple-search-ads.md`

- [ ] **Step 1: Read current marketing doc structure**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
head -100 docs/marketing/apple-search-ads.md
grep -n "Push\|push\|notification\|Bildirim" docs/marketing/apple-search-ads.md | head -10
```

Output'tan doc'un section yapısını anla — "Kampanya Öncesi Bulunan Riskler" benzeri bir bölüm var mı, yoksa direkt notes section'ı var mı?

- [ ] **Step 2: Append the dynamic push status note**

Eğer doc'ta "Kampanya Öncesi Riskler" veya "Hazır Olan Sistemler" gibi bir bölüm varsa, oranın altına ekle. Yoksa dosyanın sonuna ekle. Edit tool ile yapılır — anchor olarak doc'taki son satırı veya uygun bir başlığı bulup ekle.

Eklenecek içerik:

```markdown

---

### 🟢 [HAZIR] Dinamik Push Notification Sistemi (2026-06-08 canlı)

Phase 1 production'da. Push notification metinleri admin panelden (`/admin/push-messages`) deploy gerektirmeden değiştirilebiliyor.

**ASA kampanyası için anlamı:** Kötü performans gösteren bir push 2 dakikada A→B'ye geçirilebilir. is_active=false ile bir tipi tamamen susturabilirsin.

**Editlenebilir 6 tip:** `new_message`, `new_message_image`, `new_match`, `new_match_solver`, `new_match_badge`, `chat_question_answered`.

**Detay:**
- Spec: `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`
- Closing spec: `docs/superpowers/specs/2026-06-08-push-panel-phase1-closing-design.md`
- Admin guide: `qulo-server/docs/admin-push-messages-guide.md`
```

Edit tool kullan:
- `file_path`: `/Users/berkantcalikusu/IdeaProjects/qulo/docs/marketing/apple-search-ads.md`
- `old_string`: doc'taki son anlamlı satırın tamamı (exact match için en az 2-3 satır al)
- `new_string`: aynı satırlar + yukarıdaki blok

Eğer Step 1'de gördüğün yapı uygun bir başlık altına yerleştirmeyi gerektiriyorsa, ona göre uyarla.

- [ ] **Step 3: Verify the edit**

Run:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
grep -A2 "Dinamik Push" docs/marketing/apple-search-ads.md
```

Expected: New section visible.

- [ ] **Step 4: Commit (qulo monorepo)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add docs/marketing/apple-search-ads.md
git commit -m "docs(marketing): note dynamic push system Phase 1 live"
```

**Do NOT push** — qulo monorepo remote'unun SSH yapılandırma sorunu var (CLAUDE.md'de not edilmiş). Lokal commit yeterli. Kullanıcı uygun zamanda push eder.

---

## Verification — Phase 1 Closing Done Definition

All five must be ✅ before declaring complete (spec Section 8 ile birebir):

- [ ] `PUSH_TYPES` 6 tip; `quiz_started` + `passport_expired` hem kodda hem locale'de yok; `campaign` `INTERNAL_PUSH_TYPES`'ta (Task 1 + Task 2 commit'leri)
- [ ] `npm run build` + `npx vitest run` tertemiz (Task 3 Step 5-6)
- [ ] Production deploy başarılı, admin panel 6 tip gösteriyor (Task 4 Step 4 + Task 5 Step 2)
- [ ] **Live override:** `new_message` override → mobile cihazda yeni metin alındı (Task 5 Step 4)
- [ ] **Rollback:** "Default'a dön" → mobile cihazda original metin alındı (Task 5 Step 6)

---

## Out of Scope (do NOT include in this plan)

- Phase 2 retention push'ları (Day 1/3/7/14)
- Phase 3 gamification push'ları
- Phase 4 — 14 dil çevirisi
- Phase 5 — A/B test, audit log, cache, analytics
- Match email tasarımı (kullanıcı ile ayrı session'da konuşulacak)
- Email template editleme paneli

---

_Plan generated 2026-06-08 from spec `2026-06-08-push-panel-phase1-closing-design.md`._
