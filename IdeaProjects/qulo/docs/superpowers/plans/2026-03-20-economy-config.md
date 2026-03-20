# Economy Config System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Hardcoded ekonomi sabitlerini sunucu-tarafı config tablosuna taşıyıp, admin panelden yönetilebilir, versiyonlanmış bir ekonomi sistemi kurmak.

**Architecture:** Tek JSONB sütunlu `economy_config_versions` tablosu atomik versiyonlama sağlar. Server'da `EconomyConfigService` 5dk TTL in-memory cache ile config'i yönetir, Zod schema ile doğrular. Flutter'da `EconomyConfigNotifier` startup'ta config'i çeker, SharedPreferences'a cache'ler, API yoksa fallback kullanır.

**Tech Stack:** Node.js/Express/TypeScript, Zod, Supabase PostgreSQL, Flutter/Riverpod, SharedPreferences, EJS admin panel

**Spec:** `docs/superpowers/specs/2026-03-20-economy-config-design.md`

---

## File Map

### Server — New Files
| File | Responsibility |
|------|---------------|
| `qulo-server/migrations/020_economy_config.sql` | Tablo + v1 seed |
| `qulo-server/src/services/economy-config.service.ts` | Config CRUD, cache, validation |
| `qulo-server/src/types/economy-config.schema.ts` | Zod schema + TypeScript types |
| `qulo-server/src/admin/views/economy-config.ejs` | Admin edit form |
| `qulo-server/src/admin/views/economy-config-history.ejs` | Version history |
| `qulo-server/src/admin/views/economy-config-compare.ejs` | Version diff |

### Server — Modified Files
| File | Change |
|------|--------|
| `qulo-server/src/types/index.ts` | 5 sabit kaldırılır |
| `qulo-server/src/utils/math.ts` | Config parametre injection |
| `qulo-server/src/services/exchange.service.ts` | `GREEN_TO_PURPLE_RATIO` → config |
| `qulo-server/src/services/quiz.service.ts` | Multipliers + reward ratio → config |
| `qulo-server/src/services/user.service.ts` | Boost cost/duration → config |
| `qulo-server/src/services/referral.service.ts` | `REFERRAL_REWARD` → config |
| `qulo-server/src/services/chat-question.service.ts` | `CHAT_QUESTION_LIMITS` → config |
| `qulo-server/src/services/subscription.service.ts` | `SUBSCRIPTION_LIMITS` → config |
| `qulo-server/src/routes/app.routes.ts` | Economy endpoint eklenir |
| `qulo-server/src/controllers/app.controller.ts` | Economy handler eklenir |
| `qulo-server/src/admin/admin.routes.ts` | 4 yeni admin route |
| `qulo-server/src/admin/admin.controller.ts` | 4 yeni controller method |

### Flutter — New Files
| File | Responsibility |
|------|---------------|
| `qulov2/lib/data/models/economy_config_model.dart` | Config model + sub-models |
| `qulov2/lib/providers/economy_config_provider.dart` | Notifier + SharedPreferences cache |

### Flutter — Modified Files
| File | Change |
|------|--------|
| `qulov2/lib/core/network/services/app_config_service.dart` | Economy endpoint eklenir |
| `qulov2/lib/data/repositories/app_config_repository.dart` | Economy fetch metodu |
| `qulov2/lib/providers/api_provider.dart` | Economy provider registration |
| `qulov2/lib/features/splash/splash_screen.dart` | Economy fetch startup'a eklenir |
| `qulov2/lib/core/constants/app_constants.dart` | Ekonomi sabitleri silinir |
| `qulov2/lib/data/models/subscription_model.dart` | Computed getters kaldırılır |
| `qulov2/lib/data/models/daily_stats_model.dart` | Fallback'ler config'den |
| `qulov2/lib/providers/daily_stats_provider.dart` | Fallback'ler config'den |
| `qulov2/lib/features/quiz/mixins/quiz_screen_mixin.dart` | Fallback 20 → config |
| `qulov2/lib/features/exchange/widgets/convert_section.dart` | Fallback 3 → config |
| `qulov2/lib/features/diamonds/widgets/paywall_bottom_sheet.dart` | 500/1500 → config |
| `qulov2/lib/features/profile/mixins/edit_profile_screen_mixin.dart` | Milestones → config |
| `qulov2/lib/features/diamonds/screens/diamonds_screen.dart` | Referral 25 → config |

---

## FAZ 1 — Server Tarafı

### Task 1: Migration — Tablo + Seed

**Files:**
- Create: `qulo-server/migrations/020_economy_config.sql`

- [ ] **Step 1: Migration SQL dosyasını yaz**

```sql
-- 020_economy_config.sql
-- Economy config versioning table

CREATE TABLE economy_config_versions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  version INT NOT NULL,
  config JSONB NOT NULL,
  is_active BOOLEAN DEFAULT false,
  changed_by UUID REFERENCES admin_users(id) ON DELETE SET NULL,
  change_reason TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_active_economy_config
  ON economy_config_versions(is_active) WHERE is_active = true;

-- Seed v1 with current hardcoded values
-- RPC function for atomic version activation (transaction-safe)
CREATE OR REPLACE FUNCTION create_economy_config_version(
  p_version INT,
  p_config JSONB,
  p_changed_by UUID,
  p_change_reason TEXT
) RETURNS economy_config_versions AS $$
DECLARE
  result economy_config_versions;
BEGIN
  UPDATE economy_config_versions SET is_active = false WHERE is_active = true;

  INSERT INTO economy_config_versions (version, config, is_active, changed_by, change_reason)
  VALUES (p_version, p_config, true, p_changed_by, p_change_reason)
  RETURNING * INTO result;

  RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Seed v1 with current hardcoded values
INSERT INTO economy_config_versions (version, config, is_active, change_reason)
VALUES (1, '{
  "core": {
    "boostCostGreen": 30,
    "boostDurationMinutes": 30,
    "greenDiamondRewardRatio": 0.30,
    "greenToPurpleRatio": 3,
    "questionCountMultipliers": {
      "2": 0.5,
      "3": 0.75,
      "4": 1.0,
      "5": 1.25,
      "6": 1.5
    }
  },
  "subscriptionLimits": {
    "free": {
      "dailyDiscovers": 50,
      "maxQuestions": 4,
      "dailyUndos": 0,
      "monthlyPurpleBonus": 0,
      "chatQuestionDaily": 2,
      "chatQuestionUnmatchRisk": 1,
      "passportMode": false,
      "hasAds": true
    },
    "plus": {
      "dailyDiscovers": 999999,
      "maxQuestions": 6,
      "dailyUndos": 3,
      "monthlyPurpleBonus": 500,
      "chatQuestionDaily": 5,
      "chatQuestionUnmatchRisk": 2,
      "passportMode": false,
      "hasAds": false
    },
    "premium": {
      "dailyDiscovers": 999999,
      "maxQuestions": 10,
      "dailyUndos": 999999,
      "monthlyPurpleBonus": 1500,
      "chatQuestionDaily": 999999,
      "chatQuestionUnmatchRisk": 999999,
      "passportMode": true,
      "hasAds": false
    }
  },
  "rewards": {
    "milestones": {
      "25": 5,
      "50": 15,
      "75": 30,
      "100": 50
    },
    "referralPurple": 25,
    "maxCompletedReferrals": 10
  },
  "timing": {
    "questionTimeSeconds": 30,
    "timeExtendSeconds": 15,
    "timePresets": [15, 30, 60, 90]
  }
}'::jsonb, true, 'Initial seed from hardcoded values');
```

