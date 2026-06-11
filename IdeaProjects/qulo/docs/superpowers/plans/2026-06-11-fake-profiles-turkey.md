# Fake Profile Seeding for Turkey — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 350 unique AI-generated Turkish women seed profiles in Supabase, marked with `is_seed_profile=true` for clean removal later. Each profile has 1 photo (Replicate Flux), 3 questions (from `ai_question_bank`), realistic Turkish bio, distributed across 15 major cities.

**Architecture:** Two-stage CLI pipeline. Stage 1 generates 350 photos via Replicate, caches locally + uploads to Supabase Storage, writes manifest. Stage 2 reads manifest + name/bio pools + random questions, inserts users + user_details + user_languages + questions per profile. Cleanup script removes all `is_seed_profile=true` rows + storage objects.

**Tech Stack:** TypeScript, tsx, vitest, Supabase (@supabase/supabase-js), Replicate SDK, bcryptjs, Node 20+, Postgres.

**Spec:** `docs/superpowers/specs/2026-06-11-fake-profiles-turkey-design.md`

---

## File Structure

```
qulo-server/
├─ migrations/
│   └─ 027_is_seed_profile.sql                          NEW
├─ scripts/seed/
│   ├─ data/
│   │   ├─ tr-cities.ts                                 NEW
│   │   ├─ tr-female-names.ts                           NEW
│   │   ├─ tr-bio-pool.ts                               NEW
│   │   └─ photo-prompt-pools.ts                        NEW
│   ├─ lib/
│   │   ├─ random.ts                                    NEW
│   │   ├─ replicate.ts                                 NEW
│   │   └─ storage.ts                                   NEW
│   ├─ generate-seed-photos.ts                          NEW
│   ├─ seed-fake-tr-profiles.ts                         NEW
│   ├─ delete-fake-tr-profiles.ts                       NEW
│   └─ output/
│       └─ photos-manifest.json                         GENERATED (gitignored)
├─ seed-photos-cache/                                   GENERATED (gitignored)
│   └─ tr_001.jpg ... tr_350.jpg
├─ tests/seed/
│   ├─ data.test.ts                                     NEW
│   └─ random.test.ts                                   NEW
├─ package.json                                         MODIFY (add replicate dep)
├─ .env.example                                         MODIFY (add REPLICATE_API_TOKEN)
└─ .gitignore                                           MODIFY (add seed cache/output)
```

---

## Task 1: Project setup — dependencies, env, gitignore

**Files:**
- Modify: `qulo-server/package.json`
- Modify: `qulo-server/.env.example`
- Modify: `qulo-server/.gitignore`

- [ ] **Step 1: Install Replicate SDK**

Run from `/Users/berkantcalikusu/IdeaProjects/qulo/qulo-server`:
```bash
npm install replicate@^1.0.0
```

Expected: `replicate` added to dependencies in `package.json`, no warnings.

- [ ] **Step 2: Add REPLICATE_API_TOKEN to .env.example**

Append this line to `qulo-server/.env.example`:
```
REPLICATE_API_TOKEN=
```

- [ ] **Step 3: Update .gitignore to exclude seed caches**

Append to `qulo-server/.gitignore`:
```
seed-photos-cache/
scripts/seed/output/
```

- [ ] **Step 4: Add real token to local .env**

User obtains a Replicate API token from https://replicate.com/account/api-tokens and appends to `qulo-server/.env`:
```
REPLICATE_API_TOKEN=r8_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

(Not committed — `.env` is gitignored.)

- [ ] **Step 5: Commit**

```bash
git add qulo-server/package.json qulo-server/package-lock.json qulo-server/.env.example qulo-server/.gitignore
git commit -m "chore(seed): install Replicate SDK + env scaffolding for seed pipeline

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 2: Database migration — `is_seed_profile` column

**Files:**
- Create: `qulo-server/migrations/027_is_seed_profile.sql`

- [ ] **Step 1: Write migration SQL**

Create `qulo-server/migrations/027_is_seed_profile.sql`:

```sql
-- 027_is_seed_profile.sql
-- Mark fake/seed profiles for clean removal later.
-- Discover/match flows do NOT filter on this column — seed profiles
-- behave exactly like real users until cleanup.

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS is_seed_profile BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_users_is_seed_profile
  ON users(is_seed_profile)
  WHERE is_seed_profile = true;
```

- [ ] **Step 2: Apply migration to Supabase**

Use Supabase MCP `apply_migration` tool with name `is_seed_profile` and the SQL from Step 1. Project ref: `vtntrtozgoyhjdvvurkj`.

Alternative (if MCP unavailable): Apply via Supabase SQL Editor in dashboard.

- [ ] **Step 3: Verify column exists**

Use Supabase MCP `execute_sql`:
```sql
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name='users' AND column_name='is_seed_profile';
```

Expected: 1 row → `is_seed_profile | boolean | NO | false`.

- [ ] **Step 4: Verify index exists**

```sql
SELECT indexname FROM pg_indexes WHERE tablename='users' AND indexname='idx_users_is_seed_profile';
```

Expected: 1 row.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/migrations/027_is_seed_profile.sql
git commit -m "feat(db): add is_seed_profile column to users for seed cleanup

Migration 027. Boolean column + partial index. Discover/match flows
do not filter on this — seed profiles behave like real users until
cleanup script removes them.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 3: Random utility module + tests

**Files:**
- Create: `qulo-server/scripts/seed/lib/random.ts`
- Test: `qulo-server/tests/seed/random.test.ts`

- [ ] **Step 1: Write failing tests**

Create `qulo-server/tests/seed/random.test.ts`:

```ts
import { describe, it, expect } from 'vitest';
import { rand, jitter, pickRandom, weightedPick, sample } from '../../scripts/seed/lib/random.js';

describe('rand', () => {
  it('returns integer in [min, max] inclusive', () => {
    for (let i = 0; i < 100; i++) {
      const r = rand(1, 4);
      expect(Number.isInteger(r)).toBe(true);
      expect(r).toBeGreaterThanOrEqual(1);
      expect(r).toBeLessThanOrEqual(4);
    }
  });

  it('returns the only value when min==max', () => {
    expect(rand(7, 7)).toBe(7);
  });
});

describe('jitter', () => {
  it('returns value in [-magnitude, magnitude]', () => {
    for (let i = 0; i < 100; i++) {
      const j = jitter(0.05);
      expect(j).toBeGreaterThanOrEqual(-0.05);
      expect(j).toBeLessThanOrEqual(0.05);
    }
  });
});

describe('pickRandom', () => {
  it('returns an element from the array', () => {
    const arr = ['a', 'b', 'c'];
    for (let i = 0; i < 50; i++) {
      expect(arr).toContain(pickRandom(arr));
    }
  });

  it('throws on empty array', () => {
    expect(() => pickRandom([])).toThrow();
  });
});

describe('weightedPick', () => {
  it('respects weights statistically', () => {
    const weights = { A: 90, B: 10 };
    const counts = { A: 0, B: 0 };
    for (let i = 0; i < 10000; i++) {
      counts[weightedPick(weights)]++;
    }
    expect(counts.A).toBeGreaterThan(8500);
    expect(counts.A).toBeLessThan(9500);
  });

  it('throws when weights sum to 0', () => {
    expect(() => weightedPick({ A: 0, B: 0 })).toThrow();
  });
});

describe('sample', () => {
  it('returns N unique elements', () => {
    const arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    const picked = sample(arr, 5);
    expect(picked.length).toBe(5);
    expect(new Set(picked).size).toBe(5);
    for (const p of picked) expect(arr).toContain(p);
  });

  it('throws when N > arr.length', () => {
    expect(() => sample([1, 2], 5)).toThrow();
  });
});
```

