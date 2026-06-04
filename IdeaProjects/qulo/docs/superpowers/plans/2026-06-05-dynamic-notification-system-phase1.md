# Phase 1: Dynamic Push Notification System — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a DB-override + locale-fallback layer to the existing push notification system so admins can edit push title/body and toggle active/inactive from a backoffice panel without deploying code.

**Architecture:** Locale files (`tr.json`, `en.json`) remain the default source-of-truth (git-tracked). A new `push_messages` table holds per-(type, locale) overrides with `title?`, `body?`, `is_active` columns. `NotificationService.getTemplate()` checks the DB first; on miss/null/false-active it returns the locale-file default or `null` (skip). On DB error, automatic fallback to locale file. Two new admin EJS pages (list + edit) call four new admin REST endpoints for CRUD.

**Tech Stack:** TypeScript (ESM) + Express + Supabase JS client + EJS views + Vitest tests + Zod validators. Existing patterns: `notification.service.ts` already uses `createRequire(import.meta.url)` to load locale JSON; admin controller uses `req.session.adminEmail` for actor identity.

**Spec:** `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`

---

## File Plan

### Create

| Path | Responsibility |
|---|---|
| `qulo-server/migrations/025_push_messages.sql` | DDL: create table + unique constraint + check constraint |
| `qulo-server/src/admin/views/push-messages-list.ejs` | List view: all push types for selected locale, status, last edited |
| `qulo-server/src/admin/views/push-messages-edit.ejs` | Edit view: title/body inputs + defaults + active toggle + live preview |
| `qulo-server/src/validators/push-template.validator.ts` | Zod schemas for PUT body and route params (type, locale whitelist) |
| `qulo-server/docs/admin-push-messages-guide.md` | 1-page admin user guide |

### Modify

| Path | What changes |
|---|---|
| `qulo-server/src/services/notification.service.ts` | Add `getTemplate(type, locale)` static method. Replace inline `locales[locale]?.push?.[templateKey]` lookup at line 107 with `getTemplate()` call. Add a `PUSH_TYPES` exported const (whitelist for validators). |
| `qulo-server/src/admin/admin.controller.ts` | Add 4 handlers: GET list, GET detail, PUT save, DELETE reset. Mount routes under `/admin/push-messages` (HTML pages) and `/admin/api/push-messages` (JSON for the page JS). |
| `qulo-server/src/admin/admin.service.ts` (or new section in admin.controller.ts inline) | Service methods: `listPushTemplates(locale)`, `getPushTemplate(type, locale)`, `upsertPushTemplate(type, locale, data, actorEmail)`, `deletePushTemplate(type, locale)` |
| `qulo-server/src/admin/views/_header.ejs` | Add "Push Mesajları" link to the sidebar menu |

### Tests

| Path | Coverage |
|---|---|
| `qulo-server/tests/services/notification-getTemplate.test.ts` | Unit: override wins / partial override / is_active=false / missing locale / DB error fallback |
| `qulo-server/tests/admin/push-messages.test.ts` | Integration: list endpoint shape, PUT upsert, DELETE removes, validator rejects unknown type/locale |

---

## Task 0: Codebase Pattern Audit (read-only)

**Purpose:** A fresh subagent must understand the existing patterns before writing code. No file changes.

**Files to read:**
- `qulo-server/src/services/notification.service.ts:1-180` (existing sendPush + locale loading)
- `qulo-server/src/admin/admin.controller.ts:1-100` (handler + session pattern)
- `qulo-server/src/admin/admin.service.ts` (service method style)
- `qulo-server/src/admin/views/users.ejs` (existing list-page EJS style + class names)
- `qulo-server/src/admin/views/user-detail.ejs` (existing detail/edit EJS style)
- `qulo-server/src/admin/views/_header.ejs` (sidebar structure)
- `qulo-server/src/locales/tr.json` and `en.json` (the `push.*` keys — what types exist today)
- `qulo-server/src/validators/auth.validator.ts` (Zod usage style)
- `qulo-server/tests/` directory listing (to see existing test patterns; if empty, write tests using vitest defaults: `describe`, `it`, `expect`, `vi.mock`)

- [ ] **Step 1: List all push types currently defined**

Run: `grep -A1 '"push"' qulo-server/src/locales/tr.json | head -30`
Note every key under `push.*` — this is the canonical `PUSH_TYPES` set the validator will whitelist.

- [ ] **Step 2: Confirm admin session field name**

Run: `grep -n 'session\.admin' qulo-server/src/admin/admin.controller.ts | head -5`
Expected: `req.session.adminEmail` exists (used as `updated_by` value).

- [ ] **Step 3: Confirm Supabase client import path**

Run: `grep -n 'from .*supabase' qulo-server/src/services/notification.service.ts`
Expected: `import { supabase } from '../config/supabase.js';`

No commit at the end of Task 0 (read-only).

---