- [ ] **Step 2: Supabase SQL Editor'da migration'ı çalıştır**

Run: Supabase Dashboard → SQL Editor → 020_economy_config.sql içeriğini yapıştır → Run

- [ ] **Step 3: Seed'in doğrulandığını kontrol et**

Run (SQL Editor):
```sql
SELECT version, is_active, change_reason, created_at FROM economy_config_versions;
```
Expected: 1 satır, version=1, is_active=true

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add migrations/020_economy_config.sql
git commit -m "feat: add economy_config_versions migration with v1 seed"
```

---

### Task 2: Zod Schema + TypeScript Types

**Files:**
- Create: `qulo-server/src/types/economy-config.schema.ts`

- [ ] **Step 1: Zod schema dosyasını oluştur**

```typescript
// src/types/economy-config.schema.ts
import { z } from "zod";

// ── Boundary Constants (shared with watchdog skill) ──
export const ECONOMY_BOUNDARIES = {
  greenDiamondRewardRatio: { min: 0.10, max: 0.50 },
  boostCostGreen: { min: 5, max: 200 },
  boostDurationMinutes: { min: 5, max: 120 },
  greenToPurpleRatio: { min: 1, max: 10 },
  questionCountMultiplier: { min: 0.1, max: 3.0 },
  questionTimeSeconds: { min: 10, max: 120 },
  timeExtendSeconds: { min: 5, max: 60 },
  referralPurple: { min: 5, max: 100 },
  maxCompletedReferrals: { min: 1, max: 50 },
  // Subscription tier boundaries
  free: {
    dailyDiscovers: { min: 10, max: 200 },
    maxQuestions: { min: 2, max: 6 },
    dailyUndos: { min: 0, max: 5 },
    monthlyPurpleBonus: { min: 0, max: 100 },
    chatQuestionDaily: { min: 1, max: 10 },
    chatQuestionUnmatchRisk: { min: 1, max: 5 },
  },
  plus: {
    monthlyPurpleBonus: { min: 100, max: 2000 },
  },
  premium: {
    monthlyPurpleBonus: { min: 500, max: 5000 },
  },
} as const;

const B = ECONOMY_BOUNDARIES;

// ── Sub-schemas ──
const coreSchema = z.object({
  boostCostGreen: z.number().int().min(B.boostCostGreen.min).max(B.boostCostGreen.max),
  boostDurationMinutes: z.number().int().min(B.boostDurationMinutes.min).max(B.boostDurationMinutes.max),
  greenDiamondRewardRatio: z.number().min(B.greenDiamondRewardRatio.min).max(B.greenDiamondRewardRatio.max),
  greenToPurpleRatio: z.number().int().min(B.greenToPurpleRatio.min).max(B.greenToPurpleRatio.max),
  questionCountMultipliers: z.record(
    z.string(),
    z.number().min(B.questionCountMultiplier.min).max(B.questionCountMultiplier.max),
  ),
});

const tierLimitsSchema = z.object({
  dailyDiscovers: z.number().int().min(0),
  maxQuestions: z.number().int().min(1).max(20),
  dailyUndos: z.number().int().min(0),
  monthlyPurpleBonus: z.number().int().min(0),
  chatQuestionDaily: z.number().int().min(0),
  chatQuestionUnmatchRisk: z.number().int().min(0),
  passportMode: z.boolean(),
  hasAds: z.boolean(),
});

const subscriptionLimitsSchema = z.object({
  free: tierLimitsSchema,
  plus: tierLimitsSchema,
  premium: tierLimitsSchema,
});

const rewardsSchema = z.object({
  milestones: z.record(z.string(), z.number().int().min(0)),
  referralPurple: z.number().int().min(B.referralPurple.min).max(B.referralPurple.max),
  maxCompletedReferrals: z.number().int().min(B.maxCompletedReferrals.min).max(B.maxCompletedReferrals.max),
});

const timingSchema = z.object({
  questionTimeSeconds: z.number().int().min(B.questionTimeSeconds.min).max(B.questionTimeSeconds.max),
  timeExtendSeconds: z.number().int().min(B.timeExtendSeconds.min).max(B.timeExtendSeconds.max),
  timePresets: z.array(z.number().int().min(5).max(300)),
});

// ── Main schema ──
export const economyConfigSchema = z.object({
  core: coreSchema,
  subscriptionLimits: subscriptionLimitsSchema,
  rewards: rewardsSchema,
  timing: timingSchema,
});

// ── TypeScript types (inferred from Zod) ──
export type EconomyConfig = z.infer<typeof economyConfigSchema>;
export type EconomyCore = z.infer<typeof coreSchema>;
export type TierLimits = z.infer<typeof tierLimitsSchema>;
export type SubscriptionLimitsConfig = z.infer<typeof subscriptionLimitsSchema>;
export type RewardsConfig = z.infer<typeof rewardsSchema>;
export type TimingConfig = z.infer<typeof timingSchema>;

export interface EconomyConfigVersion {
  id: string;
  version: number;
  config: EconomyConfig;
  is_active: boolean;
  changed_by: string | null;
  change_reason: string;
  created_at: string;
}

export interface ConfigDiff {
  v1: number;
  v2: number;
  changes: Array<{
    path: string;
    oldValue: unknown;
    newValue: unknown;
  }>;
}
```

- [ ] **Step 2: Dosyanın TypeScript hatası olmadığını doğrula**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit src/types/economy-config.schema.ts`
Expected: Hata yok

- [ ] **Step 3: Commit**

```bash
git add src/types/economy-config.schema.ts
git commit -m "feat: add Zod schema and types for economy config"
```

---

### Task 3: EconomyConfigService

**Files:**
- Create: `qulo-server/src/services/economy-config.service.ts`

- [ ] **Step 1: Service dosyasını oluştur**

