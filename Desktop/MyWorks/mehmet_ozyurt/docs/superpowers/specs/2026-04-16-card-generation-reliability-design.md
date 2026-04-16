# Card Generation Reliability — Design

**Tarih:** 2026-04-16
**Kapsam:** `tabul_server` `/api/generate-cards` endpoint'i
**Branch:** APP-1915

## Problem

Kullanıcı N kart ister (örn. 150), server N'den az kart dönebiliyor. "Gold sistem" senaryosunda bu belirgin. Kök sebepler:

1. **Tek seferlik AI çağrısı** — eksik gelirse retry/fill yok.
2. **`fillAttempts: 1` hardcoded** (`server.js:165`) — gerçek fill loop yok, süs.
3. **Validation sessizce kart düşürüyor** (`server.js:136-139`) — `forbiddenWords.length === 5` değilse atılıyor.
4. **max_tokens riski** — JSON ortada kesilirse `JSON.parse` patlar, 0 kart döner.
5. **Model tembelliği** — `gpt-4o-mini`/`gpt-3.5-turbo` uzun listelerde "vb." kullanıp az kart üretir.
6. **Duplicate detection yok** — AI tekrar eden kartlar üretebilir, düşmüyor.
7. **Partial kaçağı** — Client'a `partial: true` dönüyor ama sayı garantisi yok.

## Hedef

