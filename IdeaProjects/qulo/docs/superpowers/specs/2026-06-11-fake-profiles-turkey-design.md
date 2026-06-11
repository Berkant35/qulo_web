# Fake Profile Seeding for Turkey — Design Spec

**Date:** 2026-06-11
**Owner:** Berkant Çalıkuşu
**Branch:** APP-1915
**Status:** Approved — ready for implementation plan

---

## Problem

Qulo, Türkiye'ye production launch öncesi cold-start sorunu yaşıyor:

- Discover ekranı boş → yeni kayıt olan kullanıcı kimseyi göremiyor → app'i terk ediyor
- Mevcut `seed-store-profiles.ts` sadece 8 uluslararası profil üretiyor (App Store screenshot amaçlı)
- Mevcut `seed-test-users.ts` 55 İstanbul'lu test kullanıcısı üretiyor ama `is_test_account=true` → sadece admin'ler görüyor

Bize ihtiyaç: **Türkiye'ye dağılmış, gerçek kalitede AI fotoğraflı, sorularıyla birlikte hazır 350 kadın profil** — discover'da herkes görsün, ekosistem dolu hissedilsin.

## Solution Overview

İki aşamalı pipeline:

1. **Stage 1** — `generate-seed-photos.ts`: Replicate Flux API ile 350 unique Türk kadını portresi üret, yerel cache + Supabase Storage'a yükle, manifest çıkar
2. **Stage 2** — `seed-fake-tr-profiles.ts`: Manifest + isim havuzu + şehir dağılımı + `ai_question_bank`'tan rastgele soru → DB insert (users + user_details + user_languages + questions)
3. **Cleanup** — `delete-fake-tr-profiles.ts`: `is_seed_profile=true` olan tüm satırları + Storage object'lerini siler

Fake profiller **discover'da tüm kullanıcılara görünür** ve **gerçek kullanıcı gibi davranır** — match olabilir, chat açılabilir. Hiçbir special handling yok. Tek fark: cleanup için işaretli.

## Non-Goals

