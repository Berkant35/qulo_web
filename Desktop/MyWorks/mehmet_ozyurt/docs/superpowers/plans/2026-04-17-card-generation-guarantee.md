# Card Generation Guarantee Implementation Plan

> **For agentic workers:** Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `tabul_server` `/api/generate-cards` istenen kart sayısını **%99.5+ garanti** ile döndürsün; multi-tema concat ve `gpt-4o-mini` zayıflığı dahil tüm failure case'ler kapsansın.

**Architecture:** 6 bileşen (A-F) önceki strict generator'ın üzerine eklenir: model override, over-provisioning, agresif fill, adaptive prompts, rescue round, multi-tema parser.

**Tech Stack:** Node.js + Express + axios + OpenAI Chat Completions (JSON mode + temperature param).

**Spec:** `docs/superpowers/specs/2026-04-17-card-generation-guarantee-design.md`

---

## File Structure

**Yeni:**
- `tabul_server/lib/cards/theme-parser.js`
- `tabul_server/lib/cards/adaptive-prompt.js`

**Değişen:**
- `tabul_server/lib/cards/config.js` — yeni sabitler
- `tabul_server/lib/cards/prompt-builder.js` — adaptive hint, temperature param
- `tabul_server/lib/cards/openai-client.js` — temperature opsiyonel
- `tabul_server/lib/cards/generator.js` — over-prov, theme split, rescue
- `tabul_server/server.js` — model override
- `tabul_server/functions/index.js` — model override
- `tabul_server/functions/lib/` — yeniden kopyalanır

---

## Task 1: theme-parser.js

**File:** `tabul_server/lib/cards/theme-parser.js` (YENİ)

- [ ] **Step 1: Yaz**

```javascript
// Multi-tema heuristic detection. Prompt'u parçalayıp N tema sayısı çıkarır.
// "TabuL kart" anahtar kelimesi içeren ve uzunluğu yeterli olan satırlar tema sayılır.

const KEYWORD_REGEX = /tabul|kart|card/i;
const MIN_THEME_LEN = 80;

function detectThemes(prompt) {
  const trimmed = String(prompt || '').trim();
  if (!trimmed) return [trimmed];

  // Önce satır bazlı böl, boşları at
  const blocks = trimmed.split(/\n+/).map(s => s.trim()).filter(s => s.length > 0);

  // Her bloğu test et: yeterince uzun mu + anahtar kelime içeriyor mu?
  const themeCandidates = blocks.filter(b =>
    b.length >= MIN_THEME_LEN && KEYWORD_REGEX.test(b)
  );

  // 2+ tema bulunduysa multi-tema; yoksa tek tema
  if (themeCandidates.length >= 2) {
    return themeCandidates;
  }
  return [trimmed];
}

/**
 * cardCount'u N tema arasına paylaştır. Round-robin remainder.
 * Örn. 150/3 = 50,50,50; 100/3 = 34,33,33
 */
function distributeCards(cardCount, themeCount) {
  if (themeCount <= 1) return [cardCount];
  const base = Math.floor(cardCount / themeCount);
  const remainder = cardCount - base * themeCount;
  const result = new Array(themeCount).fill(base);
  for (let i = 0; i < remainder; i += 1) result[i] += 1;
  return result;
}

module.exports = { detectThemes, distributeCards };
```

- [ ] **Step 2: Sanity check**

```bash
cd tabul_server && node -e "
const {detectThemes, distributeCards} = require('./lib/cards/theme-parser');
console.log('single:', detectThemes('Hayvanlar').length);
console.log('multi:', detectThemes('Şehirlerden TabuL kartları oluştur. Ana kelimeler şehir adları olsun. Yasak kelimeler ülke ve nüfus.\nFast food markalarından TabuL kartları oluştur. Ana kelimeler marka adları. Yasak kelimeler logo ve maskot.').length);
console.log('dist 150/3:', distributeCards(150, 3));
console.log('dist 100/3:', distributeCards(100, 3));
console.log('dist 50/1:', distributeCards(50, 1));
"
```

Expected: `single: 1`, `multi: 2`, `dist 150/3: [50,50,50]`, `dist 100/3: [34,33,33]`, `dist 50/1: [50]`

- [ ] **Step 3: Commit**

```bash
git add tabul_server/lib/cards/theme-parser.js && git commit -m "feat(server): add multi-theme prompt parser"
```

---

## Task 2: adaptive-prompt.js

**File:** `tabul_server/lib/cards/adaptive-prompt.js` (YENİ)

- [ ] **Step 1: Yaz**

