# Sayfa-Özelinde Segment Bazlı Onboarding/Info Mesajları — Uygulama Planı

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Backoffice'ten yönetilen, kullanıcı belirli bir uygulama sayfasına girince gösterilen, segment bazlı (kişiye özel), 16 dilde, deep link yönlendirmeli in-app mesaj sistemi kurmak.

**Architecture:** Mimari B — yeni `page_messages` + `page_message_events` tabloları; campaign'in segment motoru paylaşılan `segment.service`'e çıkarılır; server hem mobile fetch API'si hem EJS admin paneli sunar; mobile, mevcut core widget'lara (banner/sheet/dialog) delege eden bir dispatcher feature'ı ile gösterir.

**Tech Stack:** Node.js + Express + TypeScript + Zod + Vitest (server) · Supabase PostgreSQL (DB) · EJS (admin) · Flutter + Riverpod + Dio + Retrofit + json_serializable (mobile).

## Global Constraints

- **16 dil zorunlu** (manuel): `SUPPORTED_LOCALES = ['tr','en','de','fr','es','ar','ru','pt','it','ja','ko','zh','nl','pl','sv','hi']`. Bir mesaj 16 dilin hepsi dolu olmadan yayınlanamaz (validator zorlar).
- **Güvenlik (spec §11):** `action_url` SADECE internal path (`/^\/[a-zA-Z0-9_\/-]*$/`) veya `quloapp.com` host'lu URL; `javascript:`/`data:`/harici reddedilir. `image_url` yalnız `https://`. Mobile CTA YALNIZCA `DeepLinkParser.parse → navigateDeepLink`; `handleDeepLink(raw)` **kullanılmaz**. Event endpoint `req.user.userId` (body'den asla) + eligibility check. Mobile payload `segment`/admin alanları içermez.
- **Naming:** TS dosyaları `kebab.case.ts`, tablolar/kolonlar `snake_case`, servis `PascalCaseService` + `camelCase` singleton instance. Dart dosyaları `snake_case.dart`, sınıflar `PascalCase`, provider `camelCaseProvider`.
- **qulov2 kuralları:** Hardcode renk/spacing/string YOK (tema + i18n). Dialog/sheet yalnız `NavigationService`. `_buildXxx()` YOK. Loading = `AppLoadingWidget`. `flutter analyze` sıfır hata.
- **qulo-server kuralları:** Her endpoint Zod `validate(schema)`. Error = `Errors.*`/`AppError` + `next(err)`. Router→Controller→Service→DB. Mobile route'larda `generalLimiter`.
- **Repo yapısı:** `qulo-server` ve `qulov2` ayrı nested git repo'lar (her ikisi `main`). Her birinde `feat/page-messages` branch'i açılır; commit'ler ilgili repo'da yapılır. Migration `qulo-server/migrations/032_page_messages.sql` dosyasına yazılır ve **Supabase MCP** ile apply edilir.
- **Sayfa registry (`page` enum):** `discover, matches, chat, profile, profile_detail, questions, quiz, diamonds, exchange, passport, settings, notifications`.

---

## Dosya Yapısı