## Task 1: Database Migration — `push_messages` Table

**Files:**
- Create: `qulo-server/migrations/025_push_messages.sql`

- [ ] **Step 1: Write the migration SQL**

Create `qulo-server/migrations/025_push_messages.sql`:

```sql
-- 025_push_messages.sql
-- Override table for push notification templates (Phase 1 dynamic notification system)
-- Defaults live in src/locales/{tr,en}.json — DB rows override per (type, locale)

CREATE TABLE IF NOT EXISTS push_messages (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type        text NOT NULL,
  locale      text NOT NULL,
  title       text,
  body        text,
  is_active   boolean NOT NULL DEFAULT true,
  updated_at  timestamptz NOT NULL DEFAULT now(),
  updated_by  text,
  UNIQUE (type, locale),
  CHECK (title IS NOT NULL OR body IS NOT NULL OR is_active = false)
);

COMMENT ON TABLE push_messages IS 'Per-(type, locale) override layer for push notification templates';
COMMENT ON COLUMN push_messages.is_active IS 'false = push is muted entirely (no FCM send)';
```

- [ ] **Step 2: Apply migration via Supabase MCP**

Use the `mcp__claude_ai_Supabase__apply_migration` tool:
- `project_id`: `vtntrtozgoyhjdvvurkj`
- `name`: `push_messages_table`
- `query`: (paste the SQL above)

Expected: `{"success": true}`

- [ ] **Step 3: Verify schema in Supabase**

Use `mcp__claude_ai_Supabase__execute_sql`:
```sql
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'push_messages'
ORDER BY ordinal_position;
```
Expected: 8 rows (id, type, locale, title, body, is_active, updated_at, updated_by).

- [ ] **Step 4: Verify unique + check constraints**

```sql
SELECT conname, contype, pg_get_constraintdef(oid) AS def
FROM pg_constraint
WHERE conrelid = 'push_messages'::regclass;
```
Expected: PRIMARY KEY (id), UNIQUE (type, locale), CHECK constraint on title/body/is_active.

- [ ] **Step 5: Commit (qulo-server repo)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add migrations/025_push_messages.sql
git commit -m "feat(db): add push_messages override table for dynamic notification system"
```

---

## Task 2: `getTemplate()` Helper in NotificationService

**Files:**
- Modify: `qulo-server/src/services/notification.service.ts`
- Test: `qulo-server/tests/services/notification-getTemplate.test.ts`

- [ ] **Step 1: Define PUSH_TYPES whitelist and types**

Open `qulo-server/src/services/notification.service.ts`. Below the `locales` constant (around line 11), add:

```ts
export const PUSH_TYPES = [
  'new_message',
  'new_message_image',
  'new_match',
  'new_match_solver',
  'new_match_badge',
  'passport_expired',
  'chat_question_answered',
  'campaign',
] as const;

export type PushType = typeof PUSH_TYPES[number];
export const SUPPORTED_LOCALES = ['tr', 'en'] as const;
export type SupportedLocale = typeof SUPPORTED_LOCALES[number];

export type ResolvedTemplate = { title: string; body: string } | null;
```

(If Step 1 of Task 0 revealed different keys in `tr.json`, use that exact list instead — the locale file is the source of truth for which types exist.)

- [ ] **Step 2: Write the failing test**

Create `qulo-server/tests/services/notification-getTemplate.test.ts`:

```ts
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { NotificationService } from '../../src/services/notification.service.js';

vi.mock('../../src/config/supabase.js', () => ({
  supabase: {
    from: vi.fn(),
  },
}));

import { supabase } from '../../src/config/supabase.js';

function mockSelect(result: { data?: unknown; error?: unknown }) {
  const maybeSingle = vi.fn().mockResolvedValue(result);
  const eq2 = vi.fn(() => ({ maybeSingle }));
  const eq1 = vi.fn(() => ({ eq: eq2 }));
  const select = vi.fn(() => ({ eq: eq1 }));
  (supabase.from as any).mockReturnValue({ select });
}