```javascript
// Fill attempt index → AI'nin yeni kart üretmesini teşvik eden "dimension hint" mapping.
// Her hint, prompt'a eklenecek tek satırlık ek talimat.

const HINTS = [
  { id: 'less_common', text: 'Generate less common, less obvious examples within this theme.' },
  { id: 'niche', text: 'Focus on niche or specialized topics within this theme.' },
  { id: 'historical', text: 'Choose historical or classic examples that are still recognizable.' },
  { id: 'modern', text: 'Choose modern or trending examples (recent decades).' },
  { id: 'geographic', text: 'Pick examples from different geographic or cultural contexts.' },
  { id: 'subcategory', text: 'Drill into sub-categories of this theme that have not been used yet.' },
  { id: 'creative', text: 'Be creative; explore unusual or unexpected angles of this theme.' },
];

function getHintForAttempt(attemptIndex) {
  if (attemptIndex < HINTS.length) return HINTS[attemptIndex];
  return HINTS[HINTS.length - 1]; // exhausted → fallback to creative
}

module.exports = { getHintForAttempt, HINTS };
```

- [ ] **Step 2: Sanity check**

```bash
cd tabul_server && node -e "
const {getHintForAttempt, HINTS} = require('./lib/cards/adaptive-prompt');
console.log('attempt 0:', getHintForAttempt(0).id);
console.log('attempt 3:', getHintForAttempt(3).id);
console.log('attempt 99:', getHintForAttempt(99).id);
console.log('total hints:', HINTS.length);
"
```

Expected: `less_common`, `modern`, `creative`, `7`

- [ ] **Step 3: Commit**

```bash
git add tabul_server/lib/cards/adaptive-prompt.js && git commit -m "feat(server): add adaptive fill prompt hints"
```

---

## Task 3: config.js update

**File:** `tabul_server/lib/cards/config.js` (DEĞİŞTİ)

- [ ] **Step 1: Edit — yeni sabitler ekle, eskileri güncelle**

| Eski | Yeni | Yer |
|---|---|---|
| `MAX_FILL_ATTEMPTS: 5` | `MAX_FILL_ATTEMPTS: 10` | değiştir |
| `MAX_TOTAL_OPENAI_CALLS: 12` | `MAX_TOTAL_OPENAI_CALLS: 15` | değiştir |
| `NO_PROGRESS_LIMIT: 2` | `NO_PROGRESS_LIMIT: 3` | değiştir |
| `FILL_BATCH_SIZE: 30` | `FILL_BATCH_SIZE: 15` | değiştir |
| — | `OVERPROVISION_FACTOR: 1.33` | EKLE |
| — | `OVERPROVISION_MIN_COUNT: 100` | EKLE (≥100 kart için over-prov uygula) |
| — | `MODEL_UPGRADE_MIN_COUNT: 100` | EKLE (≥100 kart için mini → gpt-4o) |
| — | `MODEL_UPGRADE_FROM: ['gpt-4o-mini']` | EKLE |
| — | `MODEL_UPGRADE_TO: 'gpt-4o'` | EKLE |
| — | `RESCUE_ENABLED: true` | EKLE |
| — | `RESCUE_PARALLEL_CALLS: 2` | EKLE |
| — | `RESCUE_TEMPERATURE: 1.0` | EKLE |
| — | `DEFAULT_TEMPERATURE: 0.8` | EKLE (mevcut hardcoded değer) |

- [ ] **Step 2: Commit**

```bash
git add tabul_server/lib/cards/config.js && git commit -m "feat(server): add over-prov/rescue/upgrade config"
```

---

## Task 4: prompt-builder.js update

**File:** `tabul_server/lib/cards/prompt-builder.js` (DEĞİŞTİ)

- [ ] **Step 1: `buildFillMessages` imzasına `hint` (string, opsiyonel) parametresi ekle**

`buildFillMessages({ prompt, count, langName, excludeWords, hint })` — hint varsa system mesajına ek satır olarak konur:

```
ADDITIONAL FILL CONSTRAINT:
- {existing exclude rule}
- HINT: {hint.text}
```

- [ ] **Step 2: Sanity check**

```bash
cd tabul_server && node -e "
const {buildFillMessages} = require('./lib/cards/prompt-builder');
const msgs = buildFillMessages({prompt:'hayvanlar', count:5, langName:'Turkish', excludeWords:['Aslan'], hint:{id:'niche', text:'Focus on niche topics.'}});
console.log(msgs[0].content.substring(msgs[0].content.length - 250));
"
```

Expected: `HINT: Focus on niche topics.` görünür.

- [ ] **Step 3: Commit**

```bash
git add tabul_server/lib/cards/prompt-builder.js && git commit -m "feat(server): add adaptive hint param to fill messages"
```

---

## Task 5: openai-client.js update

**File:** `tabul_server/lib/cards/openai-client.js` (DEĞİŞTİ)

- [ ] **Step 1: `callOpenAI` imzasına `temperature` (number, opsiyonel — default config.DEFAULT_TEMPERATURE) ekle**