```typescript
// src/services/economy-config.service.ts
import { supabase } from "../config/supabase.js";
import {
  economyConfigSchema,
  type EconomyConfig,
  type EconomyConfigVersion,
  type ConfigDiff,
} from "../types/economy-config.schema.js";

class EconomyConfigService {
  private cachedConfig: { version: number; config: EconomyConfig } | null = null;
  private cacheExpiry = 0;
  private readonly CACHE_TTL_MS = 5 * 60 * 1000; // 5 minutes

  async getActiveConfig(): Promise<{ version: number; config: EconomyConfig }> {
    if (this.cachedConfig && Date.now() < this.cacheExpiry) {
      return this.cachedConfig;
    }

    const { data, error } = await supabase
      .from("economy_config_versions")
      .select("*")
      .eq("is_active", true)
      .limit(1)
      .single();

    if (error || !data) {
      if (this.cachedConfig) return this.cachedConfig;
      throw new Error("No active economy config found");
    }

    const row = data as EconomyConfigVersion;
    const parsed = economyConfigSchema.parse(row.config);

    this.cachedConfig = { version: row.version, config: parsed };
    this.cacheExpiry = Date.now() + this.CACHE_TTL_MS;

    return this.cachedConfig;
  }

  /**
   * Convenience: get just the config object (used by other services).
   */
  async getConfig(): Promise<EconomyConfig> {
    const { config } = await this.getActiveConfig();
    return config;
  }

  async createVersion(
    config: EconomyConfig,
    changedBy: string,
    reason: string,
  ): Promise<EconomyConfigVersion> {
    // Validate
    const parsed = economyConfigSchema.parse(config);

    // Get next version number
    const { data: maxRow } = await supabase
      .from("economy_config_versions")
      .select("version")
      .order("version", { ascending: false })
      .limit(1)
      .single();

    const nextVersion = (maxRow?.version ?? 0) + 1;

    // Transaction: deactivate old, insert new
    // Supabase JS doesn't support transactions, use rpc
    const { data, error } = await supabase.rpc("create_economy_config_version", {
      p_version: nextVersion,
      p_config: parsed,
      p_changed_by: changedBy,
      p_change_reason: reason,
    });

    if (error) {
      // Fallback: do it in two queries (acceptable for single-instance)
      await supabase
        .from("economy_config_versions")
        .update({ is_active: false })
        .eq("is_active", true);

      const { data: inserted, error: insertError } = await supabase
        .from("economy_config_versions")
        .insert({
          version: nextVersion,
          config: parsed,
          is_active: true,
          changed_by: changedBy,
          change_reason: reason,
        })
        .select()
        .single();

      if (insertError) throw insertError;
      this.invalidateCache();
      return inserted as EconomyConfigVersion;
    }

    this.invalidateCache();
    return data as EconomyConfigVersion;
  }

  async getHistory(limit = 20): Promise<EconomyConfigVersion[]> {
    const { data, error } = await supabase
      .from("economy_config_versions")
      .select("id, version, is_active, changed_by, change_reason, created_at")
      .order("version", { ascending: false })
      .limit(limit);

    if (error) throw error;
    return (data ?? []) as EconomyConfigVersion[];
  }

  async getVersion(version: number): Promise<EconomyConfigVersion | null> {
    const { data, error } = await supabase
      .from("economy_config_versions")
      .select("*")
      .eq("version", version)
      .limit(1)
      .single();

    if (error) return null;
    return data as EconomyConfigVersion;
  }

  compareVersions(v1: EconomyConfigVersion, v2: EconomyConfigVersion): ConfigDiff {
    const changes: ConfigDiff["changes"] = [];

    function diff(path: string, a: unknown, b: unknown) {
      if (typeof a === "object" && a !== null && typeof b === "object" && b !== null) {
        const allKeys = new Set([...Object.keys(a as object), ...Object.keys(b as object)]);
        for (const key of allKeys) {
          diff(
            `${path}.${key}`,
            (a as Record<string, unknown>)[key],
            (b as Record<string, unknown>)[key],
          );
        }
      } else if (a !== b) {
        changes.push({ path, oldValue: a, newValue: b });
      }
    }

    diff("config", v1.config, v2.config);

    return { v1: v1.version, v2: v2.version, changes };
  }

  invalidateCache(): void {
    this.cachedConfig = null;
    this.cacheExpiry = 0;
  }
}

export const economyConfigService = new EconomyConfigService();
```

- [ ] **Step 2: TypeScript hata kontrolü**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit`
Expected: Hata yok

- [ ] **Step 4: Commit**

```bash
git add src/services/economy-config.service.ts
git commit -m "feat: add EconomyConfigService with cache, validation, and versioning"
```

---

### Task 4: Public Economy Endpoint

**Files:**
- Modify: `qulo-server/src/routes/app.routes.ts`
- Modify: `qulo-server/src/controllers/app.controller.ts`

- [ ] **Step 1: Controller'a economy handler ekle**

`src/controllers/app.controller.ts` dosyasında, mevcut import'ların altına:

```typescript
import { economyConfigService } from "../services/economy-config.service.js";
```

Dosyanın sonuna (export'tan önce) yeni handler:

```typescript
export async function getEconomyConfigHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await economyConfigService.getActiveConfig();
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 2: Route'a economy endpoint'i ekle**

`src/routes/app.routes.ts` dosyasında import'u güncelle:

```typescript
import { getAppConfigHandler, getEconomyConfigHandler } from "../controllers/app.controller.js";
```

`router.get("/config", ...)` satırının altına:

```typescript
router.get("/economy", getEconomyConfigHandler);
```

- [ ] **Step 3: Server'ı başlatıp test et**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npm run dev`
Sonra: `curl -s http://localhost:3001/api/v1/app/economy | jq .`
Expected: `{ "version": 1, "config": { "core": { ... }, ... } }`

- [ ] **Step 4: Commit**

```bash
git add src/controllers/app.controller.ts src/routes/app.routes.ts
git commit -m "feat: add GET /api/v1/app/economy public endpoint"
```

---

### Task 5: Server Hardcoded Sabitleri Kaldır + Servisleri Migrate Et

Bu task, eski sabitleri kaldırma ve servisleri güncellemeyi **tek seferde** yapar. Böylece arada broken build state olmaz.

**Files:**
- Modify: `qulo-server/src/types/index.ts`
- Modify: `qulo-server/src/utils/math.ts`
- Modify: `qulo-server/src/services/exchange.service.ts`
- Modify: `qulo-server/src/services/quiz.service.ts`
- Modify: `qulo-server/src/services/user.service.ts`
- Modify: `qulo-server/src/services/referral.service.ts`
- Modify: `qulo-server/src/services/chat-question.service.ts`
- Modify: `qulo-server/src/services/subscription.service.ts`

Her servis dosyasında aynı pattern:
1. Eski import'u kaldır (`import { GREEN_TO_PURPLE_RATIO, ... } from "../types/index.js"`)
2. Yeni import ekle (`import { economyConfigService } from "./economy-config.service.js"`)
3. Sabit kullanılan yerlerde `await economyConfigService.getConfig()` çağır

- [ ] **Step 1: types/index.ts'den ekonomi sabitlerini kaldır**

Aşağıdaki satırları sil (16-76 arası + 33-37):
- `QUESTION_COUNT_MULTIPLIERS` (satır 16-22)
- `GREEN_DIAMOND_REWARD_RATIO` (satır 24)
- `GREEN_TO_PURPLE_RATIO` (satır 26)
- `CHAT_QUESTION_LIMITS` (satır 33-37)
- `SUBSCRIPTION_LIMITS` (satır 51-76)

Bırakılacak (kapsam dışı):
- `JwtPayload`, `PowerName` (satır 1-14) — tipler, sabit değil
- `CHAT_QUESTION_POWERS_2/4` (satır 29-30) — gameplay mekaniği, ekonomi değil
- `IAP_PRODUCT_MAP` (satır 90-97) — store ürünleri, kapsam dışı
- `SUBSCRIPTION_PRODUCT_MAP` (satır 100-103) — store ürünleri, kapsam dışı

