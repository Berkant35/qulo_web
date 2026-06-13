# Anti-Cheat: Quiz + Discover Layer Defense — Design Spec

**Date:** 2026-06-12
**Status:** Design — pending implementation plan
**Affects:** qulo-server (matching, quiz, admin), qulov2 (quiz client adapter)

## Context

Qulo'nun quiz-tabanlı eşleşme mekaniği aşağıdaki gerçek dünya saldırısına karşı korunmasız:

> İki erkek kullanıcı fiziksel olarak yan yana (kafe, ev, ofis). Erkek A bir kadının (Kadın X) quiz'ini açar, tüm soruları görür ve çözer → otomatik match. Erkek B aynı kadının quiz'ini açar, A'nın hatırladığı/söylediği cevapları kullanarak 100% doğru cevap verir → otomatik match. Aynı saldırı vektörü ekran görüntüsü paylaşımı (uzaktan) veya aynı kişinin ikinci hesap açması (multi-account) için de geçerli.

Sunucu inspeksiyonu (Haziran 2026) gösterdi:
- `POST /quiz/start` target'in **tüm sorularını** tek seferde döner (random subset değil)
- Soru metni açık (sadece şıklar shuffle'lı)
- Tüm doğrular → **otomatik match**, owner onay gate'i yok
- IP/device/konum tabanlı saldırı tespiti yok
- Min think-time enforcement yok
- Mevcut tek koruma: 1 dakikada 30 request rate-limit (saldırgan için bol bol yeter)

**Hedef:** Yan yana, ekran paylaşımı ve çoklu-hesap saldırılarını mümkün olduğunca önlemek; üretim hayatında **dry-run** veya **kapalı** modda doğrulamadan etkinleştirmemek.

**Hedef dışı:** Bot/scripting saldırıları (ayrı bir tasarım gerektirir — CAPTCHA, davranışsal entropi vs.). Bu spec insan kaynaklı cheat'e odaklanır.

## Tasarım Felsefesi

Üç prensip:

1. **Katmanlı savunma** — Tek başına yetmeyen iki katman birlikte saldırıyı kırar.
2. **Config-driven, dry-run-first** — Hiçbir kural koda gömülmez. Üretime ilk gidişte hepsi **OFF**. Production'da etkinleştirmeden önce `dry_run: true` modunda 1+ hafta veri toplanır.
3. **Mevcut pattern'i yeniden kullan** — Yeni mimari icat etme. `economy-config` ve `app-config` zaten singleton config + EJS admin form pattern'i tanımlıyor; aynısı uygulanır.

## Mimari

```
                  ┌─────────────────────────────────┐
   Discover    →  │  L1: Proximity + IP Exclusion   │  → Kadın X gizlenir
   (matching)     │  Config: proximity_exclusion     │
                  └────────────┬────────────────────┘
                               │ X görünür
                               ▼
                  ┌─────────────────────────────────┐
   Quiz Start  →  │  L2a: Drip Questions             │  → Sadece 1. soru
                  │  Config: drip_questions          │
                  └────────────┬────────────────────┘
                               ▼
                  ┌─────────────────────────────────┐
   Quiz Answer →  │  L2b: Min Think-Time + L2c       │  → ≥2s + viewer'a özel
                  │       Per-Viewer Shuffle         │     deterministik shuffle
                  │  Config: min_think_time,         │
                  │          viewer_specific_shuffle │
                  └─────────────────────────────────┘

Tüm kurallar tek bir singleton tablodan okunur:
  anti_cheat_config (id=1, jsonb)

Dry-run ve gerçek bloklar tek bir log tablosuna yazılır:
  anti_cheat_decisions
```

### L1 — Discover-Layer Proximity + IP Exclusion

**Kural:** Viewer V, target T'yi discover'da görmesin EĞER son `ttl_hours` saat içinde, V'nin konumuna `radius_meters` metre yakınında **veya** V'nin IP'sine eşit IP'den başka bir kullanıcı T'nin quiz'ini başlatmışsa.

- Tetikleyici olay: `quiz_sessions` insert (yani quiz START — match veya tamamlanma değil; soruları görmek yeterli)
- Self-quiz hariç: `solver_id != viewer_id`
- Kuralın değerlendirme noktası: `getDiscover()` SQL query'sinde `NOT EXISTS` subquery
- Config kapalıyken (`enabled: false`): subquery hiç çalıştırılmaz (overhead yok)
- `dry_run` ve `rollout_pct` etkileşimi (her ikisi de `enabled: true` iken anlamlıdır):
  - `dry_run: true` → **tüm kullanıcılar için** karar hesaplanır ve loglanır, ama asıl discover'a uygulanmaz (rollout_pct göz ardı edilir — amaç tam örneklem ölçüm).
  - `dry_run: false` → `crc32(viewer_id) % 100 < rollout_pct` olan kullanıcılar gerçek bloka tabi tutulur ve loglanır; geri kalanlar etkilenmez ve loglanmaz.
  - Bu ayrım dashboard'da net görülür: `outcome = 'DRY_RUN_BLOCKED'` ölçüm verisi; `outcome = 'BLOCKED'` gerçek uygulama verisi.

### L2a — Drip Questions

**Kural:** `POST /quiz/start` sadece ilk soruyu döner. `POST /quiz/:session_id/answer` her cevap submit'inden sonra response'una `next_question` ekler. Böylece bir kullanıcı ekran görüntüsüyle tüm soruları tek seferde ele geçiremez.

- Server: session içinde `question_ids` JSONB hâlâ tüm sıralamayı saklar (rescue/replay için kritik), ama wire'da yalnızca `current_q`'ya karşılık gelen tek soru gönderilir.
- Mobile (qulov2): mevcut "tüm sorular yüklendi" varsayımını "her cevaptan sonra next_question'dan al" şeklinde değiştir.
- Rescue endpoint'i (`POST /:session_id/rescue`): mevcut `current_q`'yu olduğu gibi bırakır; sonraki `submitAnswer` response'unda doğru soru döner.

### L2b — Min Think-Time

**Kural:** Server bir soruyu serve ettikten sonra (`last_q_served_at` damgalanır) o sorunun cevabını `min_seconds` saniye geçmeden kabul etmez.

- Implementation: `submitAnswer`'da `(NOW() - last_q_served_at) < min_seconds` ise **429 THINK_TIME_VIOLATION** döner.
- Dry-run: ihlal loglanır, cevap kabul edilir.
- `last_q_served_at` güncelleme kuralı (drip on/off bağımsız):
  - `startSession` çağrıldığında 1. soru için damgalanır.
  - Her başarılı `submitAnswer` sonrasında, bir sonraki soru için **NOW()** ile yeniden damgalanır.
  - Böylece min think-time iki cevap arasındaki gap'i ölçer; drip kapalı modda da tutarlı çalışır.

### L2c — Per-Viewer Deterministik Shuffle

**Kural:** Soru SIRASI **ve** her sorunun ŞIK SIRASI (option order — "A/B/C/D" hangi seçeneğe denk gelir) `session_id`'den türetilen seed ile deterministik olarak shuffle'lanır. Aynı session'da rescue/replay'de tutarlı kalır (kullanıcı reload ettiğinde aynı şıkları aynı yerde görür); iki farklı session arasında ise farklıdır (Erkek A'nın gördüğü "C şıkkı doğru" Erkek B için "A şıkkı doğru" olabilir).

- Mevcut durum: şık shuffle var (`shuffleArray(answers)` quiz.service.ts:186) ama deterministik değil — rescue/reload'da sıralama bozulabilir, bu da bir bug riski.
- Yeni: `seededShuffle(arr, seedFromSession(session_id))` (Fisher-Yates + seedable PRNG, örn `mulberry32` inline implementation, harici dep yok).
- Sıralama session record'una **kaydedilmez**; her okunduğunda seed'den yeniden türetilir. Bu sayede storage overhead'i sıfır.

## Veri Modeli

### Migration 028 — quiz_sessions extension

```sql
ALTER TABLE quiz_sessions
  ADD COLUMN start_location geography(POINT, 4326),
  ADD COLUMN start_ip text,
  ADD COLUMN last_q_served_at timestamptz;

CREATE INDEX quiz_sessions_target_started_geog_idx
  ON quiz_sessions USING GIST (start_location)
  WHERE started_at > NOW() - INTERVAL '7 days';

CREATE INDEX quiz_sessions_target_ip_idx
  ON quiz_sessions (target_id, start_ip, started_at DESC)
  WHERE start_ip IS NOT NULL;
```

Partial index'ler 7 günden eski satırlardan kaçınır — kural TTL'i max 24-48h olacak, 7 gün bol güvenlik marjı.

### Migration 029 — anti_cheat_config + decisions

```sql
CREATE TABLE anti_cheat_config (
  id int PRIMARY KEY DEFAULT 1 CHECK (id = 1),
  config jsonb NOT NULL,
  updated_at timestamptz DEFAULT NOW(),
  updated_by uuid REFERENCES admins(id)
);

INSERT INTO anti_cheat_config (id, config) VALUES (1, '{
  "proximity_exclusion": {
    "enabled": false,
    "dry_run": false,
    "rollout_pct": 0,
    "radius_meters": 50,
    "ttl_hours": 24,
    "ip_match_also": true,
    "require_location": true
  },
  "drip_questions": {
    "enabled": false,
    "dry_run": false
  },
  "min_think_time": {
    "enabled": false,
    "dry_run": false,
    "min_seconds": 2.0
  },
  "viewer_specific_shuffle": {
    "enabled": false,
    "dry_run": false
  }
}'::jsonb);

CREATE TABLE anti_cheat_decisions (
  id bigserial PRIMARY KEY,
  decided_at timestamptz DEFAULT NOW(),
  rule text NOT NULL,
  viewer_id uuid,
  target_id uuid,
  session_id uuid,
  outcome text NOT NULL CHECK (outcome IN ('BLOCKED', 'DRY_RUN_BLOCKED', 'ALLOWED', 'ERRORED')),
  reason jsonb
);

CREATE INDEX anti_cheat_decisions_decided_idx
  ON anti_cheat_decisions (decided_at DESC, rule);
CREATE INDEX anti_cheat_decisions_viewer_idx
  ON anti_cheat_decisions (viewer_id, decided_at DESC)
  WHERE viewer_id IS NOT NULL;
```

## Servis ve Endpoint Değişiklikleri

### Yeni — `src/services/anti-cheat-config.service.ts`

`economy-config.service.ts`'in birebir adaptasyonu:

- `getActiveConfig()`: in-memory cache, 5dk TTL. `anti_cheat_config` tablosundan tek satır okur.
- `updateConfig(patch, adminId)`: Zod ile validate eder, mevcut config + patch'i merge eder, atomik update. Cache invalidate.
- Zod şeması her field için boundary enforce eder:
  - `radius_meters`: 10–1000
  - `ttl_hours`: 1–168
  - `rollout_pct`: 0–100
  - `min_seconds`: 0.5–10

### Yeni — `src/services/anti-cheat.service.ts`

Tek sorumluluk: bir L kuralının ne yaptığına karar vermek + loglamak.

- `shouldHideTargetInDiscover(viewer, target): Promise<boolean>` — L1 sonuç + dry-run handling + rollout_pct + decision log
- `enforceMinThinkTime(session, now): { ok: boolean, reason?: string }` — L2b
- `selectDeliverableQuestion(session, currentIdx): Question[]` — drip helper
- `seedFromSession(sessionId): number` — L2c için PRNG seed

### Mevcut servislerde değişiklikler

- **`src/services/matching.service.ts`** — `getDiscover()`: config alır, kapalıysa atlar; `dry_run` veya rollout dışında ise ayrı subquery + log; içinde ise discover SQL'ine `NOT EXISTS` katar.
- **`src/services/quiz.service.ts`** — `createSession`: `req.ip` ve `req.location`'ı kabul eder, `start_location` + `start_ip` insert eder. `startSession`: drip açıksa response'tan sadece ilk soruyu döner; shuffle açıksa seedli sıralar. `submitAnswer`: think-time check + sonraki soruyu response'a koy.
- **`src/controllers/quiz.controller.ts`** — `start`: `req.ip` ve `req.body.location`'ı service'e geçir.

### Admin Panel

`economy-config` pattern'inin birebir takibi:

- **Route:** `admin.routes.ts` → `GET /admin/anti-cheat-config` + `POST /admin/anti-cheat-config` + `GET /admin/anti-cheat-stats`
- **Controller:** `admin.controller.ts` → `antiCheatConfig`, `updateAntiCheatConfig`, `antiCheatStats`
- **Views:**
  - `src/admin/views/anti-cheat-config.ejs` — her özellik için card: enabled toggle, dry_run toggle, parameter input'ları, "Save" CSRF-protected form
  - `src/admin/views/anti-cheat-stats.ejs` — son 7/30/90 gün tablo: rule başına BLOCKED, DRY_RUN_BLOCKED, ALLOWED sayıları; top excluded targets; IP-only vs konum-only match dağılımı (dry-run veriler dahil)
- **Nav:** `src/admin/views/_header.ejs` → "Settings" grubunun altına 2 link: "🛡️ Anti-Cheat", "📊 Anti-Cheat Stats"

### Mobile (qulov2) Değişiklikleri

- Quiz client adapter (`features/quiz/services/quiz_service.dart` veya benzeri): drip mode'u destekle — `startQuiz()` response'unda 1 soru gelirse her `submitAnswer` response'undan `next_question` çek; sonsa sonuç ekranına geç.
- `GET /app/config` payload'ına `drip_questions`, `min_think_time`, `viewer_specific_shuffle` flag'leri eklenecek mi? **Hayır** — bu kuralları server zaten enforce ediyor, client'ın bilmesine gerek yok. Drip aktifse server zaten tek soru döner; client her durumda "next_question varsa al, yoksa bitti" mantığıyla çalışır (forward-compatible).

## Error Handling

| Durum | Davranış |
|---|---|
| Config tablosu boş / corrupt | Service hardcoded default'a düşer (hepsi OFF), error loglanır, app sustainable kalır |
| `start_location` null (eski veya izinsiz user) | L1 query'sinde location şartı atlanır, IP-only match denenir; `require_location: true` ise L1 hiç uygulanmaz |
| `start_ip` null (proxy hatası) | IP match atlanır, location-only çalışır |
| Min think-time ihlali | Response: `429 { code: 'THINK_TIME_VIOLATION', wait_ms: N }` — UI bir kıvılcım gösterir, otomatik retry yapmaz |
| Drip mode'da `next_question` server hatası | Mobile graceful: "Bağlantı sorunu, soru yüklenemedi, tekrar dene" CTA |
| anti_cheat_decisions insert fail | Sessiz logla (`console.error`), asıl flow'u bozma — log eksikliği saldırı değil |

## Verification

### Unit Tests

- `seededShuffle(["a","b","c","d"], 42)` deterministik mi? Aynı seed → aynı output.
- `enforceMinThinkTime({ last_q_served_at: NOW() - 1s }, NOW())` → `{ ok: false }`.
- `enforceMinThinkTime({ last_q_served_at: NOW() - 3s }, NOW())` → `{ ok: true }`.
- `crc32` rollout kararı: 1000 random UUID için %25 rollout → ~250 hit.

### Integration Tests

1. **L1 happy path:** 2 test user A, B aynı koordinatta (40.99, 29.05). A → POST /quiz/start (target X). B → GET /match/discover. X listede yok. Config `enabled: false` yapılınca X listede var.
2. **L1 dry-run:** `dry_run: true`. A start → B discover. X listede VAR (uygulanmadı). `anti_cheat_decisions`'da bir `DRY_RUN_BLOCKED` satırı var.
3. **L1 rollout:** `rollout_pct: 50`. 100 farklı user_id ile test → yaklaşık yarısı block görür.
4. **L2a drip:** start → response'ta `questions.length === 1`. submitAnswer → response'ta `next_question` var.
5. **L2b think-time:** start → 0.5s sonra submitAnswer → 429. 3s sonra submitAnswer → 200.
6. **Self-quiz development bypass:** `start_ip === '127.0.0.1'` ise L1 skip.

### Manual

- 2 fiziksel telefon, aynı WiFi'ye bağlı, aynı kafe lokasyonu (mock GPS aynı koordinat). Test hesabı A ile bir kadın'ın (Test hesabı X) quiz'ini başlat. B telefondan discover refresh → X yok.
- Aynı senaryo, config `enabled: false` → X var (regression yok).

### Dry-Run Onay Süreci (production)

Spec deploy edildikten sonra, **kod merge'ten önce** production etkinleştirme yapılmaz. Aşağıdaki adımlar takip edilir:

1. Config kapalı state'de deploy.
2. Admin'den `proximity_exclusion.dry_run = true`, `rollout_pct = 100` yap.
3. 1 hafta veri topla. `anti_cheat_stats` sayfasından:
   - Toplam `DRY_RUN_BLOCKED` sayısı vs `ALLOWED` sayısı
   - IP-only vs konum-only match oranı (false positive göstergesi)
   - Excluded target başına aktif user kaybı
4. Eğer %5'ten az discover impression bloklanıyorsa → `dry_run = false`, `rollout_pct = 10`.
5. 3 gün → şikayet/anomali yoksa → `rollout_pct = 50`.
6. 1 hafta → `rollout_pct = 100`.

L2 katmanları aynı dry-run → kademeli açılış akışını takip eder.

## Rollback

Her özellik için config'te `enabled: false` yapmak yeterli. Cache TTL maksimum 5dk, yani en geç 5dk içinde tüm trafiği eski davranışa döner. Migration rollback gerekmez — yeni kolonlar null kalır, tablo varlıklarını kullanmayan kod sorunsuz çalışır.

## Açık Sorular (implementasyon planında ele alınacak)

- `crc32` Node'da hangi paket? (`buffer-crc32` veya manual implementation)
- Discover query'de `NOT EXISTS` subquery'nin performans testi: 1M quiz_sessions'da P95 latency?
- Mobile'da drip mode'a geçiş Flutter tarafında zaten "incremental fetch" pattern'ine uygun mu, yoksa state machine refactor mu gerekir? (qulov2 quiz feature'ı incelenmeli)
- `anti_cheat_decisions` ve `quiz_sessions.start_ip/start_location` retention: SQL function'ları hazır (`anti_cheat_purge_decisions`, `anti_cheat_purge_quiz_session_pii`). Railway scheduled job veya admin endpoint ile günde 1 kez tetiklenmeli (default 90 gün).
