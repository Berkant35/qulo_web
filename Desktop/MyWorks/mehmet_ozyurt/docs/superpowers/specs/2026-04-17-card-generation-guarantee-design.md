# Card Generation Guarantee — Design

**Tarih:** 2026-04-17
**Kapsam:** `tabul_server` `/api/generate-cards` — strict-count akışını "gerçek garanti"ye yükselt
**Önceki spec:** `2026-04-16-card-generation-reliability-design.md` (chunked + fill loop)
**Branch:** APP-1915

## Problem (Production Failure)

Production log'unda gözlenen failure case (2026-04-17):

```
Request: { prompt: 3 tema concat (şehirler+fast food+sosyal medya), cardCount: 150, model: 'gpt-4o-mini' }
Response: 422 INSUFFICIENT_CARDS, 110/150
```

Kök sebepler:

1. **Client `gpt-4o-mini` hardcoded** (`generate_tabul_card_cubit.dart:62`): Server default'u `gpt-4o` olsa bile client zorla mini gönderiyor. mini, "exactly N" talimatına gpt-4o'dan belirgin daha kötü uyuyor.
2. **Multi-tema concat AI'yi dağıtıyor**: 3 ayrı tema tek prompt'ta → AI her temaya 50 kart ayırıyor; fill loop'ta exclude list 100+ kelime olunca AI yeni varyasyon üretemiyor.
3. **Konservatif fill loop**: `MAX_FILL_ATTEMPTS=5`, `NO_PROGRESS_LIMIT=2` zayıf model + zor prompt'ta yetmiyor.
4. **Client'ta 422 = total failure**: Kısmi 110 kart çöpe gidiyor, kullanıcı tekrar denemek zorunda → OpenAI maliyeti 2x.

## Hedef

- 150 kart isteği için **%99.5+ başarı oranı** (sadece tek tema değil, 3+ tema concat dahil).
- Client tarafına dokunulmadan tüm sorunları server'da çöz (model, multi-tema, retry).
- Worst case maliyet ≤ 12-15 OpenAI çağrısı/istek (cost guard hâlâ aktif).
- Latency: tek tema 30-50s, multi-tema 40-60s.

## Strateji (6 bileşen kombinasyonu — A+B+C+D+E+F)

### A) Server-Side Model Override

100+ kart isteyen istekler için `gpt-4o-mini` ve eski model talepleri **server tarafından `gpt-4o`'ya zorlanır**. Client değişikliği gerekmez.

```javascript
// Eğer cardCount >= 100 ve model === 'gpt-4o-mini' → 'gpt-4o' yap
// Loglanır: "[req-X] model upgraded: gpt-4o-mini → gpt-4o (cardCount=150)"
```

### B) Over-Provisioning

İstenen kart sayısının `OVERPROVISION_FACTOR (1.33)` katı kadar raw kart iste. Dedup sonrası 1.0x kalsa bile garanti.

| Talep | Eski Chunk | Yeni Chunk |
|---|---|---|
| 50 | [50] | [50] (over-prov yok) |
| 100 | [50,50] | [50,50,33] = 133 |
| 150 | [50,50,50] | [50,50,50,50] = 200 (1.33x) |

### C) Aggressive Fill Loop

| Parametre | Eski | Yeni | Neden |
|---|---|---|---|
| `MAX_FILL_ATTEMPTS` | 5 | **10** | Daha sabırlı |
| `NO_PROGRESS_LIMIT` | 2 | **3** | Tek 0-progress affedilir |
| `FILL_BATCH_SIZE` | 30 | **15** | Küçük batch'lerde AI uyumu daha iyi |
| `MAX_TOTAL_OPENAI_CALLS` | 12 | **15** | Cost guard biraz nefes |

### D) Adaptive Prompts

Her fill attempt için farklı "dimension hint" eklenir. AI tekrar eden duplicate'lerden kurtulur.

```
attempt 1: "Generate less common, less obvious examples"
attempt 2: "Focus on niche or specialized topics within this theme"
attempt 3: "Choose historical or classic examples"
attempt 4: "Choose modern or trending examples"
attempt 5: "Pick examples from different geographic/cultural contexts"
attempt 6+: "Be creative; explore unusual angles of this theme"
```

### E) Rescue Round

`MAX_FILL_ATTEMPTS` veya `NO_PROGRESS_LIMIT` tetiklenip hâlâ eksik varsa **son şans rescue round**:

- 2 paralel OpenAI çağrısı
- `temperature=1.0` (yaratıcılık max)
- Her birinden `FILL_BATCH_SIZE` kart, exclude list ile
- Sonuçları birleştir → dedup → mevcut havuza ekle
- Tek seferlik (rescue içinde rescue yok)