- [ ] **Step 2: Run tests to verify they fail**

Run from `qulo-server/`:
```bash
npx vitest run tests/seed/random.test.ts
```

Expected: All tests fail with "Cannot find module" since `scripts/seed/lib/random.ts` does not exist yet.

- [ ] **Step 3: Implement random utility**

Create `qulo-server/scripts/seed/lib/random.ts`:

```ts
/**
 * Random utility helpers for seed scripts.
 * Pure functions, no side effects.
 */

export function rand(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

export function jitter(magnitude: number): number {
  return (Math.random() * 2 - 1) * magnitude;
}

export function pickRandom<T>(arr: readonly T[]): T {
  if (arr.length === 0) throw new Error('pickRandom: empty array');
  return arr[Math.floor(Math.random() * arr.length)]!;
}

export function weightedPick<K extends string>(weights: Record<K, number>): K {
  const total = Object.values(weights).reduce((a, b) => (a as number) + (b as number), 0) as number;
  if (total <= 0) throw new Error('weightedPick: total weight must be > 0');
  let r = Math.random() * total;
  for (const [key, w] of Object.entries(weights) as [K, number][]) {
    r -= w;
    if (r <= 0) return key;
  }
  // Floating point fallback
  return Object.keys(weights)[Object.keys(weights).length - 1] as K;
}

export function sample<T>(arr: readonly T[], n: number): T[] {
  if (n > arr.length) throw new Error(`sample: n=${n} > arr.length=${arr.length}`);
  const copy = [...arr];
  const out: T[] = [];
  for (let i = 0; i < n; i++) {
    const idx = Math.floor(Math.random() * copy.length);
    out.push(copy.splice(idx, 1)[0]!);
  }
  return out;
}
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
npx vitest run tests/seed/random.test.ts
```

Expected: All tests pass (green).

- [ ] **Step 5: Commit**

```bash
git add qulo-server/scripts/seed/lib/random.ts qulo-server/tests/seed/random.test.ts
git commit -m "feat(seed): add random utility module with tests

rand, jitter, pickRandom, weightedPick, sample — pure helpers used
by photo gen + profile seed scripts.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 4: TR cities data + integrity test

**Files:**
- Create: `qulo-server/scripts/seed/data/tr-cities.ts`
- Test: `qulo-server/tests/seed/data.test.ts` (cities portion)

- [ ] **Step 1: Write failing test for cities data**

Create `qulo-server/tests/seed/data.test.ts`:

```ts
import { describe, it, expect } from 'vitest';
import { TR_CITIES, TOTAL_QUOTA } from '../../scripts/seed/data/tr-cities.js';