### Server (qulo-server)
| Dosya | Sorumluluk |
|------|-----------|
| `migrations/032_page_messages.sql` | **YENİ** — 2 tablo + index |
| `src/validators/segment.validator.ts` | **YENİ** — `segmentSchema` (campaign'den taşınır + Faz 1 alanları) |
| `src/validators/page-message.validator.ts` | **YENİ** — content 16-dil refine + url whitelist |
| `src/services/segment.service.ts` | **YENİ** — `buildSegmentQuery` + `matchesSegment` + `previewSegmentCount` |
| `src/services/page-message.service.ts` | **YENİ** — CRUD + `getActiveForUser` + `recordEvent` + `getStats` |
| `src/validators/campaign.validator.ts` | **DEĞİŞTİR** — `segmentSchema`'yı segment.validator'dan re-export |
| `src/services/campaign.service.ts` | **DEĞİŞTİR** — segment metotlarını segment.service'ten import |
| `src/controllers/page-message.controller.ts` | **YENİ** — mobile GET + event POST handler |
| `src/routes/page-message.routes.ts` | **YENİ** — mobile route'lar |
| `src/admin/page-message.admin.controller.ts` | **YENİ** — admin CRUD + preview |
| `src/admin/views/page-messages-list.ejs` | **YENİ** — liste |
| `src/admin/views/page-messages-edit.ejs` | **YENİ** — oluştur/düzenle (16 dil + segment) |
| `src/admin/admin.routes.ts` | **DEĞİŞTİR** — page-message route blokları |
| `src/index.ts` | **DEĞİŞTİR** — `/api/v1/page-messages` mount |
| `src/constants/page-keys.ts` | **YENİ** — `PAGE_KEYS` paylaşılan sabit |

### Mobile (qulov2)
| Dosya | Sorumluluk |
|------|-----------|
| `lib/features/page_messages/data/models/page_message_model.dart` | **YENİ** — model + codegen |
| `lib/core/network/services/page_message_service.dart` | **YENİ** — Retrofit |
| `lib/features/page_messages/data/repositories/page_message_repository.dart` | **YENİ** — Result<T> |
| `lib/providers/page_messages_provider.dart` | **YENİ** — Notifier + state |
| `lib/providers/api_provider.dart` | **DEĞİŞTİR** — service+repo provider |
| `lib/features/page_messages/widgets/page_message_content.dart` | **YENİ** — ortak içerik (content map→UI) |
| `lib/features/page_messages/widgets/page_message_host.dart` | **YENİ** — dispatcher |
| `lib/features/page_messages/widgets/page_message_inline_card.dart` | **YENİ** — inline/banner gömülü görünüm |
| `lib/app.dart` | **DEĞİŞTİR** — resume'da fetch |
| `lib/core/l10n/translations/*.dart` (16) | **DEĞİŞTİR** — statik UI string'leri |
| Hedef screen'ler (discover/profile/chat...) | **DEĞİŞTİR** — `PageMessageHost` ekle |

---

## FAZ A — SERVER + DB + ADMIN

### Task 1: DB Migration — page_messages + page_message_events

**Files:**
- Create: `qulo-server/migrations/032_page_messages.sql`

**Interfaces:**
- Produces: `page_messages` tablosu (id, title, page, display_type, content jsonb, image_url, action_url, frequency, priority, segment jsonb, start_at, end_at, is_active, created_by, created_at, updated_at); `page_message_events` (id, page_message_id, user_id, event, created_at).

- [ ] **Step 1: Migration dosyasını yaz**

```sql
-- 032_page_messages.sql
-- In-app, sayfa-özelinde, segment bazlı onboarding/info mesajları.
-- Push campaign'den ayrı; segment motorunu paylaşır, FCM göndermez.
BEGIN;

CREATE TABLE IF NOT EXISTS page_messages (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title         text NOT NULL,                 -- admin-içi etiket (kullanıcıya gösterilmez)
  page          text NOT NULL,                 -- hedef sayfa anahtarı (PAGE_KEYS)
  display_type  text NOT NULL,                 -- banner | bottom_sheet | modal | inline_card
  content       jsonb NOT NULL,                -- { "tr": {title,body,cta_label}, "en": {...}, ... } 16 dil
  image_url     text,
  action_url    text,                          -- internal deep link veya quloapp.com URL
  frequency     text NOT NULL DEFAULT 'once',  -- once | every_visit | until_dismissed | daily
  priority      int  NOT NULL DEFAULT 0,
  segment       jsonb,                         -- null = herkes
  start_at      timestamptz,
  end_at        timestamptz,
  is_active     boolean NOT NULL DEFAULT true,
  created_by    uuid REFERENCES admin_users(id),
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS page_message_events (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  page_message_id uuid NOT NULL REFERENCES page_messages(id) ON DELETE CASCADE,
  user_id         uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  event           text NOT NULL,               -- shown | clicked | dismissed
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_page_messages_active_page
  ON page_messages(is_active, page);
CREATE INDEX IF NOT EXISTS idx_pme_msg_event
  ON page_message_events(page_message_id, event);
CREATE INDEX IF NOT EXISTS idx_pme_user_msg
  ON page_message_events(user_id, page_message_id);

ALTER TABLE page_messages DISABLE ROW LEVEL SECURITY;
ALTER TABLE page_message_events DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE page_messages IS 'Admin-yönetimli, sayfa-özelinde, segment bazlı in-app mesajlar';
COMMENT ON COLUMN page_messages.content IS '16 dil map: locale -> {title, body, cta_label}';
COMMENT ON TABLE page_message_events IS 'Frekans state + analitik (shown/clicked/dismissed)';

COMMIT;
```

- [ ] **Step 2: Supabase MCP ile apply et**

Supabase MCP `apply_migration` tool'unu kullan (name: `page_messages`, query: yukarıdaki SQL). Alternatif: `list_migrations` ile mevcut son numarayı doğrula (>= 031 olmalı).

- [ ] **Step 3: Tabloların oluştuğunu doğrula**

Supabase MCP `list_tables` veya `execute_sql` ile:
```sql
SELECT table_name FROM information_schema.tables
WHERE table_name IN ('page_messages','page_message_events');
```
Expected: 2 satır döner.

- [ ] **Step 4: Commit (qulo-server)**

```bash
cd qulo-server && git checkout -b feat/page-messages 2>/dev/null || git checkout feat/page-messages
git add migrations/032_page_messages.sql
git commit -m "feat(db): page_messages + page_message_events tabloları (migration 032)"
```

---

### Task 2: Segment servisi — extraction + Faz 1 davranışsal alanlar

Campaign'in segment mantığını paylaşılan servise çıkar; `matchesSegment` (saf fonksiyon, page-message fetch için) ekle; Faz 1 davranışsal alanları (`question_count`, `photo_count`, `green_diamonds`, `is_premium`, `has_match`) ekle.

**Files:**
- Create: `qulo-server/src/validators/segment.validator.ts`
- Create: `qulo-server/src/services/segment.service.ts`
- Create: `qulo-server/src/__tests__/segment.service.test.ts`
- Modify: `qulo-server/src/validators/campaign.validator.ts`
- Modify: `qulo-server/src/services/campaign.service.ts`

**Interfaces:**
- Produces: `segmentSchema` (Zod), `SegmentInput` (type); `segmentService.buildSegmentQuery(segment)`, `segmentService.matchesSegment(user: SegmentUser, segment: SegmentInput | null): boolean`, `segmentService.previewSegmentCount(segment)`. `SegmentUser` = `{ gender, age, city, subscription_plan, last_seen_at, profile_completion, created_at, question_count, photo_count, green_diamonds }`.
- Consumes: `supabase` (`config/supabase.js`).

- [ ] **Step 1: segment.validator.ts'i yaz** (segmentSchema'yı campaign.validator'dan taşı + genişlet)

```typescript
import { z } from "zod";

export const segmentSchema = z.object({
  // Demografik (mevcut)
  gender: z.enum(["MAN", "WOMAN"]).optional(),
  age_min: z.number().int().min(18).max(99).optional(),
  age_max: z.number().int().min(18).max(99).optional(),
  cities: z.array(z.string()).optional(),
  subscription_plan: z.string().optional(),
  last_active_days: z.number().int().min(1).optional(),
  profile_completion_min: z.number().int().min(0).max(100).optional(),
  profile_completion_max: z.number().int().min(0).max(100).optional(),
  registered_after: z
    .string()
    .refine((v) => !isNaN(Date.parse(v)), { message: "Must be a valid date string" })
    .optional(),
  // Faz 1 davranışsal (users tablosunda hazır alanlar)
  question_count_max: z.number().int().min(0).optional(), // örn. 0 = hiç soru eklememiş
  question_count_min: z.number().int().min(0).optional(),
  photo_count_max: z.number().int().min(0).optional(),
  green_diamonds_max: z.number().int().min(0).optional(),
  is_premium: z.boolean().optional(),
  has_match: z.boolean().optional(),
});

export type SegmentInput = z.infer<typeof segmentSchema>;
```

- [ ] **Step 2: campaign.validator.ts'i segment.validator'a yönlendir**

`campaign.validator.ts` içindeki `segmentSchema` tanımını sil, en üste ekle:
```typescript
import { segmentSchema, type SegmentInput } from "./segment.validator.js";
export { segmentSchema };
export type { SegmentInput };
```
`createCampaignSchema` aynı kalır (`segment: segmentSchema` referansı çalışmaya devam eder).

- [ ] **Step 3: matchesSegment için failing test yaz**

```typescript
// src/__tests__/segment.service.test.ts
import { describe, it, expect } from "vitest";
import { segmentService } from "../services/segment.service.js";
import type { SegmentUser } from "../services/segment.service.js";

const baseUser: SegmentUser = {
  gender: "WOMAN", age: 25, city: "Istanbul", subscription_plan: "free",
  last_seen_at: new Date().toISOString(), profile_completion: 80,
  created_at: new Date().toISOString(), question_count: 0, photo_count: 2,
  green_diamonds: 10, has_match: false,
};

describe("matchesSegment", () => {
  it("null segment → herkes uyar", () => {
    expect(segmentService.matchesSegment(baseUser, null)).toBe(true);
  });
  it("gender eşleşmezse false", () => {
    expect(segmentService.matchesSegment(baseUser, { gender: "MAN" })).toBe(false);
  });
  it("question_count_max=0 ile hiç soru eklememiş kullanıcı uyar", () => {
    expect(segmentService.matchesSegment(baseUser, { question_count_max: 0 })).toBe(true);
    expect(segmentService.matchesSegment({ ...baseUser, question_count: 3 }, { question_count_max: 0 })).toBe(false);
  });
  it("is_premium=true ile free kullanıcı uymaz", () => {
    expect(segmentService.matchesSegment(baseUser, { is_premium: true })).toBe(false);
    expect(segmentService.matchesSegment({ ...baseUser, subscription_plan: "premium" }, { is_premium: true })).toBe(true);
  });
  it("age aralığı dışında false", () => {
    expect(segmentService.matchesSegment(baseUser, { age_min: 30 })).toBe(false);
  });
});
```

- [ ] **Step 2b: Test fail etmeli** — Run: `cd qulo-server && npx vitest run src/__tests__/segment.service.test.ts`
Expected: FAIL ("Cannot find module ../services/segment.service.js").

- [ ] **Step 3b: segment.service.ts'i yaz**

```typescript
import { supabase } from "../config/supabase.js";
import type { SegmentInput } from "../validators/segment.validator.js";

export interface SegmentUser {
  gender: string | null;
  age: number | null;
  city: string | null;
  subscription_plan: string | null;
  last_seen_at: string | null;
  profile_completion: number | null;
  created_at: string | null;
  question_count: number | null;
  photo_count: number | null;
  green_diamonds: number | null;
  has_match?: boolean;
}

const PREMIUM_PLANS = new Set(["plus", "premium"]);

class SegmentService {
  // ── SQL yön: segment → eşleşen user listesi (campaign push + admin preview) ──
  buildSegmentQuery(segment: SegmentInput) {
    let query = supabase
      .from("users")
      .select("id, push_token", { count: "exact" })
      .eq("is_deleted", false);

    if (segment.gender) query = query.eq("gender", segment.gender);
    if (segment.age_min !== undefined) query = query.gte("age", segment.age_min);
    if (segment.age_max !== undefined) query = query.lte("age", segment.age_max);
    if (segment.cities?.length) query = query.in("city", segment.cities);
    if (segment.subscription_plan) query = query.eq("subscription_plan", segment.subscription_plan);
    if (segment.last_active_days !== undefined) {
      const since = new Date();
      since.setDate(since.getDate() - segment.last_active_days);
      query = query.gte("last_seen_at", since.toISOString());
    }
    if (segment.profile_completion_min !== undefined) query = query.gte("profile_completion", segment.profile_completion_min);
    if (segment.profile_completion_max !== undefined) query = query.lte("profile_completion", segment.profile_completion_max);
    if (segment.registered_after) query = query.gte("created_at", segment.registered_after);
    if (segment.question_count_max !== undefined) query = query.lte("question_count", segment.question_count_max);
    if (segment.question_count_min !== undefined) query = query.gte("question_count", segment.question_count_min);
    if (segment.green_diamonds_max !== undefined) query = query.lte("green_diamonds", segment.green_diamonds_max);
    if (segment.is_premium === true) query = query.in("subscription_plan", ["plus", "premium"]);
    if (segment.is_premium === false) query = query.eq("subscription_plan", "free");

    return query;
  }

  async previewSegmentCount(segment: SegmentInput): Promise<number> {
    const { count, error } = await this.buildSegmentQuery(segment);
    if (error) throw error;
    return count ?? 0;
  }

  // ── In-memory yön: bu user verilen segment'e uyuyor mu? (page-message fetch) ──
  matchesSegment(user: SegmentUser, segment: SegmentInput | null): boolean {
    if (!segment) return true;
    if (segment.gender && user.gender !== segment.gender) return false;
    if (segment.age_min !== undefined && (user.age ?? -1) < segment.age_min) return false;
    if (segment.age_max !== undefined && (user.age ?? 999) > segment.age_max) return false;
    if (segment.cities?.length && !(user.city && segment.cities.includes(user.city))) return false;
    if (segment.subscription_plan && user.subscription_plan !== segment.subscription_plan) return false;
    if (segment.last_active_days !== undefined) {
      const since = Date.now() - segment.last_active_days * 86_400_000;
      if (!user.last_seen_at || Date.parse(user.last_seen_at) < since) return false;
    }
    if (segment.profile_completion_min !== undefined && (user.profile_completion ?? 0) < segment.profile_completion_min) return false;
    if (segment.profile_completion_max !== undefined && (user.profile_completion ?? 100) > segment.profile_completion_max) return false;
    if (segment.registered_after && (!user.created_at || Date.parse(user.created_at) < Date.parse(segment.registered_after))) return false;
    if (segment.question_count_max !== undefined && (user.question_count ?? 0) > segment.question_count_max) return false;
    if (segment.question_count_min !== undefined && (user.question_count ?? 0) < segment.question_count_min) return false;
    if (segment.photo_count_max !== undefined && (user.photo_count ?? 0) > segment.photo_count_max) return false;
    if (segment.green_diamonds_max !== undefined && (user.green_diamonds ?? 0) > segment.green_diamonds_max) return false;
    if (segment.is_premium !== undefined) {
      const premium = PREMIUM_PLANS.has(user.subscription_plan ?? "free");
      if (segment.is_premium !== premium) return false;
    }
    if (segment.has_match !== undefined && (user.has_match ?? false) !== segment.has_match) return false;
    return true;
  }
}

export const segmentService = new SegmentService();
```

- [ ] **Step 4: Test pass etmeli** — Run: `npx vitest run src/__tests__/segment.service.test.ts`
Expected: PASS (5 test).

- [ ] **Step 5: campaign.service.ts'i refactor et** (segment metodunu sil, import et)

`campaign.service.ts` içinde `private buildSegmentQuery(...)` ve `previewSegmentCount(...)` metotlarını sil. En üste ekle:
```typescript
import { segmentService } from "./segment.service.js";
```
İçeride `this.buildSegmentQuery(...)` → `segmentService.buildSegmentQuery(...)`, `this.previewSegmentCount` çağrılarını (varsa) `segmentService.previewSegmentCount` yap. `previewSegmentCount` public metodunu campaign.service'te `previewSegmentCount(s) { return segmentService.previewSegmentCount(s); }` olarak bırak (admin controller geriye dönük çağırıyor).

- [ ] **Step 6: Build + mevcut testler geçmeli**

Run: `npm run build && npx vitest run`
Expected: tsc hatasız, tüm testler PASS (segment + mevcut campaign testleri).

- [ ] **Step 7: Commit**

```bash
git add src/validators/segment.validator.ts src/validators/campaign.validator.ts \
        src/services/segment.service.ts src/services/campaign.service.ts \
        src/__tests__/segment.service.test.ts
git commit -m "refactor(segment): paylaşılan segment.service + matchesSegment + Faz1 davranışsal alanlar"
```

---

### Task 3: page-message validator — 16 dil refine + URL whitelist

**Files:**
- Create: `qulo-server/src/constants/page-keys.ts`
- Create: `qulo-server/src/validators/page-message.validator.ts`
- Create: `qulo-server/src/__tests__/page-message.validator.test.ts`

**Interfaces:**
- Produces: `PAGE_KEYS` (readonly array), `createPageMessageSchema` (Zod), `CreatePageMessageInput` (type), `eventSchema`.
- Consumes: `segmentSchema` (segment.validator), `SUPPORTED_LOCALES` (constants/locales).

- [ ] **Step 1: page-keys.ts'i yaz**

```typescript
export const PAGE_KEYS = [
  "discover", "matches", "chat", "profile", "profile_detail",
  "questions", "quiz", "diamonds", "exchange", "passport",
  "settings", "notifications",
] as const;
export type PageKey = typeof PAGE_KEYS[number];
```

- [ ] **Step 2: validator için failing test yaz**

```typescript
// src/__tests__/page-message.validator.test.ts
import { describe, it, expect } from "vitest";
import { createPageMessageSchema } from "../validators/page-message.validator.js";
import { SUPPORTED_LOCALES } from "../constants/locales.js";

const fullContent = Object.fromEntries(
  SUPPORTED_LOCALES.map((l) => [l, { title: "T", body: "B", cta_label: "C" }]),
);
const valid = {
  title: "Onboarding ipucu", page: "discover", display_type: "banner",
  content: fullContent, frequency: "once", priority: 0,
  action_url: "/discover", is_active: true,
};

describe("createPageMessageSchema", () => {
  it("16 dil tam → geçerli", () => {
    expect(createPageMessageSchema.safeParse(valid).success).toBe(true);
  });
  it("bir dil eksik → reddedilir", () => {
    const { tr, ...missing } = fullContent;
    expect(createPageMessageSchema.safeParse({ ...valid, content: missing }).success).toBe(false);
  });
  it("javascript: action_url → reddedilir", () => {
    expect(createPageMessageSchema.safeParse({ ...valid, action_url: "javascript:alert(1)" }).success).toBe(false);
  });
  it("harici http action_url → reddedilir", () => {
    expect(createPageMessageSchema.safeParse({ ...valid, action_url: "https://attacker.com" }).success).toBe(false);
  });
  it("quloapp.com action_url → geçerli", () => {
    expect(createPageMessageSchema.safeParse({ ...valid, action_url: "https://quloapp.com/discover" }).success).toBe(true);
  });
  it("http image_url → reddedilir (https zorunlu)", () => {
    expect(createPageMessageSchema.safeParse({ ...valid, image_url: "http://x.com/a.png" }).success).toBe(false);
  });
  it("geçersiz display_type → reddedilir", () => {
    expect(createPageMessageSchema.safeParse({ ...valid, display_type: "popup" }).success).toBe(false);
  });
});
```

- [ ] **Step 3: Test fail etmeli** — Run: `npx vitest run src/__tests__/page-message.validator.test.ts`
Expected: FAIL (modül yok).

- [ ] **Step 4: page-message.validator.ts'i yaz**

```typescript
import { z } from "zod";
import { segmentSchema } from "./segment.validator.js";
import { SUPPORTED_LOCALES } from "../constants/locales.js";
import { PAGE_KEYS } from "../constants/page-keys.js";

const localeContentSchema = z.object({
  title: z.string().min(1).max(120),
  body: z.string().min(1).max(500),
  cta_label: z.string().max(40).optional().default(""),
});

// 16 dilin HEPSİ dolu olmalı
const contentSchema = z
  .record(z.string(), localeContentSchema)
  .refine(
    (c) => SUPPORTED_LOCALES.every((l) => c[l] && c[l].title && c[l].body),
    { message: "Tüm 16 dil (title+body) dolu olmalı" },
  );

// action_url: internal path (/...) veya quloapp.com host'lu URL; başka her şey reddedilir
const actionUrlSchema = z
  .string()
  .max(200)
  .refine((v) => {
    if (/^\/[a-zA-Z0-9_\/-]*$/.test(v)) return true; // internal path
    try {
      const u = new URL(v);
      return u.protocol === "https:" && (u.hostname === "quloapp.com" || u.hostname === "www.quloapp.com");
    } catch {
      return false;
    }
  }, { message: "action_url internal path veya quloapp.com https URL olmalı" })
  .optional();

const imageUrlSchema = z
  .string()
  .max(300)
  .refine((v) => v.startsWith("https://"), { message: "image_url https olmalı" })
  .optional();

export const createPageMessageSchema = z.object({
  title: z.string().min(1).max(200),
  page: z.enum(PAGE_KEYS as unknown as [string, ...string[]]),
  display_type: z.enum(["banner", "bottom_sheet", "modal", "inline_card"]),
  content: contentSchema,
  image_url: imageUrlSchema,
  action_url: actionUrlSchema,
  frequency: z.enum(["once", "every_visit", "until_dismissed", "daily"]).default("once"),
  priority: z.number().int().default(0),
  segment: segmentSchema.optional(),
  start_at: z.string().refine((v) => !isNaN(Date.parse(v)), { message: "geçersiz tarih" }).optional(),
  end_at: z.string().refine((v) => !isNaN(Date.parse(v)), { message: "geçersiz tarih" }).optional(),
  is_active: z.boolean().default(true),
});
export type CreatePageMessageInput = z.infer<typeof createPageMessageSchema>;

export const eventSchema = z.object({
  event: z.enum(["shown", "clicked", "dismissed"]),
});
```

- [ ] **Step 5: Test pass etmeli** — Run: `npx vitest run src/__tests__/page-message.validator.test.ts`
Expected: PASS (7 test).

- [ ] **Step 6: Commit**

```bash
git add src/constants/page-keys.ts src/validators/page-message.validator.ts src/__tests__/page-message.validator.test.ts
git commit -m "feat(validator): page-message şeması — 16 dil refine + action_url/image_url whitelist"
```

---

### Task 4: page-message servisi — CRUD + getActiveForUser + recordEvent + getStats

**Files:**
- Create: `qulo-server/src/services/page-message.service.ts`
- Create: `qulo-server/src/__tests__/page-message.frequency.test.ts`

**Interfaces:**
- Produces: `pageMessageService` ile metotlar: `getActiveForUser(userId): Promise<PublicPageMessage[]>`, `recordEvent(userId, messageId, event)`, `list(page)`, `getById(id)`, `create(input, adminId)`, `update(id, input)`, `toggleActive(id)`, `remove(id)`, `getStats(messageId)`. Ayrıca saf yardımcı `passesFrequency(frequency, userEvents): boolean`.
- Consumes: `supabase`, `segmentService.matchesSegment`, `SegmentUser`.
- `PublicPageMessage` = `{ id, page, display_type, content, image_url, action_url, frequency, priority }` (segment/admin alanları YOK — spec T5).

- [ ] **Step 1: passesFrequency saf fonksiyonu için failing test yaz**

```typescript
// src/__tests__/page-message.frequency.test.ts
import { describe, it, expect } from "vitest";
import { passesFrequency } from "../services/page-message.service.js";

const today = new Date().toISOString();
const yesterday = new Date(Date.now() - 86_400_000).toISOString();

describe("passesFrequency", () => {
  it("once: hiç shown yoksa geçer", () => {
    expect(passesFrequency("once", [])).toBe(true);
  });
  it("once: shown varsa geçmez", () => {
    expect(passesFrequency("once", [{ event: "shown", created_at: yesterday }])).toBe(false);
  });
  it("until_dismissed: dismissed varsa geçmez", () => {
    expect(passesFrequency("until_dismissed", [{ event: "shown", created_at: yesterday }])).toBe(true);
    expect(passesFrequency("until_dismissed", [{ event: "dismissed", created_at: yesterday }])).toBe(false);
  });
  it("daily: bugün shown varsa geçmez, dünkü shown geçer", () => {
    expect(passesFrequency("daily", [{ event: "shown", created_at: today }])).toBe(false);
    expect(passesFrequency("daily", [{ event: "shown", created_at: yesterday }])).toBe(true);
  });
  it("every_visit: her zaman geçer", () => {
    expect(passesFrequency("every_visit", [{ event: "shown", created_at: today }])).toBe(true);
  });
});
```

- [ ] **Step 2: Test fail etmeli** — Run: `npx vitest run src/__tests__/page-message.frequency.test.ts`
Expected: FAIL (modül yok).

- [ ] **Step 3: page-message.service.ts'i yaz**

```typescript
import { supabase } from "../config/supabase.js";
import { segmentService, type SegmentUser } from "./segment.service.js";
import type { CreatePageMessageInput } from "../validators/page-message.validator.js";
import type { SegmentInput } from "../validators/segment.validator.js";

export interface PmEvent { event: string; created_at: string; }
export type EventType = "shown" | "clicked" | "dismissed";

export interface PublicPageMessage {
  id: string; page: string; display_type: string;
  content: Record<string, unknown>; image_url: string | null;
  action_url: string | null; frequency: string; priority: number;
}

const SELECT_USER = "gender, age, city, subscription_plan, last_seen_at, profile_completion, created_at, question_count, photo_count, green_diamonds";

// Saf: kalıcı frekans filtresi
export function passesFrequency(frequency: string, events: PmEvent[]): boolean {
  switch (frequency) {
    case "every_visit": return true;
    case "until_dismissed": return !events.some((e) => e.event === "dismissed");
    case "once": return !events.some((e) => e.event === "shown");
    case "daily": {
      const startOfDay = new Date(); startOfDay.setHours(0, 0, 0, 0);
      return !events.some((e) => e.event === "shown" && Date.parse(e.created_at) >= startOfDay.getTime());
    }
    default: return false;
  }
}

class PageMessageService {
  async getActiveForUser(userId: string): Promise<PublicPageMessage[]> {
    const nowIso = new Date().toISOString();
    // 1. Aktif + tarih aralığındaki mesajlar
    const { data: messages, error } = await supabase
      .from("page_messages")
      .select("*")
      .eq("is_active", true)
      .order("priority", { ascending: false });
    if (error) throw error;
    const active = (messages ?? []).filter((m) =>
      (!m.start_at || m.start_at <= nowIso) && (!m.end_at || m.end_at >= nowIso),
    );
    if (active.length === 0) return [];

    // 2. Kullanıcı segment alanları
    const { data: user } = await supabase.from("users").select(SELECT_USER).eq("id", userId).single();
    const segUser = (user ?? {}) as SegmentUser;

    // 3. Bu kullanıcının ilgili mesajlara ait event'leri (frekans state)
    const ids = active.map((m) => m.id);
    const { data: evs } = await supabase
      .from("page_message_events")
      .select("page_message_id, event, created_at")
      .eq("user_id", userId)
      .in("page_message_id", ids);
    const byMsg = new Map<string, PmEvent[]>();
    for (const e of evs ?? []) {
      const arr = byMsg.get(e.page_message_id) ?? [];
      arr.push({ event: e.event, created_at: e.created_at });
      byMsg.set(e.page_message_id, arr);
    }

    // 4. Segment + frekans filtrele, public alanlara indir
    return active
      .filter((m) => segmentService.matchesSegment(segUser, (m.segment ?? null) as SegmentInput | null))
      .filter((m) => passesFrequency(m.frequency, byMsg.get(m.id) ?? []))
      .map((m): PublicPageMessage => ({
        id: m.id, page: m.page, display_type: m.display_type,
        content: m.content, image_url: m.image_url,
        action_url: m.action_url, frequency: m.frequency, priority: m.priority,
      }));
  }

  async recordEvent(userId: string, messageId: string, event: EventType): Promise<void> {
    // Eligibility: mesaj aktif mi? (spec T4 — görmediği mesaja event engeli)
    const { data: msg } = await supabase
      .from("page_messages").select("id").eq("id", messageId).eq("is_active", true).single();
    if (!msg) return;
    await supabase.from("page_message_events").insert({ page_message_id: messageId, user_id: userId, event });
  }

  // ── Admin CRUD ──
  async list(page: number, limit = 20) {
    const from = (page - 1) * limit;
    const { data, count, error } = await supabase
      .from("page_messages").select("*", { count: "exact" })
      .order("created_at", { ascending: false }).range(from, from + limit - 1);
    if (error) throw error;
    return { messages: data ?? [], total: count ?? 0 };
  }
  async getById(id: string) {
    const { data, error } = await supabase.from("page_messages").select("*").eq("id", id).single();
    if (error) throw error;
    return data;
  }
  async create(input: CreatePageMessageInput, adminId: string) {
    const { data, error } = await supabase.from("page_messages")
      .insert({ ...input, created_by: adminId }).select("*").single();
    if (error) throw error;
    return data;
  }
  async update(id: string, input: CreatePageMessageInput) {
    const { error } = await supabase.from("page_messages")
      .update({ ...input, updated_at: new Date().toISOString() }).eq("id", id);
    if (error) throw error;
  }
  async toggleActive(id: string) {
    const cur = await this.getById(id);
    const { error } = await supabase.from("page_messages")
      .update({ is_active: !cur.is_active, updated_at: new Date().toISOString() }).eq("id", id);
    if (error) throw error;
  }
  async remove(id: string) {
    const { error } = await supabase.from("page_messages").delete().eq("id", id);
    if (error) throw error;
  }

  // ── Analitik (on-the-fly aggregate) ──
  async getStats(messageId: string) {
    const { data, error } = await supabase
      .from("page_message_events").select("event, user_id").eq("page_message_id", messageId);
    if (error) throw error;
    const rows = data ?? [];
    const uniq = (ev: string) => new Set(rows.filter((r) => r.event === ev).map((r) => r.user_id)).size;
    const total = (ev: string) => rows.filter((r) => r.event === ev).length;
    const shown = uniq("shown");
    const clicked = uniq("clicked");
    return {
      shown_total: total("shown"), shown_unique: shown,
      clicked_unique: clicked, dismissed_unique: uniq("dismissed"),
      ctr: shown > 0 ? Math.round((clicked / shown) * 1000) / 10 : 0,
    };
  }
}

export const pageMessageService = new PageMessageService();
```

- [ ] **Step 4: Test pass etmeli** — Run: `npx vitest run src/__tests__/page-message.frequency.test.ts`
Expected: PASS (5 test).

- [ ] **Step 5: Build doğrula** — Run: `npm run build`
Expected: tsc hatasız.

- [ ] **Step 6: Commit**

```bash
git add src/services/page-message.service.ts src/__tests__/page-message.frequency.test.ts
git commit -m "feat(service): page-message CRUD + getActiveForUser frekans filtre + getStats"
```

---

### Task 5: Mobile API — controller + routes + mount

**Files:**
- Create: `qulo-server/src/controllers/page-message.controller.ts`
- Create: `qulo-server/src/routes/page-message.routes.ts`
- Modify: `qulo-server/src/index.ts`

**Interfaces:**
- Consumes: `pageMessageService`, `authMiddleware`, `generalLimiter`, `validate`, `eventSchema`.
- Produces: `GET /api/v1/page-messages` → `{ messages: PublicPageMessage[] }`; `POST /api/v1/page-messages/:id/event` → `{ ok: true }`.

- [ ] **Step 1: page-message.controller.ts'i yaz**

```typescript
import type { Request, Response, NextFunction } from "express";
import { pageMessageService, type EventType } from "../services/page-message.service.js";

export async function getPageMessagesHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const messages = await pageMessageService.getActiveForUser(req.user!.userId);
    res.json({ messages });
  } catch (err) { next(err); }
}

export async function postPageMessageEventHandler(req: Request, res: Response, next: NextFunction) {
  try {
    await pageMessageService.recordEvent(req.user!.userId, req.params.id, (req.body.event as EventType));
    res.json({ ok: true });
  } catch (err) { next(err); }
}
```

- [ ] **Step 2: page-message.routes.ts'i yaz**

```typescript
import { Router } from "express";
import { authMiddleware } from "../middleware/auth.js";
import { generalLimiter } from "../middleware/rateLimit.js";
import { validate } from "../middleware/validate.js";
import { eventSchema } from "../validators/page-message.validator.js";
import { getPageMessagesHandler, postPageMessageEventHandler } from "../controllers/page-message.controller.js";

const router = Router();
router.use(authMiddleware, generalLimiter);

router.get("/", getPageMessagesHandler);
router.post("/:id/event", validate(eventSchema), postPageMessageEventHandler);

export default router;
```

- [ ] **Step 3: index.ts'e mount et**

Import bölümüne (diğer route import'larının yanına):
```typescript
import pageMessageRoutes from "./routes/page-message.routes.js";
```
API v1 mount bölümüne (`app.use("/api/v1/notifications", ...)` yakınına):
```typescript
app.use("/api/v1/page-messages", pageMessageRoutes);
```

- [ ] **Step 4: Build + dev server smoke test**

Run: `npm run build`
Expected: tsc hatasız.
Run (ayrı terminal): `npm run dev` → server başlar. Sonra:
```bash
# token gerektirir; en azından auth 401 dönmeli (route mount edildi):
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/v1/page-messages
```
Expected: `401` (route var, auth yok) — `404` DEĞİL.

- [ ] **Step 5: Commit**

```bash
git add src/controllers/page-message.controller.ts src/routes/page-message.routes.ts src/index.ts
git commit -m "feat(api): mobile page-messages GET + event POST endpoint'leri"
```

---

### Task 6: Admin paneli — controller + routes + EJS view'lar

**Files:**
- Create: `qulo-server/src/admin/page-message.admin.controller.ts`
- Create: `qulo-server/src/admin/views/page-messages-list.ejs`
- Create: `qulo-server/src/admin/views/page-messages-edit.ejs`
- Modify: `qulo-server/src/admin/admin.routes.ts`

**Interfaces:**
- Consumes: `pageMessageService`, `segmentService.previewSegmentCount`, `createPageMessageSchema`, `SUPPORTED_LOCALES`, `LOCALE_NAMES`, `PAGE_KEYS`, admin middleware (`adminAuth`, `csrfValidate`).

- [ ] **Step 1: page-message.admin.controller.ts'i yaz**

```typescript
import type { Request, Response } from "express";
import { pageMessageService } from "../services/page-message.service.js";
import { segmentService } from "../services/segment.service.js";
import { createPageMessageSchema } from "../validators/page-message.validator.js";
import { SUPPORTED_LOCALES, LOCALE_NAMES } from "../constants/locales.js";
import { PAGE_KEYS } from "../constants/page-keys.js";

function parseSegment(b: Record<string, string>) {
  const s: Record<string, unknown> = {};
  if (b.segment_gender) s.gender = b.segment_gender;
  if (b.segment_age_min) s.age_min = parseInt(b.segment_age_min);
  if (b.segment_age_max) s.age_max = parseInt(b.segment_age_max);
  if (b.segment_cities) s.cities = b.segment_cities.split(",").map((c) => c.trim()).filter(Boolean);
  if (b.segment_subscription) s.subscription_plan = b.segment_subscription;
  if (b.segment_is_premium) s.is_premium = b.segment_is_premium === "true";
  if (b.segment_question_count_max) s.question_count_max = parseInt(b.segment_question_count_max);
  if (b.segment_has_match) s.has_match = b.segment_has_match === "true";
  return s;
}

function parseContent(b: Record<string, string>) {
  const c: Record<string, { title: string; body: string; cta_label: string }> = {};
  for (const l of SUPPORTED_LOCALES) {
    c[l] = { title: b[`title_${l}`] ?? "", body: b[`body_${l}`] ?? "", cta_label: b[`cta_${l}`] ?? "" };
  }
  return c;
}

class PageMessageAdminController {
  async list(req: Request, res: Response) {
    const page = Math.max(1, parseInt(req.query.page as string) || 1);
    const { messages, total } = await pageMessageService.list(page);
    res.render("page-messages-list", { messages, page, totalPages: Math.ceil(total / 20), total, session: req.session });
  }

  async newForm(req: Request, res: Response) {
    res.render("page-messages-edit", { message: null, locales: SUPPORTED_LOCALES, localeNames: LOCALE_NAMES, pages: PAGE_KEYS, session: req.session });
  }

  async editForm(req: Request, res: Response) {
    const message = await pageMessageService.getById(req.params.id);
    res.render("page-messages-edit", { message, locales: SUPPORTED_LOCALES, localeNames: LOCALE_NAMES, pages: PAGE_KEYS, session: req.session });
  }

  async create(req: Request, res: Response) {
    const input = { ...req.body, content: parseContent(req.body), segment: parseSegment(req.body),
      priority: parseInt(req.body.priority) || 0, is_active: req.body.is_active === "on" };
    const parsed = createPageMessageSchema.safeParse(input);
    if (!parsed.success) {
      req.session.pageMessageError = JSON.stringify(parsed.error.flatten().fieldErrors);
      return res.redirect("/admin/page-messages/new");
    }
    await pageMessageService.create(parsed.data, req.session.adminId!);
    res.redirect("/admin/page-messages");
  }

  async update(req: Request, res: Response) {
    const input = { ...req.body, content: parseContent(req.body), segment: parseSegment(req.body),
      priority: parseInt(req.body.priority) || 0, is_active: req.body.is_active === "on" };
    const parsed = createPageMessageSchema.safeParse(input);
    if (!parsed.success) {
      req.session.pageMessageError = JSON.stringify(parsed.error.flatten().fieldErrors);
      return res.redirect(`/admin/page-messages/${req.params.id}`);
    }
    await pageMessageService.update(req.params.id, parsed.data);
    res.redirect("/admin/page-messages");
  }

  async toggle(req: Request, res: Response) {
    await pageMessageService.toggleActive(req.params.id);
    res.redirect("/admin/page-messages");
  }

  async remove(req: Request, res: Response) {
    await pageMessageService.remove(req.params.id);
    res.json({ ok: true });
  }

  async previewSegment(req: Request, res: Response) {
    const count = await segmentService.previewSegmentCount(parseSegment(req.body));
    res.json({ count });
  }
}
export const pageMessageAdminController = new PageMessageAdminController();
```

- [ ] **Step 2: page-messages-list.ejs'i yaz** (campaigns.ejs stilini izle)

```html
<%- include('_header') %>
<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
  <h2>Sayfa Mesajları (<%= total %>)</h2>
  <a href="/admin/page-messages/new" class="btn btn-primary">+ Yeni Mesaj</a>
</div>
<table class="table">
  <thead><tr><th>Başlık</th><th>Sayfa</th><th>Format</th><th>Frekans</th><th>Öncelik</th><th>Durum</th><th></th></tr></thead>
  <tbody>
    <% messages.forEach((m) => { %>
      <tr>
        <td><%= m.title %></td>
        <td><%= m.page %></td>
        <td><%= m.display_type %></td>
        <td><%= m.frequency %></td>
        <td><%= m.priority %></td>
        <td><%= m.is_active ? '✅ Aktif' : '⛔ Pasif' %></td>
        <td>
          <a href="/admin/page-messages/<%= m.id %>" class="btn">Düzenle</a>
          <form method="post" action="/admin/page-messages/<%= m.id %>/toggle" style="display:inline;">
            <input type="hidden" name="_csrf" value="<%= session.csrfToken %>" />
            <button class="btn"><%= m.is_active ? 'Pasifleştir' : 'Aktifleştir' %></button>
          </form>
        </td>
      </tr>
    <% }); %>
  </tbody>
</table>
<%- include('_footer') %>
```

- [ ] **Step 3: page-messages-edit.ejs'i yaz** (push-messages-edit + campaign-new birleşik; 16 dil + segment)

```html
<%- include('_header') %>
<% const c = (l,f) => message && message.content && message.content[l] ? (message.content[l][f] || '') : ''; %>
<a href="/admin/page-messages" class="btn" style="background:#e5e7eb;color:#333;">← Geri</a>
<h2><%= message ? 'Mesajı Düzenle' : 'Yeni Mesaj' %></h2>
<% if (session.pageMessageError) { %>
  <div style="color:#b91c1c;"><%= session.pageMessageError %></div>
  <% session.pageMessageError = null; %>
<% } %>
<form method="post" action="<%= message ? '/admin/page-messages/' + message.id : '/admin/page-messages' %>">
  <input type="hidden" name="_csrf" value="<%= session.csrfToken %>" />
  <div class="card">
    <h3>Genel</h3>
    <label>Admin başlığı (iç)</label>
    <input name="title" value="<%= message ? message.title : '' %>" required />
    <label>Sayfa</label>
    <select name="page"><% pages.forEach((p) => { %><option value="<%= p %>" <%= message && message.page===p?'selected':'' %>><%= p %></option><% }); %></select>
    <label>Format</label>
    <select name="display_type">
      <% ['banner','bottom_sheet','modal','inline_card'].forEach((d) => { %>
        <option value="<%= d %>" <%= message && message.display_type===d?'selected':'' %>><%= d %></option><% }); %>
    </select>
    <label>Frekans</label>
    <select name="frequency">
      <% ['once','every_visit','until_dismissed','daily'].forEach((f) => { %>
        <option value="<%= f %>" <%= message && message.frequency===f?'selected':'' %>><%= f %></option><% }); %>
    </select>
    <label>Öncelik</label>
    <input type="number" name="priority" value="<%= message ? message.priority : 0 %>" />
    <label>Görsel URL (https)</label>
    <input name="image_url" value="<%= message ? (message.image_url||'') : '' %>" />
    <label>Yönlendirme (action_url — /discover veya https://quloapp.com/...)</label>
    <input name="action_url" value="<%= message ? (message.action_url||'') : '' %>" />
    <label><input type="checkbox" name="is_active" <%= !message || message.is_active ? 'checked' : '' %> /> Aktif</label>
  </div>

  <div class="card">
    <h3>İçerik (16 dil — hepsi zorunlu)</h3>
    <% locales.forEach((l) => { %>
      <fieldset style="border:1px solid #ddd;margin:8px 0;padding:8px;">
        <legend><%= localeNames[l] %> (<%= l %>)</legend>
        <input name="title_<%= l %>" placeholder="Başlık" value="<%= c(l,'title') %>" required />
        <textarea name="body_<%= l %>" placeholder="Metin" required><%= c(l,'body') %></textarea>
        <input name="cta_<%= l %>" placeholder="Buton metni (ops.)" value="<%= c(l,'cta_label') %>" />
      </fieldset>
    <% }); %>
  </div>

  <div class="card">
    <h3>Segment (boş = herkes)</h3>
    <% const seg = message && message.segment ? message.segment : {}; %>
    <label>Cinsiyet</label>
    <select name="segment_gender"><option value="">—</option>
      <option value="MAN" <%= seg.gender==='MAN'?'selected':'' %>>MAN</option>
      <option value="WOMAN" <%= seg.gender==='WOMAN'?'selected':'' %>>WOMAN</option></select>
    <label>Yaş min/max</label>
    <input type="number" name="segment_age_min" value="<%= seg.age_min||'' %>" />
    <input type="number" name="segment_age_max" value="<%= seg.age_max||'' %>" />
    <label>Şehirler (virgülle)</label>
    <input name="segment_cities" value="<%= seg.cities ? seg.cities.join(', ') : '' %>" />
    <label>Premium?</label>
    <select name="segment_is_premium"><option value="">—</option>
      <option value="true" <%= seg.is_premium===true?'selected':'' %>>Evet</option>
      <option value="false" <%= seg.is_premium===false?'selected':'' %>>Hayır</option></select>
    <label>Maks. soru sayısı (0 = hiç soru yok)</label>
    <input type="number" name="segment_question_count_max" value="<%= seg.question_count_max ?? '' %>" />
    <label>Eşleşmesi var mı?</label>
    <select name="segment_has_match"><option value="">—</option>
      <option value="true" <%= seg.has_match===true?'selected':'' %>>Evet</option>
      <option value="false" <%= seg.has_match===false?'selected':'' %>>Hayır</option></select>
    <button type="button" id="previewBtn" class="btn">Segment önizle</button>
    <span id="previewCount"></span>
  </div>

  <button type="submit" class="btn btn-primary"><%= message ? 'Güncelle' : 'Oluştur' %></button>
</form>
<script>
  document.getElementById('previewBtn').addEventListener('click', async () => {
    const fd = new FormData(document.querySelector('form'));
    const body = {}; for (const [k,v] of fd.entries()) if (k.startsWith('segment_')) body[k]=v;
    body._csrf = '<%= session.csrfToken %>';
    const r = await fetch('/admin/page-messages/preview-segment', {
      method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify(body) });
    const j = await r.json();
    document.getElementById('previewCount').textContent = ' → ' + j.count + ' kişi';
  });
</script>
<%- include('_footer') %>
```

- [ ] **Step 4: admin.routes.ts'e route blokları ekle**

Import bölümüne:
```typescript
import { pageMessageAdminController } from "./page-message.admin.controller.js";
```
Campaign route bloğunun (satır ~76) altına ekle (adminAuth + csrfGenerate zaten `router.use` ile global; POST'lara csrfValidate):
```typescript
router.get("/page-messages", (req, res) => pageMessageAdminController.list(req, res));
router.get("/page-messages/new", (req, res) => pageMessageAdminController.newForm(req, res));
router.post("/page-messages", csrfValidate, (req, res) => pageMessageAdminController.create(req, res));
router.post("/page-messages/preview-segment", csrfValidate, (req, res) => pageMessageAdminController.previewSegment(req, res));
router.get("/page-messages/:id", (req, res) => pageMessageAdminController.editForm(req, res));
router.post("/page-messages/:id", csrfValidate, (req, res) => pageMessageAdminController.update(req, res));
router.post("/page-messages/:id/toggle", csrfValidate, (req, res) => pageMessageAdminController.toggle(req, res));
router.delete("/page-messages/:id", csrfValidate, (req, res) => pageMessageAdminController.remove(req, res));
```

`SessionData` interface'ine `pageMessageError?: string;` ekle (admin.middleware veya tip dosyasında, `campaignError` yanına).

- [ ] **Step 5: Build + manuel admin smoke test**

Run: `npm run build`
Expected: tsc hatasız.
Manuel (dev server + tarayıcı): `/admin/page-messages` listesi açılır, `/admin/page-messages/new` formu 16 dil alanı + segment + önizle butonu gösterir. Bir test mesajı oluştur → liste'de görünür. (DoD: `web-security-review` sonra çalışacak — href whitelist kontrolü.)

- [ ] **Step 6: Commit**

```bash
git add src/admin/page-message.admin.controller.ts src/admin/views/page-messages-list.ejs \
        src/admin/views/page-messages-edit.ejs src/admin/admin.routes.ts
git commit -m "feat(admin): page-messages CRUD paneli (16 dil + segment + önizleme)"
```

- [ ] **Step 7: server-review + web-security-review çalıştır**

`/server-review` (SOLID/security) ve `/web-security-review` (EJS href/XSS) skill'lerini çalıştır; çıkan bulguları düzelt ve commit et.

---

## FAZ B — MOBILE (qulov2)

> Branch: `cd qulov2 && git checkout -b feat/page-messages`. Faz B, Faz A backend'i deploy/çalışır olunca başlar (gerçek API'ye karşı doğrulama).

### Task 7: PageMessageModel + codegen + parsing testi

**Files:**
- Create: `qulov2/lib/features/page_messages/data/models/page_message_model.dart`
- Create: `qulov2/test/models/page_message_model_test.dart`

**Interfaces:**
- Produces: `PageMessageModel { id, page, displayType, content: Map<String,LocaleContent>, imageUrl?, actionUrl?, frequency, priority }`, `LocaleContent { title, body, ctaLabel }`, `localized(String locale): LocaleContent` (fallback 'en').

- [ ] **Step 1: Model dosyasını yaz**

```dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_message_model.g.dart';

@JsonSerializable()
class LocaleContent extends Equatable {
  final String title;
  final String body;
  @JsonKey(name: 'cta_label', defaultValue: '')
  final String ctaLabel;

  const LocaleContent({required this.title, required this.body, this.ctaLabel = ''});

  factory LocaleContent.fromJson(Map<String, dynamic> json) => _$LocaleContentFromJson(json);
  Map<String, dynamic> toJson() => _$LocaleContentToJson(this);

  @override
  List<Object?> get props => [title, body, ctaLabel];
}

@JsonSerializable()
class PageMessageModel extends Equatable {
  final String id;
  final String page;
  @JsonKey(name: 'display_type')
  final String displayType;
  final Map<String, LocaleContent> content;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'action_url')
  final String? actionUrl;
  final String frequency;
  final int priority;

  const PageMessageModel({
    required this.id,
    required this.page,
    required this.displayType,
    required this.content,
    this.imageUrl,
    this.actionUrl,
    required this.frequency,
    required this.priority,
  });

  /// Mevcut locale içeriği; yoksa 'en'; o da yoksa ilk mevcut.
  LocaleContent localized(String locale) =>
      content[locale] ?? content['en'] ?? content.values.first;

  factory PageMessageModel.fromJson(Map<String, dynamic> json) => _$PageMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageMessageModelToJson(this);

  @override
  List<Object?> get props => [id, page, displayType, content, imageUrl, actionUrl, frequency, priority];
}
```

- [ ] **Step 2: Codegen çalıştır**

Run: `cd qulov2 && dart run build_runner build --delete-conflicting-outputs`
Expected: `page_message_model.g.dart` üretilir, hata yok.

- [ ] **Step 3: Parsing testi yaz** (user_model_test.dart pattern'i)

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:qulov2/features/page_messages/data/models/page_message_model.dart';

void main() {
  test('PageMessageModel parses + localized fallback', () {
    final json = {
      'id': 'm1', 'page': 'discover', 'display_type': 'banner',
      'content': {
        'en': {'title': 'Hi', 'body': 'Welcome', 'cta_label': 'Go'},
        'tr': {'title': 'Merhaba', 'body': 'Hoşgeldin', 'cta_label': 'Git'},
      },
      'image_url': null, 'action_url': '/discover', 'frequency': 'once', 'priority': 5,
    };
    final m = PageMessageModel.fromJson(json);
    expect(m.displayType, 'banner');
    expect(m.localized('tr').title, 'Merhaba');
    expect(m.localized('de').title, 'Hi'); // fallback en
    expect(m.priority, 5);
  });
}
```

- [ ] **Step 4: Test + analyze**

Run: `flutter test test/models/page_message_model_test.dart`
Expected: PASS.
Run: `flutter analyze lib/features/page_messages`
Expected: 0 issue.

- [ ] **Step 5: Commit**

```bash
git add lib/features/page_messages/data/models/ test/models/page_message_model_test.dart
git commit -m "feat(mobile): PageMessageModel + 16 dil content map + localized fallback"
```

---

### Task 8: Retrofit service + repository + provider kaydı

**Files:**
- Create: `qulov2/lib/core/network/services/page_message_service.dart`
- Create: `qulov2/lib/features/page_messages/data/repositories/page_message_repository.dart`
- Modify: `qulov2/lib/providers/api_provider.dart`

**Interfaces:**
- Produces: `PageMessageRetrofitService` (`getMessages()`, `trackEvent(id, body)`); `PageMessageRepository.getMessages(): Future<Result<List<PageMessageModel>>>`, `.trackEvent(id, event): Future<void>`; `pageMessageRepositoryProvider`.

- [ ] **Step 1: Retrofit service'i yaz**

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'page_message_service.g.dart';

@RestApi()
abstract class PageMessageRetrofitService {
  factory PageMessageRetrofitService(Dio dio) = _PageMessageRetrofitService;

  @GET('/page-messages')
  Future<dynamic> getMessages();

  @POST('/page-messages/{id}/event')
  Future<void> trackEvent(@Path('id') String id, @Body() Map<String, dynamic> body);
}
```

- [ ] **Step 2: Repository'yi yaz** (notification_repository pattern)

```dart
import 'package:dio/dio.dart';
import '../../../../core/network/result.dart';
import '../../../../core/network/services/page_message_service.dart';
import '../../../../core/network/dio_error_mapper.dart';
import '../models/page_message_model.dart';

class PageMessageRepository {
  final PageMessageRetrofitService _service;
  PageMessageRepository(this._service);

  Future<Result<List<PageMessageModel>>> getMessages() async {
    try {
      final response = await _service.getMessages();
      final raw = response['messages'];
      if (raw is! List) return const Success([]);
      final list = raw
          .whereType<Map<String, dynamic>>()
          .map(PageMessageModel.fromJson)
          .toList();
      return Success(list);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<void> trackEvent(String id, String event) async {
    try {
      await _service.trackEvent(id, {'event': event});
    } on DioException {
      // event tracking best-effort; sessizce yut
    }
  }
}
```
> NOT: `e.toAppFailure()` extension'ının tam import yolunu mevcut `notification_repository.dart`'tan birebir kopyala (yukarıdaki `dio_error_mapper.dart` yolu örnektir; gerçek yolu doğrula).

- [ ] **Step 3: api_provider.dart'a kaydet** (notification provider'ların yanına)

```dart
final pageMessageRetrofitServiceProvider = Provider<PageMessageRetrofitService>(
  (ref) => PageMessageRetrofitService(ref.read(networkManagerProvider).dio),
);
final pageMessageRepositoryProvider = Provider<PageMessageRepository>(
  (ref) => PageMessageRepository(ref.read(pageMessageRetrofitServiceProvider)),
);
```
(Gerekli import'ları dosyanın başına ekle.)

- [ ] **Step 4: Codegen + analyze**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: `page_message_service.g.dart` üretilir.
Run: `flutter analyze lib/features/page_messages lib/core/network/services/page_message_service.dart lib/providers/api_provider.dart`
Expected: 0 issue.

- [ ] **Step 5: Commit**

```bash
git add lib/core/network/services/page_message_service.dart \
        lib/features/page_messages/data/repositories/ lib/providers/api_provider.dart
git commit -m "feat(mobile): page-message retrofit service + repository + provider kaydı"
```

---

### Task 9: PageMessagesProvider (notifier + state + oturum-içi takip)

**Files:**
- Create: `qulov2/lib/providers/page_messages_provider.dart`

**Interfaces:**
- Produces: `PageMessagesState { messages, shownThisSession }`, `PageMessagesNotifier` (`fetch()`, `consumeForPage(page): PageMessageModel?`, `markShown(id)`, `trackEvent(id, event)`); `pageMessagesProvider`.
- Consumes: `pageMessageRepositoryProvider`.

- [ ] **Step 1: Provider'ı yaz** (notification_provider pattern)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/page_messages/data/models/page_message_model.dart';
import 'api_provider.dart';

class PageMessagesState {
  final List<PageMessageModel> messages;
  final Set<String> shownThisSession;
  const PageMessagesState({this.messages = const [], this.shownThisSession = const {}});

  PageMessagesState copyWith({List<PageMessageModel>? messages, Set<String>? shownThisSession}) =>
      PageMessagesState(
        messages: messages ?? this.messages,
        shownThisSession: shownThisSession ?? this.shownThisSession,
      );
}

class PageMessagesNotifier extends Notifier<PageMessagesState> {
  @override
  PageMessagesState build() => const PageMessagesState();

  Future<void> fetch() async {
    final result = await ref.read(pageMessageRepositoryProvider).getMessages();
    result.when(
      success: (list) => state = state.copyWith(messages: list),
      failure: (_) {}, // sessiz
    );
  }

  /// O sayfa için gösterilmeye uygun en yüksek priority mesaj (oturum-içi tekrar engeli).
  PageMessageModel? consumeForPage(String page) {
    final candidates = state.messages.where((m) {
      if (m.page != page) return false;
      if (m.frequency != 'every_visit' && state.shownThisSession.contains(m.id)) return false;
      return true;
    }).toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));
    return candidates.isEmpty ? null : candidates.first;
  }

  void markShown(String id) {
    state = state.copyWith(shownThisSession: {...state.shownThisSession, id});
    trackEvent(id, 'shown');
  }

  void trackEvent(String id, String event) {
    ref.read(pageMessageRepositoryProvider).trackEvent(id, event);
  }
}

final pageMessagesProvider =
    NotifierProvider<PageMessagesNotifier, PageMessagesState>(PageMessagesNotifier.new);
```

- [ ] **Step 2: analyze**

Run: `flutter analyze lib/providers/page_messages_provider.dart`
Expected: 0 issue.

- [ ] **Step 3: Commit**

```bash
git add lib/providers/page_messages_provider.dart
git commit -m "feat(mobile): PageMessagesNotifier — fetch + sayfa bazlı tüketim + event"
```

---

### Task 10: Ortak içerik + inline/banner görünümü + dispatcher

**Files:**
- Create: `qulov2/lib/features/page_messages/widgets/page_message_content.dart`
- Create: `qulov2/lib/features/page_messages/widgets/page_message_inline_card.dart`
- Create: `qulov2/lib/features/page_messages/widgets/page_message_host.dart`

**Interfaces:**
- Consumes: `PageMessageModel`, `localeProvider`, `AppButton`, `AppSpacing`, `context.appColors`, `NavigationService`, `DeepLinkParser`, `InAppBanner`, `CustomBottomSheet`, `CustomDialog`.
- Produces: `PageMessageContent` (StatelessWidget — title+body+image+CTA), `PageMessageInlineCard`, `PageMessageHost` (ConsumerStatefulWidget — `page` alır).

- [ ] **Step 1: page_message_content.dart'ı yaz** (ortak görünüm; CTA → deep link)

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/navigation/navigation_provider.dart';
import '../../../core/services/deep_link_parser.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/page_messages_provider.dart';
import '../data/models/page_message_model.dart';

class PageMessageContent extends ConsumerWidget {
  final PageMessageModel message;
  final VoidCallback onClose;
  const PageMessageContent({super.key, required this.message, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider).languageCode;
    final c = message.localized(locale);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: CachedNetworkImage(imageUrl: message.imageUrl!, fit: BoxFit.cover),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Text(c.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(c.body, style: Theme.of(context).textTheme.bodyMedium),
        if (c.ctaLabel.isNotEmpty && message.actionUrl != null) ...[
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: c.ctaLabel,
            onPressed: () => _onCta(context, ref),
          ),
        ],
      ],
    );
  }

  void _onCta(BuildContext context, WidgetRef ref) {
    ref.read(pageMessagesProvider.notifier).trackEvent(message.id, 'clicked');
    final url = message.actionUrl;
    if (url != null) {
      // GÜVENLİK: yalnızca parse → navigateDeepLink. handleDeepLink(raw) KULLANILMAZ.
      final result = DeepLinkParser.parse(Uri.parse(
        url.startsWith('/') ? 'https://quloapp.com$url' : url,
      ));
      if (result != null) {
        ref.read(navigationServiceProvider).navigateDeepLink(result);
      }
    }
    onClose();
  }
}
```

- [ ] **Step 2: page_message_inline_card.dart'ı yaz** (gömülü banner/card; kapatılabilir)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../data/models/page_message_model.dart';
import 'page_message_content.dart';

class PageMessageInlineCard extends ConsumerWidget {
  final PageMessageModel message;
  final VoidCallback onDismiss;
  const PageMessageInlineCard({super.key, required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: context.appColors.primary.withValues(alpha: 0.15)),
      ),
      child: Stack(
        children: [
          PageMessageContent(message: message, onClose: onDismiss),
          Positioned(
            right: 0, top: 0,
            child: GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 18, color: context.appColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
```
> NOT: `context.appColors.surfaceElevated`/`textSecondary` alan adlarını `app_colors.dart`'tan doğrula; yoksa en yakın mevcut alanı kullan.

- [ ] **Step 3: page_message_host.dart'ı yaz** (dispatcher: display_type → format)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/navigation/models/app_bottom_sheet.dart';
import '../../../core/navigation/models/app_dialog.dart';
import '../../../core/navigation/navigation_provider.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../providers/page_messages_provider.dart';
import '../data/models/page_message_model.dart';
import 'page_message_content.dart';
import 'page_message_inline_card.dart';

/// Bir sayfaya gömülür; o sayfanın uygun mesajını display_type'a göre gösterir.
/// inline/banner → child olarak döner; bottom_sheet/modal → overlay açar.
class PageMessageHost extends ConsumerStatefulWidget {
  final String page;
  const PageMessageHost({super.key, required this.page});

  @override
  ConsumerState<PageMessageHost> createState() => _PageMessageHostState();
}

class _PageMessageHostState extends ConsumerState<PageMessageHost> {
  PageMessageModel? _inline;
  bool _dispatched = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _dispatch());
  }

  void _dispatch() {
    if (_dispatched) return;
    final msg = ref.read(pageMessagesProvider.notifier).consumeForPage(widget.page);
    if (msg == null) return;
    _dispatched = true;
    ref.read(pageMessagesProvider.notifier).markShown(msg.id);

    switch (msg.displayType) {
      case 'inline_card':
      case 'banner':
        setState(() => _inline = msg);
      case 'bottom_sheet':
        ref.read(navigationServiceProvider).showAppBottomSheet(CustomBottomSheet(
          name: 'page_message_${msg.id}',
          builder: (_) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: PageMessageContent(message: msg, onClose: () => ref.read(navigationServiceProvider).closeOverlay()),
          ),
        ));
      case 'modal':
        ref.read(navigationServiceProvider).showAppDialog(CustomDialog(
          name: 'page_message_${msg.id}',
          builder: (_) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: PageMessageContent(message: msg, onClose: () => ref.read(navigationServiceProvider).closeOverlay()),
          ),
        ));
    }
  }

  void _dismissInline() {
    final id = _inline?.id;
    if (id != null) ref.read(pageMessagesProvider.notifier).trackEvent(id, 'dismissed');
    setState(() => _inline = null);
  }

  @override
  Widget build(BuildContext context) {
    if (_inline == null) return const SizedBox.shrink();
    return PageMessageInlineCard(message: _inline!, onDismiss: _dismissInline);
  }
}
```
> NOT: `closeOverlay()` mevcut imzayı `navigation_service.dart`'tan doğrula (overlay kapatma metodu). `showAppBottomSheet`/`showAppDialog` çağrıları mevcut imzalarla birebir.

- [ ] **Step 4: analyze**

Run: `flutter analyze lib/features/page_messages`
Expected: 0 issue. (Alan adı/metod uyuşmazlığı çıkarsa Step 2/3 NOT'larına göre düzelt.)

- [ ] **Step 5: Commit**

```bash
git add lib/features/page_messages/widgets/
git commit -m "feat(mobile): page-message dispatcher (host) + içerik + inline card; CTA güvenli deep link"
```

---

### Task 11: Entegrasyon — fetch tetikleme + hedef sayfalara host

**Files:**
- Modify: `qulov2/lib/app.dart`
- Modify: hedef screen'ler (en az `discover` + `profile`)

**Interfaces:**
- Consumes: `pageMessagesProvider`, `PageMessageHost`, `authProvider`.

- [ ] **Step 1: app.dart — login/resume'da fetch**

`didChangeAppLifecycleState` resumed bloğunda, `authenticated` kontrolü içine ekle:
```dart
ref.read(pageMessagesProvider.notifier).fetch();
```
Ayrıca ilk authenticated yüklemede (mevcut `notificationProvider.init()` gibi bir başlatma noktası varsa onun yanında) bir kez `fetch()` çağır.

- [ ] **Step 2: discover screen'e host ekle**

Discover ekranının body'sinin üstüne (liste başında / Column'un ilk child'ı olarak), CLAUDE.md "ayrı widget" kuralına uygun:
```dart
const PageMessageHost(page: 'discover'),
```
inline/banner mesajlar burada görünür; bottom_sheet/modal overlay olarak açılır.

- [ ] **Step 3: profile screen'e host ekle**

```dart
const PageMessageHost(page: 'profile'),
```

- [ ] **Step 4: analyze + manuel run**

Run: `flutter analyze`
Expected: 0 issue (tüm proje).
Manuel: Backend'de `discover` için bir test mesajı oluştur (admin), uygulamayı çalıştır, discover'a gir → mesaj görünür. Her format için (banner/sheet/modal/inline) bir test mesajı ile doğrula. CTA → doğru sayfaya yönlendirir. Kapat → tekrar görünmez (frekans=once).

- [ ] **Step 5: Commit**

```bash
git add lib/app.dart lib/features/discover lib/features/profile
git commit -m "feat(mobile): page-message fetch (login/resume) + discover & profile host entegrasyonu"
```

---

### Task 12: Mobile statik i18n + flutter-review

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/*.dart` (16)

- [ ] **Step 1: Statik UI key'leri ekle** (sadece widget şablonu kullanıyorsa; çoğu metin server'dan gelir)

Eğer host/inline card'da sabit metin varsa (örn. yok — kapat ikonu metinsiz). Gerekli key çıkarsa `en.dart` + `tr.dart`'a ekle, sonra `/i18n-guardian` ile 16 dile yay. Aksi halde bu task no-op olabilir; yine de kontrol et.

- [ ] **Step 2: i18n-guardian + flutter-review**

`/i18n-guardian` (16 dil senkron) ve `/flutter-review` (screen limiti, widget extraction, hardcode, reuse) skill'lerini çalıştır; bulguları düzelt.

- [ ] **Step 3: owasp-security**

`/owasp-security` skill'i ile mobile güvenlik (deep link, content render) doğrula — spec §11 T1 (CTA yalnız parse→navigateDeepLink) teyit et.

- [ ] **Step 4: Final analyze + commit**

Run: `flutter analyze`
Expected: 0 issue.
```bash
git add -A
git commit -m "chore(mobile): page-message i18n + review düzeltmeleri"
```

---

## Self-Review (yazar kontrolü)

**Spec coverage:**
- §4 şema → Task 1 ✓ · §5.1 segment → Task 2 ✓ · §5.5 validator → Task 3 ✓ · §5.2 servis + §7 analitik → Task 4 (getStats) ✓ · §5.3 mobile API → Task 5 ✓ · §5.4 admin → Task 6 ✓ · §6 mobile → Task 7-11 ✓ · §11 güvenlik → Task 3 (whitelist), Task 4 (T4/T5), Task 10 (T1 CTA), Task 6/12 (review) ✓ · §8 fazlama: Faz 1 kapsandı; Faz 2 (JOIN'li davranışsal, dönüşüm) bu planda YOK (kasıtlı).
- **Gap:** `getStats`'ı admin panelde gösteren bir görünüm Task 6'da eksik. → Task 6 EJS edit/detay sayfasına stats bölümü eklenebilir; MVP için `getStats` servis hazır, admin gösterimi küçük bir ek (edit sayfasında mevcut mesaj için stats fetch). Not düşüldü: **Task 6 Step 3'e**, `message` varsa `getStats` sonucunu gösteren küçük bir blok eklenebilir (opsiyonel, CTR/gösterim).

**Placeholder scan:** Kod adımlarında gerçek kod var. `notification_repository`'deki `e.toAppFailure()` import yolu ve `context.appColors` alan adları için doğrulama NOT'ları bırakıldı (mevcut koddan teyit) — bunlar placeholder değil, mevcut-kod-doğrulama uyarıları.

**Type consistency:** `SegmentInput`, `SegmentUser`, `PublicPageMessage`, `PageMessageModel`, `LocaleContent`, `passesFrequency`, `matchesSegment`, `consumeForPage`, `markShown`/`trackEvent` adları tasklar arası tutarlı. `frequency`/`display_type` değer enum'ları server (validator) ve mobile (consumeForPage `'every_visit'`) arasında aynı string'ler.

**Düzeltme (inline):** Task 6'ya admin stats gösterimi opsiyonel olarak işaretlendi; Faz 2 (JOIN davranışsal + dönüşüm) bilinçli olarak kapsam dışı.