### F) Multi-Tema Parser

Heuristic: prompt 2+ "TabuL kartları oluştur" cümlesi içeriyor veya 2+ newline ile ayrılmış uzun bloklar varsa **multi-tema** kabul edilir.

```
Algoritma:
1. Prompt'u newline (\n) ile böl
2. Her parçanın trim sonrası uzunluğu > 80 char ise tema olarak kabul et
   VE her parça "kart" / "tabul" gibi anahtar kelime içeriyorsa
3. N tema bulundu → her temaya cardCount/N kart ata (over-prov ile)
4. Her temayı ayrı bir "sub-job" olarak çalıştır (chunk + fill loop)
5. Sonuçları birleştir → final dedup → return
```

Eğer N tespit edilemezse (1 tema) → mevcut akış.

## Yeni Akış

```
Client → POST { prompt, cardCount=150, model='gpt-4o-mini' }
   │
   ▼ [1] Input validation + normalization
   │
   ▼ [2] Model override (cardCount >= 100 ve model === gpt-4o-mini → gpt-4o)
   │
   ▼ [3] Multi-tema detection (theme-parser.js)
   │     Eğer N >= 2 → her temayı ayrı job olarak çalıştır, sonra birleştir
   │     Aksi halde → tek tema akışı
   │
   ▼ [4] Over-provisioned chunking (cardCount * 1.33 → 4 chunk × 50 = 200)
   │
   ▼ [5] Paralel chunk çağrıları (Promise.all)
   │
   ▼ [6] Birleştir + dedup + validate
   │     Eğer ≥ cardCount unique → ilk cardCount'i al, DONE ✓
   │
   ▼ [7] Aggressive Fill Loop (eksikse)
   │     attempt 1..10, no-progress 3, batch 15
   │     Her attempt'te adaptive hint ekle
   │
   ▼ [8] Rescue Round (hâlâ eksikse)
   │     2 paralel call, temperature=1.0, exclude list ile
   │
   ▼ [9] Final
   │     ≥ cardCount → 200 success
   │     < cardCount → 422 INSUFFICIENT_CARDS + üretilen kartlar
```

## Yeni Dosyalar

```
tabul_server/lib/cards/
├── theme-parser.js       (YENİ) — multi-tema heuristic detection
├── adaptive-prompt.js    (YENİ) — fill attempt index → dimension hint
├── config.js             (DEĞİŞTİ) — yeni sabitler
├── prompt-builder.js     (DEĞİŞTİ) — adaptive hint + temperature param
├── openai-client.js      (DEĞİŞTİ) — temperature opsiyonel param
└── generator.js          (DEĞİŞTİ) — over-prov + theme split + rescue
```

```
tabul_server/server.js                 (DEĞİŞTİ) — model override (cardCount >= 100)
tabul_server/functions/index.js        (DEĞİŞTİ) — aynısı, ayrıca lib/ kopyalanır
tabul_server/functions/lib/            (KOPYALANIR) — server lib'in mirror'u
```

## Edge Case Davranışları (yeni eklenenler)

| # | Senaryo | Davranış |
|---|---|---|
| 1 | Client gpt-4o-mini gönderir + 150 kart | Server `gpt-4o`'ya yükseltir, log'a not düşer |
| 2 | Client gpt-4o-mini gönderir + 50 kart | Server müdahale etmez (mini OK küçük sayılarda) |
| 3 | Client gpt-4.1 gönderir + 150 kart | Saygı, override yok (premium model zaten) |
| 4 | 3 tema concat + 150 kart | Theme parser: 3 tema → her birine 67 kart (over-prov ile) → 3 ayrı chunk job → birleştir |
| 5 | Tek tema + 50 kart | Over-prov yok, eski akış (1 chunk = 50) |
| 6 | Tek tema + 100 kart | 3 chunk × ~33 = 100 (over-prov 1.33x → ~133 raw) |
| 7 | Tek tema + 150 kart | 4 chunk × 50 = 200 raw (over-prov 1.33x) |
| 8 | Fill loop bitti, hâlâ eksik | Rescue round: 2 paralel call, temp=1.0 |
| 9 | Rescue round da eksik bırakırsa | 422 INSUFFICIENT_CARDS + kısmi kartlar |
| 10 | Multi-tema'da bir tema fail (chunk + fill + rescue tükendi) | O tema kısmi kalır, diğer temalar tam → genel toplama eklenir → eksik varsa 422 |
| 11 | MAX_TOTAL_OPENAI_CALLS limit (15) aşıldı | Loop kırılır, mevcut sayı dönülür |
| 12 | Adaptive hint exhausted (10 attempt geçti) | Generic creative hint kullanılır |