describe('NotificationService.getTemplate', () => {
  beforeEach(() => vi.clearAllMocks());

  it('returns locale default when no override exists', async () => {
    mockSelect({ data: null, error: null });
    const tpl = await NotificationService.getTemplate('new_message', 'tr');
    expect(tpl).not.toBeNull();
    expect(tpl!.title.length).toBeGreaterThan(0);
    expect(tpl!.body.length).toBeGreaterThan(0);
  });

  it('full override replaces both title and body', async () => {
    mockSelect({ data: { title: 'X', body: 'Y', is_active: true }, error: null });
    const tpl = await NotificationService.getTemplate('new_message', 'tr');
    expect(tpl).toEqual({ title: 'X', body: 'Y' });
  });

  it('partial override (body only) keeps default title', async () => {
    mockSelect({ data: { title: null, body: 'Y', is_active: true }, error: null });
    const tpl = await NotificationService.getTemplate('new_message', 'tr');
    expect(tpl!.body).toBe('Y');
    expect(tpl!.title.length).toBeGreaterThan(0); // default
  });

  it('returns null when is_active=false', async () => {
    mockSelect({ data: { title: 'X', body: 'Y', is_active: false }, error: null });
    const tpl = await NotificationService.getTemplate('new_message', 'tr');
    expect(tpl).toBeNull();
  });

  it('falls back to locale default when DB throws', async () => {
    (supabase.from as any).mockImplementation(() => { throw new Error('db down'); });
    const tpl = await NotificationService.getTemplate('new_message', 'tr');
    expect(tpl).not.toBeNull();
    expect(tpl!.title.length).toBeGreaterThan(0);
  });

  it('returns null for unknown type with no override', async () => {
    mockSelect({ data: null, error: null });
    const tpl = await NotificationService.getTemplate('does_not_exist' as any, 'tr');
    expect(tpl).toBeNull();
  });
});
```

- [ ] **Step 3: Run test to verify failure**

Run: `cd qulo-server && npx vitest run tests/services/notification-getTemplate.test.ts`
Expected: All tests FAIL with "getTemplate is not a function" or similar.

- [ ] **Step 4: Implement `getTemplate()` static method**

In `qulo-server/src/services/notification.service.ts`, inside the `NotificationService` class (above `sendPush`), add:

```ts
static async getTemplate(
  type: PushType,
  locale: SupportedLocale,
): Promise<ResolvedTemplate> {
  const safeLocale = locales[locale] ? locale : 'en';
  const defaults = locales[safeLocale]?.push?.[type] as
    | { title?: string; body?: string }
    | undefined;

  let override: { title: string | null; body: string | null; is_active: boolean } | null = null;
  try {
    const { data } = await supabase
      .from('push_messages')
      .select('title, body, is_active')
      .eq('type', type)
      .eq('locale', safeLocale)
      .maybeSingle();
    override = (data as typeof override) ?? null;
  } catch (err) {
    console.warn('[NotificationService] push_messages fetch failed, using locale default:', err);
  }

  if (override?.is_active === false) return null;

  const title = override?.title ?? defaults?.title;
  const body = override?.body ?? defaults?.body;
  if (!title || !body) return null;

  return { title, body };
}
```

- [ ] **Step 5: Run test to verify pass**

Run: `cd qulo-server && npx vitest run tests/services/notification-getTemplate.test.ts`
Expected: All 6 tests PASS.

- [ ] **Step 6: Refactor `sendPush` to use `getTemplate()`**

Find the existing template lookup in `sendPush` (around line 107, looks like `const template = locales[locale]?.push?.[templateKey];`). Replace the lookup + null-handling block with:

```ts
const resolved = await NotificationService.getTemplate(templateKey as PushType, locale as SupportedLocale);
if (!resolved) {
  console.warn(`[NotificationService] No template or is_active=false for type=${templateKey}, locale=${locale} — skipping push (still persisting to DB if applicable)`);
  // existing DB-persist path stays; only the FCM send is skipped
}
const titleTemplate = resolved?.title;
const bodyTemplate = resolved?.body;
```

Then update the existing string-replacement logic (`{name}` substitution etc.) to operate on `titleTemplate` and `bodyTemplate` if present. If `resolved` is null, skip the FCM `send()` call entirely.

- [ ] **Step 7: Run all notification tests**

Run: `cd qulo-server && npx vitest run tests/services/`
Expected: All tests pass (no regression in existing notification tests, if any).

- [ ] **Step 8: TypeScript build check**

Run: `cd qulo-server && npm run build`
Expected: No type errors. If errors appear, narrow them to the changed lines and fix.

- [ ] **Step 9: Commit**

```bash
cd qulo-server
git add src/services/notification.service.ts tests/services/notification-getTemplate.test.ts
git commit -m "feat(notif): add getTemplate() helper with DB override + locale fallback"
```

---

## Task 3: Validator + Admin API Endpoints

**Files:**
- Create: `qulo-server/src/validators/push-template.validator.ts`
- Modify: `qulo-server/src/admin/admin.service.ts` (add 4 service methods)
- Modify: `qulo-server/src/admin/admin.controller.ts` (add 4 route handlers)
- Test: `qulo-server/tests/admin/push-messages.test.ts`

- [ ] **Step 1: Write the validator**

Create `qulo-server/src/validators/push-template.validator.ts`:

```ts
import { z } from 'zod';
import { PUSH_TYPES, SUPPORTED_LOCALES } from '../services/notification.service.js';

export const pushTemplateParamsSchema = z.object({
  type: z.enum(PUSH_TYPES as unknown as [string, ...string[]]),
});

export const pushTemplateQuerySchema = z.object({
  locale: z.enum(SUPPORTED_LOCALES as unknown as [string, ...string[]]),
});