axios.post body'sinde `temperature: temperature ?? config.DEFAULT_TEMPERATURE` kullan.

- [ ] **Step 2: Sanity check (yine API key olmadan auth check)**

```bash
cd tabul_server && node -e "
const {callOpenAI} = require('./lib/cards/openai-client');
callOpenAI({apiKey:'',model:'gpt-4o',messages:[],expectedCount:1,label:'t',temperature:1.0}).catch(e=>console.log(e.code));
"
```

Expected: `AUTH`

- [ ] **Step 3: Commit**

```bash
git add tabul_server/lib/cards/openai-client.js && git commit -m "feat(server): add optional temperature param to openai client"
```

---

## Task 6: generator.js refactor

**File:** `tabul_server/lib/cards/generator.js` (DEĞİŞTİ — büyük refactor)

- [ ] **Step 1: Yeniden yaz — major sections:**

1. **`generate()`** ana fonksiyon:
   - Input alır, `themes = detectThemes(prompt)` çağırır
   - `themes.length === 1` → `generateForTheme(themes[0], cardCount, ...)` direkt çağır
   - `themes.length >= 2` → `distributeCards(cardCount, N)` ile sub-counts üret, her temayı `generateForTheme` ile paralel çalıştır, sonuçları birleştir, global dedup, son cap

2. **`generateForTheme(themePrompt, targetCount, model, language, apiKey, logger, statsAccum)`**:
   - Over-provision hesapla: `requestCount = targetCount * OVERPROVISION_FACTOR` (eğer targetCount >= OVERPROVISION_MIN_COUNT)
   - `buildChunkSizes(requestCount)` ile chunk array
   - Paralel chunk çağrıları
   - Birleştir + dedup + validate
   - Eğer `cards.length >= targetCount` → ilk targetCount'i döndür
   - Aksi halde fill loop:
     - attempt 1..MAX_FILL_ATTEMPTS
     - Her attempt'te `getHintForAttempt(attemptIndex)` ile hint
     - `buildFillMessages({hint: ...})` çağır
     - Dedup + ekle
     - No-progress sayacı
   - Hâlâ eksikse rescue round (eğer config.RESCUE_ENABLED):
     - 2 paralel call (Promise.all), `temperature: config.RESCUE_TEMPERATURE`, exclude list ile
     - Sonuçları dedup + ekle
   - Final cap → return

3. **stats objesinde yeni alanlar:**
   - `themesDetected`, `modelUpgraded`, `rescueUsed`, `rescueAddedCards`, `overProvisionFactor`, `adaptiveHintsUsed[]`

- [ ] **Step 2: `buildChunkSizes` zaten var, dokunma. Sadece `generateForTheme` ve outer `generate` rewrite.**

- [ ] **Step 3: Sanity check**

```bash
cd tabul_server && node -e "
const {generate, buildChunkSizes} = require('./lib/cards/generator');
console.log('chunk 200:', buildChunkSizes(200));
console.log('exports OK');
"
```

Expected: `chunk 200: [50,50,50,50]` + `exports OK`.

- [ ] **Step 4: Commit**

```bash
git add tabul_server/lib/cards/generator.js && git commit -m "feat(server): add over-prov + theme split + rescue to generator"
```

---

## Task 7: server.js + functions/index.js — model override

**Files:** `tabul_server/server.js`, `tabul_server/functions/index.js`

- [ ] **Step 1: server.js'te `selectedModel` belirleme bloğundan sonra override ekle**

```javascript
// Server-side model upgrade: yüksek kart sayılarında zayıf model güçlendirilir
let upgradedModel = selectedModel;
let modelUpgraded = false;
if (
  numericCount >= cardsConfig.MODEL_UPGRADE_MIN_COUNT &&
  cardsConfig.MODEL_UPGRADE_FROM.includes(selectedModel)
) {
  upgradedModel = cardsConfig.MODEL_UPGRADE_TO;
  modelUpgraded = true;
  logger.info(`model upgraded: ${selectedModel} → ${upgradedModel} (cardCount=${numericCount})`);
}
```

`cardGenerator.generate()` çağrısına `model: upgradedModel` ver, ayrıca `modelUpgraded` flag'i stats'e dahil et (generator merge eder).

- [ ] **Step 2: functions/index.js'te aynı değişikliği yap**

- [ ] **Step 3: lib/'yi functions/lib/'e tekrar kopyala (yeni theme-parser, adaptive-prompt + güncellenenler)**

```bash
cp -r tabul_server/lib/cards/* tabul_server/functions/lib/cards/
cp tabul_server/lib/logger.js tabul_server/functions/lib/logger.js
```

- [ ] **Step 4: Syntax kontrolü**

```bash
cd tabul_server && node -c server.js && cd functions && node -c index.js
```