- [ ] **Step 2: math.ts'i parametre injection'a çevir**

Mevcut `math.ts`'deki `calculatePowerCost` ve `calculateGreenReward` fonksiyonlarını güncelle:

```typescript
// src/utils/math.ts
// Import kaldırıldı — artık parametre olarak alıyor

/**
 * Calculate power cost based on base cost and question count multiplier.
 * @param multipliers - from economyConfig.core.questionCountMultipliers
 */
export function calculatePowerCost(
  baseCost: number,
  questionCount: number,
  multipliers: Record<string, number>,
): number {
  const multiplier = multipliers[String(questionCount)] ?? 1.0;
  return Math.ceil(baseCost * multiplier);
}

/**
 * Calculate green diamond reward from purple diamonds spent.
 * @param rewardRatio - from economyConfig.core.greenDiamondRewardRatio
 */
export function calculateGreenReward(
  purpleSpent: number,
  rewardRatio: number,
): number {
  return Math.floor(purpleSpent * rewardRatio);
}
```

Not: `shuffleArray` ve `haversineDistance` fonksiyonları değişmez.

- [ ] **Step 3: exchange.service.ts — GREEN_TO_PURPLE_RATIO**

`import { GREEN_TO_PURPLE_RATIO } from "../types/index.js"` satırını kaldır.

`economyConfigService` import et. `convertGreenToPurple()` ve `getRates()` fonksiyonlarında `GREEN_TO_PURPLE_RATIO` yerine:
```typescript
const config = await economyConfigService.getConfig();
const ratio = config.core.greenToPurpleRatio;
```

- [ ] **Step 4: quiz.service.ts — calculatePowerCost ve calculateGreenReward çağrıları**

`import { QUESTION_COUNT_MULTIPLIERS, GREEN_DIAMOND_REWARD_RATIO }` kaldır.

`calculatePowerCost()` çağrılarını güncelle:
```typescript
const config = await economyConfigService.getConfig();
const cost = calculatePowerCost(power.base_cost, session.total_questions, config.core.questionCountMultipliers);
const greenReward = calculateGreenReward(cost, config.core.greenDiamondRewardRatio);
```

- [ ] **Step 5: user.service.ts — Boost cost ve duration**

`boost()` fonksiyonunda (satır ~270-286):
```typescript
const config = await economyConfigService.getConfig();
await diamondService.spendGreen(userId, config.core.boostCostGreen, "BOOST");
const boostUntil = new Date(Date.now() + config.core.boostDurationMinutes * 60 * 1000).toISOString();
```

- [ ] **Step 6: referral.service.ts — REFERRAL_REWARD ve MAX_COMPLETED_REFERRALS**

`const REFERRAL_REWARD = 25;` ve `const MAX_COMPLETED_REFERRALS = 10;` satırlarını kaldır.

Fonksiyonlarda:
```typescript
const config = await economyConfigService.getConfig();
const reward = config.rewards.referralPurple;
const maxReferrals = config.rewards.maxCompletedReferrals;
```

- [ ] **Step 7: chat-question.service.ts — CHAT_QUESTION_LIMITS**

`import { CHAT_QUESTION_LIMITS }` kaldır.

Daily limit kontrolünde:
```typescript
const config = await economyConfigService.getConfig();
const tier = subscriptionPlan ?? "free";
const limits = config.subscriptionLimits[tier];
const dailyLimit = limits.chatQuestionDaily;
const unmatchRiskLimit = limits.chatQuestionUnmatchRisk;
```

- [ ] **Step 8: subscription.service.ts — SUBSCRIPTION_LIMITS + Infinity→999999 uyumu**

`import { SUBSCRIPTION_LIMITS }` kaldır.

Limit hesaplamalarında:
```typescript
const config = await economyConfigService.getConfig();
const tier = plan ?? "free";
const limits = config.subscriptionLimits[tier];
```

**KRİTİK:** Mevcut kodda `Infinity` kontrolü var (satır 213-215):
```typescript
dailyDiscoversLimit: limits.dailyDiscovers === Infinity ? -1 : limits.dailyDiscovers,
dailyUndosLimit: limits.dailyUndos === Infinity ? -1 : limits.dailyUndos,
```

JSONB'den gelen `999999`, `Infinity` değil. Bu kontrolü threshold-based yap:
```typescript
const UNLIMITED_THRESHOLD = 999999;
dailyDiscoversLimit: limits.dailyDiscovers >= UNLIMITED_THRESHOLD ? -1 : limits.dailyDiscovers,
dailyUndosLimit: limits.dailyUndos >= UNLIMITED_THRESHOLD ? -1 : limits.dailyUndos,
```

Bu değişiklik Flutter tarafında `-1` = unlimited kontrolünü koruyor.

- [ ] **Step 9: TypeScript hata kontrolü — SIFIR HATA**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server && npx tsc --noEmit`
Expected: Hata yok

- [ ] **Step 10: Server'ı başlatıp smoke test**

Run: `npm run dev`
Sonra: `curl -s http://localhost:3001/ping`
Expected: `{"pong":true,...}`

Ve: `curl -s http://localhost:3001/api/v1/app/economy | jq .version`
Expected: `1`

- [ ] **Step 11: Commit**

```bash
git add src/types/index.ts src/utils/math.ts src/services/
git commit -m "refactor: migrate all hardcoded economy constants to EconomyConfigService"
```

---

### Task 6: Admin Panel — Economy Config Sayfaları

**Files:**
- Create: `qulo-server/src/admin/views/economy-config.ejs`
- Create: `qulo-server/src/admin/views/economy-config-history.ejs`
- Create: `qulo-server/src/admin/views/economy-config-compare.ejs`
- Modify: `qulo-server/src/admin/admin.routes.ts`
- Modify: `qulo-server/src/admin/admin.controller.ts`

- [ ] **Step 1: Admin controller'a 4 yeni method ekle**

`src/admin/admin.controller.ts` dosyasında economyConfigService import et:
```typescript
import { economyConfigService } from "../services/economy-config.service.js";
import { economyConfigSchema, ECONOMY_BOUNDARIES } from "../types/economy-config.schema.js";
```

Yeni methodlar:

```typescript
async economyConfig(req: Request, res: Response) {
  const { config, version } = await economyConfigService.getActiveConfig();
  res.render("economy-config", {
    config,
    version,
    boundaries: ECONOMY_BOUNDARIES,
    success: req.query.success,
    error: req.query.error,
    session: req.session,
    csrfToken: req.session.csrfToken,
  });
}

async updateEconomyConfig(req: Request, res: Response) {
  try {
    const config = JSON.parse(req.body.config_json);
    const reason = req.body.change_reason;

    if (!reason || reason.trim().length === 0) {
      return res.redirect("/admin/economy-config?error=Değişiklik sebebi zorunludur");
    }

    // Zod validation
    const parsed = economyConfigSchema.parse(config);
    await economyConfigService.createVersion(parsed, req.session.adminId, reason);
    res.redirect("/admin/economy-config?success=1");
  } catch (err: any) {
    const msg = err.issues ? err.issues.map((i: any) => `${i.path.join(".")}: ${i.message}`).join(", ") : err.message;
    res.redirect(`/admin/economy-config?error=${encodeURIComponent(msg)}`);
  }
}

async economyConfigHistory(req: Request, res: Response) {
  const history = await economyConfigService.getHistory(50);
  res.render("economy-config-history", {
    history,
    session: req.session,
  });
}

async economyConfigCompare(req: Request, res: Response) {
  const v1Num = parseInt(req.query.v1 as string, 10);
  const v2Num = parseInt(req.query.v2 as string, 10);

  const v1 = await economyConfigService.getVersion(v1Num);
  const v2 = await economyConfigService.getVersion(v2Num);

  if (!v1 || !v2) {
    return res.redirect("/admin/economy-config/history?error=Version not found");
  }

  const diff = economyConfigService.compareVersions(v1, v2);
  res.render("economy-config-compare", {
    v1, v2, diff,
    session: req.session,
  });
}
```

- [ ] **Step 2: Admin routes'a 4 yeni route ekle**

`src/admin/admin.routes.ts` dosyasında, `router.post("/app-config", ...)` satırının altına:

```typescript
router.get("/economy-config", (req, res) => adminController.economyConfig(req, res));
router.post("/economy-config", csrfValidate, (req, res) => adminController.updateEconomyConfig(req, res));
router.get("/economy-config/history", (req, res) => adminController.economyConfigHistory(req, res));
router.get("/economy-config/compare", (req, res) => adminController.economyConfigCompare(req, res));
```

- [ ] **Step 3: economy-config.ejs view oluştur**

`src/admin/views/economy-config.ejs` — Mevcut `app-config.ejs` pattern'ini takip ederek section bazlı form. JSON config'i hidden textarea'da tutar, JavaScript ile form alanlarını JSON'a serialize eder.

Temel yapı:
- `<%- include('_header') %>` — mevcut header
- Başarı/hata mesajı banner
- 4 section (Core, Subscription Limits, Rewards, Timing) — her biri accordion
- Her input'ta `min`/`max` HTML attribute'ları (`boundaries` objesinden)
- "Değişiklik Sebebi" zorunlu textarea
- Submit butonu
- Hidden `<textarea name="config_json">` — form submit'te JS ile doldurulur
- `<%- include('_footer') %>`

- [ ] **Step 4: economy-config-history.ejs view oluştur**