- **Katı sayı garantisi**: N istenen = N döndürülen (strict default).
- Ulaşılamazsa partial döndürme → explicit `INSUFFICIENT_CARDS` error (üretilenler yine response'a eklenir, kullanıcı OpenAI maliyetini kaybetmesin).
- Yeni felsefe: "150 istersen 150 ver."

## Mimari

### Yeni Akış

```
Client → POST /api/generate-cards { prompt, cardCount, model, language }
   │
   ▼
Input validation (cardCount 1-200, prompt 1-2000, model whitelist)
   │
   ▼
Strateji seç (cardCount ≤ CHUNK_SIZE → tek çağrı; > → chunked)
   │
   ├─ Chunk array oluştur (ör. 150 → [50, 50, 50])
   ├─ Paralel OpenAI çağrıları (Promise.all, her chunk ayrı retry)
   ├─ Sonuçları birleştir
   ├─ Validate + dedup (lower-case, trim)
   │
   ├─ eksik = requested - validUnique
   │   │
   │   └─ eksik > 0 ise fill loop
   │         attempt 1..MAX_FILL_ATTEMPTS
   │         exclude list = mevcut word'ler
   │         Her attempt sonrası: validate + dedup
   │         "No progress" guard: ardışık 2 attempt'te 0 yeni kart → kır
   │
   ▼
Sayı ulaşıldı mı?
   ├─ Evet → 200 success + kartlar + stats
   └─ Hayır → 422 INSUFFICIENT_CARDS + üretilen kartlar + stats
```

### Parametreler

| Parametre | Değer | Neden |
|---|---|---|
| `CHUNK_SIZE` | 50 | max_tokens 5000 ile güvenli, AI tembelleşmez |
| `MAX_FILL_ATTEMPTS` | 5 | Garanti için cömert ama sonsuz değil |
| `PARALLEL_CHUNKS` | true | Latency düşer (150 kart 3 paralel ≈ tek çağrı süresi) |
| `DEDUP_KEY` | `word.toLowerCase().trim()` | i18n duyarlılık yok, büyük/küçük harf duyarsız |
| `FILL_BATCH_SIZE` | `min(eksik, 30)` | AI küçük batch'te daha uyumlu |
| `MAX_TOTAL_OPENAI_CALLS` | 12 | Cost guard (3 chunk + 5 fill + pay için tampon) |
| `NO_PROGRESS_LIMIT` | 2 | Ardışık 2 sıfır ilerleme → loop kırılır |
| `OPENAI_TIMEOUT_MS` | 90000 | Chunk başına 90s |
| `OPENAI_RETRY_ON_429` | 1 attempt, 2s backoff | 429'da tek retry |

### Edge Case Davranışları

| # | Senaryo | Davranış |
|---|---|---|
| 1 | AI "vb." kullanır | Prompt'a eklenen: *"Do NOT use abbreviations like 'etc.', '...', placeholders or comments. Generate every card with full content. Array length MUST equal N."* |
| 2 | Token limit → JSON kesildi | Chunking ile önlenir. Ek güvence: `response_format: { type: "json_object" }` (OpenAI native JSON mode) |
| 3 | AI sayı üretmiyor (50 iste, 42 ver) | Fill loop eksik 8'i tamamlar |
| 4 | Forbidden count yanlış | 5'ten azsa düşür, 5'ten fazlaysa ilk 5'i al (`slice(0, 5)`) — veri kaybı azalır |
| 5 | Forbidden = main word | Filtre: `forbidden !== word` (case-insensitive). Eşleşen forbidden çıkarılır; 5'in altına düşerse kart düşer |
| 6 | Forbidden array içinde duplicate | Dedup forbidden içinde; 5 altına düşerse kart düşer |
| 7 | Boş/whitespace word | `word.trim().length > 0` |
| 8 | Chunk'lar arası duplicate | Birleştirmede global dedup |
| 9 | Fill'de AI exclude list'i ignore | Her attempt sonrası dedup; no-progress guard |
| 10 | Maliyet patlaması | `MAX_TOTAL_OPENAI_CALLS` guard |
| 11 | Chunk 429 | 1 retry (2s), hâlâ fail → chunk boş → fill telafi eder |
| 12 | Chunk timeout | 90s limit; timeout olan chunk boş → fill telafi |
| 13 | Tüm chunk'lar fail | 500 `GENERATION_ERROR` |
| 14 | Strict hâlâ eksik | 422 `INSUFFICIENT_CARDS` + kısmi kartlar data'da |
| 15 | OpenAI 401/quota | `OPENAI_AUTH_ERROR` veya `OPENAI_QUOTA` (ayırt et) |
| 16 | cardCount > 200 veya < 1 | 400 `INVALID_CARD_COUNT` |
| 17 | prompt > 2000 char | 400 `PROMPT_TOO_LONG` |
| 18 | prompt whitespace | `prompt.trim().length > 0` |

## Model Upgrade

### allowedModels Değişikliği

| Mevcut | Yeni | Açıklama |
|---|---|---|
| gpt-4 | ❌ kaldırıldı | Eski, küçük context, pahalı |
| gpt-4o | ✅ **default** | Dengeli: 16K output, iyi talimat takibi |
| gpt-4o-mini | ✅ korundu | Ucuz alternatif |
| gpt-3.5-turbo | ❌ kaldırıldı | "Exactly N" uymuyor — asıl eksik kart kaynağı |
| — | ✅ gpt-4.1 eklendi | Premium: 1M context, en iyi talimat takibi |

**Default model:** `gpt-4o-mini` → `gpt-4o` (daha iyi talimat takibi, makul maliyet).

## API Kontratı

### Request

```json
POST /api/generate-cards
{
  "prompt": "string (1-2000 char, trim sonrası)",
  "cardCount": "number 1-200 (default 50)",
  "model": "gpt-4o | gpt-4o-mini | gpt-4.1 (default gpt-4o)",
  "language": "2-char ISO (default 'tr')"
}
```

### Response — Success (200)

```json
{
  "success": true,
  "message": "Kartlar başarıyla oluşturuldu",
  "data": {
    "theme": "...",
    "themeTitle": "...",
    "cardCount": 150,
    "requestedCount": 150,
    "language": "tr",
    "languageName": "Turkish",
    "model": "gpt-4o",
    "cards": [{ "word": "...", "forbiddenWords": ["...",...] }],
    "stats": {
      "chunks": 3,
      "fillAttempts": 1,
      "duplicatesRemoved": 4,
      "invalidDropped": 2,
      "totalOpenAICalls": 4,
      "elapsedMs": 18432
    }
  }
}
```

### Response — Failure (422 sayı garanti tutmadı)

```json
{
  "success": false,
  "errorCode": "INSUFFICIENT_CARDS",
  "message": "150 kart üretilemedi (132/150). Tekrar deneyin.",
  "data": {
    "cards": [...],
    "cardCount": 132,
    "requestedCount": 150,
    "stats": { ... }
  }
}
```

### Error Kodları

| Kod | Status | Tetikleyici |
|---|---|---|
| `MISSING_PROMPT` | 400 | prompt yok veya trim sonrası boş |
| `PROMPT_TOO_LONG` | 400 | prompt > 2000 char |
| `INVALID_CARD_COUNT` | 400 | cardCount < 1 veya > 200 |
| `INVALID_MODEL` | 400 | model whitelist dışı |
| `OPENAI_AUTH_ERROR` | 500 | API key hatası (401) |
| `OPENAI_QUOTA` | 500 | Quota bitti (insufficient_quota) |
| `RATE_LIMIT` | 429 | Genel rate limit |
| `TIMEOUT` | 408 | Tüm chunk'lar timeout |
| `INSUFFICIENT_CARDS` | 422 | Strict garanti tutmadı |
| `GENERATION_ERROR` | 500 | Diğer tüm hatalar |

## Logging

### Format (console, yapısal)

```
[req-{shortId}] start | prompt="..." count=150 model=gpt-4o lang=tr
[req-{shortId}] chunk 1/3 → 50 cards in 6.2s (0 dropped)
[req-{shortId}] chunk 2/3 → 48 cards in 5.8s (2 dropped: invalid_forbidden_count)
[req-{shortId}] chunk 3/3 → 50 cards in 6.4s (0 dropped)
[req-{shortId}] merge: 148 unique (4 duplicates removed)
[req-{shortId}] fill 1: requesting 2 more (excluding 148 words)
[req-{shortId}] fill 1 → 2 new cards (progress=true)
[req-{shortId}] DONE 150/150 | calls=4 elapsed=18.4s
```

### Drop Sebepleri (stats'te sayılır)

- `invalid_forbidden_count` — forbidden 5'in altında
- `empty_word` — word boş/whitespace
- `forbidden_eq_word` — forbidden, word ile aynı (tabu ihlali)
- `duplicate_word` — chunk'lar arası aynı word
- `duplicate_forbidden` — forbidden array içinde tekrar
- `token_cutoff` — JSON kesildi (chunk level)

## Dosya Organizasyonu

`server.js` zaten 426 satır, kart logic'i şişirecek. Modüllere ayır:

```
tabul_server/
├── server.js                    (426 → ~200 satır: route'lar, middleware)
├── lib/
│   ├── cards/
│   │   ├── generator.js         (orchestration: chunk + fill loop)
│   │   ├── openai-client.js     (OpenAI çağrısı + retry + timeout)
│   │   ├── validator.js         (kart validation, drop reason üretimi)
│   │   ├── deduper.js           (lower-case + trim dedup)
│   │   └── prompt-builder.js    (system + user prompt + exclude list)
│   └── logger.js                (req-id ile yapısal log)
```

`server.js`'teki `/api/generate-cards` handler ~20 satıra iner:

```js
app.post('/api/generate-cards', async (req, res) => {
  const input = validateInput(req.body);
  if (!input.ok) return res.status(400).json(input.error);
  try {
    const result = await generator.generate(input.data);
    return res.status(result.success ? 200 : 422).json(result);
  } catch (err) {
    return res.status(errStatus(err)).json(errBody(err));
  }
});
```

## Test Stratejisi

Mevcut projede otomatik test altyapısı yok (package.json'da test script yok). Manuel doğrulama:

1. **Health check**: `GET /api/health` hâlâ çalışıyor.
2. **Happy path**: 150 kart, `gpt-4o` → 150/150 döner, `stats.fillAttempts` düşük.
3. **Küçük istek**: 10 kart, `gpt-4o-mini` → 10/10, tek chunk, fill yok.
4. **Büyük istek**: 200 kart → 200/200 (en sert case).
5. **Sınır değerler**: cardCount=0, cardCount=201, cardCount="abc" → 400 `INVALID_CARD_COUNT`.
6. **Prompt sınırları**: boş, whitespace, 2001 char → 400.
7. **Invalid model**: `model: "gpt-5"` → 400 `INVALID_MODEL`.
8. **Failure path simülasyonu**: OpenAI API key geçersiz → `OPENAI_AUTH_ERROR`.
9. **Partial (beklenmedik)**: Spec'in garanti hedefine rağmen ulaşılamazsa → 422 + kartlar.

Mevcut public test UI (`public/index.html`) üzerinden manuel doğrulama yapılır.

## Geriye Dönük Uyumluluk

- Response shape değişiklikleri **geriye dönük uyumsuz**: `partial`, `note`, `fillAttempts` (root level), `validation` kaldırılıyor. Bu bilgiler `stats`'e taşınıyor.
- Client (Flutter) tarafında `generate_tabul_card_cubit.dart` güncellenmeli:
  - `partial: true` üzerinden yapılan UI davranışı kaldırılmalı
  - `errorCode === 'INSUFFICIENT_CARDS'` için yeni handling (üretilen kartlar + retry CTA)
  - `stats` objesi opsiyonel olarak analytics'e gönderilebilir
- Default model değişikliği (`gpt-4o-mini` → `gpt-4o`) client'ı etkilemiyor (client zaten model gönderiyor veya default'u kullanıyor).

## Kapsam Dışı

- Rate limiting / kullanıcı bazlı kota (ayrı iş).
- Supabase'e istek geçmişi yazma (analytics — ileri aşama).
- Dil tespiti ile forbidden word dil eşleşme validasyonu (complex, prompt sıkılaştırmayla yetinilecek).
- Streaming response (axios non-stream kalır).
- Otomatik test suite (Jest/Vitest) — manuel test yeterli bu iterasyonda.

## Başarı Ölçütü

- 150 kart isteğinde: başarı oranı (200 response) **%95+**.
- 422 INSUFFICIENT_CARDS sıklığı **%5'in altında**.
- Ortalama `totalOpenAICalls`: 150 kart için **< 5**.
- Ortalama latency: 150 kart için **< 25s** (paralel chunk).
- 0 kart parse error senaryosu **ortadan kalkmalı**.