Expected: errors yok.

- [ ] **Step 5: Commit**

```bash
git add tabul_server/server.js tabul_server/functions/index.js tabul_server/functions/lib && git commit -m "feat(server): add model upgrade for high card counts + mirror to functions"
```

---

## Task 8: Smoke + failure case stress test

- [ ] **Step 1: Server'ı başlat**

```bash
cd tabul_server && node server.js > /tmp/tabul_server.log 2>&1 &
sleep 2 && curl -s http://localhost:8080/api/health
```

- [ ] **Step 2: Happy 5 kart**

```bash
curl -s -X POST http://localhost:8080/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{"prompt":"hayvanlar","cardCount":5,"model":"gpt-4o-mini","language":"tr"}' \
  | node -e "let s='';process.stdin.on('data',d=>s+=d);process.stdin.on('end',()=>{const j=JSON.parse(s);console.log(j.success, j.data.cardCount,'/',j.data.requestedCount, 'modelUpgraded:', j.data.stats.modelUpgraded, 'themes:', j.data.stats.themesDetected);})"
```

Expected: `true 5 / 5 modelUpgraded: false themes: 1`

- [ ] **Step 3: Tek tema 150 kart**

```bash
curl -s -X POST http://localhost:8080/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{"prompt":"futbol","cardCount":150,"model":"gpt-4o-mini","language":"tr"}' \
  > /tmp/tabul_t1.json
node -e "const j=require('/tmp/tabul_t1.json');console.log(j.success, j.data.cardCount,'/',j.data.requestedCount, 'modelUpgraded:', j.data.stats.modelUpgraded, 'themes:', j.data.stats.themesDetected, 'rescueUsed:', j.data.stats.rescueUsed)"
```

Expected: `true 150 / 150 modelUpgraded: true themes: 1 rescueUsed: false`

- [ ] **Step 4: Failure case reproduce — 3 tema concat 150 kart, mini**

Production'da fail eden tam aynı payload'u gönder:

```bash
curl -s -X POST http://localhost:8080/api/generate-cards \
  -H "Content-Type: application/json" \
  -d $'{"prompt":"Dünyanın en ikonik şehirlerinden TabuL kartları oluştur. Ana kelimeler şehir adları olsun. Yasak kelimeler o şehrin ülkesi, en ünlü yapısı, nüfusu ve kültürel özelliği kapsasın.\\nDünya genelinde bilinen fast food marka ve ürünlerinden TabuL kartları oluştur. Ana kelimeler marka adları veya ünlü menü ürünleri olsun. Yasak kelimeler markanın ülkesi, logosu, maskotu ve en ünlü ürünü kapsasın.\\nEn popüler sosyal medya platformlarından TabuL kartları oluştur. Ana kelimeler platform adları veya özellikleri olsun. Yasak kelimeler platformun kurucusu, logosu, ana özelliği ve kullanıcı kitlesi kapsasın.","cardCount":150,"model":"gpt-4o-mini","language":"tr"}' \
  > /tmp/tabul_t2.json
node -e "const j=require('/tmp/tabul_t2.json');console.log(j.success, j.data.cardCount,'/',j.data.requestedCount, 'modelUpgraded:', j.data.stats.modelUpgraded, 'themes:', j.data.stats.themesDetected, 'rescueUsed:', j.data.stats.rescueUsed)"
```

Expected: `true 150 / 150 modelUpgraded: true themes: 3` (rescue olabilir veya olmayabilir).

- [ ] **Step 5: Server'ı durdur**

```bash
pkill -f "node server.js" 2>/dev/null
```

- [ ] **Step 6: Commit (varsa tweak)**

Eğer Step 4 fail olursa: param tune (config.js → MAX_FILL_ATTEMPTS arttır, batch küçült) → tekrar test → commit.

---

## Task 9: Firebase deploy + production test

- [ ] **Step 1: Deploy**

```bash
cd tabul_server && firebase deploy --only functions
```

- [ ] **Step 2: Production'da Step 8.4'teki failure case'i tekrarla**

```bash
curl -s -X POST https://us-central1-tabulserver.cloudfunctions.net/api/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{"prompt":"<3-tema concat>","cardCount":150,"model":"gpt-4o-mini","language":"tr"}' \
  > /tmp/tabul_prod.json
node -e "const j=require('/tmp/tabul_prod.json');console.log(j.success, j.data.cardCount,'/',j.data.requestedCount)"
```

Expected: `true 150 / 150`

- [ ] **Step 3: Push**

```bash
git push origin APP-1915
```

- [ ] **Step 4: Spec + plan'ı commit'le**

```bash
git add docs/superpowers/specs/2026-04-17* docs/superpowers/plans/2026-04-17* && git commit -m "docs: add card generation guarantee spec and plan"
git push origin APP-1915
```