Tablo: version, tarih, değiştiren, sebep, aksiyonlar (Görüntüle, Karşılaştır link'leri).

- [ ] **Step 5: economy-config-compare.ejs view oluştur**

İki versiyonun diff'i — `changes` array'ini iterate ederek tablo: path, eski değer (kırmızı), yeni değer (yeşil).

- [ ] **Step 6: Test — Admin panele giriş yap ve sayfaları kontrol et**

1. `http://localhost:3001/admin/login` → admin@qulo.app / AdminQulo2026!
2. `http://localhost:3001/admin/economy-config` → form göründü mü?
3. Bir değeri değiştirip kaydet → `?success=1` redirect
4. `http://localhost:3001/admin/economy-config/history` → 2 versiyon göründü mü?
5. Karşılaştır → diff göründü mü?

- [ ] **Step 7: Commit**

```bash
git add src/admin/
git commit -m "feat: add economy config admin panel — edit, history, compare"
```

---

## FAZ 2 — Flutter Tarafı

### Task 7: Economy Config Model

**Files:**
- Create: `qulov2/lib/data/models/economy_config_model.dart`

- [ ] **Step 1: Model dosyasını oluştur**

```dart
// lib/data/models/economy_config_model.dart
import 'package:equatable/equatable.dart';

class EconomyConfigResponse extends Equatable {
  final int version;
  final EconomyConfig config;

  const EconomyConfigResponse({required this.version, required this.config});

  factory EconomyConfigResponse.fromJson(Map<String, dynamic> json) {
    return EconomyConfigResponse(
      version: json['version'] as int,
      config: EconomyConfig.fromJson(json['config'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [version, config];
}

class EconomyConfig extends Equatable {
  final EconomyCoreConfig core;
  final Map<String, TierLimits> subscriptionLimits;
  final RewardsConfig rewards;
  final TimingConfig timing;

  const EconomyConfig({
    required this.core,
    required this.subscriptionLimits,
    required this.rewards,
    required this.timing,
  });

  factory EconomyConfig.fromJson(Map<String, dynamic> json) {
    final limitsJson = json['subscriptionLimits'] as Map<String, dynamic>;
    return EconomyConfig(
      core: EconomyCoreConfig.fromJson(json['core'] as Map<String, dynamic>),
      subscriptionLimits: limitsJson.map(
        (key, value) => MapEntry(key, TierLimits.fromJson(value as Map<String, dynamic>)),
      ),
      rewards: RewardsConfig.fromJson(json['rewards'] as Map<String, dynamic>),
      timing: TimingConfig.fromJson(json['timing'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'core': core.toJson(),
    'subscriptionLimits': subscriptionLimits.map((k, v) => MapEntry(k, v.toJson())),
    'rewards': rewards.toJson(),
    'timing': timing.toJson(),
  };

  /// Get tier limits for a subscription plan. Falls back to free tier.
  TierLimits limitsFor(String? plan) =>
      subscriptionLimits[plan ?? 'free'] ?? subscriptionLimits['free']!;

  @override
  List<Object?> get props => [core, subscriptionLimits, rewards, timing];

  /// Hardcoded fallback — v1 seed values, used only when API AND cache both fail.
  static const EconomyConfig fallback = EconomyConfig(
    core: EconomyCoreConfig(
      boostCostGreen: 30,
      boostDurationMinutes: 30,
      greenDiamondRewardRatio: 0.30,
      greenToPurpleRatio: 3,
      questionCountMultipliers: {'2': 0.5, '3': 0.75, '4': 1.0, '5': 1.25, '6': 1.5},
    ),
    subscriptionLimits: {
      'free': TierLimits(dailyDiscovers: 50, maxQuestions: 4, dailyUndos: 0, monthlyPurpleBonus: 0, chatQuestionDaily: 2, chatQuestionUnmatchRisk: 1, passportMode: false, hasAds: true),
      'plus': TierLimits(dailyDiscovers: 999999, maxQuestions: 6, dailyUndos: 3, monthlyPurpleBonus: 500, chatQuestionDaily: 5, chatQuestionUnmatchRisk: 2, passportMode: false, hasAds: false),
      'premium': TierLimits(dailyDiscovers: 999999, maxQuestions: 10, dailyUndos: 999999, monthlyPurpleBonus: 1500, chatQuestionDaily: 999999, chatQuestionUnmatchRisk: 999999, passportMode: true, hasAds: false),
    },
    rewards: RewardsConfig(milestones: {'25': 5, '50': 15, '75': 30, '100': 50}, referralPurple: 25, maxCompletedReferrals: 10),
    timing: TimingConfig(questionTimeSeconds: 30, timeExtendSeconds: 15, timePresets: [15, 30, 60, 90]),
  );
}

class EconomyCoreConfig extends Equatable {
  final int boostCostGreen;
  final int boostDurationMinutes;
  final double greenDiamondRewardRatio;
  final int greenToPurpleRatio;
  final Map<String, double> questionCountMultipliers;

  const EconomyCoreConfig({
    required this.boostCostGreen,
    required this.boostDurationMinutes,
    required this.greenDiamondRewardRatio,
    required this.greenToPurpleRatio,
    required this.questionCountMultipliers,
  });

  factory EconomyCoreConfig.fromJson(Map<String, dynamic> json) {
    return EconomyCoreConfig(
      boostCostGreen: json['boostCostGreen'] as int,
      boostDurationMinutes: json['boostDurationMinutes'] as int,
      greenDiamondRewardRatio: (json['greenDiamondRewardRatio'] as num).toDouble(),
      greenToPurpleRatio: json['greenToPurpleRatio'] as int,
      questionCountMultipliers: (json['questionCountMultipliers'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as num).toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
    'boostCostGreen': boostCostGreen,
    'boostDurationMinutes': boostDurationMinutes,
    'greenDiamondRewardRatio': greenDiamondRewardRatio,
    'greenToPurpleRatio': greenToPurpleRatio,
    'questionCountMultipliers': questionCountMultipliers,
  };

  @override
  List<Object?> get props => [boostCostGreen, boostDurationMinutes, greenDiamondRewardRatio, greenToPurpleRatio, questionCountMultipliers];
}

class TierLimits extends Equatable {
  final int dailyDiscovers;
  final int maxQuestions;
  final int dailyUndos;
  final int monthlyPurpleBonus;
  final int chatQuestionDaily;
  final int chatQuestionUnmatchRisk;
  final bool passportMode;
  final bool hasAds;

  const TierLimits({
    required this.dailyDiscovers,
    required this.maxQuestions,
    required this.dailyUndos,
    required this.monthlyPurpleBonus,
    required this.chatQuestionDaily,
    required this.chatQuestionUnmatchRisk,
    required this.passportMode,
    required this.hasAds,
  });

  factory TierLimits.fromJson(Map<String, dynamic> json) {
    return TierLimits(
      dailyDiscovers: json['dailyDiscovers'] as int,
      maxQuestions: json['maxQuestions'] as int,
      dailyUndos: json['dailyUndos'] as int,
      monthlyPurpleBonus: json['monthlyPurpleBonus'] as int,
      chatQuestionDaily: json['chatQuestionDaily'] as int,
      chatQuestionUnmatchRisk: json['chatQuestionUnmatchRisk'] as int,
      passportMode: json['passportMode'] as bool,
      hasAds: json['hasAds'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'dailyDiscovers': dailyDiscovers,
    'maxQuestions': maxQuestions,
    'dailyUndos': dailyUndos,
    'monthlyPurpleBonus': monthlyPurpleBonus,
    'chatQuestionDaily': chatQuestionDaily,
    'chatQuestionUnmatchRisk': chatQuestionUnmatchRisk,
    'passportMode': passportMode,
    'hasAds': hasAds,
  };

  @override
  List<Object?> get props => [dailyDiscovers, maxQuestions, dailyUndos, monthlyPurpleBonus, chatQuestionDaily, chatQuestionUnmatchRisk, passportMode, hasAds];
}

class RewardsConfig extends Equatable {
  final Map<String, int> milestones;
  final int referralPurple;
  final int maxCompletedReferrals;

  const RewardsConfig({
    required this.milestones,
    required this.referralPurple,
    required this.maxCompletedReferrals,
  });

  factory RewardsConfig.fromJson(Map<String, dynamic> json) {
    return RewardsConfig(
      milestones: (json['milestones'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as int)),
      referralPurple: json['referralPurple'] as int,
      maxCompletedReferrals: json['maxCompletedReferrals'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'milestones': milestones,
    'referralPurple': referralPurple,
    'maxCompletedReferrals': maxCompletedReferrals,
  };

  @override
  List<Object?> get props => [milestones, referralPurple, maxCompletedReferrals];
}

class TimingConfig extends Equatable {
  final int questionTimeSeconds;
  final int timeExtendSeconds;
  final List<int> timePresets;

  const TimingConfig({
    required this.questionTimeSeconds,
    required this.timeExtendSeconds,
    required this.timePresets,
  });

  factory TimingConfig.fromJson(Map<String, dynamic> json) {
    return TimingConfig(
      questionTimeSeconds: json['questionTimeSeconds'] as int,
      timeExtendSeconds: json['timeExtendSeconds'] as int,
      timePresets: (json['timePresets'] as List<dynamic>).cast<int>(),
    );
  }

  Map<String, dynamic> toJson() => {
    'questionTimeSeconds': questionTimeSeconds,
    'timeExtendSeconds': timeExtendSeconds,
    'timePresets': timePresets,
  };

  @override
  List<Object?> get props => [questionTimeSeconds, timeExtendSeconds, timePresets];
}
```

- [ ] **Step 2: flutter analyze**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: Yeni dosyada hata yok

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/data/models/economy_config_model.dart
git commit -m "feat: add EconomyConfig model with fallback values"
```

---

### Task 8: Economy Config Provider + Splash Entegrasyonu

**Files:**
- Create: `qulov2/lib/providers/economy_config_provider.dart`
- Modify: `qulov2/lib/core/network/services/app_config_service.dart`
- Modify: `qulov2/lib/data/repositories/app_config_repository.dart`
- Modify: `qulov2/lib/providers/api_provider.dart`
- Modify: `qulov2/lib/features/splash/splash_screen.dart`

- [ ] **Step 1: Retrofit service'e economy endpoint ekle**

`lib/core/network/services/app_config_service.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_config_service.g.dart';

@RestApi()
abstract class AppConfigRetrofitService {
  factory AppConfigRetrofitService(Dio dio) = _AppConfigRetrofitService;

  @GET('/app/config')
  Future<dynamic> getConfig();

  @GET('/app/economy')
  Future<dynamic> getEconomyConfig();
}
```

- [ ] **Step 2: Retrofit codegen çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 3: Repository'ye economy fetch ekle**

`lib/data/repositories/app_config_repository.dart` dosyasına:

```dart
import 'package:qulo_v2/data/models/economy_config_model.dart';
```

Yeni method:
```dart
Future<Result<EconomyConfigResponse>> getEconomyConfig() async {
  try {
    final response = await _service.getEconomyConfig();
    return Success(EconomyConfigResponse.fromJson(response));
  } on DioException catch (e) {
    return Failure(e.toAppFailure());
  } catch (e) {
    return Failure(UnknownFailure(error: e, message: 'Failed to parse economy config'));
  }
}
```

- [ ] **Step 4: Economy config provider oluştur**

```dart
// lib/providers/economy_config_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/data/models/economy_config_model.dart';
import 'package:qulo_v2/providers/api_provider.dart';

final economyConfigProvider = NotifierProvider<EconomyConfigNotifier, EconomyConfig>(
  EconomyConfigNotifier.new,
);

class EconomyConfigNotifier extends Notifier<EconomyConfig> {
  static const _cacheKey = 'economy_config_cache';

  @override
  EconomyConfig build() => EconomyConfig.fallback;

  /// Called during splash — fetch from API, fallback to cache, then hardcoded.
  Future<void> fetch() async {
    final repo = ref.read(appConfigRepositoryProvider);
    final result = await repo.getEconomyConfig();

    await result.when(
      success: (response) async {
        state = response.config;
        await _saveToCache(response.config);
      },
      failure: (_) async {
        // Try cached config
        final cached = await _loadFromCache();
        if (cached != null) {
          state = cached;
        }
        // else: keep fallback (already set in build())
        // Retry in background
        _retryInBackground();
      },
    );
  }

  Future<void> _saveToCache(EconomyConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(config.toJson()));
  }

  Future<EconomyConfig?> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_cacheKey);
    if (cached == null) return null;
    try {
      return EconomyConfig.fromJson(jsonDecode(cached) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> _retryInBackground() async {
    await Future.delayed(const Duration(seconds: 30));
    final repo = ref.read(appConfigRepositoryProvider);
    final result = await repo.getEconomyConfig();
    result.when(
      success: (response) async {
        state = response.config;
        await _saveToCache(response.config);
      },
      failure: (_) {}, // Give up silently
    );
  }
}
```

- [ ] **Step 5: Splash screen'e economy fetch ekle**

`lib/features/splash/splash_screen.dart` dosyasında `_checkVersionAndAuth()` methodunda, `checkVersion()` çağrısından sonra:

```dart
Future<void> _checkVersionAndAuth() async {
  _splashStopwatch.stop();
  AnalyticsManager.instance.logEvent(AnalyticsEvents.appSplashDuration, params: {
    AnalyticsEvents.paramDurationMs: _splashStopwatch.elapsedMilliseconds,
  });

  final status = await ref.read(appConfigProvider.notifier).checkVersion();
  if (!mounted) return;

  // Fetch economy config (non-blocking — fallback available)
  await ref.read(economyConfigProvider.notifier).fetch();
  if (!mounted) return;

  switch (status) {
    // ... rest stays the same
```

Import ekle: `import 'package:qulo_v2/providers/economy_config_provider.dart';`

- [ ] **Step 6: flutter analyze**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: Hata yok

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/core/network/services/app_config_service.dart lib/core/network/services/app_config_service.g.dart lib/data/repositories/app_config_repository.dart lib/providers/economy_config_provider.dart lib/providers/api_provider.dart lib/features/splash/splash_screen.dart
git commit -m "feat: add economy config provider with startup fetch and cache"
```

---

### Task 9: Flutter Hardcoded Değerleri Kaldır

**Files:**
- Modify: `qulov2/lib/core/constants/app_constants.dart`
- Modify: `qulov2/lib/data/models/subscription_model.dart`
- Modify: `qulov2/lib/data/models/daily_stats_model.dart`
- Modify: `qulov2/lib/providers/daily_stats_provider.dart`
- Modify: `qulov2/lib/features/quiz/mixins/quiz_screen_mixin.dart`
- Modify: `qulov2/lib/features/exchange/widgets/convert_section.dart`
- Modify: `qulov2/lib/features/diamonds/widgets/paywall_bottom_sheet.dart`
- Modify: `qulov2/lib/features/profile/mixins/edit_profile_screen_mixin.dart`
- Modify: `qulov2/lib/features/diamonds/screens/diamonds_screen.dart`

Bu task'ı dosya dosya yapıyoruz. Her dosyada pattern aynı: hardcoded değer yerine `ref.read(economyConfigProvider)` kullan.

- [ ] **Step 1: app_constants.dart — ekonomi sabitlerini kaldır**

Şu satırları sil:
- `questionTimeSeconds` (satır 5)
- `timeExtendSeconds` (satır 6)
- `greenDiamondRewardRatio` (satır 7)
- `boostCostGreen` (satır 8)
- `boostDurationMinutes` (satır 9)
- `timePresets` (satır 11)

Bırakılacak: `maxPhotos`, `minQuestions`, `maxQuestions` (UI sabitleri — soru oluşturma form validasyonu), `questionCategories`, `supportedQuestionLocales`, `localeFlagEmojis`.

Not: `minQuestions` ve `maxQuestions` spec'te belirtilmedi çünkü soru oluşturma form sınırları — ekonomi değil, UI validasyonu.

- [ ] **Step 2: subscription_model.dart — computed getters kaldır**

`SubscriptionInfo` sınıfından şu getter'ları kaldır (satır 47-68):
- `hasAds` → artık `economyConfig.limitsFor(plan).hasAds`
- `hasPassport` → artık `economyConfig.limitsFor(plan).passportMode`
- `dailyDiscoverLimit` → artık `economyConfig.limitsFor(plan).dailyDiscovers`
- `maxQuestions` → artık `economyConfig.limitsFor(plan).maxQuestions`
- `dailyUndoLimit` → artık `economyConfig.limitsFor(plan).dailyUndos`
- `monthlyPurpleBonus` → artık `economyConfig.limitsFor(plan).monthlyPurpleBonus`

`SubscriptionStatusResponse.fromJson` fallback'i de economy config'den:
```dart
limits: json['limits'] != null
    ? SubscriptionLimits.fromJson(json['limits'] as Map<String, dynamic>)
    : const SubscriptionLimits(
        dailyDiscovers: 50, maxQuestions: 4, dailyUndos: 0,
        monthlyPurpleBonus: 0, passportMode: false, hasAds: true,
      ),
```
Bu fallback kalabilir çünkü server API zaten limitleri dönüyor. Ama `SubscriptionInfo` computed getters KALDIRILMALI — çift kaynak.

**Dikkat:** `SubscriptionInfo` getter'ları kullanan tüm yerleri bulmak için grep yap:
```bash
grep -rn "\.dailyDiscoverLimit\|\.maxQuestions\|\.dailyUndoLimit\|\.monthlyPurpleBonus\|\.hasAds\|\.hasPassport" lib/ --include="*.dart"
```
Bu yerleri `economyConfigProvider` kullanacak şekilde güncelle.

- [ ] **Step 3: daily_stats_provider.dart — fallback'i economy config'den al**

```dart
failure: (_) {
  final config = ref.read(economyConfigProvider);
  final free = config.limitsFor('free');
  return DailyStats(
    dailyDiscoversUsed: 0,
    dailyDiscoversLimit: free.dailyDiscovers,
    dailyUndosUsed: 0,
    dailyUndosLimit: free.dailyUndos,
    questionsCreated: 0,
    questionsLimit: free.maxQuestions,
    monthlyPurpleBonus: free.monthlyPurpleBonus,
    passportMode: free.passportMode,
    hasAds: free.hasAds,
  );
},
```

- [ ] **Step 4: quiz_screen_mixin.dart — fallback cost 20 kaldır**

`getPowerCost()` fonksiyonundaki fallback `20` yerine:
```dart
return ref.read(economyConfigProvider).core.boostCostGreen; // or a generic default
```
Aslında bu power cost'u — exchange rates'den gelir. Fallback olarak economy config'den bir değer kullanmak yanlış olur. Doğrusu:
```dart
int getPowerCost(String powerName) {
  final rates = ref.read(exchangeProvider).rates;
  if (rates != null) {
    final power = rates.powers.where((p) => p.name == powerName).firstOrNull;
    if (power != null) return power.purpleCost;
  }
  return 0; // Power kullanılamaz, 0 göster
}
```

- [ ] **Step 5: convert_section.dart — fallback ratio 3 kaldır**

```dart
int get _convertRatio =>
    ref.read(exchangeProvider).rates?.convertRatio ??
    ref.read(economyConfigProvider).core.greenToPurpleRatio;
```

- [ ] **Step 6: paywall_bottom_sheet.dart — 500/1500 kaldır**

```dart
final config = ref.read(economyConfigProvider);
final bonus = isPremium
    ? config.limitsFor('premium').monthlyPurpleBonus
    : config.limitsFor('plus').monthlyPurpleBonus;
```

- [ ] **Step 7: edit_profile_screen_mixin.dart — milestone rewards kaldır**

Milestone rewards'u config'den:
```dart
final milestones = ref.read(economyConfigProvider).rewards.milestones;
// milestones = {'25': 5, '50': 15, '75': 30, '100': 50}
```

- [ ] **Step 8: diamonds_screen.dart — referral 25 kaldır**

Paylaşım mesajındaki "25 mor elmas" yerine:
```dart
final reward = ref.read(economyConfigProvider).rewards.referralPurple;
final message = "Qulo'ya katıl! Davet kodumu kullan, ikimize de $reward mor elmas hediye: $code";
```

- [ ] **Step 9: Localization string'lerindeki hardcoded sayıları güncelle**

`app_localizations.dart`'ta "25 mor elmas", "500 mor elmas/ay", "1500 mor elmas/ay" gibi string'ler varsa, bunları parametrik hale getir:
- `referral_description` → `'Arkadaşını davet et, ikimize de {amount} mor elmas hediye!'`
- `sub_plus_diamonds` → `'{amount} mor elmas/ay'`
- `sub_premium_diamonds` → `'{amount} mor elmas/ay'`

UI'da çağırırken:
```dart
context.tr('referral_description', args: {'amount': config.rewards.referralPurple.toString()})
```

- [ ] **Step 10: flutter analyze — SIFIR HATA**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: Hata yok

- [ ] **Step 11: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/
git commit -m "refactor: replace all hardcoded economy values with economy config provider"
```

---

## FAZ 3 — Economy Watchdog Skill

### Task 10: Economy Watchdog Skill Dosyası

**Files:**
- Create: `~/.claude/skills/economy/economy.md`

- [ ] **Step 1: Skill dosyasını oluştur**

```markdown
---
name: economy
description: Economy config watchdog — check health, detect drift, validate boundaries. Use when economy files are edited or on manual /economy invocation.
---

# Economy Watchdog

## Triggered By
- Manual: `/economy` command
- Automatic: Hook fires when economy-related files are edited

## Mode A — Automatic Check (on file edit trigger)

When an economy-related file is edited, check:

1. **Hardcoded detection:** Scan the changed file for new hardcoded diamond amounts, ratios, or limits that should be in economy config
2. **Drift check:** Compare Flutter fallback values in `EconomyConfig.fallback` (qulov2/lib/data/models/economy_config_model.dart) against server's active config (`curl localhost:3001/api/v1/app/economy`)
3. **Migration check:** If new constants are added to any service file, flag them for economy config migration

Report findings to user with actionable suggestions.

## Mode B — Manual Report (`/economy`)

Generate a full economy health report:

1. Fetch active config: `curl -s http://localhost:3001/api/v1/app/economy | jq .`
   - If server unreachable, try Railway: `curl -s https://qulo-server-production.up.railway.app/api/v1/app/economy | jq .`
2. Show current active config version and all values in a formatted table
3. Compare Flutter fallback (`EconomyConfig.fallback` in economy_config_model.dart) vs server config — flag any mismatches
4. Health score: X/Y values synchronized

## Mode C — Safety Boundaries (always active)

These boundaries MUST be enforced when suggesting or reviewing economy config changes:

| Value | Min | Max |
|-------|-----|-----|
| greenDiamondRewardRatio | 0.10 | 0.50 |
| boostCostGreen | 5 | 200 |
| boostDurationMinutes | 5 | 120 |
| greenToPurpleRatio | 1 | 10 |
| dailyDiscovers (free) | 10 | 200 |
| maxQuestions (free) | 2 | 6 |
| dailyUndos (free) | 0 | 5 |
| referralPurple | 5 | 100 |
| questionTimeSeconds | 10 | 120 |
| timeExtendSeconds | 5 | 60 |
| monthlyPurpleBonus (plus) | 100 | 2000 |
| monthlyPurpleBonus (premium) | 500 | 5000 |
| chatQuestionDaily (free) | 1 | 10 |
| chatQuestionUnmatchRisk (free) | 1 | 5 |
| questionCountMultipliers (each) | 0.1 | 3.0 |

If any value is outside boundaries, show a WARNING with explanation of the risk.

## Key Files
- Server config service: `qulo-server/src/services/economy-config.service.ts`
- Zod schema + boundaries: `qulo-server/src/types/economy-config.schema.ts`
- Flutter model + fallback: `qulov2/lib/data/models/economy_config_model.dart`
- Flutter provider: `qulov2/lib/providers/economy_config_provider.dart`
- Server constants (should be empty of economy values): `qulo-server/src/types/index.ts`
- Admin panel: `http://localhost:3001/admin/economy-config`
```

- [ ] **Step 2: Hook'u settings.json'a ekle (update-config skill ile)**

Economy dosyaları edit edildiğinde otomatik bildirim:

Hook konfigürasyonu:
- afterEdit event
- File pattern: `economy_config|app_constants.dart|types/index.ts|exchange.service|diamond.service|quiz.service|referral.service|user.service.*boost|subscription.service|chat-question.service`
- Action: Echo uyarı, kullanıcıya skill tetiklenmesini hatırlat

- [ ] **Step 3: Skill'i test et**

`/economy` komutunu çalıştır → rapor oluşmalı

- [ ] **Step 4: Commit**

```bash
git add ~/.claude/skills/economy/
git commit -m "feat: add economy watchdog skill with health check, drift detection, and safety boundaries"
```

---

## Post-Implementation Checklist

- [ ] Server TypeScript build hatasız: `cd qulo-server && npm run build`
- [ ] Server smoke test: `curl localhost:3001/api/v1/app/economy` → config JSON dönüyor
- [ ] Admin panel: `/admin/economy-config` → form açılıyor, kayıt yapılabiliyor
- [ ] Admin history: `/admin/economy-config/history` → versiyon listesi görünüyor
- [ ] Flutter analyze: `cd qulov2 && flutter analyze` → 0 hata
- [ ] Flutter app başlangıcında economy config yükleniyor (splash log'u kontrol et)
- [ ] `app_constants.dart`'ta ekonomi sabiti kalmadı (grep ile doğrula)
- [ ] `types/index.ts`'te ekonomi sabiti kalmadı
- [ ] `/economy` skill çalışıyor, rapor üretiyor