// Reject unknown placeholders. Only allow letters, digits, underscore inside {…}.
const PLACEHOLDER_RE = /\{([a-zA-Z0-9_]+)\}/g;
const ALLOWED_PLACEHOLDERS = new Set(['name', 'badge', 'result']);

function validatePlaceholders(text: string | null | undefined): boolean {
  if (!text) return true;
  for (const match of text.matchAll(PLACEHOLDER_RE)) {
    if (!ALLOWED_PLACEHOLDERS.has(match[1])) return false;
  }
  return true;
}

export const pushTemplateBodySchema = z.object({
  title: z.string().trim().min(1).max(120).optional().nullable()
    .refine(validatePlaceholders, { message: 'Title contains an unknown {placeholder}' }),
  body: z.string().trim().min(1).max(280).optional().nullable()
    .refine(validatePlaceholders, { message: 'Body contains an unknown {placeholder}' }),
  is_active: z.boolean(),
}).refine(
  (v) => v.title || v.body || v.is_active === false,
  { message: 'At least one of title/body must be set when is_active is true' },
);

export type PushTemplateBody = z.infer<typeof pushTemplateBodySchema>;
```

- [ ] **Step 2: Add service methods to admin.service.ts**

Open `qulo-server/src/admin/admin.service.ts`. Add a new export section (or methods on `adminService`):

```ts
import { PUSH_TYPES, SUPPORTED_LOCALES, NotificationService } from '../services/notification.service.js';
import { createRequire } from 'node:module';
const adminRequire = createRequire(import.meta.url);
const adminLocales = {
  en: adminRequire('../locales/en.json'),
  tr: adminRequire('../locales/tr.json'),
} as Record<string, { push?: Record<string, { title?: string; body?: string }> }>;

export const pushTemplateAdminService = {
  async list(locale: string) {
    const { data } = await supabase
      .from('push_messages')
      .select('type, title, body, is_active, updated_at, updated_by')
      .eq('locale', locale);

    const overridesByType = new Map((data ?? []).map(r => [r.type, r]));

    return PUSH_TYPES.map((type) => {
      const o = overridesByType.get(type);
      const def = adminLocales[locale]?.push?.[type];
      return {
        type,
        default_title: def?.title ?? '',
        default_body: def?.body ?? '',
        override_title: o?.title ?? null,
        override_body: o?.body ?? null,
        is_active: o?.is_active ?? true,
        updated_at: o?.updated_at ?? null,
        updated_by: o?.updated_by ?? null,
        has_override: !!o,
      };
    });
  },

  async getOne(type: string, locale: string) {
    const { data } = await supabase
      .from('push_messages')
      .select('title, body, is_active, updated_at, updated_by')
      .eq('type', type)
      .eq('locale', locale)
      .maybeSingle();
    const def = adminLocales[locale]?.push?.[type];
    return {
      type,
      locale,
      default_title: def?.title ?? '',
      default_body: def?.body ?? '',
      override_title: data?.title ?? null,
      override_body: data?.body ?? null,
      is_active: data?.is_active ?? true,
      updated_at: data?.updated_at ?? null,
      updated_by: data?.updated_by ?? null,
    };
  },

  async upsert(
    type: string,
    locale: string,
    payload: { title?: string | null; body?: string | null; is_active: boolean },
    actorEmail: string,
  ) {
    const { data, error } = await supabase
      .from('push_messages')
      .upsert({
        type,
        locale,
        title: payload.title ?? null,
        body: payload.body ?? null,
        is_active: payload.is_active,
        updated_at: new Date().toISOString(),
        updated_by: actorEmail,
      }, { onConflict: 'type,locale' })
      .select()
      .single();
    if (error) throw error;
    return data;
  },

  async remove(type: string, locale: string) {
    const { error } = await supabase
      .from('push_messages')
      .delete()
      .eq('type', type)
      .eq('locale', locale);
    if (error) throw error;
  },
};
```

- [ ] **Step 3: Wire up handlers in admin.controller.ts**

In `qulo-server/src/admin/admin.controller.ts`, import the validator and service, then add 4 handlers and route them. Place near other admin routes:

```ts
import {
  pushTemplateParamsSchema,
  pushTemplateQuerySchema,
  pushTemplateBodySchema,
} from '../validators/push-template.validator.js';
import { pushTemplateAdminService } from './admin.service.js';

// Page: list view (HTML)
router.get('/push-messages', async (req, res) => {
  const locale = (req.query.locale as string) || 'tr';
  if (!['tr','en'].includes(locale)) return res.redirect('/admin/push-messages?locale=tr');
  const rows = await pushTemplateAdminService.list(locale);
  res.render('push-messages-list', { rows, locale, adminEmail: req.session.adminEmail });
});

