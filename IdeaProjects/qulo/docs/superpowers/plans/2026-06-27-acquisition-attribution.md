# "Bizi Nereden Duydunuz?" Attribution — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Yeni kullanıcıların uygulamayı nereden duyduğunu ölçmek; kanal listesi backoffice'ten yönetilir, dönüşüm raporu admin'de görünür.

**Architecture:** Mevcut `referral` (mobile API) + `page-messages`/`campaigns` (admin CRUD) pattern'leri birebir klonlanır. İki yeni tablo (`acquisition_channels`, `user_acquisition`) + `users.acquisition_answered` denormalize flag. Mobile'da profile-setup-gate sonrası ilk discover'da tek seferlik bottom-sheet.

**Tech Stack:** Node.js + Express + TypeScript + Zod + Supabase (server), EJS (admin), Flutter + Riverpod + Retrofit/Dio + json_serializable (mobile).

## Global Constraints

- **16 dil (sıra önemli):** `tr, en, de, fr, es, ar, ru, pt, it, ja, ko, zh, nl, pl, sv, hi` (server: `SUPPORTED_LOCALES`; mobile: `lib/core/l10n/translations/*.dart`). Tüm uygulama string'leri 16 dilde olmalı.
- **Mobile import:** Daima `package:qulo_v2/...` — relative import YASAK (`always_use_package_imports` lint).
- **Mobile analyze:** `cd qulov2 && fvm dart analyze` (bu FVM'de `flutter analyze` CRASH eder). Test: `fvm flutter test`.
- **Mobile UI:** Hardcoded renk/string yok (theme + l10n). Loading: `AppLoadingWidget.small()`. Navigasyon: `ref.read(navigationServiceProvider)`. `CircularProgressIndicator` YASAK.
- **Server validator:** Zod + `validate(schema)` middleware. Mobile route'lar `authMiddleware` + `generalLimiter`.
- **Admin:** Tüm POST/DELETE'e `csrfValidate`. View'lar `_header.ejs`/`_footer.ejs` include eder, `_csrf` hidden input zorunlu.
- **DB:** Supabase, RLS disabled (service_role). Migration `qulo-server/migrations/` altında, manuel/Supabase MCP ile uygulanır.
- **Branch'ler:** Server → `qulo-server/` içinde `feat/acquisition-attribution`. Mobile → `qulov2/` içinde `feat/acquisition-attribution`. Her iki repo nested git; git komutları ilgili dizin içinden çalıştırılır. **Remote'a push EDİLMEZ** (kullanıcı tetikler).
- **Ödül yok, referral'a dokunulmaz.**

---

### Task 1: DB migration + seed kanallar

**Files:**
- Create: `qulo-server/migrations/033_acquisition.sql`

**Interfaces:**
- Produces: `acquisition_channels (id, key, label jsonb, emoji, sort_order, is_active, is_freeform, created_by, created_at, updated_at)`, `user_acquisition (id, user_id UNIQUE, channel_id, channel_key, freeform_text, skipped, created_at)`, `users.acquisition_answered boolean`.

- [ ] **Step 1: Server branch aç**

`main` admin altyapısını (campaigns + page-messages + locales) içerir; branch oradan dallanır.

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git checkout main && git checkout -b feat/acquisition-attribution
```

- [ ] **Step 2: Migration dosyasını yaz**

`qulo-server/migrations/033_acquisition.sql`:

```sql
-- 033_acquisition.sql — "Bizi nereden duydunuz?" attribution

CREATE TABLE IF NOT EXISTS acquisition_channels (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  key         text NOT NULL UNIQUE,            -- stabil slug (tiktok, friend, other...)
  label       jsonb NOT NULL,                  -- { "tr": "...", "en": "...", ... } 16 dil
  emoji       text,                            -- görsel (🎵 📸 ...)
  sort_order  int NOT NULL DEFAULT 0,
  is_active   boolean NOT NULL DEFAULT true,
  is_freeform boolean NOT NULL DEFAULT false,  -- true → opsiyonel serbest metin alanı
  created_by  uuid REFERENCES admin_users(id),
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS user_acquisition (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  channel_id    uuid REFERENCES acquisition_channels(id) ON DELETE SET NULL,
  channel_key   text,                          -- cevaplama anındaki key snapshot
  freeform_text text,                          -- is_freeform kanal için opsiyonel
  skipped       boolean NOT NULL DEFAULT false,
  created_at    timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE users ADD COLUMN IF NOT EXISTS acquisition_answered boolean NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_acquisition_channels_active_order ON acquisition_channels(is_active, sort_order);
CREATE INDEX IF NOT EXISTS idx_user_acquisition_channel ON user_acquisition(channel_key);
CREATE INDEX IF NOT EXISTS idx_user_acquisition_created ON user_acquisition(created_at);

-- Seed: varsayılan kanallar (admin sonradan düzenleyebilir)
INSERT INTO acquisition_channels (key, label, emoji, sort_order, is_freeform) VALUES
  ('tiktok',    '{"tr":"TikTok","en":"TikTok","de":"TikTok","fr":"TikTok","es":"TikTok","ar":"TikTok","ru":"TikTok","pt":"TikTok","it":"TikTok","ja":"TikTok","ko":"TikTok","zh":"TikTok","nl":"TikTok","pl":"TikTok","sv":"TikTok","hi":"TikTok"}', '🎵', 10, false),
  ('instagram', '{"tr":"Instagram","en":"Instagram","de":"Instagram","fr":"Instagram","es":"Instagram","ar":"Instagram","ru":"Instagram","pt":"Instagram","it":"Instagram","ja":"Instagram","ko":"Instagram","zh":"Instagram","nl":"Instagram","pl":"Instagram","sv":"Instagram","hi":"Instagram"}', '📸', 20, false),
  ('twitter',   '{"tr":"X (Twitter)","en":"X (Twitter)","de":"X (Twitter)","fr":"X (Twitter)","es":"X (Twitter)","ar":"X (Twitter)","ru":"X (Twitter)","pt":"X (Twitter)","it":"X (Twitter)","ja":"X (Twitter)","ko":"X (Twitter)","zh":"X (Twitter)","nl":"X (Twitter)","pl":"X (Twitter)","sv":"X (Twitter)","hi":"X (Twitter)"}', '🐦', 30, false),
  ('friend',    '{"tr":"Arkadaş / aile","en":"Friend / family","de":"Freund / Familie","fr":"Ami / famille","es":"Amigo / familia","ar":"صديق / عائلة","ru":"Друг / семья","pt":"Amigo / família","it":"Amico / famiglia","ja":"友人・家族","ko":"친구 / 가족","zh":"朋友 / 家人","nl":"Vriend / familie","pl":"Znajomy / rodzina","sv":"Vän / familj","hi":"दोस्त / परिवार"}', '👥', 40, false),
  ('app_store', '{"tr":"App Store / Google Play","en":"App Store / Google Play","de":"App Store / Google Play","fr":"App Store / Google Play","es":"App Store / Google Play","ar":"App Store / Google Play","ru":"App Store / Google Play","pt":"App Store / Google Play","it":"App Store / Google Play","ja":"App Store / Google Play","ko":"App Store / Google Play","zh":"App Store / Google Play","nl":"App Store / Google Play","pl":"App Store / Google Play","sv":"App Store / Google Play","hi":"App Store / Google Play"}', '📱', 50, false),
  ('google',    '{"tr":"Google araması","en":"Google search","de":"Google-Suche","fr":"Recherche Google","es":"Búsqueda de Google","ar":"بحث جوجل","ru":"Поиск Google","pt":"Pesquisa Google","it":"Ricerca Google","ja":"Google検索","ko":"Google 검색","zh":"Google 搜索","nl":"Google-zoekopdracht","pl":"Wyszukiwarka Google","sv":"Google-sökning","hi":"Google खोज"}', '🔍', 60, false),
  ('other',     '{"tr":"Diğer","en":"Other","de":"Andere","fr":"Autre","es":"Otro","ar":"أخرى","ru":"Другое","pt":"Outro","it":"Altro","ja":"その他","ko":"기타","zh":"其他","nl":"Anders","pl":"Inne","sv":"Annat","hi":"अन्य"}', '✨', 70, true)
ON CONFLICT (key) DO NOTHING;
```

- [ ] **Step 3: Migration'ı Supabase'e uygula**

Supabase MCP tool'ları ile (proje ref: `vtntrtozgoyhjdvvurkj`) `033_acquisition.sql` içeriğini çalıştır. Alternatif: Supabase Dashboard → SQL Editor.

- [ ] **Step 4: Tabloları doğrula**

Supabase MCP (list_tables veya `SELECT`) ile:
```sql
SELECT key, emoji, sort_order, is_freeform FROM acquisition_channels ORDER BY sort_order;
SELECT column_name FROM information_schema.columns WHERE table_name='users' AND column_name='acquisition_answered';
```
Expected: 7 kanal satırı + `acquisition_answered` kolonu mevcut.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add migrations/033_acquisition.sql
git commit -m "feat(db): acquisition_channels + user_acquisition tabloları + seed"
```

---

### Task 2: Server — label resolve helper + acquisition service + validator

**Files:**
- Modify: `qulo-server/src/utils/locales.ts` (yeni `pickLabel` export)
- Create: `qulo-server/src/validators/acquisition.validator.ts`
- Create: `qulo-server/src/services/acquisition.service.ts`
- Test: `qulo-server/src/__tests__/acquisition.service.test.ts`

**Interfaces:**
- Consumes: `supabase` (`../config/supabase.js`), `resolveLocale`, `SUPPORTED_LOCALES`.
- Produces:
  - `pickLabel(label: Record<string,string> | null | undefined, locale?: string): string`
  - `submitAnswerSchema` (zod) → `{ channel_id?: string (uuid); skipped?: boolean; freeform_text?: string }`
  - `acquisitionService.getChannels(locale: string): Promise<Array<{ id, key, label, emoji, is_freeform }>>`
  - `acquisitionService.submitAnswer(userId, { channelId?, skipped?, freeformText? }): Promise<{ answered: boolean }>`

- [ ] **Step 1: `pickLabel` testini yaz**

`qulo-server/src/__tests__/acquisition.service.test.ts`:

```typescript
import { describe, it, expect } from "vitest";
import { pickLabel } from "../utils/locales.js";

describe("pickLabel", () => {
  it("returns the requested locale when present", () => {
    expect(pickLabel({ tr: "Merhaba", en: "Hello" }, "tr")).toBe("Merhaba");
  });

  it("falls back to en when locale missing", () => {
    expect(pickLabel({ en: "Hello" }, "de")).toBe("Hello");
  });

  it("falls back to first non-empty when en missing", () => {
    expect(pickLabel({ fr: "Bonjour" }, "de")).toBe("Bonjour");
  });

  it("returns empty string for null label", () => {
    expect(pickLabel(null, "tr")).toBe("");
  });
});
```

- [ ] **Step 2: Testin başarısız olduğunu doğrula**

Run: `cd qulo-server && npm test -- acquisition.service`
Expected: FAIL — `pickLabel` is not exported.

- [ ] **Step 3: `pickLabel` helper'ını ekle**

`qulo-server/src/utils/locales.ts` dosyasının sonuna ekle (mevcut `resolveLocale` ve `SUPPORTED_LOCALES` import'unu kullanır):

```typescript
/**
 * 16-dil JSONB label'dan kullanıcının diline en uygun değeri seçer.
 * Fallback: istenen locale → en → ilk dolu değer → "".
 */
export function pickLabel(
  label: Record<string, string> | null | undefined,
  locale?: string,
): string {
  if (!label) return "";
  const loc = resolveLocale(locale);
  if (label[loc]?.trim()) return label[loc];
  if (label.en?.trim()) return label.en;
  const first = Object.values(label).find((v) => v?.trim());
  return first ?? "";
}
```

- [ ] **Step 4: Testin geçtiğini doğrula**

Run: `cd qulo-server && npm test -- acquisition.service`
Expected: PASS (4 test).

- [ ] **Step 5: Validator'ı yaz**

`qulo-server/src/validators/acquisition.validator.ts`:

```typescript
import { z } from "zod";

export const submitAnswerSchema = z
  .object({
    channel_id: z.string().uuid().optional(),
    skipped: z.boolean().optional(),
    freeform_text: z.string().max(280).optional(),
  })
  .refine((d) => d.skipped === true || !!d.channel_id, {
    message: "channel_id or skipped is required",
  })
  .refine((d) => !(d.skipped === true && d.channel_id), {
    message: "channel_id and skipped cannot be combined",
  });

export type SubmitAnswerInput = z.infer<typeof submitAnswerSchema>;
```

- [ ] **Step 6: Service'i yaz**

`qulo-server/src/services/acquisition.service.ts`:

```typescript
import { supabase } from "../config/supabase.js";
import { pickLabel } from "../utils/locales.js";

export class AcquisitionService {
  async getChannels(locale: string) {
    const { data, error } = await supabase
      .from("acquisition_channels")
      .select("id, key, label, emoji, is_freeform")
      .eq("is_active", true)
      .order("sort_order", { ascending: true });
    if (error) throw error;
    return (data ?? []).map((c) => ({
      id: c.id,
      key: c.key,
      label: pickLabel(c.label as Record<string, string>, locale),
      emoji: c.emoji,
      is_freeform: c.is_freeform,
    }));
  }

  async submitAnswer(
    userId: string,
    input: { channelId?: string; skipped?: boolean; freeformText?: string },
  ): Promise<{ answered: boolean }> {
    // Idempotent: zaten cevaplamışsa sessizce kabul et
    const { data: existing } = await supabase
      .from("user_acquisition")
      .select("id")
      .eq("user_id", userId)
      .maybeSingle();
    if (existing) return { answered: true };

    let channelKey: string | null = null;
    let isFreeform = false;
    if (input.channelId) {
      const { data: ch } = await supabase
        .from("acquisition_channels")
        .select("key, is_freeform")
        .eq("id", input.channelId)
        .maybeSingle();
      channelKey = ch?.key ?? null;
      isFreeform = ch?.is_freeform ?? false;
    }

    const { error: insertErr } = await supabase.from("user_acquisition").insert({
      user_id: userId,
      channel_id: input.channelId ?? null,
      channel_key: channelKey,
      freeform_text: isFreeform ? (input.freeformText ?? null) : null,
      skipped: input.skipped ?? false,
    });
    // UNIQUE(user_id) yarışında ikinci insert hata verir → idempotent kabul
    if (insertErr && !insertErr.message.includes("duplicate")) throw insertErr;

    await supabase
      .from("users")
      .update({ acquisition_answered: true })
      .eq("id", userId);

    return { answered: true };
  }
}

export const acquisitionService = new AcquisitionService();
```

- [ ] **Step 7: Build + test**

Run: `cd qulo-server && npx tsc --noEmit && npm test -- acquisition.service`
Expected: tsc temiz, testler PASS.

- [ ] **Step 8: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/utils/locales.ts src/validators/acquisition.validator.ts src/services/acquisition.service.ts src/__tests__/acquisition.service.test.ts
git commit -m "feat(server): acquisition service + pickLabel helper + validator"
```

---

### Task 3: Server — mobile routes + mount + getMe flag

**Files:**
- Create: `qulo-server/src/routes/acquisition.routes.ts`
- Modify: `qulo-server/src/index.ts` (mount + import)
- Modify: `qulo-server/src/services/user.service.ts` (getMe select'e `acquisition_answered`)

**Interfaces:**
- Consumes: `acquisitionService`, `submitAnswerSchema`, `authMiddleware`, `generalLimiter`, `validate`.
- Produces: `GET /api/v1/acquisition/channels`, `POST /api/v1/acquisition/answer`; `getMe` yanıtında `acquisition_answered: boolean`.

- [ ] **Step 1: Route dosyasını yaz**

`qulo-server/src/routes/acquisition.routes.ts`:

```typescript
import { Router } from "express";
import { authMiddleware } from "../middleware/auth.js";
import { generalLimiter } from "../middleware/rateLimit.js";
import { validate } from "../middleware/validate.js";
import { submitAnswerSchema } from "../validators/acquisition.validator.js";
import { acquisitionService } from "../services/acquisition.service.js";

const router = Router();
router.use(authMiddleware);
router.use(generalLimiter);

router.get("/channels", async (req, res, next) => {
  try {
    const locale = (req.user as { locale?: string } | undefined)?.locale
      ?? (req.query.locale as string | undefined)
      ?? "en";
    const channels = await acquisitionService.getChannels(locale);
    res.json({ channels });
  } catch (err) {
    next(err);
  }
});

router.post("/answer", validate(submitAnswerSchema), async (req, res, next) => {
  try {
    const result = await acquisitionService.submitAnswer(req.user!.userId, {
      channelId: req.body.channel_id,
      skipped: req.body.skipped,
      freeformText: req.body.freeform_text,
    });
    res.json(result);
  } catch (err) {
    next(err);
  }
});

export default router;
```

> NOT: JWT payload'da `locale` olmayabilir. Eğer `req.user.locale` yoksa, service zaten `pickLabel` fallback'iyle `en` döner. İstenirse route içinde `users` tablosundan locale çekilebilir; MVP için query/fallback yeterli.

- [ ] **Step 2: Route'u mount et**

`qulo-server/src/index.ts` — referral mount satırının (`app.use("/api/v1/referrals", referralRoutes);`) yanına ekle:

Import bloğuna:
```typescript
import acquisitionRoutes from "./routes/acquisition.routes.js";
```
Mount bloğuna:
```typescript
app.use("/api/v1/acquisition", acquisitionRoutes);
```

- [ ] **Step 3: getMe'ye flag ekle**

`qulo-server/src/services/user.service.ts` → `getMe` içindeki `.select(...)` string'ine `acquisition_answered` kolonunu ekle (örn. `created_at`'ten sonra):

```typescript
      "interests, question_count, acquisition_answered, created_at"
```

- [ ] **Step 4: Build + manuel smoke**

Run: `cd qulo-server && npx tsc --noEmit`
Expected: temiz.

Run (opsiyonel, dev sunucu açıksa): `npm run dev` → başka terminalde geçerli token ile
`curl -H "Authorization: Bearer <token>" localhost:3000/api/v1/acquisition/channels`
Expected: `{ "channels": [ ... 7 kanal ... ] }`.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/routes/acquisition.routes.ts src/index.ts src/services/user.service.ts
git commit -m "feat(server): acquisition mobile routes + getMe acquisition_answered flag"
```

---

### Task 4: Server — admin service + controller + validator + routes

**Files:**
- Create: `qulo-server/src/services/acquisition-channel.service.ts`
- Create: `qulo-server/src/admin/acquisition.admin.controller.ts`
- Create: `qulo-server/src/validators/acquisition-channel.validator.ts`
- Modify: `qulo-server/src/admin/admin.routes.ts` (import + routes)

**Interfaces:**
- Consumes: `supabase`, `SUPPORTED_LOCALES`, `csrfValidate`, `acquisitionChannelService`.
- Produces:
  - `acquisitionChannelService.list()`, `.getById(id)`, `.create(input, adminId)`, `.update(id, input)`, `.toggleActive(id)`, `.softDelete(id)`, `.getReport(from?, to?)`
  - `createChannelSchema` (zod)
  - `acquisitionAdminController.{ list, newForm, create, editForm, update, toggle, remove }`

- [ ] **Step 1: Admin service'i yaz**

`qulo-server/src/services/acquisition-channel.service.ts`:

```typescript
import { supabase } from "../config/supabase.js";

export interface ChannelInput {
  key: string;
  label: Record<string, string>;
  emoji?: string;
  sort_order: number;
  is_active: boolean;
  is_freeform: boolean;
}

export class AcquisitionChannelService {
  async list() {
    const { data, error } = await supabase
      .from("acquisition_channels")
      .select("*")
      .order("sort_order", { ascending: true });
    if (error) throw error;
    return data ?? [];
  }

  async getById(id: string) {
    const { data, error } = await supabase
      .from("acquisition_channels")
      .select("*")
      .eq("id", id)
      .maybeSingle();
    if (error) throw error;
    return data;
  }

  async create(input: ChannelInput, adminId: string) {
    const { data, error } = await supabase
      .from("acquisition_channels")
      .insert({ ...input, created_by: adminId })
      .select("*")
      .single();
    if (error) throw error;
    return data;
  }

  async update(id: string, input: ChannelInput) {
    const { error } = await supabase
      .from("acquisition_channels")
      .update({ ...input, updated_at: new Date().toISOString() })
      .eq("id", id);
    if (error) throw error;
  }

  async toggleActive(id: string) {
    const cur = await this.getById(id);
    if (!cur) return;
    const { error } = await supabase
      .from("acquisition_channels")
      .update({ is_active: !cur.is_active, updated_at: new Date().toISOString() })
      .eq("id", id);
    if (error) throw error;
  }

  async softDelete(id: string) {
    const { error } = await supabase
      .from("acquisition_channels")
      .update({ is_active: false, updated_at: new Date().toISOString() })
      .eq("id", id);
    if (error) throw error;
  }

  /** Kanal başına cevap sayısı + skip + toplam. 0'lı aktif kanallar da listelenir. */
  async getReport(from?: string, to?: string) {
    let q = supabase.from("user_acquisition").select("channel_key, skipped, created_at");
    if (from) q = q.gte("created_at", from);
    if (to) q = q.lte("created_at", to);
    const { data, error } = await q;
    if (error) throw error;
    const rows = data ?? [];

    const channels = await this.list();
    const counts = new Map<string, number>();
    let skipped = 0;
    for (const r of rows) {
      if (r.skipped) { skipped++; continue; }
      if (r.channel_key) counts.set(r.channel_key, (counts.get(r.channel_key) ?? 0) + 1);
    }
    const answered = rows.length - skipped;
    const byChannel = channels.map((c) => ({
      key: c.key,
      label: c.label,
      emoji: c.emoji,
      is_active: c.is_active,
      count: counts.get(c.key) ?? 0,
      pct: answered > 0 ? Math.round(((counts.get(c.key) ?? 0) / answered) * 1000) / 10 : 0,
    }));
    return { total: rows.length, answered, skipped, byChannel };
  }
}

export const acquisitionChannelService = new AcquisitionChannelService();
```

- [ ] **Step 2: Admin validator'ı yaz**

`qulo-server/src/validators/acquisition-channel.validator.ts`:

```typescript
import { z } from "zod";

export const createChannelSchema = z.object({
  key: z.string().min(1).max(40).regex(/^[a-z0-9_]+$/, "lowercase, digit, underscore"),
  label: z.record(z.string()),
  emoji: z.string().max(8).optional(),
  sort_order: z.number().int().default(0),
  is_active: z.boolean().default(true),
  is_freeform: z.boolean().default(false),
});

export type CreateChannelInput = z.infer<typeof createChannelSchema>;
```

- [ ] **Step 3: Admin controller'ı yaz**

`qulo-server/src/admin/acquisition.admin.controller.ts`:

```typescript
import type { Request, Response } from "express";
import { acquisitionChannelService } from "../services/acquisition-channel.service.js";
import { createChannelSchema } from "../validators/acquisition-channel.validator.js";
import { SUPPORTED_LOCALES, LOCALE_NAMES } from "../constants/locales.js";

function parseLabel(b: Record<string, string>): Record<string, string> {
  const label: Record<string, string> = {};
  for (const l of SUPPORTED_LOCALES) {
    const v = (b[`label_${l}`] ?? "").trim();
    if (v) label[l] = v;
  }
  return label;
}

function buildInput(b: Record<string, string>) {
  return {
    key: (b.key ?? "").trim().toLowerCase(),
    label: parseLabel(b),
    emoji: (b.emoji ?? "").trim() || undefined,
    sort_order: parseInt(b.sort_order) || 0,
    is_active: b.is_active === "on",
    is_freeform: b.is_freeform === "on",
  };
}

class AcquisitionAdminController {
  async list(req: Request, res: Response) {
    try {
      const channels = await acquisitionChannelService.list();
      const report = await acquisitionChannelService.getReport(
        (req.query.from as string) || undefined,
        (req.query.to as string) || undefined,
      );
      res.render("acquisition-list", {
        channels,
        report,
        from: req.query.from ?? "",
        to: req.query.to ?? "",
        localeNames: LOCALE_NAMES,
        session: req.session,
        csrfToken: req.session.csrfToken,
      });
    } catch (err) {
      console.error("[Admin] acquisition list failed:", (err as Error).message);
      res.status(500).render("error", { message: "Kanallar yüklenemedi.", session: req.session });
    }
  }

  async newForm(req: Request, res: Response) {
    res.render("acquisition-edit", {
      channel: null,
      locales: SUPPORTED_LOCALES,
      localeNames: LOCALE_NAMES,
      session: req.session,
      csrfToken: req.session.csrfToken,
    });
  }

  async create(req: Request, res: Response) {
    try {
      const parsed = createChannelSchema.safeParse(buildInput(req.body));
      if (!parsed.success) {
        return res.status(400).render("error", {
          message: parsed.error.errors.map((e) => e.message).join(" · "),
          session: req.session,
        });
      }
      await acquisitionChannelService.create(parsed.data, req.session.adminId!);
      res.redirect("/admin/acquisition");
    } catch (err) {
      console.error("[Admin] acquisition create failed:", (err as Error).message);
      res.status(500).render("error", { message: (err as Error).message, session: req.session });
    }
  }

  async editForm(req: Request, res: Response) {
    const channel = await acquisitionChannelService.getById(req.params.id as string);
    if (!channel) return res.redirect("/admin/acquisition");
    res.render("acquisition-edit", {
      channel,
      locales: SUPPORTED_LOCALES,
      localeNames: LOCALE_NAMES,
      session: req.session,
      csrfToken: req.session.csrfToken,
    });
  }

  async update(req: Request, res: Response) {
    const id = req.params.id as string;
    try {
      const parsed = createChannelSchema.safeParse(buildInput(req.body));
      if (!parsed.success) {
        return res.status(400).render("error", {
          message: parsed.error.errors.map((e) => e.message).join(" · "),
          session: req.session,
        });
      }
      await acquisitionChannelService.update(id, parsed.data);
      res.redirect("/admin/acquisition");
    } catch (err) {
      console.error("[Admin] acquisition update failed:", (err as Error).message);
      res.status(500).render("error", { message: (err as Error).message, session: req.session });
    }
  }

  async toggle(req: Request, res: Response) {
    try {
      await acquisitionChannelService.toggleActive(req.params.id as string);
    } catch (err) {
      console.error("[Admin] acquisition toggle failed:", (err as Error).message);
    }
    res.redirect("/admin/acquisition");
  }

  async remove(req: Request, res: Response) {
    try {
      await acquisitionChannelService.softDelete(req.params.id as string);
    } catch (err) {
      console.error("[Admin] acquisition delete failed:", (err as Error).message);
    }
    res.redirect("/admin/acquisition");
  }
}

export const acquisitionAdminController = new AcquisitionAdminController();
```

- [ ] **Step 4: Route'ları ekle**

`qulo-server/src/admin/admin.routes.ts` — import bloğuna:
```typescript
import { acquisitionAdminController } from "./acquisition.admin.controller.js";
```
Campaigns/page-messages route'larının yakınına:
```typescript
router.get("/acquisition", (req, res) => acquisitionAdminController.list(req, res));
router.get("/acquisition/new", (req, res) => acquisitionAdminController.newForm(req, res));
router.post("/acquisition", csrfValidate, (req, res) => acquisitionAdminController.create(req, res));
router.get("/acquisition/:id", (req, res) => acquisitionAdminController.editForm(req, res));
router.post("/acquisition/:id", csrfValidate, (req, res) => acquisitionAdminController.update(req, res));
router.post("/acquisition/:id/toggle", csrfValidate, (req, res) => acquisitionAdminController.toggle(req, res));
router.post("/acquisition/:id/delete", csrfValidate, (req, res) => acquisitionAdminController.remove(req, res));
```

- [ ] **Step 5: Build doğrula**

Run: `cd qulo-server && npx tsc --noEmit`
Expected: temiz. (Views henüz yok ama EJS runtime'da resolve edilir; tsc'yi etkilemez.)

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/services/acquisition-channel.service.ts src/validators/acquisition-channel.validator.ts src/admin/acquisition.admin.controller.ts src/admin/admin.routes.ts
git commit -m "feat(admin): acquisition channel CRUD service + controller + routes"
```

---

### Task 5: Server — admin EJS views + sidebar

**Files:**
- Create: `qulo-server/src/admin/views/acquisition-list.ejs`
- Create: `qulo-server/src/admin/views/acquisition-edit.ejs`
- Modify: `qulo-server/src/admin/views/_header.ejs` (sidebar link)

**Interfaces:**
- Consumes: `channels`, `report`, `from`, `to`, `localeNames`, `csrfToken` (list); `channel`, `locales`, `localeNames`, `csrfToken` (edit).

- [ ] **Step 1: List view'ı yaz**

`qulo-server/src/admin/views/acquisition-list.ejs`:

```ejs
<%- include('_header') %>
<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
  <h2>Kaynak & Reklam</h2>
  <a href="/admin/acquisition/new" class="btn btn-primary">+ Yeni Kanal</a>
</div>

<div class="card" style="margin-bottom:20px;">
  <h3 style="margin-top:0;">Dönüşüm Raporu</h3>
  <form method="GET" action="/admin/acquisition" style="margin-bottom:12px;">
    <label>Başlangıç <input type="date" name="from" value="<%= from %>" /></label>
    <label style="margin-left:8px;">Bitiş <input type="date" name="to" value="<%= to %>" /></label>
    <button type="submit" class="btn" style="margin-left:8px;">Filtrele</button>
  </form>
  <p>Toplam cevap: <strong><%= report.total %></strong> · Cevaplayan: <strong><%= report.answered %></strong> · Atlayan: <strong><%= report.skipped %></strong></p>
  <table>
    <thead><tr><th>Kanal</th><th>Sayı</th><th>%</th></tr></thead>
    <tbody>
      <% report.byChannel.forEach((r) => { %>
      <tr>
        <td><%= r.emoji || '' %> <%= (r.label && (r.label.tr || r.label.en)) || r.key %></td>
        <td><%= r.count %></td>
        <td><%= r.pct %>%</td>
      </tr>
      <% }) %>
    </tbody>
  </table>
</div>

<div class="card">
  <h3 style="margin-top:0;">Kanallar</h3>
  <table>
    <thead><tr><th>Sıra</th><th>Emoji</th><th>Key</th><th>TR / EN</th><th>Serbest</th><th>Durum</th><th></th></tr></thead>
    <tbody>
      <% channels.forEach((c) => { %>
      <tr>
        <td><%= c.sort_order %></td>
        <td style="font-size:18px;"><%= c.emoji || '' %></td>
        <td><a href="/admin/acquisition/<%= c.id %>" style="color:#a855f7;"><%= c.key %></a></td>
        <td><%= (c.label && c.label.tr) || '-' %> / <%= (c.label && c.label.en) || '-' %></td>
        <td><%= c.is_freeform ? '✏️' : '' %></td>
        <td>
          <span class="badge" style="background: <%= c.is_active ? '#d1fae5' : '#f3f4f6' %>; color: <%= c.is_active ? '#065f46' : '#6b7280' %>;">
            <%= c.is_active ? 'Aktif' : 'Pasif' %>
          </span>
        </td>
        <td style="white-space:nowrap;">
          <a href="/admin/acquisition/<%= c.id %>" class="btn btn-sm">Düzenle</a>
          <form method="POST" action="/admin/acquisition/<%= c.id %>/toggle" style="display:inline;">
            <input type="hidden" name="_csrf" value="<%= csrfToken %>" />
            <button type="submit" class="btn btn-sm"><%= c.is_active ? 'Pasifleştir' : 'Aktifleştir' %></button>
          </form>
        </td>
      </tr>
      <% }) %>
    </tbody>
  </table>
</div>
<%- include('_footer') %>
```

- [ ] **Step 2: Edit/new view'ı yaz**

`qulo-server/src/admin/views/acquisition-edit.ejs`:

```ejs
<%- include('_header') %>
<h2><%= channel ? 'Kanal Düzenle' : 'Yeni Kanal' %></h2>
<form method="POST" action="<%= channel ? '/admin/acquisition/' + channel.id : '/admin/acquisition' %>">
  <input type="hidden" name="_csrf" value="<%= csrfToken %>" />
  <div class="card">
    <label>Key (slug, küçük harf) *</label>
    <input name="key" value="<%= channel ? channel.key : '' %>" placeholder="tiktok" style="width:100%;margin-bottom:12px;" <%= channel ? 'readonly' : '' %> />

    <label>Emoji</label>
    <input name="emoji" value="<%= channel ? (channel.emoji || '') : '' %>" placeholder="🎵" style="width:100%;margin-bottom:12px;" />

    <label>Sıra</label>
    <input name="sort_order" type="number" value="<%= channel ? channel.sort_order : 0 %>" style="width:100%;margin-bottom:12px;" />

    <label style="display:block;margin-bottom:8px;">
      <input type="checkbox" name="is_active" <%= !channel || channel.is_active ? 'checked' : '' %> /> Aktif
    </label>
    <label style="display:block;margin-bottom:8px;">
      <input type="checkbox" name="is_freeform" <%= channel && channel.is_freeform ? 'checked' : '' %> /> Serbest metin alanı aç (ör. "Diğer")
    </label>
  </div>

  <div class="card">
    <h3 style="margin-top:0;">Etiketler (16 dil)</h3>
    <p style="color:#666;font-size:12px;">Marka adları her dile aynı yazılır. En az EN + TR önerilir.</p>
    <% locales.forEach((l) => { %>
      <fieldset style="border:1px solid #ddd;margin:8px 0;padding:12px;border-radius:6px;">
        <legend style="font-weight:600;padding:0 6px;"><%= localeNames[l] %> (<%= l %>)</legend>
        <input name="label_<%= l %>" placeholder="Etiket" value="<%= channel && channel.label && channel.label[l] ? channel.label[l] : '' %>" style="width:100%;" />
      </fieldset>
    <% }) %>
  </div>

  <button type="submit" class="btn btn-primary"><%= channel ? 'Güncelle' : 'Oluştur' %></button>
</form>
<%- include('_footer') %>
```

- [ ] **Step 3: Sidebar link'i ekle**

`qulo-server/src/admin/views/_header.ejs` — Communication `sidebar-section`'ından sonra yeni bölüm ekle:

```ejs
<!-- Acquisition -->
<div class="sidebar-section">
  <div class="sidebar-section-title">Acquisition</div>
  <a href="/admin/acquisition" class="sidebar-link">
    <span class="icon">&#128226;</span> Kaynak &amp; Reklam
  </a>
</div>
```

- [ ] **Step 4: Manuel doğrula**

Run: `cd qulo-server && npm run dev` → tarayıcıda `/admin/login` → giriş → `/admin/acquisition`.
Expected: 7 seed kanal listelenir, rapor bloğu görünür (henüz cevap yoksa 0). "Yeni Kanal" + "Düzenle" formları açılır, kayıt eder.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/admin/views/acquisition-list.ejs src/admin/views/acquisition-edit.ejs src/admin/views/_header.ejs
git commit -m "feat(admin): acquisition kanal yönetimi + rapor view + sidebar"
```

- [ ] **Step 6: Server-review**

`/server-review` skill'ini çalıştır (SOLID + Security). Bulguları gider, tekrar commit et.

---

### Task 6: Mobile — model + service + repository + provider + DI + user flag

**Files:**
- Create: `qulov2/lib/data/models/acquisition_channel_model.dart`
- Create: `qulov2/lib/core/network/services/acquisition_service.dart`
- Create: `qulov2/lib/data/repositories/acquisition_repository.dart`
- Create: `qulov2/lib/providers/acquisition_provider.dart`
- Modify: `qulov2/lib/data/repositories/interfaces.dart` (yeni interface)
- Modify: `qulov2/lib/providers/api_provider.dart` (2 provider)
- Modify: `qulov2/lib/data/models/user_model.dart` (`acquisitionAnswered`)
- Test: `qulov2/test/acquisition_channel_model_test.dart`

**Interfaces:**
- Consumes: `NetworkManager`, `Result<T>`, `Success/Failure`, `e.toAppFailure()`.
- Produces:
  - `AcquisitionChannel { id, key, label, emoji, isFreeform }` + `fromJson`
  - `AcquisitionService` (retrofit): `getChannels()`, `submitAnswer(Map)`
  - `IAcquisitionRepository` + `AcquisitionRepository`: `getChannels(): Future<Result<List<AcquisitionChannel>>>`, `submitAnswer({channelId, skipped, freeformText}): Future<Result<void>>`
  - `acquisitionProvider` (AsyncNotifierProvider)
  - `acquisitionServiceProvider`, `acquisitionRepositoryProvider`
  - `UserModel.acquisitionAnswered: bool`

- [ ] **Step 1: Mobile branch aç**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git checkout main && git checkout -b feat/acquisition-attribution
```
> Not: Mevcut branch `feat/onboarding-coach-marks`. Yeni feature `main`'den dallanır. (Coach-marks henüz merge edilmediyse main'de yoktur — sorun değil, bu feature bağımsız.)

- [ ] **Step 2: Model testini yaz**

`qulov2/test/acquisition_channel_model_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/data/models/acquisition_channel_model.dart';

void main() {
  test('AcquisitionChannel.fromJson maps server fields', () {
    final json = {
      'id': 'abc',
      'key': 'tiktok',
      'label': 'TikTok',
      'emoji': '🎵',
      'is_freeform': false,
    };
    final c = AcquisitionChannel.fromJson(json);
    expect(c.id, 'abc');
    expect(c.key, 'tiktok');
    expect(c.label, 'TikTok');
    expect(c.emoji, '🎵');
    expect(c.isFreeform, false);
  });
}
```

- [ ] **Step 3: Modeli yaz**

`qulov2/lib/data/models/acquisition_channel_model.dart`:

```dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'acquisition_channel_model.g.dart';

@JsonSerializable()
class AcquisitionChannel extends Equatable {
  final String id;
  final String key;
  final String label;
  final String? emoji;
  @JsonKey(name: 'is_freeform')
  final bool isFreeform;

  const AcquisitionChannel({
    required this.id,
    required this.key,
    required this.label,
    this.emoji,
    this.isFreeform = false,
  });

  factory AcquisitionChannel.fromJson(Map<String, dynamic> json) =>
      _$AcquisitionChannelFromJson(json);
  Map<String, dynamic> toJson() => _$AcquisitionChannelToJson(this);

  @override
  List<Object?> get props => [id, key, label, emoji, isFreeform];
}
```

- [ ] **Step 4: Retrofit service'i yaz**

`qulov2/lib/core/network/services/acquisition_service.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'acquisition_service.g.dart';

@RestApi()
abstract class AcquisitionService {
  factory AcquisitionService(Dio dio) = _AcquisitionService;

  @GET('/acquisition/channels')
  Future<dynamic> getChannels();

  @POST('/acquisition/answer')
  Future<dynamic> submitAnswer(@Body() Map<String, dynamic> data);
}
```

- [ ] **Step 5: Interface + repository'i yaz**

`qulov2/lib/data/repositories/interfaces.dart` — sonuna ekle:

```dart
abstract class IAcquisitionRepository {
  Future<Result<List<AcquisitionChannel>>> getChannels();
  Future<Result<void>> submitAnswer({
    String? channelId,
    bool skipped,
    String? freeformText,
  });
}
```
> `interfaces.dart` başına model import'u ekle: `import 'package:qulo_v2/data/models/acquisition_channel_model.dart';`

`qulov2/lib/data/repositories/acquisition_repository.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/network/services/acquisition_service.dart';
import 'package:qulo_v2/data/models/acquisition_channel_model.dart';
import 'package:qulo_v2/data/repositories/interfaces.dart';

class AcquisitionRepository implements IAcquisitionRepository {
  final AcquisitionService _service;

  AcquisitionRepository(this._service);

  @override
  Future<Result<List<AcquisitionChannel>>> getChannels() async {
    try {
      final response = await _service.getChannels();
      final list = (response['channels'] as List)
          .map((e) => AcquisitionChannel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Success(list);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    } catch (e) {
      return Failure(UnknownFailure(error: e));
    }
  }

  @override
  Future<Result<void>> submitAnswer({
    String? channelId,
    bool skipped = false,
    String? freeformText,
  }) async {
    try {
      await _service.submitAnswer({
        if (channelId != null) 'channel_id': channelId,
        if (skipped) 'skipped': true,
        if (freeformText != null && freeformText.isNotEmpty)
          'freeform_text': freeformText,
      });
      return const Success(null);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
```

- [ ] **Step 6: Provider'ı yaz**

`qulov2/lib/providers/acquisition_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/data/models/acquisition_channel_model.dart';
import 'package:qulo_v2/providers/api_provider.dart';

class AcquisitionNotifier extends AsyncNotifier<List<AcquisitionChannel>> {
  @override
  Future<List<AcquisitionChannel>> build() async {
    final result = await ref.read(acquisitionRepositoryProvider).getChannels();
    return result.when(
      success: (data) => data,
      failure: (_) => <AcquisitionChannel>[],
    );
  }

  Future<Result<void>> submit({
    String? channelId,
    bool skipped = false,
    String? freeformText,
  }) {
    return ref.read(acquisitionRepositoryProvider).submitAnswer(
          channelId: channelId,
          skipped: skipped,
          freeformText: freeformText,
        );
  }
}

final acquisitionProvider =
    AsyncNotifierProvider<AcquisitionNotifier, List<AcquisitionChannel>>(
  AcquisitionNotifier.new,
);
```

- [ ] **Step 7: DI kaydı**

`qulov2/lib/providers/api_provider.dart` — referral provider'larının yanına ekle (import'lar dosya başına):

```dart
import 'package:qulo_v2/core/network/services/acquisition_service.dart';
import 'package:qulo_v2/data/repositories/acquisition_repository.dart';
```
```dart
final acquisitionServiceProvider = Provider<AcquisitionService>(
  (ref) => AcquisitionService(ref.read(networkManagerProvider).dio),
);

final acquisitionRepositoryProvider = Provider<AcquisitionRepository>(
  (ref) => AcquisitionRepository(ref.read(acquisitionServiceProvider)),
);
```

- [ ] **Step 8: User model flag**

`qulov2/lib/data/models/user_model.dart` — `referralCode` yakınına alan ekle:

```dart
  @JsonKey(name: 'acquisition_answered')
  final bool acquisitionAnswered;
```
Constructor'a: `this.acquisitionAnswered = false,`
`props` listesine: `acquisitionAnswered,`

- [ ] **Step 9: Codegen + analyze + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
fvm dart run build_runner build --delete-conflicting-outputs
fvm dart analyze
fvm flutter test test/acquisition_channel_model_test.dart
```
Expected: codegen `.g.dart` üretir, analyze temiz, test PASS.

- [ ] **Step 10: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/data/models/acquisition_channel_model.dart lib/data/models/acquisition_channel_model.g.dart \
  lib/core/network/services/acquisition_service.dart lib/core/network/services/acquisition_service.g.dart \
  lib/data/repositories/acquisition_repository.dart lib/data/repositories/interfaces.dart \
  lib/providers/acquisition_provider.dart lib/providers/api_provider.dart \
  lib/data/models/user_model.dart lib/data/models/user_model.g.dart \
  test/acquisition_channel_model_test.dart
git commit -m "feat(mobile): acquisition model + service + repository + provider + DI"
```

---

### Task 7: Mobile — anket bottom-sheet UI + discover tetik + overlay guard

**Files:**
- Create: `qulov2/lib/features/discover/widgets/acquisition_sheet.dart`
- Modify: `qulov2/lib/features/discover/mixins/discover_screen_mixin.dart` (tetik + guard)
- Modify: `qulov2/lib/features/discover/screens/discover_screen.dart` (tetik çağrısı)

**Interfaces:**
- Consumes: `acquisitionProvider`, `NavigationService.showAppBottomSheet`, `CustomBottomSheet`, `userProvider`, `context.tr`.
- Produces: `AcquisitionSheet` widget; `DiscoverScreenMixin.maybeStartAcquisition()`.

- [ ] **Step 1: Sheet widget'ını yaz**

`qulov2/lib/features/discover/widgets/acquisition_sheet.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_loading_widget.dart';
import 'package:qulo_v2/data/models/acquisition_channel_model.dart';
import 'package:qulo_v2/providers/acquisition_provider.dart';

class AcquisitionSheet extends ConsumerStatefulWidget {
  const AcquisitionSheet({super.key});

  @override
  ConsumerState<AcquisitionSheet> createState() => _AcquisitionSheetState();
}

class _AcquisitionSheetState extends ConsumerState<AcquisitionSheet> {
  String? _selectedId;
  bool _selectedFreeform = false;
  final _freeformController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _freeformController.dispose();
    super.dispose();
  }

  Future<void> _submit({required bool skip}) async {
    if (_submitting) return;
    setState(() => _submitting = true);
    await ref.read(acquisitionProvider.notifier).submit(
          channelId: skip ? null : _selectedId,
          skipped: skip,
          freeformText: _selectedFreeform ? _freeformController.text.trim() : null,
        );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final channelsAsync = ref.watch(acquisitionProvider);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.tr('acq_title'),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(context.tr('acq_subtitle'),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.lg),
          channelsAsync.when(
            loading: () => const Center(child: AppLoadingWidget.large()),
            error: (_, __) => const SizedBox.shrink(),
            data: (channels) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final c in channels)
                  _ChannelTile(
                    channel: c,
                    selected: _selectedId == c.id,
                    onTap: () => setState(() {
                      _selectedId = c.id;
                      _selectedFreeform = c.isFreeform;
                    }),
                  ),
                if (_selectedFreeform)
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    child: TextField(
                      controller: _freeformController,
                      decoration: InputDecoration(
                        hintText: context.tr('acq_other_hint'),
                      ),
                      maxLength: 280,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: (_selectedId == null || _submitting)
                ? null
                : () => _submit(skip: false),
            child: _submitting
                ? const AppLoadingWidget.small()
                : Text(context.tr('acq_continue')),
          ),
          TextButton(
            onPressed: _submitting ? null : () => _submit(skip: true),
            child: Text(context.tr('acq_skip')),
          ),
        ],
      ),
    );
  }
}

class _ChannelTile extends StatelessWidget {
  final AcquisitionChannel channel;
  final bool selected;
  final VoidCallback onTap;

  const _ChannelTile({
    required this.channel,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.cardPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (channel.emoji != null) ...[
                Text(channel.emoji!, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(child: Text(channel.label)),
              if (selected) Icon(Icons.check_circle, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Mixin tetiğini ekle**

`qulov2/lib/features/discover/mixins/discover_screen_mixin.dart` — import'lar:
```dart
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/features/discover/widgets/acquisition_sheet.dart';
import 'package:qulo_v2/providers/user_provider.dart';
```
Sınıfa alan + metot (mevcut `_coachTried` yanına):
```dart
  bool _acqTried = false;

  /// Profile-setup-gate sonrası ilk discover'da, kullanıcı henüz cevaplamadıysa
  /// tek seferlik "bizi nereden duydunuz?" sheet'ini açar. Coach-mark gibi başka
  /// bir overlay aktifse bu turda açmaz (çakışma guard).
  void maybeStartAcquisition() {
    if (_acqTried) return;
    final user = ref.read(userProvider).valueOrNull;
    if (user == null || user.acquisitionAnswered) return;
    if (CoachMarkService.instance.hasActiveTour) return; // overlay çakışması guard
    _acqTried = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await ref.read(navigationServiceProvider).showAppBottomSheet<void>(
            CustomBottomSheet(
              name: 'acquisition',
              isDismissible: false,
              enableDrag: false,
              maxHeightFactor: 0.85,
              builder: (_) => const AcquisitionSheet(),
            ),
          );
    });
  }
```
> `CoachMarkService` zaten import'lu (mixin dosyasında mevcut). `hasActiveTour` getter'ı yoksa Step 3'te eklenir.

- [ ] **Step 3: CoachMarkService'e `hasActiveTour` getter'ı (yoksa) ekle**

`qulov2/lib/core/services/coach_mark_service.dart` — `_activeEntry` alanını kullanan getter:
```dart
  bool get hasActiveTour => _activeEntry != null;
```
> Eğer bu branch `main`'den dallandıysa coach-mark kodu olmayabilir. O durumda import'u ve guard satırını çıkar; anket guard'ı sadece `_acqTried` + `acquisitionAnswered` ile çalışır. (Coach-marks merge edilince guard'ı geri ekle.)

- [ ] **Step 4: Discover screen'den tetikle**

`qulov2/lib/features/discover/screens/discover_screen.dart` — `data:` branch'inde, kart gösterilen yolda `maybeStartAcquisition()` çağır (build içinde, `maybeStartDiscoverCoach` çağrısı varsa onun yanına; yoksa kartlı dalın başına):

```dart
                maybeStartAcquisition();
```

- [ ] **Step 5: Analyze + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
fvm dart analyze
fvm flutter test
```
Expected: analyze temiz, mevcut testler + model testi PASS.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/features/discover/widgets/acquisition_sheet.dart \
  lib/features/discover/mixins/discover_screen_mixin.dart \
  lib/features/discover/screens/discover_screen.dart \
  lib/core/services/coach_mark_service.dart
git commit -m "feat(mobile): bizi nereden duydunuz sheet + discover tetik + overlay guard"
```

---

### Task 8: Mobile — l10n (16 dil)

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/{tr,en,de,fr,es,ar,ru,pt,it,ja,ko,zh,nl,pl,sv,hi}.dart`

**Interfaces:**
- Produces: `acq_title`, `acq_subtitle`, `acq_skip`, `acq_continue`, `acq_other_hint`, `acq_thanks` (her dilde).

- [ ] **Step 1: 6 anahtarı 16 dile ekle**

Her `translations/<lang>.dart` map'ine aşağıdaki anahtarları ekle. Önce TR + EN (referans), sonra kalan 14 dil. Örnek (tr):

```dart
  // Acquisition ("Bizi nereden duydunuz?")
  'acq_title': 'Bizi nereden duydun?',
  'acq_subtitle': 'Qulo\'ya nasıl ulaştığını öğrenmek bize çok yardımcı olur.',
  'acq_skip': 'Atla',
  'acq_continue': 'Devam',
  'acq_other_hint': 'İstersen biraz daha anlat (opsiyonel)',
  'acq_thanks': 'Teşekkürler!',
```

en:
```dart
  'acq_title': 'How did you hear about us?',
  'acq_subtitle': 'Knowing how you found Qulo really helps us.',
  'acq_skip': 'Skip',
  'acq_continue': 'Continue',
  'acq_other_hint': 'Tell us a bit more (optional)',
  'acq_thanks': 'Thanks!',
```

de:
```dart
  'acq_title': 'Wie hast du von uns erfahren?',
  'acq_subtitle': 'Zu wissen, wie du Qulo gefunden hast, hilft uns sehr.',
  'acq_skip': 'Überspringen',
  'acq_continue': 'Weiter',
  'acq_other_hint': 'Erzähl uns etwas mehr (optional)',
  'acq_thanks': 'Danke!',
```

fr:
```dart
  'acq_title': 'Comment avez-vous entendu parler de nous ?',
  'acq_subtitle': 'Savoir comment vous avez découvert Qulo nous aide beaucoup.',
  'acq_skip': 'Passer',
  'acq_continue': 'Continuer',
  'acq_other_hint': 'Dites-nous en un peu plus (facultatif)',
  'acq_thanks': 'Merci !',
```

es:
```dart
  'acq_title': '¿Cómo nos conociste?',
  'acq_subtitle': 'Saber cómo encontraste Qulo nos ayuda mucho.',
  'acq_skip': 'Omitir',
  'acq_continue': 'Continuar',
  'acq_other_hint': 'Cuéntanos un poco más (opcional)',
  'acq_thanks': '¡Gracias!',
```

ar:
```dart
  'acq_title': 'كيف سمعت عنّا؟',
  'acq_subtitle': 'معرفة كيف وجدت Qulo تساعدنا كثيرًا.',
  'acq_skip': 'تخطّي',
  'acq_continue': 'متابعة',
  'acq_other_hint': 'أخبرنا المزيد (اختياري)',
  'acq_thanks': 'شكرًا!',
```

ru:
```dart
  'acq_title': 'Откуда вы о нас узнали?',
  'acq_subtitle': 'Нам очень помогает знать, как вы нашли Qulo.',
  'acq_skip': 'Пропустить',
  'acq_continue': 'Продолжить',
  'acq_other_hint': 'Расскажите подробнее (необязательно)',
  'acq_thanks': 'Спасибо!',
```

pt:
```dart
  'acq_title': 'Como ouviu falar de nós?',
  'acq_subtitle': 'Saber como você encontrou o Qulo nos ajuda muito.',
  'acq_skip': 'Pular',
  'acq_continue': 'Continuar',
  'acq_other_hint': 'Conte-nos um pouco mais (opcional)',
  'acq_thanks': 'Obrigado!',
```

it:
```dart
  'acq_title': 'Come ci hai conosciuti?',
  'acq_subtitle': 'Sapere come hai trovato Qulo ci aiuta molto.',
  'acq_skip': 'Salta',
  'acq_continue': 'Continua',
  'acq_other_hint': 'Raccontaci qualcosa in più (facoltativo)',
  'acq_thanks': 'Grazie!',
```

ja:
```dart
  'acq_title': 'どこで私たちを知りましたか？',
  'acq_subtitle': 'Quloをどう見つけたか教えていただけると助かります。',
  'acq_skip': 'スキップ',
  'acq_continue': '続ける',
  'acq_other_hint': 'もう少し教えてください（任意）',
  'acq_thanks': 'ありがとう！',
```

ko:
```dart
  'acq_title': '저희를 어떻게 알게 되셨나요?',
  'acq_subtitle': 'Qulo를 어떻게 찾으셨는지 알려주시면 큰 도움이 됩니다.',
  'acq_skip': '건너뛰기',
  'acq_continue': '계속',
  'acq_other_hint': '조금 더 알려주세요 (선택)',
  'acq_thanks': '감사합니다!',
```

zh:
```dart
  'acq_title': '你是怎么知道我们的？',
  'acq_subtitle': '了解你如何找到 Qulo 对我们很有帮助。',
  'acq_skip': '跳过',
  'acq_continue': '继续',
  'acq_other_hint': '再多告诉我们一点（可选）',
  'acq_thanks': '谢谢！',
```

nl:
```dart
  'acq_title': 'Hoe heb je over ons gehoord?',
  'acq_subtitle': 'Weten hoe je Qulo hebt gevonden helpt ons enorm.',
  'acq_skip': 'Overslaan',
  'acq_continue': 'Doorgaan',
  'acq_other_hint': 'Vertel ons iets meer (optioneel)',
  'acq_thanks': 'Bedankt!',
```

pl:
```dart
  'acq_title': 'Skąd o nas wiesz?',
  'acq_subtitle': 'Wiedza o tym, jak trafiłeś do Qulo, bardzo nam pomaga.',
  'acq_skip': 'Pomiń',
  'acq_continue': 'Dalej',
  'acq_other_hint': 'Powiedz nam coś więcej (opcjonalnie)',
  'acq_thanks': 'Dziękujemy!',
```

sv:
```dart
  'acq_title': 'Hur hörde du talas om oss?',
  'acq_subtitle': 'Att veta hur du hittade Qulo hjälper oss mycket.',
  'acq_skip': 'Hoppa över',
  'acq_continue': 'Fortsätt',
  'acq_other_hint': 'Berätta gärna lite mer (valfritt)',
  'acq_thanks': 'Tack!',
```

hi:
```dart
  'acq_title': 'आपने हमारे बारे में कैसे सुना?',
  'acq_subtitle': 'आपने Qulo को कैसे पाया, यह जानना हमें बहुत मदद करता है।',
  'acq_skip': 'छोड़ें',
  'acq_continue': 'जारी रखें',
  'acq_other_hint': 'थोड़ा और बताएं (वैकल्पिक)',
  'acq_thanks': 'धन्यवाद!',
```

- [ ] **Step 2: Analyze + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
fvm dart analyze
fvm flutter test
```
Expected: analyze temiz, testler PASS.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/core/l10n/translations/
git commit -m "feat(mobile): acquisition anketi 16 dil l10n"
```

---

### Task 9: Final review + doğrulama

**Files:** (yok — review + doğrulama)

- [ ] **Step 1: Flutter-review**

`/flutter-review` skill'ini çalıştır. Bulguları gider, gerekirse commit et.

- [ ] **Step 2: Mobile tam analyze + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
fvm dart analyze
fvm flutter test
```
Expected: 0 hata, tüm testler PASS.

- [ ] **Step 3: Server build + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx tsc --noEmit && npm test
```
Expected: tsc temiz, vitest PASS.

- [ ] **Step 4: Uçtan uca doğrulama (manuel)**

1. Server dev (`npm run dev`) + admin `/admin/acquisition` → kanal ekle/düzenle/toggle, rapor görünür.
2. Mobile cihaz/emülatör: yeni hesap → profile-setup-gate tamamla → ilk discover'da anket sheet'i açılır → kanal seç + Devam → tekrar discover'a girince **açılmaz** (flag). Ayrı hesapta "Atla" → kapanır, tekrar açılmaz.
3. Admin raporda yeni cevaplar sayılır.

- [ ] **Step 5: Özet + memory**

Kullanıcıya değişiklik özeti sun. Önemli kalıcı bilgileri memory'ye yaz (yeni tablolar, branch'ler, kapsam dışı influencer kod notu). Branch'ler **push EDİLMEZ** — kullanıcı tetikler.

---

## Self-Review Notları

- **Spec kapsamı:** Bölüm 2 (DB) → Task 1; Bölüm 3 (Mobile API) → Task 2-3; Bölüm 4 (Backoffice) → Task 4-5; Bölüm 5 (Mobile) → Task 6-8. Tümü kapsandı.
- **Tek-seferlik:** `users.acquisition_answered` (denormalize, getMe'de döner) + mobile `_acqTried` + sheet guard.
- **Overlay çakışması:** `CoachMarkService.hasActiveTour` guard (Task 7 Step 2-3).
- **Snapshot:** `channel_key` (Task 1) → rapor `getReport` (Task 4) bu alandan grupluyor.
- **Influencer custom kod:** kapsam dışı, backlog (spec Bölüm 1).