- **Chatbot / otomatik mesaj** yok — match sonrası fake profil hiç cevap yazmaz (Phase 3 ileride ayrı spec'e)
- **Erkek profil** yok — sadece kadın profil (gender=WOMAN, gender_pref=MAN)
- **Yabancı dil** yok — sadece Türkçe (locale=tr, preferred_languages=["tr"])
- **Match service modifikasyonu** yok — match flow olduğu gibi kalır
- **Admin UI** yok — operasyon CLI üzerinden

---

## Decisions

| Soru | Karar | Gerekçe |
|---|---|---|
| Toplam profil sayısı | **350** | 7 coğrafi bölge × 50 hedef. Şehir dağılımına göre coğrafi yayılım. |
| Foto kaynağı | **Replicate Flux schnell** (~$1 toplam) | Telif sorunu yok, her foto unique, ~$0.003/foto |
| Foto sayısı | **Profil başına 1** | Kullanıcı isteği — gerçek tekil kalite görselleri |
| İçerik dili | **Sadece Türkçe** | Türkiye launch target, hedeflenmiş kullanıcı deneyimi |
| Soru kaynağı | **`ai_question_bank` rastgele (locale=tr)** | 7001 mevcut soru var, ek API maliyeti yok |
| Lokasyon dağılımı | **Büyük şehir nüfus ağırlıklı** | Realistik — İstanbul 80, Ankara 50, İzmir 40, ... |
| Yaş aralığı | **22-38** | Geniş spektrum, profesyonel hayata yakın profiller |
| Marking | **`is_seed_profile BOOLEAN`** | Yeni kolon + partial index, cleanup tek sorgu |
| Match davranışı | **Normal akış** (özel handling yok) | Gerçek user gibi davransın; match olursa olsun |
| Pipeline mimarisi | **İki aşamalı** (foto + profil ayrı) | Foto curation şansı, idempotent, yeniden çalıştırılabilir |

---

## Architecture

```
qulo-server/
├─ migrations/
│   └─ 027_is_seed_profile.sql          ← NEW
├─ scripts/seed/
│   ├─ generate-seed-photos.ts          ← NEW (Stage 1)
│   ├─ seed-fake-tr-profiles.ts         ← NEW (Stage 2)
│   ├─ delete-fake-tr-profiles.ts       ← NEW (cleanup)
│   ├─ data/
│   │   ├─ tr-cities.ts                 ← NEW (lat/lng + quota)
│   │   ├─ tr-female-names.ts           ← NEW (~80 first + ~100 surnames)
│   │   ├─ tr-bio-pool.ts               ← NEW (~30 templates + hobby/job/trait havuzları)
│   │   └─ photo-prompt-pools.ts        ← NEW (hair/expression/outfit/setting varyantları)
│   └─ output/
│       └─ photos-manifest.json         ← generated, gitignore'd
└─ seed-photos-cache/                    ← gitignore'd, yerel foto cache
    └─ tr_001.jpg ... tr_350.jpg
```

**Toplam yeni dosya:** 1 migration + 3 script + 4 data + 1 manifest

**`matching.service.ts` değişmez.** Diğer prod kodu değişmez.

---

## Database Migration

### `027_is_seed_profile.sql`

```sql
-- Mark fake/seed profiles for clean removal later.
-- Discover/match flows do NOT filter on this column — seed profiles
-- behave exactly like real users until cleanup.

ALTER TABLE users
  ADD COLUMN IF NOT EXISTS is_seed_profile BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_users_is_seed_profile
  ON users(is_seed_profile)
  WHERE is_seed_profile = true;
```

**Mevcut akışla uyum:**
- `is_test_account=false` (default) → mevcut TikTok-seed filter (`matching.service.ts:43`) tetiklenmez → seed profiller herkese görünür
- `email_verified=true` set edilir → discover gereği
- `is_deleted=false` (default)

---

## Stage 1 — Photo Generation

### Script: `scripts/seed/generate-seed-photos.ts`

**API:** Replicate `black-forest-labs/flux-schnell`
- 1024×1024, JPG, aspect_ratio="3:4"
- ~$0.003/foto, ~3sn/foto
- Concurrency limit: 10 parallel request
- Env: `REPLICATE_API_TOKEN` (.env + Railway)

**Prompt builder:**
```
"Portrait of a {age}-year-old Turkish woman with {hair} hair, {expression},
 wearing {outfit}, in {setting}, natural lighting, shot on iPhone,
 slight grain, candid selfie aesthetic, photorealistic, NOT glamour,
 NOT studio, casual everyday look"
```

**Çeşitlilik havuzları (`photo-prompt-pools.ts`):**
- `hair` (6): dark brown / black / chestnut / dyed blonde / auburn / light brown
- `expression` (4): gentle smile / soft gaze / slight laughter / thoughtful look
- `outfit` (5): oversized sweater / summer dress / casual blouse / linen shirt / leather jacket
- `setting` (8): Istanbul rooftop / cozy cafe / park bench / Bosphorus view / sunlit apartment / Cappadocia balloons / Antalya beach / autumn street

Kombinatoriyel: 6 × 4 × 5 × 8 = 960 kombinasyon → 350 için bol bol unique.

**Akış (her seq 001-350 için):**
1. Yerel cache'te `seed-photos-cache/tr_NNN.jpg` varsa → atla (idempotent)
2. Prompt üret (yaş, hair, expression, outfit, setting kombinasyonu)
3. Replicate API call → image URL döner
4. `fetch` ile blob indir → `seed-photos-cache/tr_NNN.jpg` yaz
5. Supabase Storage `photos` bucket → `seed/tr_NNN.jpg` upload (upsert)
6. Public URL al

**Manifest format (`output/photos-manifest.json`):**
```json
[
  {
    "seq": 1,
    "prompt": "Portrait of a 26-year-old Turkish woman...",
    "local_path": "seed-photos-cache/tr_001.jpg",
    "storage_url": "https://vtntrtozgoyhjdvvurkj.supabase.co/storage/v1/object/public/photos/seed/tr_001.jpg",
    "generated_at": "2026-06-11T20:15:00Z"
  },
  ...
]
```

**CLI flags:**
- `--regenerate <seq>` — tek seq'i yeniden üret (kötü çıkanları düzeltmek için)
- `--from <seq> --to <seq>` — kısmi range üret
- (default) — eksik olanları üret

**Manuel curation:** Operatör manifest'i + cache'i inspecte eder, beğenmediği seq'i `--regenerate` ile yeniler. Bu adım opsiyonel ama önerilen.

---

## Stage 2 — Profile Seeding

### Script: `scripts/seed/seed-fake-tr-profiles.ts`

**Önkoşul:** `photos-manifest.json` mevcut (Stage 1 tamamlanmış)

### City Distribution (`data/tr-cities.ts`)

| Şehir | lat | lng | Quota |
|---|---|---|---|
| İstanbul | 41.0082 | 28.9784 | 80 |
| Ankara | 39.9334 | 32.8597 | 50 |
| İzmir | 38.4192 | 27.1287 | 40 |
| Bursa | 40.1885 | 29.0610 | 25 |
| Antalya | 36.8969 | 30.7133 | 25 |
| Adana | 37.0000 | 35.3213 | 18 |
| Konya | 37.8746 | 32.4932 | 18 |
| Gaziantep | 37.0662 | 37.3833 | 18 |
| Kayseri | 38.7322 | 35.4853 | 14 |
| Eskişehir | 39.7767 | 30.5206 | 14 |
| Trabzon | 41.0027 | 39.7168 | 14 |
| Mersin | 36.8121 | 34.6415 | 14 |
| Samsun | 41.2867 | 36.3300 | 12 |
| Diyarbakır | 37.9144 | 40.2306 | 10 |
| Erzurum | 39.9000 | 41.2700 | 8 |
| **TOPLAM** |  |  | **350** |

**Lat/lng jitter:** Her profil için merkez koordinatına ±0.05° (~5km) random offset → noktalar üst üste binmez.

### Name Pool (`data/tr-female-names.ts`)

- ~80 first name (örnek): Ayşe, Zeynep, Elif, Merve, Selin, Ece, Deniz, Esra, Burcu, Damla, Ceren, Gizem, Pınar, Tuğçe, Beyza, Esma, İrem, Yağmur, Defne, Aslı, Berfin, Eda, Sude, Naz, Melisa, ...
- ~100 surname (örnek): Yılmaz, Kaya, Demir, Çelik, Şahin, Aydın, Öztürk, Doğan, Arslan, Polat, Aslan, Çetin, Kaplan, Özdemir, Tekin, Korkmaz, Erdoğan, Aksoy, Güneş, ...

Kombinatoriyel: 80 × 100 = 8000 >> 350. **Uniqueness garantisi:** insert sırasında `seen` set kontrolü → çakışırsa yeniden çek.

### Bio Pool (`data/tr-bio-pool.ts`)

~30 template, placeholder'lı:
```
"{city}'da {job} olarak çalışıyorum. {hobby} ve {hobby2} tutkusu."
"Sabahları kahve, akşamları {hobby}. {city}'da yaşayan bir {job}."
"{job}'um, hayata {trait} bakarım. {hobby} dolu bir hayat."
"{city}'lıyım, {job} hayatımı dolduruyor. Boş zamanlarımda {hobby}."
...
```

- `hobby` havuzu (~25): kahve, kitap, yoga, koşu, müzik, dans, yemek yapma, sinema, seyahat, doğa yürüyüşü, fotoğraf, resim, dil öğrenme, podcast, pilates, bahçe, ...
- `trait` havuzu (~15): pozitif, gerçekçi, meraklı, sakin, tutkulu, hayalperest, dürüst, ...
- `job` havuzu (~30): Öğretmen, Hemşire, Pazarlama Uzmanı, Grafik Tasarımcı, Avukat, Mimar, Diyetisyen, İnsan Kaynakları Uzmanı, Yazılım Geliştirici, Editör, Mühendis, Doktor, Eczacı, ...

### Per-Profile Random Field Defaults

```ts
{
  email: `seed_tr_${String(seq).padStart(3, '0')}@qulo.test`,
  password_hash: bcrypt("SeedFake1234!", 12),  // kimse login olmayacak
  name: pickUniqueFirstName(),
  surname: pickUniqueSurname(),
  age: rand(22, 38),
  gender: "WOMAN",
  gender_pref: "MAN",
  bio: renderBioTemplate(city, job),
  city: cityName,
  country: "Turkey",
  lat: city.lat + jitter(),
  lng: city.lng + jitter(),
  locale: "tr",
  preferred_languages: ["tr"],
  match_radius_km: rand(25, 100),
  age_pref_min: Math.max(18, age - 5),
  age_pref_max: Math.min(50, age + 8),
  relationship_goal: weightedPick({ SERIOUS: 50, NOT_SURE: 30, FRIENDSHIP: 15, CASUAL: 5 }),
  email_verified: true,
  is_online: Math.random() < 0.3,
  profile_completion: rand(78, 92),
  green_diamonds: rand(10, 40),
  photos: [manifest[seq - 1].storage_url],   // ← tek foto
  is_seed_profile: true,                      // ← cleanup marker
  is_test_account: false,                     // ← discover'da görünür
  last_seen_at: randomTimeWithin(72 * 3600),
  referral_code: `S${String(seq).padStart(3, '0')}${randomAlpha(5)}`,
}
```

### User Details Insert

```ts
{
  user_id: insertedUserId,
  height: rand(158, 180),
  zodiac: pickRandom(ZODIACS),
  job: pickRandom(JOBS),
  smoking: weightedPick({ NO: 60, SOMETIMES: 30, YES: 10 }),
  alcohol: weightedPick({ SOMETIMES: 50, NO: 35, YES: 15 }),
  personality: pickRandom(["Introvert", "Extrovert", "Ambivert"]),
}
```

### User Languages Insert

```ts
{ user_id: insertedUserId, locale: "tr" }
```

### Questions Insert (3 questions per profile)

Önceden cache'le:
```ts
const { data: pool } = await supabase
  .from("ai_question_bank")
  .select("question_text, answers, category")
  .eq("locale", "tr")
  .eq("is_active", true)
  .limit(2000);
```

Her profil için 3 random soru seç (kategori çeşitliliği için: 1 relationship + 1 personality + 1 lifestyle/diğer):

```ts
for (let i = 0; i < 3; i++) {
  const q = sample(pool);
  await supabase.from("questions").insert({
    user_id: insertedUserId,
    order_num: i + 1,
    question_text: q.question_text,
    answer_1: q.answers[0],
    answer_2: q.answers[1],
    answer_3: q.answers[2],
    answer_4: q.answers[3],
    correct_answer: rand(1, 4),  // profile rastgele birini "doğru" seçer
    category: q.category,
    time_limit: 30,
    locale: "tr",
  });
}
```

### Idempotency

- Email unique constraint var (`seed_tr_NNN@qulo.test`)
- Insert'ten önce `SELECT id FROM users WHERE email = ...` → varsa atla
- Hata durumunda script kaldığı yerden devam edebilir

### CLI

```bash
npx tsx scripts/seed/seed-fake-tr-profiles.ts
# (varsa atlayarak eksikleri ekler)
```

---

## Cleanup

### Script: `scripts/seed/delete-fake-tr-profiles.ts`

```ts
// 1. Tüm seed user ID'lerini topla
const { data: users } = await supabase
  .from("users")
  .select("id")
  .eq("is_seed_profile", true);
const ids = users.map(u => u.id);

// 2. Related tablolardan sil
const tables = [
  "user_details", "user_languages", "questions",
  "swipes", "matches", "messages",
  "refresh_tokens", "diamond_transactions",
  "notifications", "user_badges",
];
for (const t of tables) {
  await supabase.from(t).delete().in("user_id", ids);
}
// matches/swipes target taraftaki referansları da temizle
await supabase.from("swipes").delete().in("target_id", ids);
await supabase.from("matches").delete().in("user2_id", ids);

// 3. Storage seed/ klasörünü sil
const storageFiles = ids.map((_, i) =>
  `seed/tr_${String(i + 1).padStart(3, '0')}.jpg`
);
await supabase.storage.from("photos").remove(storageFiles);

// 4. users tablosundan sil
await supabase.from("users").delete().eq("is_seed_profile", true);
```

**CLI:** `npx tsx scripts/seed/delete-fake-tr-profiles.ts --confirm`
(`--confirm` flag olmadan dry-run yapar, kaç satır silineceğini yazar.)

---

## Verification

### Stage 1 sonrası
- [ ] `output/photos-manifest.json` 350 entry içerir
- [ ] `seed-photos-cache/tr_001.jpg` ... `tr_350.jpg` mevcut
- [ ] Random 5 foto manuel inspeksiyon → kalite OK
- [ ] Storage URL'leri 200 döner (curl test)

### Stage 2 sonrası
- [ ] `SELECT COUNT(*) FROM users WHERE is_seed_profile=true` = 350
- [ ] `SELECT city, COUNT(*) FROM users WHERE is_seed_profile=true GROUP BY city` quota tablosuyla eşleşir
- [ ] `SELECT COUNT(*) FROM questions WHERE user_id IN (SELECT id FROM users WHERE is_seed_profile=true)` = 1050
- [ ] `SELECT COUNT(*) FROM user_details WHERE user_id IN (...)` = 350
- [ ] Random 5 profil API call: `/api/v1/users/{id}` → name, photo, bio, sorular gelir
- [ ] Gerçek test user (İstanbul) `/api/v1/discover` çağırır → ≥50 seed profil görünür (radius default 100km ile)
- [ ] Manuel: APP-1915 branch'inde mobile build → discover ekranı dolu

### Match akış doğrulaması
- [ ] Gerçek user seed profilin sorularını çözer → match satırı normal oluşur (özel logic yok)
- [ ] Chat açılır → kullanıcı mesaj yazar → seed user "online görünmez" (sadece offline kalır), cevap gelmez
- [ ] Yeşil elmas akışı normal işler

### Cleanup doğrulaması (dev DB'de)
- [ ] `--confirm` siler → COUNT(*) = 0
- [ ] Storage seed/ klasörü boş
- [ ] Tekrar seed çalıştırılır → 350 yeniden eklenir (idempotent)

---

## Operational Runbook

**İlk çalıştırma:**
```bash
# 0. Migration uygula
psql $DATABASE_URL -f migrations/027_is_seed_profile.sql

# 1. .env'e REPLICATE_API_TOKEN ekle
echo "REPLICATE_API_TOKEN=r8_xxxx" >> .env

# 2. Stage 1: foto üret (~30dk, ~$1)
npx tsx scripts/seed/generate-seed-photos.ts

# 3. Manifest + cache inspekte et, kötü olanları yenile
npx tsx scripts/seed/generate-seed-photos.ts --regenerate 47

# 4. Stage 2: profil seed (~2dk)
npx tsx scripts/seed/seed-fake-tr-profiles.ts

# 5. Doğrula
psql $DATABASE_URL -c "SELECT COUNT(*) FROM users WHERE is_seed_profile=true"
```

**Cleanup (yeterli gerçek kullanıcıya ulaşınca):**
```bash
# Dry-run önce
npx tsx scripts/seed/delete-fake-tr-profiles.ts

# Onaylı sil
npx tsx scripts/seed/delete-fake-tr-profiles.ts --confirm
```

---

## Risks & Mitigations

| Risk | Mitigation |
|---|---|
| AI fotolar arasında garip/deformite olanlar | `--regenerate <seq>` flag, manuel curation aşaması |
| Replicate API rate limit | Concurrency 10 ile sınırlı, retry/backoff |
| Replicate URL'leri expire olur (~1h) | Hemen download + Supabase Storage'a upload |
| Tek foto profili "şüpheli" görünebilir | %30 gerçek user de tek foto yüklüyor (varsayım); risk düşük |
| Match olur ama cevap gelmez → kullanıcı şüphelenir | Kabullenmiş risk; kullanıcı sayısı arttıkça oran düşer |
| Cleanup sırasında match'i olan gerçek user'ın chat'i kırılır | Match/messages cascade silinir, gerçek user için "kullanıcı silindi" benzeri standart UI |
| Email pattern (seed_tr_XX) public exposed olur | Email zaten public değil; sadece DB internal |

---

## Out of Scope (Future Work)

- **Phase 2:** Erkek seed profiller (gender=MAN için aynı pipeline)
- **Phase 3:** Otomatik chat yanıt sistemi (AI veya scripted)
- **Phase 4:** Diğer ülkeler (EU, US için lokalize pipeline)
- **Admin UI:** Seed profil yönetimi web paneli

---

## Cost Summary

| Kalem | Maliyet |
|---|---|
| Replicate Flux Schnell (350 × $0.003) | ~$1.05 |
| Supabase Storage (350 × ~150KB = ~50MB) | $0 (free tier) |
| GPT-4o (kullanılmıyor — bio template) | $0 |
| Developer time (one-shot) | ~2-3 saat |
| **TOPLAM** | **~$1** + dev time |

Cleanup maliyetsiz.