// Page: edit view (HTML)
router.get('/push-messages/:type', async (req, res) => {
  const parsedParams = pushTemplateParamsSchema.safeParse(req.params);
  const parsedQuery = pushTemplateQuerySchema.safeParse(req.query);
  if (!parsedParams.success || !parsedQuery.success) return res.redirect('/admin/push-messages?locale=tr');
  const item = await pushTemplateAdminService.getOne(parsedParams.data.type, parsedQuery.data.locale);
  res.render('push-messages-edit', { item, adminEmail: req.session.adminEmail });
});

// API: get one (JSON for the page JS)
router.get('/api/push-messages/:type', async (req, res) => {
  const parsedParams = pushTemplateParamsSchema.safeParse(req.params);
  const parsedQuery = pushTemplateQuerySchema.safeParse(req.query);
  if (!parsedParams.success || !parsedQuery.success) return res.status(400).json({ error: 'invalid_request' });
  const item = await pushTemplateAdminService.getOne(parsedParams.data.type, parsedQuery.data.locale);
  res.json(item);
});

// API: upsert
router.put('/api/push-messages/:type', async (req, res) => {
  const parsedParams = pushTemplateParamsSchema.safeParse(req.params);
  const parsedQuery = pushTemplateQuerySchema.safeParse(req.query);
  const parsedBody = pushTemplateBodySchema.safeParse(req.body);
  if (!parsedParams.success || !parsedQuery.success || !parsedBody.success) {
    return res.status(400).json({ error: 'invalid_request', details: parsedBody.error?.issues ?? null });
  }
  const actor = req.session.adminEmail ?? 'unknown';
  const row = await pushTemplateAdminService.upsert(
    parsedParams.data.type,
    parsedQuery.data.locale,
    parsedBody.data,
    actor,
  );
  res.json(row);
});

// API: reset to default
router.delete('/api/push-messages/:type', async (req, res) => {
  const parsedParams = pushTemplateParamsSchema.safeParse(req.params);
  const parsedQuery = pushTemplateQuerySchema.safeParse(req.query);
  if (!parsedParams.success || !parsedQuery.success) return res.status(400).json({ error: 'invalid_request' });
  await pushTemplateAdminService.remove(parsedParams.data.type, parsedQuery.data.locale);
  res.json({ ok: true });
});
```

(Adjust the `router` variable name to match what `admin.controller.ts` already uses — it may be `adminRouter` or similar. Check Task 0 step 2 output.)

- [ ] **Step 4: Write integration test**

Create `qulo-server/tests/admin/push-messages.test.ts`:

```ts
import { describe, it, expect, beforeEach, afterEach, vi } from 'vitest';
import { pushTemplateAdminService } from '../../src/admin/admin.service.js';
import { pushTemplateBodySchema } from '../../src/validators/push-template.validator.js';

describe('push-template validator', () => {
  it('accepts a full override', () => {
    const r = pushTemplateBodySchema.safeParse({ title: 'X', body: 'Y', is_active: true });
    expect(r.success).toBe(true);
  });
  it('accepts partial override (body only)', () => {
    const r = pushTemplateBodySchema.safeParse({ body: 'Y', is_active: true });
    expect(r.success).toBe(true);
  });
  it('rejects empty active payload', () => {
    const r = pushTemplateBodySchema.safeParse({ is_active: true });
    expect(r.success).toBe(false);
  });
  it('rejects unknown placeholder', () => {
    const r = pushTemplateBodySchema.safeParse({ body: 'Hi {foo}', is_active: true });
    expect(r.success).toBe(false);
  });
  it('allows known placeholders', () => {
    const r = pushTemplateBodySchema.safeParse({ body: 'Hi {name}, your {badge}', is_active: true });
    expect(r.success).toBe(true);
  });
  it('accepts is_active=false with no content', () => {
    const r = pushTemplateBodySchema.safeParse({ is_active: false });
    expect(r.success).toBe(true);
  });
});

describe('pushTemplateAdminService.list (shape)', () => {
  it('returns one entry per PUSH_TYPE', async () => {
    vi.doMock('../../src/config/supabase.js', () => ({
      supabase: {
        from: () => ({ select: () => ({ eq: () => ({ data: [], error: null }) }) }),
      },
    }));
    const { pushTemplateAdminService: svc } = await import('../../src/admin/admin.service.js');
    const rows = await svc.list('tr');
    expect(rows.length).toBeGreaterThan(0);
    rows.forEach(r => {
      expect(r).toHaveProperty('type');
      expect(r).toHaveProperty('default_title');
      expect(r).toHaveProperty('is_active');
    });
  });
});
```

- [ ] **Step 5: Run validator + service tests**

Run: `cd qulo-server && npx vitest run tests/admin/push-messages.test.ts`
Expected: All 7 tests PASS.

- [ ] **Step 6: Build check**

Run: `cd qulo-server && npm run build`
Expected: No type errors.

- [ ] **Step 7: Commit**

```bash
cd qulo-server
git add src/validators/push-template.validator.ts src/admin/admin.service.ts src/admin/admin.controller.ts tests/admin/push-messages.test.ts
git commit -m "feat(admin): push template CRUD endpoints + validator"
```

---

## Task 4: Admin View — List Page

**Files:**
- Create: `qulo-server/src/admin/views/push-messages-list.ejs`
- Modify: `qulo-server/src/admin/views/_header.ejs` (sidebar link)

- [ ] **Step 1: Create the list EJS view**

Create `qulo-server/src/admin/views/push-messages-list.ejs`. Use the same outer structure as `users.ejs` (which you read in Task 0). Reuse the same header/footer includes, table CSS classes, and color tokens. Body should follow this structure:

```html
<%- include('_header', { title: 'Push Mesajları', active: 'push-messages' }) %>

