# Chat Question System v2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Chat soru sistemini yeniden tasarlayarak ücretsiz soru oluşturma, power destekli cevaplama, güç engeli mekanizması, ödül medya, taslak sistemi ve chat kilidi özelliklerini eklemek.

**Architecture:** DB migration ile yeni kolonlar/tablolar eklenir. Server tarafında chat-question service power handling ile genişletilir (mevcut diamond/exchange servisleri yeniden kullanılır). Flutter tarafında full screen stepper ile soru oluşturma, tam ekran soru çözme, kurtarma ve sonuç ekranları eklenir.

**Tech Stack:** Flutter, Riverpod, Node.js, Express, TypeScript, Supabase PostgreSQL, Zod validation

---

## File Map

| Dosya | Değişiklik |
|-------|-----------|
| **Server — Yeni/Değişen** | |
| `qulo-server/migrations/019_chat_question_v2.sql` | Yeni kolonlar + chat_question_drafts tablosu + power kayıtları |
| `qulo-server/src/types/index.ts` | PowerName'e POWER_BLOCK/POWER_UNBLOCK ekle, chat question limitleri |
| `qulo-server/src/utils/math.ts` | `calculateGreenReward` → `Math.floor` (mevcut `Math.ceil` → değişecek) |
| `qulo-server/src/validators/chat-question.validator.ts` | Yeni alanlar (option_count, time_limit, hint, vb.) + use-power + timeout schema |
| `qulo-server/src/services/chat-question.service.ts` | Büyük rewrite: ücretsiz oluşturma, power handling, use-power, timeout, draft/history |
| `qulo-server/src/controllers/chat-question.controller.ts` | Yeni handler'lar: usePower, timeout, drafts, history |
| `qulo-server/src/routes/chat.routes.ts` | Yeni route'lar |
| `qulo-server/src/services/chat.service.ts` | sendMessage'a chat lock kontrolü |
| **Flutter — Yeni** | |
| `qulov2/lib/data/models/chat_question_model.dart` | Mevcut model genişletme (4 şık, süre, hint, medya, power, lock) |
| `qulov2/lib/data/models/chat_question_draft_model.dart` | Taslak modeli |
| `qulov2/lib/features/chat/screens/create_chat_question_screen.dart` | Full screen stepper |
| `qulov2/lib/features/chat/widgets/chat_question_step1.dart` | Adım 1: Soru içeriği |
| `qulov2/lib/features/chat/widgets/chat_question_step2.dart` | Adım 2: Ayarlar |
| `qulov2/lib/features/chat/screens/solve_chat_question_screen.dart` | Cevaplama tam ekranı |
| `qulov2/lib/features/chat/widgets/chat_question_power_bar.dart` | Power bar (2/4 şık'a göre) |
| `qulov2/lib/features/chat/widgets/chat_question_rescue.dart` | Kurtarma ekranı |
| `qulov2/lib/features/chat/widgets/chat_question_result.dart` | Sonuç + ödül medya reveal |
| `qulov2/lib/features/chat/widgets/blurred_media_preview.dart` | Bulanık medya önizleme |
| `qulov2/lib/features/chat/sheets/draft_history_sheet.dart` | Taslak/geçmiş bottom sheet |
| **Flutter — Değişen** | |
| `qulov2/lib/features/chat/sheets/create_question_sheet.dart` | Kaldırılacak |
| `qulov2/lib/features/chat/widgets/chat_question_card.dart` | 4 şık, bulanık medya, kilit, "Aç" butonu |
| `qulov2/lib/features/chat/widgets/chat_question_message.dart` | Yeni model alanları |
| `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart` | Chat kilidi kontrolü, soru oluşturma navigasyonu |
| `qulov2/lib/core/network/services/chat_service.dart` | Yeni endpoint'ler (use-power, timeout, drafts, history) |
| `qulov2/lib/data/repositories/chat_repository.dart` | Yeni metotlar |
| `qulov2/lib/providers/chat_provider.dart` | Draft/history, chat lock state |
| `qulov2/lib/routing/route_names.dart` | Yeni route isimleri |
| `qulov2/lib/routing/app_router.dart` | Yeni route tanımları |

---

## Task 1: Database Migration

**Files:**
- Create: `qulo-server/migrations/019_chat_question_v2.sql`

**Spec referans:** Veritabanı Değişiklikleri bölümü

- [ ] **Step 1: Migration SQL dosyasını oluştur**

```sql
-- 019_chat_question_v2.sql
-- Chat Question System v2: 4-option support, timer, hints, reward media, power block, chat lock, drafts

-- ═══ chat_questions: new columns ═══
ALTER TABLE chat_questions
  ADD COLUMN IF NOT EXISTS option_count INTEGER DEFAULT 2,
  ADD COLUMN IF NOT EXISTS option_c TEXT,
  ADD COLUMN IF NOT EXISTS option_d TEXT,
  ADD COLUMN IF NOT EXISTS time_limit_seconds INTEGER DEFAULT 30,
  ADD COLUMN IF NOT EXISTS hint_text TEXT,
  ADD COLUMN IF NOT EXISTS reward_media_url TEXT,
  ADD COLUMN IF NOT EXISTS reward_media_type TEXT,
  ADD COLUMN IF NOT EXISTS has_chat_lock BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS has_power_block BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS power_block_removed BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS powers_used JSONB DEFAULT '[]'::jsonb;

-- Remove diamond_cost column (questions are now free to create)
-- Keep column for backward compat but default to 0
ALTER TABLE chat_questions ALTER COLUMN diamond_cost SET DEFAULT 0;

-- Update correct_option to support C/D
ALTER TABLE chat_questions DROP CONSTRAINT IF EXISTS chat_questions_correct_option_check;
ALTER TABLE chat_questions ADD CONSTRAINT chat_questions_correct_option_check
  CHECK (correct_option IN ('A', 'B', 'C', 'D'));

-- Update answered_option to support C/D
ALTER TABLE chat_questions DROP CONSTRAINT IF EXISTS chat_questions_answered_option_check;
ALTER TABLE chat_questions ADD CONSTRAINT chat_questions_answered_option_check
  CHECK (answered_option IN ('A', 'B', 'C', 'D'));

-- ═══ chat_question_drafts: new table ═══
CREATE TABLE IF NOT EXISTS chat_question_drafts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question_text TEXT NOT NULL,
  option_count INTEGER NOT NULL DEFAULT 2,
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT,
  option_d TEXT,
  correct_option TEXT NOT NULL CHECK (correct_option IN ('A', 'B', 'C', 'D')),
  time_limit_seconds INTEGER NOT NULL DEFAULT 30,
  hint_text TEXT,
  has_unmatch_risk BOOLEAN DEFAULT false,
  has_chat_lock BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_chat_question_drafts_user ON chat_question_drafts(user_id);

-- ═══ powers: new power types for chat questions ═══
INSERT INTO powers (name, base_cost, green_cost, purple_cost, accuracy_rate, is_active, description)
VALUES
  ('POWER_BLOCK', 40, 120, 40, NULL, true, 'Blocks opponent from using any powers during chat question'),
  ('POWER_UNBLOCK', 50, 150, 50, NULL, true, 'Removes power block, enables power usage')
ON CONFLICT (name) DO UPDATE SET
  base_cost = EXCLUDED.base_cost,
  green_cost = EXCLUDED.green_cost,
  purple_cost = EXCLUDED.purple_cost,
  description = EXCLUDED.description;

-- ═══ Add special_green_reward column to powers table for POWER_UNBLOCK ═══
ALTER TABLE powers ADD COLUMN IF NOT EXISTS special_green_reward INTEGER;
UPDATE powers SET special_green_reward = 140 WHERE name = 'POWER_UNBLOCK';
```

- [ ] **Step 2: Migration'ı Supabase SQL Editor'da çalıştır**

Supabase dashboard → SQL Editor → migration'ı yapıştır ve çalıştır.

- [ ] **Step 3: Doğrulama**

```sql
-- Yeni kolonları kontrol et
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'chat_questions'
ORDER BY ordinal_position;

-- Drafts tablosu var mı?
SELECT COUNT(*) FROM chat_question_drafts;

-- Yeni power'lar var mı?
SELECT name, base_cost, purple_cost, special_green_reward FROM powers WHERE name IN ('POWER_BLOCK', 'POWER_UNBLOCK');
```

- [ ] **Step 4: Commit**

```bash
cd qulo-server && git add migrations/019_chat_question_v2.sql && git commit -m "feat: add migration 019 — chat question v2 schema"
```

---

## Task 2: Server Types, Math Utils & Validators

**Files:**
- Modify: `qulo-server/src/types/index.ts`
- Modify: `qulo-server/src/utils/math.ts`
- Modify: `qulo-server/src/validators/chat-question.validator.ts`

**Spec referans:** Ekonomi + API Değişiklikleri bölümleri

- [ ] **Step 1: types/index.ts — PowerName ve chat question config**

`PowerName` type'ına `POWER_BLOCK` ve `POWER_UNBLOCK` ekle. Chat question limitleri ekle:

```typescript
// types/index.ts — mevcut PowerName'i güncelle:
export type PowerName =
  | "ORACLE"
  | "HALF"
  | "SKIP"
  | "SKIP_ALL"
  | "TIME_EXTEND"
  | "HINT"
  | "POWER_BLOCK"
  | "POWER_UNBLOCK";

// Chat question power'ları (2 şık vs 4 şık için)
export const CHAT_QUESTION_POWERS_2: PowerName[] = ["ORACLE", "SKIP"];
export const CHAT_QUESTION_POWERS_4: PowerName[] = ["ORACLE", "SKIP", "HALF", "HINT", "TIME_EXTEND"];

// Chat question limitleri (subscription tier'a göre)
export const CHAT_QUESTION_LIMITS = {
  free: { daily: 2, unmatchRisk: 1 },
  plus: { daily: 5, unmatchRisk: 2 },
  premium: { daily: Infinity, unmatchRisk: Infinity },
} as const;
```

- [ ] **Step 2: utils/math.ts — calculateGreenReward Math.floor'a çevir**

Spec'e göre aşağı yuvarlama:

```typescript
// Satır 14-16'yı değiştir:
export function calculateGreenReward(purpleSpent: number): number {
  return Math.floor(purpleSpent * GREEN_DIAMOND_REWARD_RATIO);
}
```

- [ ] **Step 3: validators/chat-question.validator.ts — Tüm schema'ları güncelle**

```typescript
import { z } from "zod";

export const createChatQuestionSchema = z.object({
  question_text: z.string().min(3).max(200),
  option_count: z.number().int().refine((v) => v === 2 || v === 4),
  option_a: z.string().min(1).max(100),
  option_b: z.string().min(1).max(100),
  option_c: z.string().min(1).max(100).optional(),
  option_d: z.string().min(1).max(100).optional(),
  correct_option: z.enum(["A", "B", "C", "D"]),
  time_limit_seconds: z.number().int().refine((v) => [15, 30, 45, 60, 90].includes(v)),
  hint_text: z.string().max(200).optional(),
  reward_media_url: z.string().url().optional(),
  reward_media_type: z.enum(["image", "audio"]).optional(),
  has_unmatch_risk: z.boolean().default(false),
  has_chat_lock: z.boolean().default(false),
  use_power_block: z.boolean().default(false),
}).refine(
  (data) => {
    if (data.option_count === 4) {
      return !!data.option_c && !!data.option_d;
    }
    return true;
  },
  { message: "4-option questions require option_c and option_d" },
).refine(
  (data) => {
    if (data.option_count === 2) {
      return data.correct_option === "A" || data.correct_option === "B";
    }
    return true;
  },
  { message: "2-option questions only allow A or B as correct" },
);

export const answerChatQuestionSchema = z.object({
  selected_option: z.enum(["A", "B", "C", "D"]),
  power_used: z.enum(["ORACLE", "SKIP", "HALF", "HINT", "TIME_EXTEND"]).optional(),
  time_spent: z.number().int().min(0).optional(),
});

export const usePowerSchema = z.object({
  power_name: z.enum(["ORACLE", "HALF", "HINT", "TIME_EXTEND", "POWER_UNBLOCK"]),
});

export const saveDraftSchema = z.object({
  question_text: z.string().min(3).max(200),
  option_count: z.number().int().refine((v) => v === 2 || v === 4),
  option_a: z.string().min(1).max(100),
  option_b: z.string().min(1).max(100),
  option_c: z.string().max(100).optional(),
  option_d: z.string().max(100).optional(),
  correct_option: z.enum(["A", "B", "C", "D"]),
  time_limit_seconds: z.number().int().default(30),
  hint_text: z.string().max(200).optional(),
  has_unmatch_risk: z.boolean().default(false),
  has_chat_lock: z.boolean().default(false),
});

export type CreateChatQuestionInput = z.infer<typeof createChatQuestionSchema>;
export type AnswerChatQuestionInput = z.infer<typeof answerChatQuestionSchema>;
export type UsePowerInput = z.infer<typeof usePowerSchema>;
export type SaveDraftInput = z.infer<typeof saveDraftSchema>;
```

- [ ] **Step 4: TypeScript kontrol**

```bash
cd qulo-server && npx tsc --noEmit
```
Expected: Hatalar olacak (service/controller henüz güncellenmedi) — sadece type/validator hataları olmamalı.

- [ ] **Step 5: Commit**

```bash
git add src/types/index.ts src/utils/math.ts src/validators/chat-question.validator.ts
git commit -m "feat: update types, math utils and validators for chat question v2"
```

---

## Task 3: Server — createQuestion Rewrite

**Files:**
- Modify: `qulo-server/src/services/chat-question.service.ts` (createQuestion metodu)

**Spec referans:** Soru Oluşturma + Güç Engeli Mekanizması bölümleri

- [ ] **Step 1: Import'ları güncelle**

```typescript
import { supabase } from "../config/supabase.js";
import { Errors } from "../utils/errors.js";
import { assertUuid } from "../utils/validation.js";
import { diamondService } from "./diamond.service.js";
import { exchangeService } from "./exchange.service.js";
import { matchingService } from "./matching.service.js";
import { NotificationService } from "./notification.service.js";
import { calculatePowerCost, calculateGreenReward } from "../utils/math.js";
import {
  CHAT_QUESTION_LIMITS,
  CHAT_QUESTION_POWERS_2,
  CHAT_QUESTION_POWERS_4,
  GREEN_DIAMOND_REWARD_RATIO,
  type PowerName,
} from "../types/index.js";
```

- [ ] **Step 2: Sabit limitleri kaldır, subscription-aware limit kontrolü ekle**

Mevcut `DAILY_QUESTION_LIMIT`, `DAILY_UNMATCH_RISK_LIMIT`, `NORMAL_QUESTION_COST`, `UNMATCH_RISK_COST` sabitlerini kaldır.

`getUserSubscriptionTier()` helper'ı ekle:

```typescript
private async getUserTier(userId: string): Promise<"free" | "plus" | "premium"> {
  const { data } = await supabase
    .from("user_subscriptions")
    .select("plan")
    .eq("user_id", userId)
    .eq("status", "active")
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();
  return (data?.plan as "plus" | "premium") ?? "free";
}
```

- [ ] **Step 3: createQuestion metodunu yeniden yaz**

Diamond harcamayı kaldır. Yeni alanları ekle. Power block handling:

```typescript
async createQuestion(
  matchId: string,
  senderId: string,
  data: CreateChatQuestionInput,
) {
  const match = await this.verifyMatchAccess(senderId, matchId);
  const tier = await this.getUserTier(senderId);
  const limits = CHAT_QUESTION_LIMITS[tier];

  // Daily limit check
  const todayStart = new Date();
  todayStart.setHours(0, 0, 0, 0);

  const { data: todayQuestions, error: countErr } = await supabase
    .from("chat_questions")
    .select("id, has_unmatch_risk")
    .eq("match_id", matchId)
    .eq("sender_id", senderId)
    .gte("created_at", todayStart.toISOString());

  if (countErr) throw Errors.SERVER_ERROR();

  const questionsToday = todayQuestions?.length ?? 0;
  if (questionsToday >= limits.daily) {
    throw Errors.DAILY_LIMIT_EXCEEDED("chat_questions");
  }

  if (data.has_unmatch_risk) {
    const riskToday = (todayQuestions ?? []).filter((q) => q.has_unmatch_risk).length;
    if (riskToday >= limits.unmatchRisk) {
      throw Errors.DAILY_LIMIT_EXCEEDED("unmatch_risk_questions");
    }
  }

  // Power Block handling
  let hasPowerBlock = false;
  if (data.use_power_block) {
    const usedFromInventory = await exchangeService.tryUseInventory(senderId, "POWER_BLOCK");
    if (!usedFromInventory) {
      const { data: power } = await supabase
        .from("powers")
        .select("purple_cost")
        .eq("name", "POWER_BLOCK")
        .single();
      if (!power) throw Errors.SERVER_ERROR();
      await diamondService.spendPurple(senderId, power.purple_cost, "POWER_BLOCK", matchId);
    }
    hasPowerBlock = true;
  }

  // Insert question (FREE — no diamond cost)
  const insertData: Record<string, unknown> = {
    match_id: matchId,
    sender_id: senderId,
    question_text: data.question_text,
    option_count: data.option_count,
    option_a: data.option_a,
    option_b: data.option_b,
    correct_option: data.correct_option,
    time_limit_seconds: data.time_limit_seconds,
    has_unmatch_risk: data.has_unmatch_risk,
    has_chat_lock: data.has_chat_lock,
    has_power_block: hasPowerBlock,
    diamond_cost: 0,
  };
  if (data.option_c) insertData.option_c = data.option_c;
  if (data.option_d) insertData.option_d = data.option_d;
  if (data.hint_text) insertData.hint_text = data.hint_text;
  if (data.reward_media_url) {
    insertData.reward_media_url = data.reward_media_url;
    insertData.reward_media_type = data.reward_media_type;
  }

  const { data: question, error: insertErr } = await supabase
    .from("chat_questions")
    .insert(insertData)
    .select("*")
    .single();

  if (insertErr) {
    console.error("[chat-question] Insert error:", insertErr);
    throw Errors.SERVER_ERROR();
  }

  // Insert message marker
  await supabase.from("messages").insert({
    match_id: matchId,
    sender_id: senderId,
    content: `__QUESTION__:${question.id}`,
    is_image: false,
  });

  // Push notification
  const otherUserId = match.user1_id === senderId ? match.user2_id : match.user1_id;
  NotificationService.sendPush(otherUserId, "new_message", {}, undefined, {
    actionUrl: `/matches/chat/${matchId}`,
  }).catch(() => {});

  return question;
}
```

- [ ] **Step 4: TypeScript kontrol**

```bash
cd qulo-server && npx tsc --noEmit
```

- [ ] **Step 5: Commit**

```bash
git add src/services/chat-question.service.ts
git commit -m "feat: rewrite createQuestion — free creation, power block, new fields"
```

---

## Task 4: Server — answerQuestion + usePower + timeout

**Files:**
- Modify: `qulo-server/src/services/chat-question.service.ts` (answerQuestion, yeni metotlar)

**Spec referans:** Cevaplama Akışı + Power Sistemi + Süre Bitimi bölümleri

- [ ] **Step 1: usePower metodu ekle**

Power kullanma (cevaplamadan önce veya ayrı olarak). Bu metot ORACLE, HALF, HINT, TIME_EXTEND ve POWER_UNBLOCK power'larını handle eder:

```typescript
async usePower(questionId: string, userId: string, powerName: PowerName) {
  assertUuid(questionId, "questionId");
  const question = await this.fetchQuestion(questionId);
  if (question.sender_id === userId) throw Errors.VALIDATION_ERROR({ sender: "Cannot use powers on own question" });
  if (question.answered_option != null) throw Errors.ALREADY_ANSWERED();

  const match = await this.verifyMatchAccess(userId, question.match_id);

  // Validate power is allowed for this option_count
  const allowedPowers = question.option_count === 2 ? CHAT_QUESTION_POWERS_2 : CHAT_QUESTION_POWERS_4;
  if (powerName !== "POWER_UNBLOCK" && !allowedPowers.includes(powerName)) {
    throw Errors.VALIDATION_ERROR({ power: `Power ${powerName} not available for ${question.option_count}-option questions` });
  }

  // Power block check
  if (powerName !== "POWER_UNBLOCK" && question.has_power_block && !question.power_block_removed) {
    throw Errors.VALIDATION_ERROR({ power: "Powers are blocked. Use POWER_UNBLOCK first." });
  }

  // HINT requires hint_text
  if (powerName === "HINT" && !question.hint_text) {
    throw Errors.VALIDATION_ERROR({ power: "No hint available for this question" });
  }

  // Handle POWER_UNBLOCK
  if (powerName === "POWER_UNBLOCK") {
    if (!question.has_power_block || question.power_block_removed) {
      throw Errors.VALIDATION_ERROR({ power: "No power block to remove" });
    }

    const usedFromInventory = await exchangeService.tryUseInventory(userId, "POWER_UNBLOCK");
    if (!usedFromInventory) {
      const { data: power } = await supabase.from("powers").select("purple_cost").eq("name", "POWER_UNBLOCK").single();
      if (!power) throw Errors.SERVER_ERROR();
      await diamondService.spendPurple(userId, power.purple_cost, "POWER_UNBLOCK", questionId);
    }

    // Special green reward to question sender
    const { data: unblockPower } = await supabase.from("powers").select("special_green_reward").eq("name", "POWER_UNBLOCK").single();
    const greenReward = unblockPower?.special_green_reward ?? 140;
    await diamondService.earnGreen(question.sender_id, greenReward, "POWER_UNBLOCK_REWARD", questionId);

    // Update question
    await supabase.from("chat_questions").update({
      power_block_removed: true,
      powers_used: [...(question.powers_used ?? []), { name: "POWER_UNBLOCK", cost: 0, green_reward: greenReward }],
    }).eq("id", questionId);

    return { power_result: { unblocked: true }, green_reward_to_sender: greenReward };
  }

  // Handle normal powers (ORACLE, HALF, HINT, TIME_EXTEND)
  let cost = 0;
  let greenReward = 0;
  const usedFromInventory = await exchangeService.tryUseInventory(userId, powerName);
  if (!usedFromInventory) {
    const { data: power } = await supabase.from("powers").select("base_cost").eq("name", powerName).single();
    if (!power) throw Errors.SERVER_ERROR();
    cost = calculatePowerCost(power.base_cost, 1); // 1 question
    await diamondService.spendPurple(userId, cost, `POWER_USED:${powerName}`, questionId);
    greenReward = calculateGreenReward(cost);
    if (greenReward > 0) {
      await diamondService.earnGreen(question.sender_id, greenReward, `POWER_REWARD:${powerName}`, questionId);
    }
  }

  // Update powers_used
  await supabase.from("chat_questions").update({
    powers_used: [...(question.powers_used ?? []), { name: powerName, cost, green_reward: greenReward }],
  }).eq("id", questionId);

  // Apply power effect
  const powerResult: Record<string, unknown> = {};
  switch (powerName) {
    case "ORACLE": {
      const { data: power } = await supabase.from("powers").select("accuracy_rate").eq("name", "ORACLE").single();
      const isAccurate = Math.random() < (power?.accuracy_rate ?? 0.7);
      const options = question.option_count === 2 ? ["A", "B"] : ["A", "B", "C", "D"];
      if (isAccurate) {
        powerResult.suggested_option = question.correct_option;
      } else {
        const wrong = options.filter((o) => o !== question.correct_option);
        powerResult.suggested_option = wrong[Math.floor(Math.random() * wrong.length)];
      }
      break;
    }
    case "HALF": {
      const wrong = ["A", "B", "C", "D"].filter((o) => o !== question.correct_option);
      const shuffled = wrong.sort(() => Math.random() - 0.5);
      powerResult.removed_options = shuffled.slice(0, 2);
      break;
    }
    case "HINT": {
      powerResult.hint_text = question.hint_text;
      break;
    }
    case "TIME_EXTEND": {
      powerResult.extra_seconds = 15;
      break;
    }
  }

  return { power_result: powerResult, cost, green_reward: greenReward };
}
```

- [ ] **Step 2: answerQuestion metodunu güncelle**

Mevcut `answerQuestion`'ı güncelle — SKIP power desteği, yeni alanlar, %30 ödül:

```typescript
async answerQuestion(questionId: string, userId: string, selectedOption: string, powerUsed?: string, timeSpent?: number) {
  assertUuid(questionId, "questionId");
  const question = await this.fetchQuestion(questionId);
  if (question.sender_id === userId) throw Errors.VALIDATION_ERROR({ sender: "Cannot answer own question" });
  if (question.answered_option != null) throw Errors.ALREADY_ANSWERED();

  const match = await this.verifyMatchAccess(userId, question.match_id);

  // SKIP power — auto-correct
  if (powerUsed === "SKIP") {
    if (question.has_power_block && !question.power_block_removed) {
      throw Errors.VALIDATION_ERROR({ power: "Powers are blocked" });
    }

    let cost = 0;
    let greenReward = 0;
    const usedFromInventory = await exchangeService.tryUseInventory(userId, "SKIP");
    if (!usedFromInventory) {
      const { data: power } = await supabase.from("powers").select("base_cost").eq("name", "SKIP").single();
      if (!power) throw Errors.SERVER_ERROR();
      cost = calculatePowerCost(power.base_cost, 1);
      await diamondService.spendPurple(userId, cost, "POWER_USED:SKIP", questionId);
      greenReward = calculateGreenReward(cost);
      if (greenReward > 0) {
        await diamondService.earnGreen(question.sender_id, greenReward, "POWER_REWARD:SKIP", questionId);
      }
    }

    const { data: updated } = await supabase.from("chat_questions").update({
      answered_option: question.correct_option,
      is_correct: true,
      answered_at: new Date().toISOString(),
      powers_used: [...(question.powers_used ?? []), { name: "SKIP", cost, green_reward: greenReward }],
    }).eq("id", questionId).select("*").single();

    return {
      question: this.sanitizeQuestion(updated, userId),
      is_correct: true,
      unmatched: false,
      reward_media_url: updated?.reward_media_url ?? null,
    };
  }

  // Normal answer
  const isCorrect = selectedOption === question.correct_option;

  const { data: updated } = await supabase.from("chat_questions").update({
    answered_option: selectedOption,
    is_correct: isCorrect,
    answered_at: new Date().toISOString(),
  }).eq("id", questionId).select("*").single();

  // Unmatch if wrong + risky
  let unmatched = false;
  if (!isCorrect && question.has_unmatch_risk) {
    try {
      await matchingService.unmatch(question.sender_id, match.id);
      unmatched = true;
    } catch {}
  }

  // Push notification
  NotificationService.sendPush(question.sender_id, "chat_question_answered", {
    result: isCorrect ? "correct" : "wrong",
  }, undefined, { actionUrl: `/matches/chat/${question.match_id}` }).catch(() => {});

  return {
    question: this.sanitizeQuestion(updated, userId),
    is_correct: isCorrect,
    unmatched,
    reward_media_url: isCorrect ? (updated?.reward_media_url ?? null) : null,
  };
}
```

- [ ] **Step 3: timeout metodu ekle**

```typescript
async handleTimeout(questionId: string, userId: string) {
  assertUuid(questionId, "questionId");
  const question = await this.fetchQuestion(questionId);
  if (question.sender_id === userId) throw Errors.VALIDATION_ERROR({ sender: "Not the answerer" });
  if (question.answered_option != null) throw Errors.ALREADY_ANSWERED();

  return {
    can_rescue: true,
    has_power_block: question.has_power_block && !question.power_block_removed,
  };
}
```

- [ ] **Step 4: Helper metotları ekle**

```typescript
private async fetchQuestion(questionId: string) {
  const { data, error } = await supabase
    .from("chat_questions")
    .select("*")
    .eq("id", questionId)
    .single();
  if (error || !data) throw Errors.SESSION_NOT_FOUND();
  return data;
}

private sanitizeQuestion(question: any, userId: string) {
  if (question.sender_id !== userId && question.answered_option == null) {
    const { correct_option, ...safe } = question;
    return safe;
  }
  return question;
}
```

- [ ] **Step 5: getQuestion güncelle — yeni alanlarla**

Mevcut `getQuestion` aynı kalır, ek olarak `reward_media_url` ve `reward_media_type` cevaplanmamışsa gizlenmez (bulanık preview frontend'de olacak).

- [ ] **Step 6: TypeScript kontrol**

```bash
cd qulo-server && npx tsc --noEmit
```

- [ ] **Step 7: Commit**

```bash
git add src/services/chat-question.service.ts
git commit -m "feat: add power handling, answer update, use-power and timeout to chat questions"
```

---

## Task 5: Server — Draft/History, Chat Lock, Controller & Routes

**Files:**
- Modify: `qulo-server/src/services/chat-question.service.ts` (draft/history metotları)
- Modify: `qulo-server/src/services/chat.service.ts` (chat lock)
- Modify: `qulo-server/src/controllers/chat-question.controller.ts`
- Modify: `qulo-server/src/routes/chat.routes.ts`

**Spec referans:** Taslak Sistemi + Chat Kilidi + API Değişiklikleri bölümleri

- [ ] **Step 1: Draft/history metotlarını chat-question.service.ts'e ekle**

```typescript
async saveDraft(userId: string, data: SaveDraftInput) {
  const { data: draft, error } = await supabase
    .from("chat_question_drafts")
    .insert({ user_id: userId, ...data })
    .select("*")
    .single();
  if (error) throw Errors.SERVER_ERROR();
  return draft;
}

async getDrafts(userId: string) {
  const { data, error } = await supabase
    .from("chat_question_drafts")
    .select("*")
    .eq("user_id", userId)
    .order("updated_at", { ascending: false })
    .limit(50);
  if (error) throw Errors.SERVER_ERROR();
  return data ?? [];
}

async deleteDraft(userId: string, draftId: string) {
  assertUuid(draftId, "draftId");
  const { error } = await supabase
    .from("chat_question_drafts")
    .delete()
    .eq("id", draftId)
    .eq("user_id", userId);
  if (error) throw Errors.SERVER_ERROR();
  return { success: true };
}

async getHistory(userId: string, page = 1, limit = 20) {
  const offset = (page - 1) * limit;
  const { data, error, count } = await supabase
    .from("chat_questions")
    .select("id, question_text, option_count, option_a, option_b, option_c, option_d, correct_option, time_limit_seconds, hint_text, has_unmatch_risk, has_chat_lock, created_at", { count: "exact" })
    .eq("sender_id", userId)
    .order("created_at", { ascending: false })
    .range(offset, offset + limit - 1);
  if (error) throw Errors.SERVER_ERROR();
  return { items: data ?? [], total: count ?? 0, page, limit };
}
```

- [ ] **Step 2: Chat lock — chat.service.ts sendMessage'a kontrol ekle**

`sendMessage` metodunda medya kontrolünden sonra, chat lock kontrolü ekle:

```typescript
// chat.service.ts sendMessage içine (media check'ten sonra):
// Chat lock check
const { data: lockedQuestion } = await supabase
  .from("chat_questions")
  .select("id")
  .eq("match_id", matchId)
  .eq("has_chat_lock", true)
  .is("answered_option", null)
  .limit(1)
  .maybeSingle();

if (lockedQuestion) {
  throw new AppError("CHAT_LOCKED", 403, "Chat is locked until the question is answered");
}
```

- [ ] **Step 3: Controller handler'ları ekle**

```typescript
// chat-question.controller.ts — yeni handler'lar:

export async function usePowerHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const questionId = req.params.id as string;
    const { power_name } = req.body as UsePowerInput;
    const data = await chatQuestionService.usePower(questionId, userId, power_name as PowerName);
    res.json(data);
  } catch (err) {
    next(err);
  }
}

export async function timeoutHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const questionId = req.params.id as string;
    const data = await chatQuestionService.handleTimeout(questionId, userId);
    res.json(data);
  } catch (err) {
    next(err);
  }
}

export async function saveDraftHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const data = await chatQuestionService.saveDraft(userId, req.body);
    res.status(201).json(data);
  } catch (err) {
    next(err);
  }
}

export async function getDraftsHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const data = await chatQuestionService.getDrafts(userId);
    res.json(data);
  } catch (err) {
    next(err);
  }
}

export async function deleteDraftHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const draftId = req.params.id as string;
    const data = await chatQuestionService.deleteDraft(userId, draftId);
    res.json(data);
  } catch (err) {
    next(err);
  }
}

export async function getHistoryHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const page = parseInt(req.query.page as string) || 1;
    const data = await chatQuestionService.getHistory(userId, page);
    res.json(data);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 4: Route'ları ekle**

```typescript
// chat.routes.ts — yeni route'lar:
import { usePowerSchema, saveDraftSchema } from "../validators/chat-question.validator.js";
import {
  usePowerHandler,
  timeoutHandler,
  saveDraftHandler,
  getDraftsHandler,
  deleteDraftHandler,
  getHistoryHandler,
} from "../controllers/chat-question.controller.js";

// Mevcut question route'larından sonra:
router.post("/questions/:id/use-power", validate(usePowerSchema), usePowerHandler);
router.post("/questions/:id/timeout", timeoutHandler);
router.get("/questions/drafts", getDraftsHandler);
router.post("/questions/drafts", validate(saveDraftSchema), saveDraftHandler);
router.delete("/questions/drafts/:id", deleteDraftHandler);
router.get("/questions/history", getHistoryHandler);
```

**ÖNEMLİ:** `/questions/drafts` ve `/questions/history` route'ları `/questions/:id` route'undan ÖNCE tanımlanmalı, yoksa Express `drafts`/`history` kelimesini `:id` parametresi olarak algılar.

- [ ] **Step 5: Errors.ts'e CHAT_LOCKED ekle**

```typescript
CHAT_LOCKED: () => new AppError("CHAT_LOCKED", 403, "Chat is locked until the question is answered"),
```

- [ ] **Step 6: TypeScript kontrol + server başlat**

```bash
cd qulo-server && npx tsc --noEmit && npm run dev
```

- [ ] **Step 7: API testleri**

Postman/curl ile temel endpoint'leri test et:
- POST `/chat/:matchId/questions` — yeni alanlarla soru oluştur
- GET `/chat/questions/:id` — soruyu getir
- POST `/chat/questions/:id/use-power` — power kullan
- POST `/chat/questions/:id/answer` — cevapla
- GET `/chat/questions/drafts` — taslaklar
- POST `/chat/questions/drafts` — taslak kaydet
- GET `/chat/questions/history` — geçmiş

- [ ] **Step 8: Commit**

```bash
git add src/services/chat-question.service.ts src/services/chat.service.ts src/controllers/chat-question.controller.ts src/routes/chat.routes.ts src/utils/errors.ts
git commit -m "feat: complete server-side chat question v2 — drafts, history, powers, chat lock"
```

---

## Task 6: Flutter — Models & Network Layer

**Files:**
- Modify: `qulov2/lib/data/models/chat_question_model.dart`
- Create: `qulov2/lib/data/models/chat_question_draft_model.dart`
- Modify: `qulov2/lib/core/network/services/chat_service.dart`
- Modify: `qulov2/lib/data/repositories/chat_repository.dart`

**Spec referans:** API Değişiklikleri + Flutter Dosya Yapısı bölümleri

- [ ] **Step 1: ChatQuestionModel güncelle**

Mevcut modele yeni alanlar ekle (option_count, option_c, option_d, time_limit_seconds, hint_text, reward_media_url, reward_media_type, has_chat_lock, has_power_block, power_block_removed, powers_used):

```dart
class ChatQuestionModel {
  final String id;
  final String matchId;
  final String senderId;
  final String questionText;
  final int optionCount;
  final String optionA;
  final String optionB;
  final String? optionC;
  final String? optionD;
  final bool hasUnmatchRisk;
  final int timeLimitSeconds;
  final String? hintText;
  final String? rewardMediaUrl;
  final String? rewardMediaType;
  final bool hasChatLock;
  final bool hasPowerBlock;
  final bool powerBlockRemoved;
  final List<Map<String, dynamic>> powersUsed;
  final int diamondCost;
  final String? answeredOption;
  final bool? isCorrect;
  final String? answeredAt;
  final String createdAt;

  // ... constructor, fromJson, toJson ...
}
```

- [ ] **Step 2: ChatQuestionDraftModel oluştur**

```dart
class ChatQuestionDraftModel {
  final String id;
  final String questionText;
  final int optionCount;
  final String optionA;
  final String optionB;
  final String? optionC;
  final String? optionD;
  final String correctOption;
  final int timeLimitSeconds;
  final String? hintText;
  final bool hasUnmatchRisk;
  final bool hasChatLock;
  final String createdAt;

  // ... constructor, fromJson ...
}
```

- [ ] **Step 3: ChatService — yeni endpoint'ler**

```dart
@POST('/chat/questions/{questionId}/use-power')
Future<Map<String, dynamic>> usePower(
  @Path('questionId') String questionId,
  @Body() Map<String, dynamic> data,
);

@POST('/chat/questions/{questionId}/timeout')
Future<Map<String, dynamic>> handleTimeout(
  @Path('questionId') String questionId,
);

@GET('/chat/questions/drafts')
Future<List<ChatQuestionDraftModel>> getDrafts();

@POST('/chat/questions/drafts')
Future<ChatQuestionDraftModel> saveDraft(@Body() Map<String, dynamic> data);

@DELETE('/chat/questions/drafts/{draftId}')
Future<void> deleteDraft(@Path('draftId') String draftId);

@GET('/chat/questions/history')
Future<Map<String, dynamic>> getHistory(@Query('page') int page);
```

- [ ] **Step 4: ChatRepository — yeni metotlar**

Her endpoint için try/catch + Result pattern ile repository metotları.

- [ ] **Step 5: build_runner çalıştır (Retrofit code gen)**

```bash
cd qulov2 && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 6: Dart analyze**

```bash
cd qulov2 && dart analyze lib/data/models/chat_question_model.dart lib/data/models/chat_question_draft_model.dart lib/core/network/services/chat_service.dart lib/data/repositories/chat_repository.dart
```

- [ ] **Step 7: Commit**

```bash
cd qulov2 && git add lib/data/models/ lib/core/network/services/chat_service.dart lib/core/network/services/chat_service.g.dart lib/data/repositories/chat_repository.dart
git commit -m "feat: flutter models, service and repository for chat question v2"
```

---

## Task 7: Flutter — Create Chat Question Screen (Full Screen Stepper)

**Files:**
- Create: `qulov2/lib/features/chat/screens/create_chat_question_screen.dart`
- Create: `qulov2/lib/features/chat/widgets/chat_question_step1.dart`
- Create: `qulov2/lib/features/chat/widgets/chat_question_step2.dart`
- Create: `qulov2/lib/features/chat/sheets/draft_history_sheet.dart`
- Delete: `qulov2/lib/features/chat/sheets/create_question_sheet.dart`
- Modify: `qulov2/lib/routing/route_names.dart`
- Modify: `qulov2/lib/routing/app_router.dart`

**Spec referans:** Soru Oluşturma bölümü

- [ ] **Step 1: Route tanımla**

`route_names.dart`'a `createChatQuestion` ekle. `app_router.dart`'a route ekle — `matchId` parametresi ile.

- [ ] **Step 2: Step 1 widget — Soru içeriği**

`chat_question_step1.dart`: Şık sayısı toggle (2/4), soru metni TextField, şık TextField'ları (2 veya 4), doğru cevap radio seçimi. Form validation (min 3 char soru, her şık dolu, doğru cevap seçili).

- [ ] **Step 3: Step 2 widget — Ayarlar**

`chat_question_step2.dart`: Süre chip'leri (15/30/45/60/90), ipucu TextField (opsiyonel), ödül medya seçici (fotoğraf/ses — mevcut `imagePickerManagerProvider` + `chatRepositoryProvider.uploadMedia()` kullanılır), unmatch checkbox, chat lock toggle, Power Block toggle (envanterden/satın al).

- [ ] **Step 4: CreateChatQuestionScreen — Stepper**

Full screen, `Stepper` veya custom `PageView` ile 2 adım. "İleri" / "Geri" / "Gönder" / "Taslak Kaydet" butonları. Gönderimde API çağrısı + navigation pop.

- [ ] **Step 5: DraftHistorySheet**

Bottom sheet: 2 tab (Taslaklar / Geçmiş). Liste görünümü. Seçildiğinde callback ile soru verilerini döndürür → CreateChatQuestionScreen alanları doldurulur.

- [ ] **Step 6: Mevcut create_question_sheet.dart referanslarını güncelle**

Chat mixin'deki soru oluşturma butonunu yeni route'a yönlendir. Eski bottom sheet'i kaldır.

- [ ] **Step 7: Dart analyze**

```bash
cd qulov2 && dart analyze lib/features/chat/screens/create_chat_question_screen.dart lib/features/chat/widgets/chat_question_step1.dart lib/features/chat/widgets/chat_question_step2.dart
```

- [ ] **Step 8: Commit**

```bash
git commit -m "feat: create chat question screen — full screen stepper with drafts"
```

---

## Task 8: Flutter — Solve Question Screen (Power Bar, Timer, Answer)

**Files:**
- Create: `qulov2/lib/features/chat/screens/solve_chat_question_screen.dart`
- Create: `qulov2/lib/features/chat/widgets/chat_question_power_bar.dart`
- Create: `qulov2/lib/features/chat/widgets/chat_question_rescue.dart`
- Create: `qulov2/lib/features/chat/widgets/chat_question_result.dart`
- Create: `qulov2/lib/features/chat/widgets/reward_media_reveal.dart`
- Create: `qulov2/lib/features/chat/widgets/blurred_media_preview.dart`

**Spec referans:** Cevaplama Akışı + Power Sistemi + Süre Bitimi + Sonuç Ekranı bölümleri

- [ ] **Step 1: SolveChatQuestionScreen**

Full screen: üstte CountdownTimer, ortada soru + şıklar, altta PowerBar. State: `_timeRemaining`, `_selectedOption`, `_removedOptions`, `_suggestedOption`, `_hintVisible`, `_isAnswering`.

Timer `time_limit_seconds`'dan başlar. Süre bitince rescue dialog/sheet göster.

- [ ] **Step 2: ChatQuestionPowerBar**

2 şık: ORACLE + SKIP butonları. 4 şık: ORACLE + SKIP + HALF + HINT + TIME_EXTEND. Power block aktifse → hepsi kilitli + POWER_UNBLOCK butonu görünür. Her power butonu tıklandığında `usePower` API çağrısı → sonucu UI'a uygula.

Mevcut quiz ekranındaki `PowerBar` widget'ından pattern alınır ama kopyalanmaz — chat question'a özel yeni widget.

- [ ] **Step 3: ChatQuestionRescue**

Süre bittiğinde açılan dialog/bottom sheet. SKIP butonu (maliyeti göster). Power block aktifse: önce POWER_UNBLOCK butonu, sonra SKIP. "Vazgeç" butonu → yanlış cevap olarak işle.

- [ ] **Step 4: ChatQuestionResult**

Doğru/yanlış feedback ekranı. Doğru: yeşil ikon + mesaj + ödül medya reveal (varsa). Yanlış: kırmızı ikon + mesaj + unmatch bildirimi (varsa) + kilitli medya.

- [ ] **Step 5: RewardMediaReveal**

Animasyonlu widget: bulanık fotoğraf → netleşme (AnimatedContainer + ImageFiltered blur değeri 0'a düşer). Ses için: kilitli ikon → play butonu reveal.

- [ ] **Step 6: BlurredMediaPreview**

CachedNetworkImage + ImageFilter.blur(sigmaX: 20, sigmaY: 20) + kilit ikonu overlay. Ses için: generic "ses" ikonu + kilit.

- [ ] **Step 7: Dart analyze**

```bash
cd qulov2 && dart analyze lib/features/chat/screens/solve_chat_question_screen.dart
```

- [ ] **Step 8: Commit**

```bash
git commit -m "feat: solve chat question screen — timer, powers, rescue, result, reward reveal"
```

---

## Task 9: Flutter — Chat Question Card Update + Chat Lock UI

**Files:**
- Modify: `qulov2/lib/features/chat/widgets/chat_question_card.dart`
- Modify: `qulov2/lib/features/chat/widgets/chat_question_message.dart`
- Modify: `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart`
- Modify: `qulov2/lib/providers/chat_provider.dart`

**Spec referans:** Chat'te Görünüm + Chat Kilidi bölümleri

- [ ] **Step 1: chat_question_card.dart güncelle**

- 4 şıklı soru desteği (C/D şıkları)
- "Aç" butonu: cevaplayıcı için → `SolveChatQuestionScreen`'e navigate
- Bulanık medya preview (ödül medya varsa)
- Power block badge (güç engeli aktifse)
- Chat lock badge (kilit aktifse)
- Mevcut doğrudan cevaplama yerine "Aç" ile tam ekrana git

- [ ] **Step 2: chat_question_message.dart güncelle**

Yeni model alanlarıyla uyumlu hale getir. Artık doğrudan cevaplama yapmıyor — "Aç" butonu ile `SolveChatQuestionScreen`'e yönlendiriyor.

- [ ] **Step 3: Chat lock UI — chat_screen_mixin.dart**

Chat state'ten aktif lock kontrolü. Lock varsa input bar'ı devre dışı bırak + bilgi mesajı göster.

```dart
bool get _hasChatLock {
  final state = ref.read(chatProvider(widget.matchId)).valueOrNull;
  return state?.hasChatLock ?? false;
}
```

Chat input widget'ında `_hasChatLock` true ise: TextField disabled + "Soruyu cevaplayın" overlay.

- [ ] **Step 4: chat_provider.dart — chat lock state**

`ChatState`'e `hasChatLock` alanı ekle. `loadMessages` veya `loadMediaStatus` gibi bir init flow'da aktif lock kontrolü.

- [ ] **Step 5: Dart analyze**

```bash
cd qulov2 && dart analyze lib/features/chat/widgets/chat_question_card.dart lib/features/chat/widgets/chat_question_message.dart lib/features/chat/mixins/chat_screen_mixin.dart lib/providers/chat_provider.dart
```

- [ ] **Step 6: Commit**

```bash
git commit -m "feat: update chat question card — 4 options, open button, blurred media, chat lock"
```

---

## Task 10: Manuel Test + Polish

- [ ] **Step 1: Full rebuild (Local Dev)**

IntelliJ'den "Local Dev" run config ile full rebuild. `dart-define` compile-time sabitleri değiştiğinden hot restart yetmez.

- [ ] **Step 2: Test senaryoları**

| Senaryo | Beklenen |
|---------|----------|
| 2 şıklı soru oluştur (ücretsiz) | Diamond harcanmaz, soru chat'te görünür |
| 4 şıklı soru oluştur | C/D şıkları giriliyor, doğru cevap seçilebilir |
| Ödül medya ekle (fotoğraf) | Upload başarılı, kartta bulanık preview |
| Süre seçimi (15s) | Chip seçili, soru açılınca 15s geri sayım |
| İpucu ekle | HINT power'ı kullanınca ipucu görünür |
| Unmatch checkbox | Yanlış cevapta unmatch tetiklenir |
| Chat kilidi toggle | Soru cevaplanana kadar input devre dışı |
| Power Block aktif et | Cevaplayıcı güçler kilitli görür |
| Soruyu "Aç" butonu ile aç | Tam ekran soru çözme açılır, süre başlar |
| ORACLE power kullan (4 şık) | Bir şık önerilir |
| HALF power kullan (4 şık) | 2 yanlış şık elenir |
| SKIP power kullan | Soru doğru sayılır, ödül medya açılır |
| Power Unblock (Y) kullan | Engel kalkar, güçler açılır, yüksek yeşil ödül |
| Süre bitimi → kurtarma | SKIP ile kurtar veya yanlış cevap |
| Süre bitimi + Power Block | Önce Unblock, sonra SKIP |
| Doğru cevap → medya reveal | Bulanık → netleşme animasyonu |
| Yanlış cevap → medya kilitli | Bulanık kalır |
| Taslak kaydet | Kayıt başarılı, taslaklar listesinde görünür |
| Taslaktan soru oluştur | Alanlar dolu gelir, medya boş |
| Geçmişten soru tekrar gönder | Alanlar kopyalanır |
| Günlük limit (Free tier) | 2'den sonra hata mesajı |