describe('TR_CITIES', () => {
  it('quotas sum to 350', () => {
    const sum = TR_CITIES.reduce((acc, c) => acc + c.count, 0);
    expect(sum).toBe(350);
    expect(TOTAL_QUOTA).toBe(350);
  });

  it('all cities have valid lat/lng in Turkey bounds', () => {
    for (const c of TR_CITIES) {
      expect(c.lat).toBeGreaterThan(35);   // Turkey south ≈ 36.0
      expect(c.lat).toBeLessThan(43);      // Turkey north ≈ 42.1
      expect(c.lng).toBeGreaterThan(25);   // Turkey west ≈ 26.0
      expect(c.lng).toBeLessThan(45);      // Turkey east ≈ 44.8
    }
  });

  it('all city names are unique non-empty strings', () => {
    const names = TR_CITIES.map(c => c.name);
    expect(new Set(names).size).toBe(names.length);
    for (const n of names) expect(n.length).toBeGreaterThan(0);
  });

  it('all counts are positive integers', () => {
    for (const c of TR_CITIES) {
      expect(Number.isInteger(c.count)).toBe(true);
      expect(c.count).toBeGreaterThan(0);
    }
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: Fails with "Cannot find module".

- [ ] **Step 3: Create cities data file**

Create `qulo-server/scripts/seed/data/tr-cities.ts`:

```ts
export interface TrCity {
  name: string;
  lat: number;
  lng: number;
  count: number;
}

export const TR_CITIES: TrCity[] = [
  { name: 'İstanbul',    lat: 41.0082, lng: 28.9784, count: 80 },
  { name: 'Ankara',      lat: 39.9334, lng: 32.8597, count: 50 },
  { name: 'İzmir',       lat: 38.4192, lng: 27.1287, count: 40 },
  { name: 'Bursa',       lat: 40.1885, lng: 29.0610, count: 25 },
  { name: 'Antalya',     lat: 36.8969, lng: 30.7133, count: 25 },
  { name: 'Adana',       lat: 37.0000, lng: 35.3213, count: 18 },
  { name: 'Konya',       lat: 37.8746, lng: 32.4932, count: 18 },
  { name: 'Gaziantep',   lat: 37.0662, lng: 37.3833, count: 18 },
  { name: 'Kayseri',     lat: 38.7322, lng: 35.4853, count: 14 },
  { name: 'Eskişehir',   lat: 39.7767, lng: 30.5206, count: 14 },
  { name: 'Trabzon',     lat: 41.0027, lng: 39.7168, count: 14 },
  { name: 'Mersin',      lat: 36.8121, lng: 34.6415, count: 14 },
  { name: 'Samsun',      lat: 41.2867, lng: 36.3300, count: 12 },
  { name: 'Diyarbakır',  lat: 37.9144, lng: 40.2306, count: 10 },
  { name: 'Erzurum',     lat: 39.9000, lng: 41.2700, count: 8  },
];

export const TOTAL_QUOTA = TR_CITIES.reduce((a, c) => a + c.count, 0);
```

- [ ] **Step 4: Run tests to verify pass**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: All 4 cities tests pass.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/scripts/seed/data/tr-cities.ts qulo-server/tests/seed/data.test.ts
git commit -m "feat(seed): add Turkey city distribution data (350 quota)

15 cities, population-weighted distribution: İstanbul 80, Ankara 50,
İzmir 40, ... Erzurum 8. Total = 350.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 5: TR female names data + tests

**Files:**
- Create: `qulo-server/scripts/seed/data/tr-female-names.ts`
- Modify: `qulo-server/tests/seed/data.test.ts` (add names tests)

- [ ] **Step 1: Append failing test for names**

Append to `qulo-server/tests/seed/data.test.ts`:

```ts
import { TR_FEMALE_FIRST_NAMES, TR_SURNAMES } from '../../scripts/seed/data/tr-female-names.js';

describe('TR_FEMALE_FIRST_NAMES', () => {
  it('has at least 60 unique entries', () => {
    expect(TR_FEMALE_FIRST_NAMES.length).toBeGreaterThanOrEqual(60);
    expect(new Set(TR_FEMALE_FIRST_NAMES).size).toBe(TR_FEMALE_FIRST_NAMES.length);
  });

  it('all entries are non-empty trimmed strings', () => {
    for (const n of TR_FEMALE_FIRST_NAMES) {
      expect(n.length).toBeGreaterThan(0);
      expect(n).toBe(n.trim());
    }
  });
});

describe('TR_SURNAMES', () => {
  it('has at least 80 unique entries', () => {
    expect(TR_SURNAMES.length).toBeGreaterThanOrEqual(80);
    expect(new Set(TR_SURNAMES).size).toBe(TR_SURNAMES.length);
  });

  it('combinatorial space supports 350 unique pairs', () => {
    expect(TR_FEMALE_FIRST_NAMES.length * TR_SURNAMES.length).toBeGreaterThan(350 * 10);
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: New tests fail with "Cannot find module".

- [ ] **Step 3: Create names data file**

Create `qulo-server/scripts/seed/data/tr-female-names.ts`:

```ts
export const TR_FEMALE_FIRST_NAMES: string[] = [
  'Ayşe', 'Fatma', 'Emine', 'Hatice', 'Zeynep', 'Elif', 'Merve', 'Selin',
  'Esra', 'Burcu', 'Deniz', 'Ece', 'Pınar', 'Tuğçe', 'Beyza', 'Gizem',
  'Ceren', 'Damla', 'Esma', 'İrem', 'Yağmur', 'Defne', 'Aslı', 'Berfin',
  'Eda', 'Sude', 'Naz', 'Melisa', 'Buse', 'Cansu', 'Ezgi', 'Şeyma',
  'Tuba', 'Sema', 'Hande', 'Begüm', 'Dilara', 'Sıla', 'Nehir', 'Öykü',
  'Lara', 'Mira', 'Nisa', 'Rüya', 'Çağla', 'Tülin', 'Sevgi', 'Müge',
  'Gözde', 'Burcu', 'Yasemin', 'Banu', 'Filiz', 'Gül', 'Nazan', 'Sevda',
  'Tülay', 'Songül', 'Berna', 'Ebru', 'Aysu', 'Pelin', 'Sinem', 'Tülin',
  'Funda', 'Gamze', 'Hülya', 'İlknur', 'Kübra', 'Leyla', 'Müjgan', 'Nilgün',
  'Özlem', 'Reyhan', 'Sevim', 'Tülin', 'Ülkü', 'Vildan', 'Yelda', 'Zehra',
].filter((v, i, a) => a.indexOf(v) === i);

export const TR_SURNAMES: string[] = [
  'Yılmaz', 'Kaya', 'Demir', 'Çelik', 'Şahin', 'Aydın', 'Öztürk', 'Doğan',
  'Arslan', 'Polat', 'Aslan', 'Çetin', 'Kaplan', 'Özdemir', 'Tekin', 'Korkmaz',
  'Erdoğan', 'Aksoy', 'Güneş', 'Acar', 'Koç', 'Kurt', 'Şimşek', 'Avcı',
  'Erdem', 'Yıldız', 'Karadağ', 'Bulut', 'Yıldırım', 'Özkan', 'Karaca', 'Tunç',
  'Güler', 'Pekkan', 'Akın', 'Çakır', 'Yavuz', 'Sezer', 'Topal', 'Türk',
  'Türkmen', 'Uçar', 'Uysal', 'Yalçın', 'Yener', 'Yiğit', 'Zengin', 'Ateş',
  'Bayrak', 'Bilgin', 'Çoban', 'Demirci', 'Duran', 'Ekinci', 'Engin', 'Genç',
  'Güven', 'Hoca', 'İnan', 'Kara', 'Kavak', 'Keser', 'Kıvanç', 'Köse',
  'Kuru', 'Mert', 'Nazlı', 'Ocak', 'Okay', 'Önal', 'Özbek', 'Özcan',
  'Özen', 'Özer', 'Özgür', 'Pala', 'Pamuk', 'Parlak', 'Saraç', 'Sarı',
  'Savaş', 'Sayar', 'Sayın', 'Selen', 'Soylu', 'Sönmez', 'Şen', 'Taş',
  'Taşkın', 'Tezcan', 'Toker', 'Tosun', 'Tuna', 'Türker', 'Üner', 'Yağız',
  'Yaman', 'Yenidoğan', 'Yorulmaz', 'Yurt',
].filter((v, i, a) => a.indexOf(v) === i);
```

(Note: `.filter` deduplicates in case future edits add duplicates.)

- [ ] **Step 4: Run tests to verify they pass**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: All names tests pass.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/scripts/seed/data/tr-female-names.ts qulo-server/tests/seed/data.test.ts
git commit -m "feat(seed): add Turkish female name + surname pools

~70 first names + ~100 surnames, ~7000 combinations supports 350
unique name pairs with margin.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 6: TR bio pool + bio renderer + tests

**Files:**
- Create: `qulo-server/scripts/seed/data/tr-bio-pool.ts`
- Modify: `qulo-server/tests/seed/data.test.ts` (add bio tests)

- [ ] **Step 1: Append failing test for bio**

Append to `qulo-server/tests/seed/data.test.ts`:

```ts
import { TR_BIO_TEMPLATES, TR_HOBBIES, TR_TRAITS, TR_JOBS, renderBio } from '../../scripts/seed/data/tr-bio-pool.js';

describe('TR bio pools', () => {
  it('templates have at least 15 entries', () => {
    expect(TR_BIO_TEMPLATES.length).toBeGreaterThanOrEqual(15);
  });

  it('hobbies/traits/jobs pools have enough entries', () => {
    expect(TR_HOBBIES.length).toBeGreaterThanOrEqual(20);
    expect(TR_TRAITS.length).toBeGreaterThanOrEqual(10);
    expect(TR_JOBS.length).toBeGreaterThanOrEqual(20);
  });

  it('renderBio returns a non-empty string without placeholders', () => {
    for (let i = 0; i < 50; i++) {
      const bio = renderBio('İstanbul', 'Mimar');
      expect(bio.length).toBeGreaterThan(10);
      expect(bio).not.toMatch(/\{[a-z_]+\}/);
    }
  });

  it('renderBio substitutes city and job into output', () => {
    let cityHit = 0;
    let jobHit = 0;
    for (let i = 0; i < 50; i++) {
      const bio = renderBio('İzmir', 'Avukat');
      if (bio.includes('İzmir')) cityHit++;
      if (bio.includes('Avukat')) jobHit++;
    }
    // Some templates use {city}, some {job} — both should hit in 50 runs
    expect(cityHit).toBeGreaterThan(5);
    expect(jobHit).toBeGreaterThan(5);
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: New tests fail with "Cannot find module".

- [ ] **Step 3: Create bio pool**

Create `qulo-server/scripts/seed/data/tr-bio-pool.ts`:

```ts
import { pickRandom, sample } from '../lib/random.js';

export const TR_BIO_TEMPLATES: string[] = [
  '{city}\'da {job} olarak çalışıyorum. {hobby} ve {hobby2} tutkusu.',
  'Sabahları kahve, akşamları {hobby}. {city}\'da yaşayan bir {job}.',
  '{job}\'um, hayata {trait} bakarım. {hobby} dolu bir hayat.',
  '{city}\'lıyım, {job} hayatımı dolduruyor. Boş zamanlarımda {hobby}.',
  'Hafta içi {job}, hafta sonu {hobby}. {city} sevdalısı.',
  '{trait} biri, {hobby} ile rahatlarım. {job} olarak çalışıyorum.',
  '{city}\'da yeni bir maceraya hazır. {hobby} ve iyi sohbet bekliyorum.',
  '{hobby} en büyük tutkum. {job}, {city}, kahve — bu kadar.',
  'Hayatımı {trait} yaşıyorum. {job}, {hobby} ve {hobby2}.',
  'Bir {job}\'um, {hobby} bana iyi geliyor. {city} kalbim.',
  '{hobby2} ile günümü kapatırım. {city}\'da {job} olarak yoluma devam.',
  'Hayatın küçük detaylarına {trait} bakarım. {hobby} ve sıcak sohbet.',
  '{city}\'da büyüdüm, {job} olarak çalışıyorum. {hobby} severim.',
  'İçimde bir gezgin var. {hobby2}, {hobby} ve {city} güneşi.',
  'Bazen {hobby}, bazen kitap. {job} olmak bana özgürlük veriyor.',
  '{city} sokakları, {hobby} ve iyi müzik — benim hayatım.',
  '{trait} bir bakış açısıyla yaşıyorum. {job}, {hobby}, {city}.',
  'Pazarlık severim ama sevgide değil. {city}\'da {job}.',
  'Hayat kısa, {hobby} uzun. {city}\'lı bir {job}.',
  '{job}\'um ama her zaman bir sanatçı kalbim var. {hobby2} tutkum.',
];

export const TR_HOBBIES: string[] = [
  'kahve', 'kitap okumak', 'yoga', 'koşu', 'müzik', 'dans', 'yemek yapma',
  'sinema', 'seyahat', 'doğa yürüyüşü', 'fotoğraf', 'resim', 'dil öğrenme',
  'podcast', 'pilates', 'bahçe işleri', 'yüzme', 'bisiklet', 'tiyatro',
  'konser', 'müze gezmek', 'kamp', 'pasta yapmak', 'el işi', 'puzzle',
];

export const TR_TRAITS: string[] = [
  'pozitif', 'gerçekçi', 'meraklı', 'sakin', 'tutkulu', 'hayalperest',
  'dürüst', 'samimi', 'azimli', 'huzurlu', 'meraklı', 'esprili',
  'sabırlı', 'cesur', 'dengeli',
];

export const TR_JOBS: string[] = [
  'Öğretmen', 'Hemşire', 'Pazarlama Uzmanı', 'Grafik Tasarımcı', 'Avukat',
  'Mimar', 'Diyetisyen', 'İnsan Kaynakları Uzmanı', 'Yazılım Geliştirici',
  'Editör', 'Mühendis', 'Doktor', 'Eczacı', 'Psikolog', 'Mali Müşavir',
  'Pazarlamacı', 'Sosyal Medya Uzmanı', 'Mağaza Müdürü', 'Veteriner',
  'Fotoğrafçı', 'Çevirmen', 'Veri Analisti', 'UI/UX Tasarımcı',
  'Halkla İlişkiler Uzmanı', 'Müzisyen', 'Yazar', 'Etkinlik Koordinatörü',
  'Kuaför', 'Antrenör', 'Reklam Yöneticisi',
];

export function renderBio(city: string, job: string): string {
  const template = pickRandom(TR_BIO_TEMPLATES);
  const [hobby, hobby2] = sample(TR_HOBBIES, 2);
  const trait = pickRandom(TR_TRAITS);
  return template
    .replaceAll('{city}', city)
    .replaceAll('{job}', job)
    .replaceAll('{hobby2}', hobby2)
    .replaceAll('{hobby}', hobby)
    .replaceAll('{trait}', trait);
}
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: All bio tests pass.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/scripts/seed/data/tr-bio-pool.ts qulo-server/tests/seed/data.test.ts
git commit -m "feat(seed): add Turkish bio template pool + renderer

20 bio templates with {city}/{job}/{hobby}/{trait} placeholders,
25 hobbies, 15 traits, 30 jobs. renderBio() composes a natural
1-sentence bio per profile.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 7: Photo prompt pools + prompt builder + tests

**Files:**
- Create: `qulo-server/scripts/seed/data/photo-prompt-pools.ts`
- Modify: `qulo-server/tests/seed/data.test.ts` (add prompt tests)

- [ ] **Step 1: Append failing test**

Append to `qulo-server/tests/seed/data.test.ts`:

```ts
import { buildPhotoPrompt } from '../../scripts/seed/data/photo-prompt-pools.js';

describe('buildPhotoPrompt', () => {
  it('returns deterministic-format string for fixed age', () => {
    const p = buildPhotoPrompt(27);
    expect(p.length).toBeGreaterThan(50);
    expect(p).toContain('27');
    expect(p).toContain('Turkish woman');
    expect(p).toMatch(/photorealistic/i);
  });

  it('varies across calls (diversity check)', () => {
    const seen = new Set<string>();
    for (let i = 0; i < 50; i++) {
      seen.add(buildPhotoPrompt(25));
    }
    expect(seen.size).toBeGreaterThan(10);
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: Fails — `buildPhotoPrompt` not found.

- [ ] **Step 3: Create photo prompt pools**

Create `qulo-server/scripts/seed/data/photo-prompt-pools.ts`:

```ts
import { pickRandom } from '../lib/random.js';

export const HAIR_OPTIONS = [
  'dark brown', 'black', 'chestnut', 'dyed blonde', 'auburn', 'light brown',
] as const;

export const EXPRESSION_OPTIONS = [
  'gentle smile', 'soft gaze at camera', 'slight laughter', 'thoughtful look',
] as const;

export const OUTFIT_OPTIONS = [
  'oversized sweater', 'casual summer dress', 'plain blouse',
  'linen shirt', 'leather jacket', 'denim jacket over t-shirt',
] as const;

export const SETTING_OPTIONS = [
  'Istanbul rooftop with city skyline',
  'cozy cafe with warm lighting',
  'park bench in autumn',
  'Bosphorus view at golden hour',
  'sunlit apartment by a window',
  'Cappadocia balloon background',
  'Antalya beach at sunset',
  'autumn street with fallen leaves',
] as const;

export function buildPhotoPrompt(age: number): string {
  const hair = pickRandom(HAIR_OPTIONS);
  const expression = pickRandom(EXPRESSION_OPTIONS);
  const outfit = pickRandom(OUTFIT_OPTIONS);
  const setting = pickRandom(SETTING_OPTIONS);
  return (
    `Portrait of a ${age}-year-old Turkish woman with ${hair} hair, ` +
    `${expression}, wearing ${outfit}, in ${setting}, natural lighting, ` +
    `shot on iPhone, slight grain, candid selfie aesthetic, photorealistic, ` +
    `NOT glamour, NOT studio lighting, casual everyday look`
  );
}
```

- [ ] **Step 4: Run tests to verify they pass**

```bash
npx vitest run tests/seed/data.test.ts
```

Expected: All tests pass (cities + names + bio + prompt).

- [ ] **Step 5: Commit**

```bash
git add qulo-server/scripts/seed/data/photo-prompt-pools.ts qulo-server/tests/seed/data.test.ts
git commit -m "feat(seed): add photo prompt diversity pools + builder

6 hair × 4 expression × 6 outfit × 8 setting = 1152 unique combinations
for 350 profiles. Prompt template optimized for realistic candid feel,
explicit anti-glamour anchors.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 8: Replicate API wrapper

**Files:**
- Create: `qulo-server/scripts/seed/lib/replicate.ts`

- [ ] **Step 1: Implement Replicate wrapper**

Create `qulo-server/scripts/seed/lib/replicate.ts`:

```ts
import Replicate from 'replicate';

const REPLICATE_TOKEN = process.env.REPLICATE_API_TOKEN;
if (!REPLICATE_TOKEN) {
  throw new Error('REPLICATE_API_TOKEN missing in env');
}

const client = new Replicate({ auth: REPLICATE_TOKEN });

const MODEL = 'black-forest-labs/flux-schnell';

/**
 * Generate one image. Returns the temporary Replicate URL.
 * Caller MUST download and rehost — URL expires within ~1 hour.
 */
export async function generateImage(prompt: string): Promise<string> {
  const output = (await client.run(MODEL, {
    input: {
      prompt,
      aspect_ratio: '3:4',
      num_outputs: 1,
      output_format: 'jpg',
      output_quality: 90,
      go_fast: true,
    },
  })) as unknown;

  // SDK returns either string[] of URLs or FileOutput[] depending on version
  if (Array.isArray(output) && output.length > 0) {
    const first = output[0];
    if (typeof first === 'string') return first;
    if (first && typeof (first as { url?: () => URL }).url === 'function') {
      return (first as { url: () => URL }).url().toString();
    }
  }
  throw new Error(`Unexpected Replicate output shape: ${JSON.stringify(output).slice(0, 200)}`);
}
```

- [ ] **Step 2: Smoke test (manual, optional)**

To verify the wrapper works, run an inline node test from `qulo-server/`:
```bash
npx tsx -e "
import 'dotenv/config';
import { generateImage } from './scripts/seed/lib/replicate.js';
generateImage('A simple red apple on a white background').then(url => console.log('OK:', url)).catch(e => { console.error(e); process.exit(1); });
"
```

Expected: Prints a `replicate.delivery/...` URL within 5-10 seconds.

If output is empty or shape is unexpected, inspect the raw output by adding `console.log(output)` before the array check.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/scripts/seed/lib/replicate.ts
git commit -m "feat(seed): add Replicate Flux Schnell wrapper

generateImage(prompt) returns the temporary Replicate URL. Caller
must download + rehost because URL expires in ~1h.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 9: Supabase storage upload wrapper

**Files:**
- Create: `qulo-server/scripts/seed/lib/storage.ts`

- [ ] **Step 1: Implement storage wrapper**

Create `qulo-server/scripts/seed/lib/storage.ts`:

```ts
import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!SUPABASE_URL || !SUPABASE_KEY) {
  throw new Error('SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY missing in env');
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
const BUCKET = 'photos';

/**
 * Download a remote URL to a Buffer.
 */
export async function downloadToBuffer(url: string): Promise<Buffer> {
  const res = await fetch(url);
  if (!res.ok) throw new Error(`Download failed ${res.status}: ${url}`);
  return Buffer.from(await res.arrayBuffer());
}

/**
 * Upload a local file to Supabase storage at the given path inside `photos` bucket.
 * Returns the public URL. Uses upsert=true (idempotent).
 */
export async function uploadFile(localPath: string, storagePath: string): Promise<string> {
  const buffer = readFileSync(localPath);
  const { error } = await supabase.storage
    .from(BUCKET)
    .upload(storagePath, buffer, {
      contentType: 'image/jpeg',
      upsert: true,
    });
  if (error) throw new Error(`Upload failed: ${error.message}`);

  const { data } = supabase.storage.from(BUCKET).getPublicUrl(storagePath);
  return data.publicUrl;
}

/**
 * Delete a list of storage paths inside `photos` bucket.
 */
export async function deleteFiles(paths: string[]): Promise<void> {
  if (paths.length === 0) return;
  const { error } = await supabase.storage.from(BUCKET).remove(paths);
  if (error) throw new Error(`Delete failed: ${error.message}`);
}
```

- [ ] **Step 2: Commit**

```bash
git add qulo-server/scripts/seed/lib/storage.ts
git commit -m "feat(seed): add Supabase Storage upload/delete wrapper

downloadToBuffer, uploadFile (upsert=true, idempotent), deleteFiles.
Targets 'photos' bucket.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 10: Photo generation script (Stage 1)

**Files:**
- Create: `qulo-server/scripts/seed/generate-seed-photos.ts`

- [ ] **Step 1: Implement Stage 1 script**

Create `qulo-server/scripts/seed/generate-seed-photos.ts`:

```ts
/**
 * Stage 1: Generate 350 Turkish women portrait photos via Replicate Flux.
 *
 * Usage:
 *   npx tsx scripts/seed/generate-seed-photos.ts
 *   npx tsx scripts/seed/generate-seed-photos.ts --regenerate 47
 *   npx tsx scripts/seed/generate-seed-photos.ts --from 1 --to 50
 *
 * Outputs:
 *   - seed-photos-cache/tr_001.jpg ... tr_350.jpg (local)
 *   - photos/seed/tr_001.jpg ... (Supabase storage)
 *   - scripts/seed/output/photos-manifest.json
 */

import 'dotenv/config';
import { existsSync, mkdirSync, writeFileSync, readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

import { buildPhotoPrompt } from './data/photo-prompt-pools.js';
import { rand } from './lib/random.js';
import { generateImage } from './lib/replicate.js';
import { downloadToBuffer, uploadFile } from './lib/storage.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const REPO_ROOT = join(__dirname, '..', '..');
const CACHE_DIR = join(REPO_ROOT, 'seed-photos-cache');
const MANIFEST_PATH = join(__dirname, 'output', 'photos-manifest.json');

const TOTAL = 350;
const CONCURRENCY = 6;

interface ManifestEntry {
  seq: number;
  prompt: string;
  local_path: string;
  storage_url: string;
  generated_at: string;
}

function ensureDirs() {
  if (!existsSync(CACHE_DIR)) mkdirSync(CACHE_DIR, { recursive: true });
  if (!existsSync(dirname(MANIFEST_PATH))) mkdirSync(dirname(MANIFEST_PATH), { recursive: true });
}

function loadManifest(): Map<number, ManifestEntry> {
  if (!existsSync(MANIFEST_PATH)) return new Map();
  const raw = JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8')) as ManifestEntry[];
  return new Map(raw.map((e) => [e.seq, e]));
}

function saveManifest(entries: Map<number, ManifestEntry>) {
  const sorted = [...entries.values()].sort((a, b) => a.seq - b.seq);
  writeFileSync(MANIFEST_PATH, JSON.stringify(sorted, null, 2));
}

function seqFileName(seq: number): string {
  return `tr_${String(seq).padStart(3, '0')}.jpg`;
}

async function generateOne(seq: number, force = false): Promise<ManifestEntry> {
  const fileName = seqFileName(seq);
  const localPath = join(CACHE_DIR, fileName);
  const storagePath = `seed/${fileName}`;

  if (!force && existsSync(localPath)) {
    console.log(`  ⏭️  ${seq.toString().padStart(3, '0')} exists, skipping generation`);
    // still upload + return entry (idempotent for resumed runs)
    const url = await uploadFile(localPath, storagePath);
    return {
      seq,
      prompt: '(cached)',
      local_path: localPath,
      storage_url: url,
      generated_at: new Date().toISOString(),
    };
  }

  const age = rand(22, 38);
  const prompt = buildPhotoPrompt(age);
  const replicateUrl = await generateImage(prompt);
  const buffer = await downloadToBuffer(replicateUrl);
  writeFileSync(localPath, buffer);
  const storageUrl = await uploadFile(localPath, storagePath);
  console.log(`  ✅ ${seq.toString().padStart(3, '0')} (age ${age}) → ${storageUrl}`);
  return {
    seq,
    prompt,
    local_path: localPath,
    storage_url: storageUrl,
    generated_at: new Date().toISOString(),
  };
}

async function runBatch(seqs: number[], force: boolean, manifest: Map<number, ManifestEntry>) {
  for (let i = 0; i < seqs.length; i += CONCURRENCY) {
    const slice = seqs.slice(i, i + CONCURRENCY);
    const results = await Promise.allSettled(slice.map((s) => generateOne(s, force)));
    for (let j = 0; j < results.length; j++) {
      const r = results[j];
      const seq = slice[j];
      if (r.status === 'fulfilled') {
        manifest.set(seq, r.value);
      } else {
        console.error(`  ❌ ${seq}: ${r.reason instanceof Error ? r.reason.message : r.reason}`);
      }
    }
    saveManifest(manifest);
    console.log(`  💾 manifest saved (${manifest.size} entries)`);
  }
}

function parseArgs(): { mode: 'all' | 'regen' | 'range'; from?: number; to?: number; seq?: number } {
  const args = process.argv.slice(2);
  const regenIdx = args.indexOf('--regenerate');
  if (regenIdx >= 0) return { mode: 'regen', seq: Number(args[regenIdx + 1]) };
  const fromIdx = args.indexOf('--from');
  const toIdx = args.indexOf('--to');
  if (fromIdx >= 0 && toIdx >= 0) {
    return { mode: 'range', from: Number(args[fromIdx + 1]), to: Number(args[toIdx + 1]) };
  }
  return { mode: 'all' };
}

async function main() {
  ensureDirs();
  const manifest = loadManifest();
  const args = parseArgs();

  let seqs: number[];
  let force = false;
  if (args.mode === 'regen') {
    if (!args.seq || args.seq < 1 || args.seq > TOTAL) throw new Error('invalid --regenerate seq');
    seqs = [args.seq];
    force = true;
  } else if (args.mode === 'range') {
    if (!args.from || !args.to || args.from > args.to) throw new Error('invalid --from/--to');
    seqs = [];
    for (let i = args.from; i <= args.to; i++) seqs.push(i);
  } else {
    seqs = [];
    for (let i = 1; i <= TOTAL; i++) seqs.push(i);
  }

  console.log(`\n🎨 Generating ${seqs.length} photo(s) (concurrency ${CONCURRENCY})\n`);
  const start = Date.now();
  await runBatch(seqs, force, manifest);
  const sec = ((Date.now() - start) / 1000).toFixed(1);
  console.log(`\n✨ Done in ${sec}s — manifest: ${manifest.size}/350 entries\n`);
}

main().catch((e) => {
  console.error('FATAL:', e);
  process.exit(1);
});
```

- [ ] **Step 2: Smoke test with 3-photo range**

Run from `qulo-server/`:
```bash
npx tsx scripts/seed/generate-seed-photos.ts --from 1 --to 3
```

Expected:
- Prints `🎨 Generating 3 photo(s)...`
- 3 `✅` lines with seq + storage URL
- `seed-photos-cache/tr_001.jpg`, `tr_002.jpg`, `tr_003.jpg` exist
- `scripts/seed/output/photos-manifest.json` contains 3 entries
- Each storage URL returns 200 when curled

Verify:
```bash
ls -la seed-photos-cache/ | grep tr_
cat scripts/seed/output/photos-manifest.json | head -30
curl -I "$(cat scripts/seed/output/photos-manifest.json | grep -m1 storage_url | sed 's/.*"storage_url": "//' | sed 's/",//')"
```

- [ ] **Step 3: Visual inspection**

User opens 3 generated files in Finder/Preview to confirm quality. If any is bad:
```bash
npx tsx scripts/seed/generate-seed-photos.ts --regenerate 2
```

- [ ] **Step 4: Commit**

```bash
git add qulo-server/scripts/seed/generate-seed-photos.ts
git commit -m "feat(seed): Stage 1 — generate 350 Turkish portraits via Replicate

Concurrency 6, batch saves manifest after each chunk, idempotent
(skips cached files), supports --regenerate <seq> and --from/--to.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 11: Profile seeding script (Stage 2)

**Files:**
- Create: `qulo-server/scripts/seed/seed-fake-tr-profiles.ts`

- [ ] **Step 1: Implement Stage 2 script**

Create `qulo-server/scripts/seed/seed-fake-tr-profiles.ts`:

```ts
/**
 * Stage 2: Insert 350 fake Turkish women profiles into Supabase.
 * Reads photo manifest from Stage 1.
 *
 * Usage:
 *   npx tsx scripts/seed/seed-fake-tr-profiles.ts
 */

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import bcrypt from 'bcryptjs';
import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

import { TR_CITIES, TOTAL_QUOTA } from './data/tr-cities.js';
import { TR_FEMALE_FIRST_NAMES, TR_SURNAMES } from './data/tr-female-names.js';
import { TR_JOBS, renderBio } from './data/tr-bio-pool.js';
import { rand, jitter, pickRandom, weightedPick, sample } from './lib/random.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const MANIFEST_PATH = join(__dirname, 'output', 'photos-manifest.json');

const SUPABASE_URL = process.env.SUPABASE_URL!;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const SEED_PASSWORD = 'SeedFake1234!';
const ZODIACS = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra',
                 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
const PERSONALITIES = ['Introvert', 'Extrovert', 'Ambivert'];

interface ManifestEntry {
  seq: number;
  storage_url: string;
}

interface QuestionBankRow {
  question_text: string;
  answers: string[];
  category: string;
}

function loadManifest(): ManifestEntry[] {
  const raw = JSON.parse(readFileSync(MANIFEST_PATH, 'utf-8')) as ManifestEntry[];
  if (raw.length < TOTAL_QUOTA) {
    throw new Error(`Manifest has ${raw.length} entries, need ${TOTAL_QUOTA}. Run Stage 1 first.`);
  }
  return raw;
}

async function loadQuestionPool(): Promise<QuestionBankRow[]> {
  const { data, error } = await supabase
    .from('ai_question_bank')
    .select('question_text, answers, category')
    .eq('locale', 'tr')
    .eq('is_active', true)
    .limit(2000);
  if (error) throw new Error(`question_bank query: ${error.message}`);
  if (!data || data.length < 100) throw new Error(`Insufficient TR question_bank rows: ${data?.length}`);
  return data as QuestionBankRow[];
}

function randomLastSeen(): string {
  const hoursAgo = rand(0, 72);
  return new Date(Date.now() - hoursAgo * 3600 * 1000).toISOString();
}

function randomAlpha(len: number): string {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  let out = '';
  for (let i = 0; i < len; i++) out += chars[Math.floor(Math.random() * chars.length)];
  return out;
}

async function seedOneProfile(
  seq: number,
  city: { name: string; lat: number; lng: number },
  manifest: ManifestEntry[],
  questionPool: QuestionBankRow[],
  usedNames: Set<string>,
  passwordHash: string,
): Promise<boolean> {
  const email = `seed_tr_${String(seq).padStart(3, '0')}@qulo.test`;

  const { data: existing } = await supabase
    .from('users').select('id').eq('email', email).maybeSingle();
  if (existing) {
    console.log(`  ⏭️  ${email} exists, skipping`);
    return false;
  }

  // Pick unique name pair
  let name = '', surname = '', key = '';
  let attempts = 0;
  do {
    name = pickRandom(TR_FEMALE_FIRST_NAMES);
    surname = pickRandom(TR_SURNAMES);
    key = `${name} ${surname}`;
    attempts++;
    if (attempts > 100) throw new Error('Name pool exhausted');
  } while (usedNames.has(key));
  usedNames.add(key);

  const age = rand(22, 38);
  const job = pickRandom(TR_JOBS);
  const bio = renderBio(city.name, job);
  const lat = city.lat + jitter(0.05);
  const lng = city.lng + jitter(0.05);

  const photoEntry = manifest.find((m) => m.seq === seq);
  if (!photoEntry) throw new Error(`Manifest missing seq=${seq}`);

  const userPayload = {
    email,
    password_hash: passwordHash,
    name,
    surname,
    age,
    gender: 'WOMAN',
    gender_pref: 'MAN',
    bio,
    city: city.name,
    country: 'Turkey',
    lat,
    lng,
    locale: 'tr',
    preferred_languages: ['tr'],
    match_radius_km: rand(25, 100),
    age_pref_min: Math.max(18, age - 5),
    age_pref_max: Math.min(50, age + 8),
    relationship_goal: weightedPick({ SERIOUS: 50, NOT_SURE: 30, FRIENDSHIP: 15, CASUAL: 5 }),
    email_verified: true,
    is_online: Math.random() < 0.3,
    profile_completion: rand(78, 92),
    green_diamonds: rand(10, 40),
    photos: [photoEntry.storage_url],
    is_seed_profile: true,
    is_test_account: false,
    last_seen_at: randomLastSeen(),
    referral_code: `S${String(seq).padStart(3, '0')}${randomAlpha(5)}`,
  };

  const { data: inserted, error } = await supabase
    .from('users').insert(userPayload).select('id').single();
  if (error || !inserted) {
    console.error(`  ❌ ${email}: ${error?.message ?? 'unknown insert error'}`);
    return false;
  }
  const userId = inserted.id as string;

  // user_details
  const detailsErr = await supabase.from('user_details').insert({
    user_id: userId,
    height: rand(158, 180),
    zodiac: pickRandom(ZODIACS),
    job,
    smoking: weightedPick({ NO: 60, SOMETIMES: 30, YES: 10 }),
    alcohol: weightedPick({ SOMETIMES: 50, NO: 35, YES: 15 }),
    personality: pickRandom(PERSONALITIES),
  });
  if (detailsErr.error) console.warn(`  ⚠️  user_details: ${detailsErr.error.message}`);

  // user_languages
  const langErr = await supabase.from('user_languages').insert({ user_id: userId, locale: 'tr' });
  if (langErr.error) console.warn(`  ⚠️  user_languages: ${langErr.error.message}`);

  // questions × 3
  const picks = sample(questionPool, 3);
  for (let i = 0; i < picks.length; i++) {
    const q = picks[i];
    const qErr = await supabase.from('questions').insert({
      user_id: userId,
      order_num: i + 1,
      question_text: q.question_text,
      answer_1: q.answers[0],
      answer_2: q.answers[1],
      answer_3: q.answers[2],
      answer_4: q.answers[3],
      correct_answer: rand(1, 4),
      category: q.category,
      time_limit: 30,
      locale: 'tr',
    });
    if (qErr.error) console.warn(`  ⚠️  question ${i + 1}: ${qErr.error.message}`);
  }

  console.log(`  ✅ ${seq.toString().padStart(3, '0')} ${name} ${surname} (${city.name}, ${age}) — 3 questions`);
  return true;
}

async function main() {
  console.log('\n🌱 Seeding 350 fake Turkish profiles...\n');

  const manifest = loadManifest();
  const questionPool = await loadQuestionPool();
  const usedNames = new Set<string>();
  const passwordHash = await bcrypt.hash(SEED_PASSWORD, 12);

  let seq = 1;
  let created = 0;
  for (const city of TR_CITIES) {
    for (let i = 0; i < city.count; i++) {
      try {
        const ok = await seedOneProfile(seq, city, manifest, questionPool, usedNames, passwordHash);
        if (ok) created++;
      } catch (e) {
        console.error(`  ❌ seq=${seq}: ${e instanceof Error ? e.message : e}`);
      }
      seq++;
    }
  }

  console.log(`\n📊 Created: ${created} | Total seq: ${seq - 1}\n`);
}

main().catch((e) => {
  console.error('FATAL:', e);
  process.exit(1);
});
```

- [ ] **Step 2: Verify TypeScript compiles**

From `qulo-server/`:
```bash
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/scripts/seed/seed-fake-tr-profiles.ts
git commit -m "feat(seed): Stage 2 — insert 350 fake profiles into Supabase

Reads photo manifest, picks unique name pairs, renders Turkish bios,
samples 3 questions from ai_question_bank, inserts users +
user_details + user_languages + questions. Sets is_seed_profile=true.
Idempotent via email unique check.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 12: Cleanup script

**Files:**
- Create: `qulo-server/scripts/seed/delete-fake-tr-profiles.ts`

- [ ] **Step 1: Implement cleanup script**

Create `qulo-server/scripts/seed/delete-fake-tr-profiles.ts`:

```ts
/**
 * Delete all seed profiles (is_seed_profile=true) + their related data.
 *
 * Usage:
 *   npx tsx scripts/seed/delete-fake-tr-profiles.ts            # dry-run (count only)
 *   npx tsx scripts/seed/delete-fake-tr-profiles.ts --confirm  # actually delete
 */

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.SUPABASE_URL!;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const RELATED_TABLES = [
  'user_details',
  'user_languages',
  'questions',
  'swipes',
  'matches',
  'messages',
  'refresh_tokens',
  'diamond_transactions',
  'notifications',
  'user_badges',
];

async function main() {
  const confirmed = process.argv.includes('--confirm');

  const { data: users, error } = await supabase
    .from('users').select('id, email').eq('is_seed_profile', true);
  if (error) throw new Error(`fetch users: ${error.message}`);
  if (!users || users.length === 0) {
    console.log('ℹ️  No seed profiles found. Nothing to do.');
    return;
  }

  const ids = users.map((u) => u.id as string);
  console.log(`\n📋 Found ${ids.length} seed profiles.\n`);

  if (!confirmed) {
    console.log('🟡 DRY-RUN. Pass --confirm to actually delete.\n');
    return;
  }

  // Delete from related tables
  for (const t of RELATED_TABLES) {
    const { error: e } = await supabase.from(t).delete().in('user_id', ids);
    if (e && !e.message.includes('does not exist')) {
      console.warn(`  ⚠️  ${t}: ${e.message}`);
    } else {
      console.log(`  🧹 ${t} cleaned`);
    }
  }

  // Target-side references
  await supabase.from('swipes').delete().in('target_id', ids);
  await supabase.from('matches').delete().in('user2_id', ids);
  await supabase.from('matches').delete().in('user1_id', ids);

  // Storage cleanup
  const storagePaths = ids.map((_, i) => `seed/tr_${String(i + 1).padStart(3, '0')}.jpg`);
  const { error: storageErr } = await supabase.storage.from('photos').remove(storagePaths);
  if (storageErr) console.warn(`  ⚠️  storage: ${storageErr.message}`);
  else console.log(`  🧹 storage seed/ cleaned (${storagePaths.length} files)`);

  // Final users delete
  const { error: delErr } = await supabase.from('users').delete().eq('is_seed_profile', true);
  if (delErr) throw new Error(`delete users: ${delErr.message}`);

  console.log(`\n✅ Deleted ${ids.length} seed profiles + related data.\n`);
}

main().catch((e) => {
  console.error('FATAL:', e);
  process.exit(1);
});
```

- [ ] **Step 2: TypeScript check**

```bash
npx tsc --noEmit
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add qulo-server/scripts/seed/delete-fake-tr-profiles.ts
git commit -m "feat(seed): add cleanup script for seed profiles

DELETE WHERE is_seed_profile=true cascade across user_details,
user_languages, questions, swipes, matches, messages, etc. Drops
seed/ storage objects. Dry-run by default, --confirm to apply.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Task 13: End-to-end smoke test (small batch)

**Goal:** Verify full pipeline works with a small subset (3 profiles) before running the full 350.

- [ ] **Step 1: Generate 3 photos**

From `qulo-server/`:
```bash
npx tsx scripts/seed/generate-seed-photos.ts --from 1 --to 3
```

Expected: 3 `✅` lines, manifest has 3 entries.

- [ ] **Step 2: Temporarily limit Stage 2 to first 3 seqs (manual edit)**

Open `qulo-server/scripts/seed/seed-fake-tr-profiles.ts`, in `main()` after the for-of loop initialization, add an early-exit:

```ts
    if (seq > 3) break;  // SMOKE TEST GUARD — remove after verification
```

Actually patch by placing the break inside the inner loop:
```ts
    for (let i = 0; i < city.count; i++) {
      if (seq > 3) break;  // SMOKE TEST GUARD
      ...
```

Wrap the outer loop too:
```ts
  for (const city of TR_CITIES) {
    if (seq > 3) break;  // SMOKE TEST GUARD
    for (let i = 0; i < city.count; i++) {
      if (seq > 3) break;  // SMOKE TEST GUARD
      ...
```

- [ ] **Step 3: Run Stage 2 (limited)**

```bash
npx tsx scripts/seed/seed-fake-tr-profiles.ts
```

Expected: 3 `✅` lines (3 İstanbul profiles), no errors.

- [ ] **Step 4: Verify via SQL**

Use Supabase MCP `execute_sql`:
```sql
SELECT id, name, surname, city, age, photos, is_seed_profile
FROM users
WHERE is_seed_profile = true
ORDER BY email;
```

Expected: 3 rows, all `is_seed_profile=true`, `city='İstanbul'`, `photos` has 1 URL.

```sql
SELECT user_id, question_text FROM questions
WHERE user_id IN (SELECT id FROM users WHERE is_seed_profile=true);
```

Expected: 9 rows (3 questions × 3 users), all in Turkish.

```sql
SELECT user_id, job FROM user_details
WHERE user_id IN (SELECT id FROM users WHERE is_seed_profile=true);
```

Expected: 3 rows.

- [ ] **Step 5: Verify photo URL is reachable**

```bash
curl -I "$(cat scripts/seed/output/photos-manifest.json | grep -m1 storage_url | sed 's/.*"storage_url": "//' | sed 's/",//')"
```

Expected: `HTTP/2 200`, `content-type: image/jpeg`.

- [ ] **Step 6: Verify discover sees them (manual)**

Login as a real test user (e.g. `tester_001@qulo.test`) and call discover endpoint or open the app. The 3 seed profiles should appear in the candidate list (Istanbul, female, age 22-38).

If they don't appear, debug:
- `gender_pref` of test user must include WOMAN
- `age_pref_min/max` must overlap
- `match_radius_km` must reach them
- `email_verified=true` on seed (already set)

- [ ] **Step 7: Clean up smoke test rows**

```bash
npx tsx scripts/seed/delete-fake-tr-profiles.ts --confirm
```

Verify:
```sql
SELECT COUNT(*) FROM users WHERE is_seed_profile=true;
```

Expected: `0`.

- [ ] **Step 8: Remove SMOKE TEST GUARD from script**

Open `qulo-server/scripts/seed/seed-fake-tr-profiles.ts` and remove the three `if (seq > 3) break;` lines added in Step 2.

- [ ] **Step 9: Verify removal**

```bash
grep -n "SMOKE TEST GUARD" scripts/seed/seed-fake-tr-profiles.ts
```

Expected: no output (lines removed).

- [ ] **Step 10: Commit (cleanup state)**

Nothing should be staged at this point — Step 8 reverted to the file's last committed state. Confirm:
```bash
git status
```

Expected: working tree clean (or only the manifest/cache changes which are gitignored).

---

## Task 14: Full production run

**Goal:** Run the full pipeline against production Supabase and verify 350 profiles are live.

- [ ] **Step 1: Generate all 350 photos**

```bash
npx tsx scripts/seed/generate-seed-photos.ts
```

Expected: Runs ~30 minutes. Progress prints every 6 seqs. Manifest grows to 350. Cost ~$1.

If interrupted: re-run the same command — it skips already-cached files.

- [ ] **Step 2: Visual inspection of cache directory**

Open `qulo-server/seed-photos-cache/` in Finder. Spot-check 20 random files. If any have:
- Distorted faces, missing limbs, weird artifacts
- Obviously non-Turkish appearance
- Clearly NSFW or inappropriate content

Regenerate each by seq:
```bash
npx tsx scripts/seed/generate-seed-photos.ts --regenerate 47
npx tsx scripts/seed/generate-seed-photos.ts --regenerate 102
# ... etc
```

- [ ] **Step 3: Insert all 350 profiles**

```bash
npx tsx scripts/seed/seed-fake-tr-profiles.ts
```

Expected: ~2 minutes runtime. 350 `✅` lines. No `❌` lines (warnings on user_details/questions are tolerable but rare).

- [ ] **Step 4: Verify counts**

Use Supabase MCP `execute_sql`:
```sql
-- Total seed profiles
SELECT COUNT(*) AS total FROM users WHERE is_seed_profile=true;
-- Expected: 350
```

```sql
-- Distribution by city
SELECT city, COUNT(*) FROM users WHERE is_seed_profile=true
GROUP BY city ORDER BY COUNT(*) DESC;
-- Expected: matches TR_CITIES quota (İstanbul 80, Ankara 50, ...)
```

```sql
-- Total seed questions
SELECT COUNT(*) FROM questions
WHERE user_id IN (SELECT id FROM users WHERE is_seed_profile=true);
-- Expected: 1050
```

```sql
-- All have photos
SELECT COUNT(*) FROM users
WHERE is_seed_profile=true AND (photos IS NULL OR array_length(photos, 1) IS NULL);
-- Expected: 0
```

```sql
-- All photo URLs are storage URLs
SELECT COUNT(*) FROM users
WHERE is_seed_profile=true AND photos[1] NOT LIKE '%/storage/v1/object/public/photos/seed/%';
-- Expected: 0
```

- [ ] **Step 5: Discover smoke test**

Login as `tester_001@qulo.test` (Istanbul tester user). Set their `match_radius_km` temporarily to 500:
```sql
UPDATE users SET match_radius_km=500
WHERE email='tester_001@qulo.test';
```

Call discover endpoint via curl or open app. Confirm seed profiles appear. After test, restore radius:
```sql
UPDATE users SET match_radius_km=100
WHERE email='tester_001@qulo.test';
```

- [ ] **Step 6: Mobile app sanity check**

Run mobile app (`flutter run` in `qulov2/`), login as test user, swipe through discover. Confirm:
- Multiple seed profiles appear
- Each has photo + bio + sorular
- Profile detail page renders cleanly

- [ ] **Step 7: Commit operational notes**

Update `qulo-server/CLAUDE.md` (or `qulo/CLAUDE.md` if appropriate) with a brief operational note:

Append a section under "## Seed Profile System (TR)" with:
```markdown
## Seed Profile System (TR)
- **Volume:** 350 fake Turkish women profiles, marked `is_seed_profile=true`
- **Run:** `npx tsx scripts/seed/generate-seed-photos.ts && npx tsx scripts/seed/seed-fake-tr-profiles.ts`
- **Cleanup:** `npx tsx scripts/seed/delete-fake-tr-profiles.ts --confirm`
- **Spec:** `docs/superpowers/specs/2026-06-11-fake-profiles-turkey-design.md`
- **Plan:** `docs/superpowers/plans/2026-06-11-fake-profiles-turkey.md`
```

Commit:
```bash
git add qulo-server/CLAUDE.md
git commit -m "docs(claude): note seed profile system entry points

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

- [ ] **Step 8: Push branch**

```bash
git push origin APP-1915
```

Expected: Push succeeds. Branch up to date.

---

## Self-Review Summary

**Spec coverage check:**
- ✅ Problem framed → solution overview matches (Tasks 10-12 deliver pipeline)
- ✅ Non-goals respected (no match-service mod, no chatbot, no English)
- ✅ All decisions in spec table mapped to tasks
- ✅ Migration 027 → Task 2
- ✅ City distribution → Task 4 with exact table
- ✅ Photo prompts → Task 7
- ✅ Stage 1 (photo gen) → Task 10
- ✅ Stage 2 (profile seed) → Task 11
- ✅ Cleanup → Task 12
- ✅ Verification queries → Task 14

**Placeholder scan:** No TBD/TODO/vague directions. Every step has either complete code, exact command, or specific expected output.

**Type consistency:** All function names cross-check (`buildPhotoPrompt`, `renderBio`, `pickRandom`, `weightedPick`, `sample`, `generateImage`, `uploadFile`).

**Known follow-up risk:** If Replicate's SDK output shape differs from string[], Step 8.2's smoke test catches it before Task 10 runs at scale.