<div class="container">
  <header class="page-header">
    <h1>Push Mesajları</h1>
    <div class="locale-switch">
      <% ['tr','en'].forEach(function(l) { %>
        <a href="?locale=<%= l %>" class="<%= l === locale ? 'active' : '' %>"><%= l.toUpperCase() %></a>
      <% }); %>
    </div>
  </header>

  <table class="data-table">
    <thead>
      <tr>
        <th>Tip</th>
        <th>Başlık</th>
        <th>Durum</th>
        <th>Son düzenlenme</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <% rows.forEach(function(row) { %>
        <tr>
          <td><code><%= row.type %></code></td>
          <td><%= row.override_title ?? row.default_title %></td>
          <td>
            <% if (row.is_active) { %><span class="badge badge-green">🟢 Aktif</span>
            <% } else { %><span class="badge badge-red">🔴 Pasif</span><% } %>
          </td>
          <td>
            <% if (row.has_override) { %>
              <%= new Date(row.updated_at).toLocaleString('tr-TR') %>
              <% if (row.updated_by) { %><small>(<%= row.updated_by %>)</small><% } %>
            <% } else { %>
              <em>default</em>
            <% } %>
          </td>
          <td><a class="btn btn-sm" href="/admin/push-messages/<%= row.type %>?locale=<%= locale %>">Düzenle</a></td>
        </tr>
      <% }); %>
    </tbody>
  </table>
</div>

<%- include('_footer') %>
```

(The exact CSS class names — `data-table`, `badge-green`, `btn btn-sm` — must match what `users.ejs` uses. Adjust based on Task 0 findings.)

- [ ] **Step 2: Add sidebar link**

Open `qulo-server/src/admin/views/_header.ejs`. Find the existing sidebar nav block. Add a new menu item (in the same style as existing ones, e.g. before the closing `</nav>`):

```html
<a href="/admin/push-messages?locale=tr" class="<%= active === 'push-messages' ? 'active' : '' %>">
  🔔 Push Mesajları
</a>
```

- [ ] **Step 3: Local smoke test — list page renders**

Start server locally: `cd qulo-server && npm run dev`

In another terminal:
```bash
curl -s -b "session=<paste session cookie>" http://localhost:3000/admin/push-messages?locale=tr | grep -c "Push Mesajları"
```

Or simpler: open `http://localhost:3000/admin/push-messages?locale=tr` in browser after admin login. Expected: 8 push types listed, all status = 🟢 Aktif, all updated_at = "default".

- [ ] **Step 4: Commit**

```bash
cd qulo-server
git add src/admin/views/push-messages-list.ejs src/admin/views/_header.ejs
git commit -m "feat(admin): push messages list view + sidebar link"
```

---

## Task 5: Admin View — Edit Page

**Files:**
- Create: `qulo-server/src/admin/views/push-messages-edit.ejs`

- [ ] **Step 1: Create the edit EJS view**

Create `qulo-server/src/admin/views/push-messages-edit.ejs`:

```html
<%- include('_header', { title: 'Push Mesajı Düzenle', active: 'push-messages' }) %>

<div class="container">
  <a href="/admin/push-messages?locale=<%= item.locale %>" class="btn-link">← Geri</a>
  <h1>Push Mesajı: <code><%= item.type %></code> (<%= item.locale.toUpperCase() %>)</h1>

  <form id="push-form" data-type="<%= item.type %>" data-locale="<%= item.locale %>">
    <div class="form-group">
      <label>Başlık</label>
      <input type="text" name="title" id="f-title" value="<%= item.override_title ?? '' %>" maxlength="120" />
      <small>Default: <code id="d-title"><%= item.default_title %></code>
        <button type="button" class="btn-link" onclick="resetField('title')">Default'a dön</button></small>
    </div>

    <div class="form-group">
      <label>Gövde</label>
      <textarea name="body" id="f-body" maxlength="280" rows="3"><%= item.override_body ?? '' %></textarea>
      <small>Default: <code id="d-body"><%= item.default_body %></code>
        <button type="button" class="btn-link" onclick="resetField('body')">Default'a dön</button></small>
    </div>

    <div class="form-group">
      <label>
        <input type="checkbox" name="is_active" id="f-active" <%= item.is_active ? 'checked' : '' %> />
        Aktif
      </label>
    </div>

    <hr/>
    <h3>📱 Önizleme</h3>
    <div class="preview-card">
      <strong id="p-title"></strong>
      <p id="p-body"></p>
    </div>

    <div class="actions">
      <a href="/admin/push-messages?locale=<%= item.locale %>" class="btn">İptal</a>
      <button type="submit" class="btn btn-primary">Kaydet</button>
      <% if (item.override_title || item.override_body) { %>
        <button type="button" class="btn btn-danger" onclick="resetAll()">Override'ı tamamen sil</button>
      <% } %>
    </div>
  </form>
</div>

<script>
const PARAM_EXAMPLES = { name: 'Berkant', badge: 'Altın Soru Çözücü', result: 'doğru' };

function fillPlaceholders(text) {
  if (!text) return '';
  return text.replace(/\{([a-zA-Z0-9_]+)\}/g, (_, k) => PARAM_EXAMPLES[k] ?? '{' + k + '}');
}

function updatePreview() {
  const title = document.getElementById('f-title').value || document.getElementById('d-title').textContent;
  const body = document.getElementById('f-body').value || document.getElementById('d-body').textContent;
  document.getElementById('p-title').textContent = fillPlaceholders(title);
  document.getElementById('p-body').textContent = fillPlaceholders(body);
}

function resetField(field) {
  document.getElementById('f-' + field).value = '';
  updatePreview();
}

function resetAll() {
  if (!confirm("Override tamamen silinecek ve default'a dönecek. Emin misin?")) return;
  const form = document.getElementById('push-form');
  fetch(`/admin/api/push-messages/${form.dataset.type}?locale=${form.dataset.locale}`, { method: 'DELETE' })
    .then(r => r.ok ? location.reload() : alert('Hata: silinemedi'));
}

document.addEventListener('input', updatePreview);
updatePreview();

document.getElementById('push-form').addEventListener('submit', async (e) => {
  e.preventDefault();
  const form = e.target;
  const isActive = document.getElementById('f-active').checked;
  const title = document.getElementById('f-title').value.trim() || null;
  const body = document.getElementById('f-body').value.trim() || null;

  if (!isActive && !confirm('Bu push artık hiç gönderilmeyecek. Emin misin?')) return;

  const res = await fetch(`/admin/api/push-messages/${form.dataset.type}?locale=${form.dataset.locale}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ title, body, is_active: isActive }),
  });
  if (res.ok) { alert('Kaydedildi'); location.reload(); }
  else { const err = await res.json(); alert('Hata: ' + (err.error || 'unknown')); }
});
</script>

<%- include('_footer') %>
```

- [ ] **Step 2: Local smoke test — edit page renders**

With local server still running:
1. Browser → `http://localhost:3000/admin/push-messages?locale=tr`
2. Click "Düzenle" on `new_message` row
3. Verify: form shows, default values displayed under inputs, preview updates as you type
4. Type a new title like "Yeni mesaj geldi 👀" → click Kaydet → page reloads
5. Go back to list → `new_message` row now shows the new title and "X saniye önce" instead of "default"
6. Click Düzenle again → click "Override'ı tamamen sil" → confirm → list row goes back to "default"

- [ ] **Step 3: Commit**

```bash
cd qulo-server
git add src/admin/views/push-messages-edit.ejs
git commit -m "feat(admin): push message edit view with inline preview + override delete"
```

---

## Task 6: Production Deploy