## API Kontratı (geriye dönük uyumlu — sadece stats'e ekleme)

### Request (değişiklik yok)

```json
{
  "prompt": "string (1-2000 char)",
  "cardCount": "1-200",
  "model": "gpt-4o | gpt-4o-mini | gpt-4.1",
  "language": "ISO code"
}
```

### Response — Success (200)

```json
{
  "success": true,
  "data": {
    ...,
    "model": "gpt-4o",                    // override sonrası gerçek model
    "cards": [...],
    "stats": {
      "chunks": 4,
      "fillAttempts": 2,
      "duplicatesRemoved": 56,
      "invalidDropped": 0,
      "totalOpenAICalls": 6,
      "elapsedMs": 38421,
      // YENİ:
      "modelUpgraded": true,              // mini → gpt-4o yapıldıysa
      "themesDetected": 3,                // multi-tema parser sonucu
      "rescueUsed": false,                // rescue round çalıştı mı
      "rescueAddedCards": 0,
      "overProvisionFactor": 1.33,
      "adaptiveHintsUsed": ["less_common", "niche"]
    }
  }
}
```

### Response — Failure (422 — beklenen <%0.5)

```json
{
  "success": false,
  "errorCode": "INSUFFICIENT_CARDS",
  "message": "150 kart üretilemedi (132/150). Tekrar deneyin.",
  "data": { "cards": [...132 cards...], "stats": {...} }
}
```

## Logging (genişletilmiş)

```
[req-X] start | prompt="..." count=150 model=gpt-4o-mini lang=tr
[req-X] model upgraded: gpt-4o-mini → gpt-4o (cardCount=150)
[req-X] themes detected: 3 (sub-cardCount=67 each, over-prov to 89)
[req-X] theme 1/3 chunks: [50, 39] over-prov=1.33
[req-X] theme 1/3 chunk 1/2 → 49/50 cards in 16.5s
...
[req-X] theme 1/3 fill 1 (hint=less_common): +8 cards, total=67/67 ✓
[req-X] theme 2/3 fill 2 (hint=niche): +5 cards
[req-X] theme 2/3 fill 3 (hint=historical): no progress (0/0 new)
[req-X] theme 2/3 fill 4 (hint=modern): +3 cards
[req-X] theme 3/3 done 67/67 ✓
[req-X] global merge: 199 unique → take first 150
[req-X] DONE 150/150 | calls=8 elapsed=42.3s | rescueUsed=false
```

Rescue tetiklendiyse:
```
[req-X] fill exhausted (10 attempts), still missing=12
[req-X] RESCUE round: 2 parallel calls (temp=1.0, batch=15 each)
[req-X] rescue 1 → 14 raw, 9 valid
[req-X] rescue 2 → 14 raw, 11 valid
[req-X] rescue merged: +13 unique cards, total=151/150 ✓
[req-X] DONE 150/150 | calls=14 elapsed=58.1s | rescueUsed=true
```

## Test Stratejisi

Test framework yok, manuel curl + production smoke:

1. **Lokal smoke**: `5 kart` happy → 200 ✓
2. **Lokal tek tema**: `150 kart, gpt-4o` → 200 ✓
3. **Lokal multi-tema (failure case reproduce)**: 3-tema concat 150 kart, gpt-4o-mini gönder → 200 ✓ + log'da `model upgraded` + `themes detected: 3`
4. **Sınır değerler**: cardCount=200 (max), prompt edge cases
5. **Production**: Firebase deploy sonrası aynı 3 senaryo

## Geriye Dönük Uyumluluk

- Response shape **eklemeli** (yeni field'lar `stats` içine eklenir, mevcut field'lar korunur).
- Client'a dokunulmaz; gpt-4o-mini hardcoded'ı server-side handle edilir.
- 422 INSUFFICIENT_CARDS hâlâ var (beklenmedik durumda); olasılığı %0.5'e düşer.

## Kapsam Dışı

- Client `gpt-4o-mini` hardcoded'ını client tarafında değiştirme (server-side override yeterli).
- Client'ta 422 handling iyileştirmesi (kısmi kartları kullanma).
- Streaming response.
- AI ile prompt önişlem (özetleme, kategori çıkarma).
- Otomatik test suite.

## Başarı Ölçütü

- 150 kart isteği başarı oranı: **%99.5+** (3-tema concat dahil).
- Failure case (3-tema 150 kart mini): **0/2 → 2/2 başarılı**.
- Avg `totalOpenAICalls`: **≤ 8**.
- Avg latency: **≤ 50s**.
- Worst case latency: **≤ 90s** (function timeout 300s, içeride kalır).