**Files:**
- (no new files — deploys what's already committed)

- [ ] **Step 1: Push all qulo-server commits to main**

```bash
cd qulo-server
git log origin/main..HEAD --oneline   # should show 4 commits from Tasks 1-5
git push origin main
```

- [ ] **Step 2: Watch Railway deploy**

Run: `railway logs --since 5m 2>&1 | tail -50`
Wait for `Build successful` and server startup logs (e.g. `[server] Listening on...`).

If build fails: read error, fix locally, recommit, repush.

- [ ] **Step 3: Smoke-test production list endpoint**

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://qulo-server-production.up.railway.app/admin/push-messages?locale=tr
```
Expected: `302` (redirect to login — auth gate works) or `200` if you're already logged in via cookie.

- [ ] **Step 4: Live override test (manual)**

In browser:
1. Log in to `https://qulo-server-production.up.railway.app/admin`
2. Click sidebar → "🔔 Push Mesajları"
3. Open `new_message` → write a new body, e.g. `"{name} senin için bir şeyler hazırladı 👀"`
4. Save
5. Open mobile app (real device with notifications enabled), have a friend send you a chat message
6. Verify the push notification body matches what you just wrote

- [ ] **Step 5: Rollback test**

1. Back to admin → `new_message` → "Override'ı tamamen sil" → confirm
2. Have the friend send another message
3. Verify the push body is back to the original locale-file default (e.g. `"{name} size mesaj gönderdi"`)

- [ ] **Step 6: Verify Railway logs**

```bash
railway logs --since 10m 2>&1 | grep -iE "getTemplate|push_messages|notification"
```
Expected: No `[NotificationService] push_messages fetch failed` warnings during the override path.

- [ ] **Step 7: No commit (deploy-only task — code already committed in Tasks 1-5)**

---

## Task 7: Admin User Guide + Marketing Doc Update

**Files:**
- Create: `qulo-server/docs/admin-push-messages-guide.md`
- Modify: `qulo/docs/marketing/apple-search-ads.md` (note Phase 1 ready)

- [ ] **Step 1: Write the admin guide**

Create `qulo-server/docs/admin-push-messages-guide.md`:

```markdown
# Admin Guide — Push Mesajları

## Ne için var
Push notification metinlerini deploy gerektirmeden değiştirmek için.

## Nasıl açılır
Admin paneli → sol menü → "🔔 Push Mesajları"

## Mesaj düzenleme
1. Listeden bir push tipini seç (örn. `new_message`)
2. Düzenle'ye tıkla
3. Başlık veya gövde alanlarına yeni metni yaz
   - Boş bırakırsan dosyadaki orijinal metin geçerli
   - "{name}", "{badge}", "{result}" placeholder'larını kullanabilirsin
4. Önizleme bölümünde nasıl görüneceğini gör
5. Kaydet
6. Değişiklik anında geçerli — bir sonraki push yeni metinle gider

## Push'u tamamen kapatma
Edit ekranında "Aktif" kutucuğunu kaldır → Kaydet.
Onay penceresi çıkar, kabul edersen o push artık hiç gönderilmez.

## Default'a geri dönme
- Tek alan için: input'un altındaki "Default'a dön" linkine tıkla
- Tüm override için: edit sayfasının altındaki "Override'ı tamamen sil" butonu

## Dil seçimi
Sayfanın üst sağındaki TR / EN linkleriyle hangi dili düzenlediğini değiştir. Her dil için ayrı override yazılır.

## Hata durumunda
- DB sorunu çıkarsa otomatik olarak dosyadaki orijinal metin kullanılır
- Yanlış placeholder (örn. `{foo}`) yazarsan kaydedemezsin — sistem reddeder

## Hangi tipler var
- `new_message` — yeni mesaj
- `new_message_image` — fotoğraf mesajı
- `new_match` — yeni eşleşme (alıcı)
- `new_match_solver` — yeni eşleşme (çözen)
- `new_match_badge` — badge ile eşleşme
- `passport_expired` — pasaport bitti
- `chat_question_answered` — sohbet sorusu cevaplandı
- `campaign` — kampanya (dinamik içerik, edit etkilemez)
```

- [ ] **Step 2: Update marketing doc**

In `/Users/berkantcalikusu/IdeaProjects/qulo/docs/marketing/apple-search-ads.md`, append under "Kampanya Öncesi Bulunan Riskler" a new entry:

```markdown
### 🟢 [HAZIR] Dinamik Push Sistemi (2026-06-05)

Phase 1 canlıda — push metinleri admin panelden değiştirilebiliyor. ASA kampanyası sırasında kötü performans gösteren push'lar 2 dakikada A→B'ye geçirilebilir. Detay: `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`
```

- [ ] **Step 3: Commit guide to qulo-server**

```bash
cd qulo-server
git add docs/admin-push-messages-guide.md
git commit -m "docs(admin): push messages user guide"
git push origin main
```

- [ ] **Step 4: Commit marketing update to qulo monorepo**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add docs/marketing/apple-search-ads.md
git commit -m "docs(marketing): note dynamic push system Phase 1 ready"
# Don't push yet — qulo monorepo remote needs SSH fix first (separate issue)
```

---

## Verification — Phase 1 Done Definition

All five must be ✅ before declaring Phase 1 complete:

- [ ] `push_messages` table exists in Supabase (verified via SQL in Task 1.3)
- [ ] `NotificationService.getTemplate()` exists and all 6 unit tests pass (Task 2.5)
- [ ] Admin panel `/admin/push-messages` renders with 8 push types listed (Task 4.3)
- [ ] **Live override test** — admin edit → real push received with new text on mobile (Task 6.4)
- [ ] **Rollback test** — "Override'ı tamamen sil" → next push uses default (Task 6.5)

---

## Out of Scope (do NOT include in this plan)

- Retention push types (Phase 2)
- Gamification push types (Phase 3)
- Additional locales beyond tr/en (Phase 4)
- A/B testing, audience segments, audit log, analytics, cache layer (Phase 5)
- Email or in-app banner template editing
- Campaign system refactor

---

_Plan generated 2026-06-05 from spec `2026-06-05-dynamic-notification-system-design.md`._
