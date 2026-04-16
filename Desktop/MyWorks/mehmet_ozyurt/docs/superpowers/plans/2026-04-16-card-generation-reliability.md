# Card Generation Reliability Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `tabul_server` `/api/generate-cards` endpoint'i istenen kart sayısını strict garantiyle döndürsün; eksik geldiğinde fill loop ile tamamlasın, ulaşılamazsa explicit error dönsün.

**Architecture:** Tek monolitik handler (`server.js:51-186`) modüller halinde `lib/cards/` altına bölünür: `generator.js` (orchestration), `openai-client.js` (API çağrı + retry + timeout), `validator.js` (drop reason'lı validasyon), `deduper.js`, `prompt-builder.js`. Akış: input validate → chunk böl → paralel OpenAI → birleştir + dedup + validate → eksikse fill loop (max 5, no-progress guard) → strict response.

**Tech Stack:** Node.js + Express + axios + OpenAI Chat Completions API. Test framework yok (manuel curl + UI doğrulama). Her chunk için OpenAI native JSON mode (`response_format: { type: "json_object" }`) kullanılır.

**Spec:** `docs/superpowers/specs/2026-04-16-card-generation-reliability-design.md`

---

## File Structure

**Yeni dosyalar:**
- `tabul_server/lib/cards/config.js` — sabitler (CHUNK_SIZE, MAX_FILL_ATTEMPTS, vb.)
- `tabul_server/lib/cards/deduper.js` — dedup helper
- `tabul_server/lib/cards/validator.js` — kart validasyon + drop reason
- `tabul_server/lib/cards/prompt-builder.js` — system/user/fill prompt yapımı
- `tabul_server/lib/cards/openai-client.js` — OpenAI HTTP çağrısı + retry + timeout
- `tabul_server/lib/cards/generator.js` — orchestration (chunk + fill loop)
- `tabul_server/lib/logger.js` — req-id'li yapısal log

**Değiştirilen:**
- `tabul_server/server.js` — `/api/generate-cards` handler ince refactor; allowedModels listesi; default model

---

## Task 1: Konfigürasyon Sabitleri

**Files:**
- Create: `tabul_server/lib/cards/config.js`

- [ ] **Step 1: Config dosyasını yaz**

```javascript
// tabul_server/lib/cards/config.js
// Kart üretim akışının tüm sabit parametreleri tek noktada.

module.exports = {
  // Strateji
  CHUNK_SIZE: 50,                    // Tek OpenAI çağrısında üretilecek max kart
  PARALLEL_CHUNKS: true,             // Chunk'lar paralel mi sıralı mı çağrılsın
  FILL_BATCH_SIZE: 30,               // Fill attempt başına istenecek max kart

  // Garanti & guard
  MAX_FILL_ATTEMPTS: 5,              // Eksik kart için max ek istek
  MAX_TOTAL_OPENAI_CALLS: 12,        // Bir istek için OpenAI çağrı tavanı (cost guard)
  NO_PROGRESS_LIMIT: 2,              // Ardışık 0 yeni kart sonrası fill loop'u kır

  // Timeout & retry
  OPENAI_TIMEOUT_MS: 90000,          // Chunk başına HTTP timeout
  OPENAI_RETRY_ON_429: 1,            // 429 için retry sayısı
  OPENAI_RETRY_BACKOFF_MS: 2000,     // 429 retry öncesi bekleme

  // Input limit
  MAX_PROMPT_LENGTH: 2000,
  MIN_CARD_COUNT: 1,
  MAX_CARD_COUNT: 200,

  // Model
  ALLOWED_MODELS: ['gpt-4o', 'gpt-4o-mini', 'gpt-4.1'],
  DEFAULT_MODEL: 'gpt-4o',

  // Per-card token tahmini (max_tokens hesabı için kart başına yaklaşık)
  TOKENS_PER_CARD: 100,
  MIN_MAX_TOKENS: 1000,
  MAX_MAX_TOKENS: 16000,
};
```

- [ ] **Step 2: Sanity check — modülü yükle**

Run: `cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "console.log(require('./lib/cards/config').DEFAULT_MODEL)"`

Expected: `gpt-4o`

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/config.js
git commit -m "feat(server): add card generation config constants"
```

---

## Task 2: Logger

**Files:**
- Create: `tabul_server/lib/logger.js`

- [ ] **Step 1: Logger'ı yaz**

```javascript
// tabul_server/lib/logger.js
// Request-scoped console logger. Her satır [req-{shortId}] prefix ile gider.
// Production'da Winston/Pino'ya yükseltmek kolay; şimdilik console.log yeterli.

const crypto = require('crypto');

function newReqId() {
  return crypto.randomBytes(4).toString('hex'); // 8-char short id
}

function createLogger(reqId) {
  const prefix = `[req-${reqId}]`;
  return {
    reqId,
    info: (...args) => console.log(prefix, ...args),
    warn: (...args) => console.warn(prefix, ...args),
    error: (...args) => console.error(prefix, ...args),
  };
}

module.exports = { newReqId, createLogger };
```

- [ ] **Step 2: Sanity check**

Run: `cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "const {newReqId, createLogger} = require('./lib/logger'); const log = createLogger(newReqId()); log.info('test', {x: 1});"`

Expected: `[req-XXXXXXXX] test { x: 1 }` (X'ler hex)

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/logger.js
git commit -m "feat(server): add request-scoped logger"
```

---

## Task 3: Deduper

**Files:**
- Create: `tabul_server/lib/cards/deduper.js`

- [ ] **Step 1: Deduper'ı yaz**

```javascript
// tabul_server/lib/cards/deduper.js
// Kart listesini dedup eder. Anahtar: word.toLowerCase().trim().
// Forbidden array içi tekrarları da dedup eder (yan etki: kart objesi mutate).

function dedupKey(word) {
  return String(word || '').toLowerCase().trim();
}

/**
 * Kart listesinden duplicate'leri çıkarır. İlk gelen korunur.
 * @param {Array<{word:string,forbiddenWords:string[]}>} cards
 * @param {Set<string>=} existingKeys Önceden bilinen key'ler (chunk birleştirmede kullanılır)
 * @returns {{ unique: Array, removedCount: number, allKeys: Set<string> }}
 */
function dedupCards(cards, existingKeys) {
  const seen = new Set(existingKeys || []);
  const unique = [];
  let removed = 0;
  for (const card of cards) {
    const key = dedupKey(card.word);
    if (!key) { removed += 1; continue; }
    if (seen.has(key)) { removed += 1; continue; }
    seen.add(key);
    unique.push(card);
  }
  return { unique, removedCount: removed, allKeys: seen };
}

/**
 * Tek kart içindeki forbidden array'inde duplicate ve word ile eşleşen
 * forbidden'ları çıkarır.
 * @returns {{forbiddenWords:string[], droppedDuplicates:number, droppedSelfRef:number}}
 */
function cleanForbidden(word, forbiddenWords) {
  const wordKey = dedupKey(word);
  const seen = new Set();
  const cleaned = [];
  let droppedDuplicates = 0;
  let droppedSelfRef = 0;
  for (const fw of (forbiddenWords || [])) {
    const fwTrimmed = String(fw || '').trim();
    if (!fwTrimmed) { droppedDuplicates += 1; continue; }
    const fwKey = dedupKey(fwTrimmed);
    if (fwKey === wordKey) { droppedSelfRef += 1; continue; }
    if (seen.has(fwKey)) { droppedDuplicates += 1; continue; }
    seen.add(fwKey);
    cleaned.push(fwTrimmed);
  }
  return { forbiddenWords: cleaned, droppedDuplicates, droppedSelfRef };
}

module.exports = { dedupKey, dedupCards, cleanForbidden };
```

- [ ] **Step 2: Sanity check (dedup davranışı)**

Run:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "
const { dedupCards, cleanForbidden } = require('./lib/cards/deduper');
const r = dedupCards([
  { word: 'Aslan', forbiddenWords: ['a','b','c','d','e'] },
  { word: 'aslan', forbiddenWords: ['a','b','c','d','e'] },
  { word: 'Kaplan', forbiddenWords: [] },
  { word: '   ', forbiddenWords: [] },
]);
console.log('unique:', r.unique.length, 'removed:', r.removedCount);
const c = cleanForbidden('Aslan', ['Aslan', 'Hayvan', 'Hayvan', '', 'Vahşi']);
console.log('forbidden:', c.forbiddenWords, 'dups:', c.droppedDuplicates, 'self:', c.droppedSelfRef);
"
```

Expected:
```
unique: 2 removed: 2
forbidden: [ 'Hayvan', 'Vahşi' ] dups: 2 self: 1
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/deduper.js
git commit -m "feat(server): add card deduper with forbidden cleanup"
```

---

## Task 4: Validator

**Files:**
- Create: `tabul_server/lib/cards/validator.js`

- [ ] **Step 1: Validator'ı yaz**

```javascript
// tabul_server/lib/cards/validator.js
// Kart validasyonu + drop reason sayımı.
// Her kart için: word boş mu, forbiddenWords sayısı 5'e tamamlanabiliyor mu?
// 5'ten fazlaysa ilk 5'i alırız (veri kaybı azaltma).

const { cleanForbidden } = require('./deduper');

const REQUIRED_FORBIDDEN_COUNT = 5;

const DROP_REASONS = {
  EMPTY_WORD: 'empty_word',
  INVALID_FORBIDDEN_COUNT: 'invalid_forbidden_count',
};

/**
 * Tek bir AI raw kartını normalize eder. Geçerliyse `card`, değilse `dropReason`.
 * Yan etkiler: forbidden cleanup + (varsa) ilk 5'e kırpma.
 *
 * @param {{word?:string, forbiddenWords?:string[], kelime?:string, yasakliKelimeler?:string[]}} raw
 * @returns {{ ok: true, card: {word:string, forbiddenWords:string[]}, stats: object } |
 *           { ok: false, reason: string, stats: object }}
 */
function validateCard(raw) {
  const word = String(raw.word ?? raw.kelime ?? '').trim();
  if (!word) {
    return { ok: false, reason: DROP_REASONS.EMPTY_WORD, stats: { droppedDuplicates: 0, droppedSelfRef: 0 } };
  }

  const rawForbidden = Array.isArray(raw.forbiddenWords)
    ? raw.forbiddenWords
    : (Array.isArray(raw.yasakliKelimeler) ? raw.yasakliKelimeler : []);

  const cleaned = cleanForbidden(word, rawForbidden);

  // Eğer 5'ten fazlaysa ilk 5'i al (veri kaybı önleme).
  let finalForbidden = cleaned.forbiddenWords;
  if (finalForbidden.length > REQUIRED_FORBIDDEN_COUNT) {
    finalForbidden = finalForbidden.slice(0, REQUIRED_FORBIDDEN_COUNT);
  }

  if (finalForbidden.length !== REQUIRED_FORBIDDEN_COUNT) {
    return {
      ok: false,
      reason: DROP_REASONS.INVALID_FORBIDDEN_COUNT,
      stats: { droppedDuplicates: cleaned.droppedDuplicates, droppedSelfRef: cleaned.droppedSelfRef },
    };
  }

  return {
    ok: true,
    card: { word, forbiddenWords: finalForbidden },
    stats: { droppedDuplicates: cleaned.droppedDuplicates, droppedSelfRef: cleaned.droppedSelfRef },
  };
}

/**
 * Raw kart listesini valide eder. Geçerli kartları + drop sayımlarını döner.
 *
 * @param {Array<object>} rawCards
 * @returns {{ valid: Array, dropped: { [reason: string]: number }, totalDropped: number }}
 */
function validateCards(rawCards) {
  const valid = [];
  const dropped = {
    [DROP_REASONS.EMPTY_WORD]: 0,
    [DROP_REASONS.INVALID_FORBIDDEN_COUNT]: 0,
  };
  for (const raw of rawCards) {
    const result = validateCard(raw);
    if (result.ok) {
      valid.push(result.card);
    } else {
      dropped[result.reason] = (dropped[result.reason] || 0) + 1;
    }
  }
  const totalDropped = Object.values(dropped).reduce((a, b) => a + b, 0);
  return { valid, dropped, totalDropped };
}

module.exports = { validateCards, validateCard, DROP_REASONS };
```

- [ ] **Step 2: Sanity check**

Run:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "
const { validateCards } = require('./lib/cards/validator');
const r = validateCards([
  { word: 'Aslan', forbiddenWords: ['a','b','c','d','e'] },
  { word: '', forbiddenWords: ['a','b','c','d','e'] },
  { word: 'Kaplan', forbiddenWords: ['a','b','c'] },
  { word: 'Tilki', forbiddenWords: ['a','b','c','d','e','f','g'] },
  { word: 'Kurt', forbiddenWords: ['a','b','c','d','Kurt'] },
]);
console.log(JSON.stringify(r, null, 2));
"
```

Expected (özet):
- `valid.length === 2` (Aslan + Tilki[ilk 5])
- `dropped.empty_word === 1`
- `dropped.invalid_forbidden_count === 2` (Kaplan: 3 var; Kurt: self-ref sonrası 4 kalır)

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/validator.js
git commit -m "feat(server): add card validator with drop reasons"
```

---

## Task 5: Prompt Builder

**Files:**
- Create: `tabul_server/lib/cards/prompt-builder.js`

- [ ] **Step 1: Prompt builder'ı yaz**

```javascript
// tabul_server/lib/cards/prompt-builder.js
// AI prompt'larını üretir: ilk chunk + fill (exclude list ile).
// Mesajlar AI tembelliğini engelleyecek katı talimatlarla yazıldı.

const LANGUAGE_NAMES = {
  tr: 'Turkish', en: 'English', de: 'German', fr: 'French',
  es: 'Spanish', it: 'Italian', pt: 'Portuguese', ru: 'Russian',
  ja: 'Japanese', ko: 'Korean', zh: 'Chinese', ar: 'Arabic',
  hi: 'Hindi', nl: 'Dutch', pl: 'Polish', sv: 'Swedish',
  da: 'Danish', fi: 'Finnish', nb: 'Norwegian', cs: 'Czech',
  sk: 'Slovak', hu: 'Hungarian', ro: 'Romanian', bg: 'Bulgarian',
  hr: 'Croatian', sl: 'Slovenian', sr: 'Serbian', lt: 'Lithuanian',
  uk: 'Ukrainian', el: 'Greek', he: 'Hebrew', th: 'Thai',
  vi: 'Vietnamese', id: 'Indonesian', ms: 'Malay',
};

function getLanguageName(code) {
  return LANGUAGE_NAMES[code] || 'Turkish';
}

/**
 * İlk üretim prompt'u (chunk veya tek seferlik).
 * AI'ya: themeTitle + cards array, exact N, no abbreviations.
 */
function buildInitialMessages({ prompt, count, langName, includeThemeTitle = true }) {
  const themeRule = includeThemeTitle
    ? `- "themeTitle" MUST be a creative, personalized short name for the deck (max 10 characters, in ${langName})`
    : '- Do NOT include "themeTitle"; only the "cards" array.';

  const schemaExample = includeThemeTitle
    ? `{"themeTitle": "SHORT_TITLE", "cards": [{"word": "MAIN_WORD", "forbiddenWords": ["forbidden1", "forbidden2", "forbidden3", "forbidden4", "forbidden5"]}]}`
    : `{"cards": [{"word": "MAIN_WORD", "forbiddenWords": ["forbidden1", "forbidden2", "forbidden3", "forbidden4", "forbidden5"]}]}`;

  const system = `You are a Tabul (Taboo) card game card generator. Generate EXACTLY ${count} Tabul cards based on the given theme.

Response MUST be a single JSON object with this exact format:
${schemaExample}

Strict rules:
${themeRule}
- The "cards" array length MUST equal ${count}. No more, no less.
- Each card MUST have exactly 5 forbidden words.
- Forbidden words must be the closest related words to the main word.
- Forbidden words MUST NOT include or equal the main word.
- Forbidden words within a card MUST be unique (no duplicates inside the same card).
- Cards must be relevant to the theme.
- ALL words (themeTitle, main words, forbidden words) MUST be in ${langName} language.
- Do NOT use abbreviations like "etc.", "...", placeholders, comments, or trailing notes.
- Do NOT wrap the response in markdown code blocks.
- Return ONLY the JSON object, no other text or explanation.`;

  const user = `Generate ${count} Tabul cards in ${langName}. Theme: ${prompt}`;

  return [
    { role: 'system', content: system },
    { role: 'user', content: user },
  ];
}

/**
 * Fill prompt'u: exclude list ile ek N kart. themeTitle yok.
 * @param {string[]} excludeWords Daha önce üretilmiş word listesi
 */
function buildFillMessages({ prompt, count, langName, excludeWords }) {
  const baseMessages = buildInitialMessages({ prompt, count, langName, includeThemeTitle: false });
  const excludeListStr = excludeWords.length > 0
    ? excludeWords.map(w => `"${w}"`).join(', ')
    : '(none)';

  // System mesajına ek kural ekle
  baseMessages[0].content += `

ADDITIONAL FILL CONSTRAINT:
- The following ${excludeWords.length} words are ALREADY in the deck. You MUST NOT generate any card whose "word" is in this list (case-insensitive):
${excludeListStr}
- Generate ${count} BRAND-NEW cards that are different from the excluded words. Be creative; choose less obvious but still theme-relevant options.`;

  baseMessages[1].content = `Generate ${count} ADDITIONAL Tabul cards in ${langName} for theme "${prompt}", excluding the listed words. Stay strictly on theme.`;

  return baseMessages;
}

module.exports = { buildInitialMessages, buildFillMessages, getLanguageName, LANGUAGE_NAMES };
```

- [ ] **Step 2: Sanity check**

Run:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "
const { buildInitialMessages, buildFillMessages } = require('./lib/cards/prompt-builder');
const init = buildInitialMessages({ prompt: 'Hayvanlar', count: 50, langName: 'Turkish' });
console.log('--- INITIAL SYSTEM ---');
console.log(init[0].content.substring(0, 200));
const fill = buildFillMessages({ prompt: 'Hayvanlar', count: 5, langName: 'Turkish', excludeWords: ['Aslan','Kaplan'] });
console.log('--- FILL SYSTEM (last 300 chars) ---');
console.log(fill[0].content.substring(fill[0].content.length - 300));
"
```

Expected: Initial system mesajında "EXACTLY 50", "MUST equal 50", "themeTitle"; fill system mesajında "ADDITIONAL FILL CONSTRAINT", "Aslan", "Kaplan" görünür.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/prompt-builder.js
git commit -m "feat(server): add prompt builder with strict rules and fill exclude list"
```

---

## Task 6: OpenAI Client (HTTP + retry + timeout + JSON mode)

**Files:**
- Create: `tabul_server/lib/cards/openai-client.js`

- [ ] **Step 1: OpenAI client'ı yaz**

```javascript
// tabul_server/lib/cards/openai-client.js
// OpenAI Chat Completions çağrısı sarmalayıcısı:
// - response_format: json_object (native JSON mode)
// - axios timeout
// - 429 için config'lenebilir retry + exponential backoff
// - Hata sınıflandırması: AUTH, QUOTA, RATE_LIMIT, TIMEOUT, PARSE, GENERIC

const axios = require('axios');
const config = require('./config');

const OPENAI_URL = 'https://api.openai.com/v1/chat/completions';

class OpenAIError extends Error {
  constructor(code, message, original) {
    super(message);
    this.name = 'OpenAIError';
    this.code = code; // 'AUTH' | 'QUOTA' | 'RATE_LIMIT' | 'TIMEOUT' | 'PARSE' | 'GENERIC'
    this.original = original;
  }
}

function classifyError(err) {
  if (err.code === 'ECONNABORTED' || /timeout/i.test(err.message || '')) {
    return new OpenAIError('TIMEOUT', 'OpenAI request timed out', err);
  }
  const status = err.response?.status;
  const data = err.response?.data;
  if (status === 401) return new OpenAIError('AUTH', 'OpenAI authentication failed', err);
  if (status === 429) {
    const errType = data?.error?.type || '';
    const errCode = data?.error?.code || '';
    if (errType === 'insufficient_quota' || errCode === 'insufficient_quota') {
      return new OpenAIError('QUOTA', 'OpenAI quota exceeded', err);
    }
    return new OpenAIError('RATE_LIMIT', 'OpenAI rate limited', err);
  }
  return new OpenAIError('GENERIC', `OpenAI request failed: ${err.message}`, err);
}

function calcMaxTokens(count) {
  const estimate = count * config.TOKENS_PER_CARD;
  return Math.min(Math.max(estimate, config.MIN_MAX_TOKENS), config.MAX_MAX_TOKENS);
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

/**
 * Tek bir OpenAI çağrısı. Başarısızsa OpenAIError fırlatır.
 * @param {object} params
 * @param {string} params.apiKey
 * @param {string} params.model
 * @param {Array<{role:string,content:string}>} params.messages
 * @param {number} params.expectedCount   max_tokens hesabı için
 * @param {object} params.logger
 * @param {string} params.label           Log'da chunk/fill etiketi
 * @returns {Promise<{ raw: string, parsed: object, elapsedMs: number }>}
 */
async function callOpenAI({ apiKey, model, messages, expectedCount, logger, label }) {
  if (!apiKey) {
    throw new OpenAIError('AUTH', 'OpenAI API key missing');
  }

  const maxTokens = calcMaxTokens(expectedCount);
  const startedAt = Date.now();
  let attempt = 0;
  let lastErr;

  while (attempt <= config.OPENAI_RETRY_ON_429) {
    try {
      const response = await axios.post(
        OPENAI_URL,
        {
          model,
          messages,
          temperature: 0.8,
          max_tokens: maxTokens,
          response_format: { type: 'json_object' },
        },
        {
          headers: {
            Authorization: `Bearer ${apiKey}`,
            'Content-Type': 'application/json',
          },
          timeout: config.OPENAI_TIMEOUT_MS,
        }
      );

      const raw = response.data.choices?.[0]?.message?.content || '';
      let parsed;
      try {
        parsed = JSON.parse(raw);
      } catch (parseErr) {
        throw new OpenAIError('PARSE', `OpenAI response is not valid JSON: ${parseErr.message}`, parseErr);
      }
      const elapsedMs = Date.now() - startedAt;
      return { raw, parsed, elapsedMs };
    } catch (err) {
      lastErr = err instanceof OpenAIError ? err : classifyError(err);

      // Sadece RATE_LIMIT için retry
      if (lastErr.code === 'RATE_LIMIT' && attempt < config.OPENAI_RETRY_ON_429) {
        attempt += 1;
        const backoff = config.OPENAI_RETRY_BACKOFF_MS * attempt;
        logger?.warn(`${label} rate limited, retry ${attempt}/${config.OPENAI_RETRY_ON_429} in ${backoff}ms`);
        await sleep(backoff);
        continue;
      }
      throw lastErr;
    }
  }

  throw lastErr;
}

module.exports = { callOpenAI, OpenAIError, calcMaxTokens };
```

- [ ] **Step 2: Sanity check (api key olmadan, hata sınıfı)**

Run:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "
const { callOpenAI, calcMaxTokens } = require('./lib/cards/openai-client');
console.log('maxTokens(50):', calcMaxTokens(50));
console.log('maxTokens(150):', calcMaxTokens(150));
console.log('maxTokens(5):', calcMaxTokens(5));
callOpenAI({ apiKey: '', model: 'gpt-4o', messages: [], expectedCount: 1, label: 'test' })
  .catch(e => console.log('error code:', e.code, '|', e.message));
"
```

Expected:
```
maxTokens(50): 5000
maxTokens(150): 15000
maxTokens(5): 1000
error code: AUTH | OpenAI API key missing
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/openai-client.js
git commit -m "feat(server): add OpenAI client with JSON mode, timeout, and 429 retry"
```

---

## Task 7: Generator (orchestration + chunk + fill loop)

**Files:**
- Create: `tabul_server/lib/cards/generator.js`

- [ ] **Step 1: Generator'ı yaz**

```javascript
// tabul_server/lib/cards/generator.js
// Strict-count card generation orchestrator:
// - cardCount'a göre chunk array üretir
// - Paralel OpenAI çağrıları (config.PARALLEL_CHUNKS)
// - Her sonucu validate + dedup
// - Eksik kalırsa fill loop (max attempts + no-progress guard + total call guard)
// - Sayı garanti edilirse success, edilmezse INSUFFICIENT_CARDS

const config = require('./config');
const { validateCards } = require('./validator');
const { dedupCards } = require('./deduper');
const { buildInitialMessages, buildFillMessages, getLanguageName } = require('./prompt-builder');
const { callOpenAI, OpenAIError } = require('./openai-client');

/**
 * cardCount'u CHUNK_SIZE'a göre parçalar.
 * Örn. 150 → [50, 50, 50]; 60 → [50, 10]; 30 → [30]
 */
function buildChunkSizes(cardCount) {
  if (cardCount <= config.CHUNK_SIZE) return [cardCount];
  const chunks = [];
  let remaining = cardCount;
  while (remaining > 0) {
    const take = Math.min(remaining, config.CHUNK_SIZE);
    chunks.push(take);
    remaining -= take;
  }
  return chunks;
}

/**
 * Tek chunk'tan kart listesini ve themeTitle'ı çıkarır.
 * AI'nin döndürdüğü JSON formatlarını tolere eder.
 */
function extractCardsAndTitle(parsed) {
  const rawCards = Array.isArray(parsed)
    ? parsed
    : (Array.isArray(parsed?.cards) ? parsed.cards : []);
  const themeTitle = (!Array.isArray(parsed) && typeof parsed?.themeTitle === 'string')
    ? parsed.themeTitle.trim().substring(0, 10)
    : '';
  return { rawCards, themeTitle };
}

function extractThemeTitleFromPrompt(prompt) {
  const firstSentence = String(prompt).split(/[.!?\n]/)[0].trim();
  return firstSentence.length > 10 ? firstSentence.substring(0, 10) : firstSentence;
}

/**
 * Ana giriş noktası. Strict-count generation.
 *
 * @param {object} input
 * @param {string} input.prompt
 * @param {number} input.cardCount
 * @param {string} input.model
 * @param {string} input.language
 * @param {string} input.apiKey
 * @param {object} input.logger
 * @returns {Promise<{
 *   success: boolean,
 *   errorCode?: string,
 *   message?: string,
 *   data: {
 *     theme: string, themeTitle: string,
 *     cardCount: number, requestedCount: number,
 *     language: string, languageName: string, model: string,
 *     cards: Array,
 *     stats: object
 *   }
 * }>}
 */
async function generate({ prompt, cardCount, model, language, apiKey, logger }) {
  const langName = getLanguageName(language);
  const startedAt = Date.now();

  const chunkSizes = buildChunkSizes(cardCount);
  let totalOpenAICalls = 0;
  let firstThemeTitle = '';
  const stats = {
    chunks: chunkSizes.length,
    fillAttempts: 0,
    duplicatesRemoved: 0,
    invalidDropped: 0,
    invalidByReason: { empty_word: 0, invalid_forbidden_count: 0 },
    chunkFailures: 0,
    totalOpenAICalls: 0,
    elapsedMs: 0,
  };

  logger.info(`start | prompt="${prompt.substring(0, 50)}${prompt.length > 50 ? '...' : ''}" count=${cardCount} model=${model} lang=${language}`);

  // 1) Chunk'ları çağır
  async function runChunk(size, idx) {
    const label = `chunk ${idx + 1}/${chunkSizes.length}`;
    const messages = buildInitialMessages({
      prompt, count: size, langName,
      includeThemeTitle: idx === 0, // Sadece ilk chunk themeTitle ister
    });
    try {
      const t0 = Date.now();
      const { parsed } = await callOpenAI({
        apiKey, model, messages, expectedCount: size, logger, label,
      });
      const elapsedMs = Date.now() - t0;
      const { rawCards, themeTitle } = extractCardsAndTitle(parsed);
      const validation = validateCards(rawCards);
      logger.info(`${label} → ${validation.valid.length}/${size} cards in ${(elapsedMs / 1000).toFixed(1)}s (${validation.totalDropped} dropped: ${JSON.stringify(validation.dropped)})`);
      return { ok: true, valid: validation.valid, themeTitle, dropped: validation.dropped, totalDropped: validation.totalDropped };
    } catch (err) {
      logger.warn(`${label} failed: ${err.code || 'ERR'} | ${err.message}`);
      return { ok: false, error: err };
    }
  }

  let chunkResults;
  if (config.PARALLEL_CHUNKS) {
    chunkResults = await Promise.all(chunkSizes.map((size, i) => {
      totalOpenAICalls += 1;
      return runChunk(size, i);
    }));
  } else {
    chunkResults = [];
    for (let i = 0; i < chunkSizes.length; i += 1) {
      totalOpenAICalls += 1;
      chunkResults.push(await runChunk(chunkSizes[i], i));
    }
  }

  // Sonuçları topla
  let allValidCards = [];
  for (const r of chunkResults) {
    if (!r.ok) {
      stats.chunkFailures += 1;
      // Sadece terminal hata türlerinde erken çıkış
      if (r.error instanceof OpenAIError && (r.error.code === 'AUTH' || r.error.code === 'QUOTA')) {
        stats.totalOpenAICalls = totalOpenAICalls;
        stats.elapsedMs = Date.now() - startedAt;
        return {
          success: false,
          errorCode: r.error.code === 'AUTH' ? 'OPENAI_AUTH_ERROR' : 'OPENAI_QUOTA',
          message: r.error.message,
          data: {
            theme: prompt, themeTitle: '', cardCount: 0, requestedCount: cardCount,
            language, languageName: langName, model, cards: [], stats,
          },
        };
      }
      continue;
    }
    allValidCards.push(...r.valid);
    if (!firstThemeTitle && r.themeTitle) firstThemeTitle = r.themeTitle;
    for (const reason of Object.keys(r.dropped)) {
      stats.invalidByReason[reason] = (stats.invalidByReason[reason] || 0) + r.dropped[reason];
    }
    stats.invalidDropped += r.totalDropped;
  }

  // Dedup
  let dedupResult = dedupCards(allValidCards);
  let cards = dedupResult.unique;
  stats.duplicatesRemoved += dedupResult.removedCount;
  let knownKeys = dedupResult.allKeys;

  logger.info(`merge: ${cards.length} unique (${stats.duplicatesRemoved} duplicates removed)`);

  // 2) Fill loop
  let consecutiveZeroProgress = 0;
  while (cards.length < cardCount) {
    if (totalOpenAICalls >= config.MAX_TOTAL_OPENAI_CALLS) {
      logger.warn(`fill aborted: MAX_TOTAL_OPENAI_CALLS (${config.MAX_TOTAL_OPENAI_CALLS}) reached`);
      break;
    }
    if (stats.fillAttempts >= config.MAX_FILL_ATTEMPTS) {
      logger.warn(`fill aborted: MAX_FILL_ATTEMPTS (${config.MAX_FILL_ATTEMPTS}) reached`);
      break;
    }
    if (consecutiveZeroProgress >= config.NO_PROGRESS_LIMIT) {
      logger.warn(`fill aborted: ${config.NO_PROGRESS_LIMIT} consecutive zero-progress attempts`);
      break;
    }

    const missing = cardCount - cards.length;
    const requestSize = Math.min(missing, config.FILL_BATCH_SIZE);
    const excludeWords = cards.map(c => c.word);
    const messages = buildFillMessages({
      prompt, count: requestSize, langName, excludeWords,
    });
    stats.fillAttempts += 1;
    totalOpenAICalls += 1;
    const label = `fill ${stats.fillAttempts}`;
    logger.info(`${label}: requesting ${requestSize} more (excluding ${excludeWords.length} words, missing=${missing})`);

    let newValid;
    try {
      const t0 = Date.now();
      const { parsed } = await callOpenAI({
        apiKey, model, messages, expectedCount: requestSize, logger, label,
      });
      const elapsedMs = Date.now() - t0;
      const { rawCards } = extractCardsAndTitle(parsed);
      const validation = validateCards(rawCards);
      newValid = validation.valid;
      for (const reason of Object.keys(validation.dropped)) {
        stats.invalidByReason[reason] = (stats.invalidByReason[reason] || 0) + validation.dropped[reason];
      }
      stats.invalidDropped += validation.totalDropped;
      logger.info(`${label} returned ${rawCards.length} raw, ${newValid.length} valid in ${(elapsedMs / 1000).toFixed(1)}s`);
    } catch (err) {
      logger.warn(`${label} failed: ${err.code || 'ERR'} | ${err.message}`);
      if (err instanceof OpenAIError && (err.code === 'AUTH' || err.code === 'QUOTA')) {
        stats.totalOpenAICalls = totalOpenAICalls;
        stats.elapsedMs = Date.now() - startedAt;
        return {
          success: false,
          errorCode: err.code === 'AUTH' ? 'OPENAI_AUTH_ERROR' : 'OPENAI_QUOTA',
          message: err.message,
          data: {
            theme: prompt, themeTitle: firstThemeTitle || extractThemeTitleFromPrompt(prompt),
            cardCount: cards.length, requestedCount: cardCount,
            language, languageName: langName, model, cards, stats,
          },
        };
      }
      newValid = [];
    }

    const before = cards.length;
    const dedupNew = dedupCards(newValid, knownKeys);
    cards = cards.concat(dedupNew.unique);
    stats.duplicatesRemoved += dedupNew.removedCount;
    knownKeys = dedupNew.allKeys;
    const progress = cards.length - before;
    if (progress === 0) {
      consecutiveZeroProgress += 1;
      logger.warn(`${label} progress=0 (consecutiveZero=${consecutiveZeroProgress})`);
    } else {
      consecutiveZeroProgress = 0;
      logger.info(`${label} progress=+${progress}, total=${cards.length}/${cardCount}`);
    }

    // Hedefe ulaşıldıysa fazlasını kırp
    if (cards.length > cardCount) {
      cards = cards.slice(0, cardCount);
    }
  }

  // 3) Sonuç
  stats.totalOpenAICalls = totalOpenAICalls;
  stats.elapsedMs = Date.now() - startedAt;
  const themeTitle = firstThemeTitle || extractThemeTitleFromPrompt(prompt);

  if (cards.length >= cardCount) {
    const finalCards = cards.slice(0, cardCount);
    logger.info(`DONE ${finalCards.length}/${cardCount} | calls=${totalOpenAICalls} elapsed=${(stats.elapsedMs / 1000).toFixed(1)}s`);
    return {
      success: true,
      message: 'Kartlar basariyla olusturuldu',
      data: {
        theme: prompt, themeTitle,
        cardCount: finalCards.length, requestedCount: cardCount,
        language, languageName: langName, model, cards: finalCards, stats,
      },
    };
  }

  // Sayı garanti edilmedi
  logger.error(`INSUFFICIENT ${cards.length}/${cardCount} | calls=${totalOpenAICalls} elapsed=${(stats.elapsedMs / 1000).toFixed(1)}s`);
  return {
    success: false,
    errorCode: 'INSUFFICIENT_CARDS',
    message: `${cardCount} kart üretilemedi (${cards.length}/${cardCount}). Tekrar deneyin.`,
    data: {
      theme: prompt, themeTitle,
      cardCount: cards.length, requestedCount: cardCount,
      language, languageName: langName, model, cards, stats,
    },
  };
}

module.exports = { generate, buildChunkSizes };
```

- [ ] **Step 2: Sanity check (chunk math)**

Run:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && node -e "
const { buildChunkSizes } = require('./lib/cards/generator');
console.log('150:', buildChunkSizes(150));
console.log('60:', buildChunkSizes(60));
console.log('30:', buildChunkSizes(30));
console.log('1:', buildChunkSizes(1));
console.log('200:', buildChunkSizes(200));
"
```

Expected:
```
150: [ 50, 50, 50 ]
60: [ 50, 10 ]
30: [ 30 ]
1: [ 1 ]
200: [ 50, 50, 50, 50 ]
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/lib/cards/generator.js
git commit -m "feat(server): add card generator with chunking and fill loop"
```

---

## Task 8: Server Refactor — `/api/generate-cards` handler

**Files:**
- Modify: `tabul_server/server.js` (mevcut handler'ı `lib/cards/generator.js`'i kullanacak şekilde yeniden yaz; allowedModels listesini güncelle; default model'i değiştir; LANGUAGE_NAMES + getMaxTokensForCardCount + extractThemeTitle eski helper'ları kaldır)

- [ ] **Step 1: Eski yardımcıları + import'ları temizle, yenilerini ekle**

Bu adım `server.js`'in başında 7-49 satırlarını yeni hale getirir. Aşağıdaki dönüşümü uygula.

Eski (`server.js:1-49` civarı, **silinecek**):
```javascript
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const axios = require('axios');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Ana sayfa - HTML UI
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Dil kodu -> dil adi eslestirmesi
const LANGUAGE_NAMES = {
  tr: 'Turkish', en: 'English', de: 'German', fr: 'French',
  es: 'Spanish', it: 'Italian', pt: 'Portuguese', ru: 'Russian',
  ja: 'Japanese', ko: 'Korean', zh: 'Chinese', ar: 'Arabic',
  hi: 'Hindi', nl: 'Dutch', pl: 'Polish', sv: 'Swedish',
  da: 'Danish', fi: 'Finnish', nb: 'Norwegian', cs: 'Czech',
  sk: 'Slovak', hu: 'Hungarian', ro: 'Romanian', bg: 'Bulgarian',
  hr: 'Croatian', sl: 'Slovenian', sr: 'Serbian', lt: 'Lithuanian',
  uk: 'Ukrainian', el: 'Greek', he: 'Hebrew', th: 'Thai',
  vi: 'Vietnamese', id: 'Indonesian', ms: 'Malay',
};

function getMaxTokensForCardCount(count) {
  if (count <= 50) return 5000;
  if (count <= 100) return 10000;
  return 16000;
}

// Fallback: AI themeTitle donmezse prompt'un ilk kismindan max 10 karakter
function extractThemeTitle(prompt) {
  const firstSentence = prompt.split(/[.!?\n]/)[0].trim();
  return firstSentence.length > 10
    ? firstSentence.substring(0, 10)
    : firstSentence;
}
```

Yeni (`server.js:1-30` civarı, **yerine konacak**):
```javascript
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const cardsConfig = require('./lib/cards/config');
const cardGenerator = require('./lib/cards/generator');
const { newReqId, createLogger } = require('./lib/logger');

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Ana sayfa - HTML UI
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});
```

(Not: `axios` import'u ve helper'lar kaldırıldı; artık `lib/cards/openai-client.js` içinde.)

- [ ] **Step 2: `/api/generate-cards` handler'ı yeniden yaz**

Eski handler (`server.js:51-186`, **tamamı silinecek** — `app.post('/api/generate-cards'` ile başlayan blok bittiğinde sonraki `app.get('/api/health'`'e kadar olan kısım) yerine aşağıdaki konacak:

```javascript
// Tabul kartlari olusturma endpoint'i (strict-count, chunked, fill-loop)
app.post('/api/generate-cards', async (req, res) => {
  const reqId = newReqId();
  const logger = createLogger(reqId);

  try {
    const {
      prompt,
      cardCount = 50,
      model = cardsConfig.DEFAULT_MODEL,
      language = 'tr',
    } = req.body || {};

    // Input validation
    if (typeof prompt !== 'string' || prompt.trim().length === 0) {
      return res.status(400).json({
        success: false, errorCode: 'MISSING_PROMPT', message: 'Prompt gerekli', reqId,
      });
    }
    if (prompt.length > cardsConfig.MAX_PROMPT_LENGTH) {
      return res.status(400).json({
        success: false, errorCode: 'PROMPT_TOO_LONG',
        message: `Prompt en fazla ${cardsConfig.MAX_PROMPT_LENGTH} karakter olabilir`, reqId,
      });
    }
    const numericCount = Number(cardCount);
    if (!Number.isInteger(numericCount) || numericCount < cardsConfig.MIN_CARD_COUNT || numericCount > cardsConfig.MAX_CARD_COUNT) {
      return res.status(400).json({
        success: false, errorCode: 'INVALID_CARD_COUNT',
        message: `cardCount ${cardsConfig.MIN_CARD_COUNT}-${cardsConfig.MAX_CARD_COUNT} arasinda integer olmali`, reqId,
      });
    }
    const selectedModel = cardsConfig.ALLOWED_MODELS.includes(model) ? model : null;
    if (!selectedModel) {
      return res.status(400).json({
        success: false, errorCode: 'INVALID_MODEL',
        message: `model şunlardan biri olmalı: ${cardsConfig.ALLOWED_MODELS.join(', ')}`, reqId,
      });
    }
    if (!process.env.OPENAI_API_KEY) {
      return res.status(500).json({
        success: false, errorCode: 'OPENAI_AUTH_ERROR', message: 'OpenAI API key tanımlanmamış', reqId,
      });
    }

    // Generate
    const result = await cardGenerator.generate({
      prompt: prompt.trim(),
      cardCount: numericCount,
      model: selectedModel,
      language,
      apiKey: process.env.OPENAI_API_KEY,
      logger,
    });

    const status = result.success
      ? 200
      : (result.errorCode === 'INSUFFICIENT_CARDS' ? 422
        : result.errorCode === 'OPENAI_AUTH_ERROR' ? 500
        : result.errorCode === 'OPENAI_QUOTA' ? 500
        : 500);
    return res.status(status).json({ ...result, reqId });
  } catch (error) {
    logger.error('Unhandled error:', error?.message || error);
    return res.status(500).json({
      success: false, errorCode: 'GENERATION_ERROR',
      message: 'Kartlar oluşturulurken hata oluştu', reqId,
    });
  }
});
```

- [ ] **Step 3: Server'ı başlat ve health check'i doğrula**

Run (foreground'da değil, background'da; sonra durdurursun):
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && (node server.js &) && sleep 2 && curl -s http://localhost:3000/api/health && echo && kill %1 2>/dev/null
```

Expected: `{"status":"OK","apiKeyConfigured":true}` (veya false; önemli olan JSON döner).

> Not: `pkill -f "node server.js"` ile temizleyebilirsin gerekirse.

- [ ] **Step 4: Input validation smoke test (server hâlâ ayakta)**

Server'ı tekrar başlat, sonra:

```bash
# Boş prompt
curl -s -X POST http://localhost:3000/api/generate-cards -H "Content-Type: application/json" -d '{"prompt":"","cardCount":5}' | head -c 200; echo

# cardCount sınır dışı
curl -s -X POST http://localhost:3000/api/generate-cards -H "Content-Type: application/json" -d '{"prompt":"test","cardCount":999}' | head -c 200; echo

# Geçersiz model
curl -s -X POST http://localhost:3000/api/generate-cards -H "Content-Type: application/json" -d '{"prompt":"test","cardCount":5,"model":"gpt-5"}' | head -c 200; echo

# Çok uzun prompt (2001 char)
PAYLOAD=$(node -e "process.stdout.write(JSON.stringify({prompt: 'a'.repeat(2001), cardCount: 5}))")
curl -s -X POST http://localhost:3000/api/generate-cards -H "Content-Type: application/json" -d "$PAYLOAD" | head -c 200; echo
```

Expected (sırayla): `MISSING_PROMPT`, `INVALID_CARD_COUNT`, `INVALID_MODEL`, `PROMPT_TOO_LONG`.

- [ ] **Step 5: End-to-end happy path (gerçek OpenAI çağrısı, küçük sayı)**

Server hâlâ ayaktayken:
```bash
curl -s -X POST http://localhost:3000/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{"prompt":"hayvanlar","cardCount":5,"model":"gpt-4o-mini","language":"tr"}' \
  | node -e "
let s='';process.stdin.on('data',d=>s+=d);process.stdin.on('end',()=>{
  const j = JSON.parse(s);
  console.log('success:', j.success, 'errorCode:', j.errorCode);
  console.log('cardCount:', j.data?.cardCount, '/', j.data?.requestedCount);
  console.log('stats:', JSON.stringify(j.data?.stats));
  console.log('first card:', JSON.stringify(j.data?.cards?.[0]));
});"
```

Expected:
- `success: true errorCode: undefined`
- `cardCount: 5 / 5`
- `stats` görünür (chunks=1, fillAttempts=0, totalOpenAICalls=1)
- İlk kartta `word` ve 5 elemanlı `forbiddenWords` (Türkçe)

- [ ] **Step 6: Server'ı durdur**

```bash
pkill -f "node server.js" 2>/dev/null; sleep 1
```

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add tabul_server/server.js
git commit -m "feat(server): rewire /api/generate-cards to chunked strict generator"
```

---

## Task 9: Stress Test — 150 kart end-to-end doğrulaması

Bu task implementasyon değil, ana hedefin (strict 150) tutmasını kanıtlama. Hata bulursan task 7-8'e geri dön.

- [ ] **Step 1: Server'ı başlat**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/tabul_server && (node server.js > /tmp/tabul_server.log 2>&1 &) && sleep 2
```

- [ ] **Step 2: 150 kart isteği (gpt-4o, default)**

```bash
curl -s -X POST http://localhost:3000/api/generate-cards \
  -H "Content-Type: application/json" \
  -d '{"prompt":"futbol","cardCount":150,"language":"tr"}' \
  | node -e "
let s='';process.stdin.on('data',d=>s+=d);process.stdin.on('end',()=>{
  const j = JSON.parse(s);
  console.log('success:', j.success);
  console.log('errorCode:', j.errorCode || '-');
  console.log('cardCount:', j.data?.cardCount, '/', j.data?.requestedCount);
  console.log('stats:', JSON.stringify(j.data?.stats, null, 2));
  // Validate her kartın forbiddenWords.length === 5
  const bad = (j.data?.cards || []).filter(c => !c.word || (c.forbiddenWords || []).length !== 5);
  console.log('bad cards:', bad.length);
});"
```

Expected:
- `success: true` veya (kabul edilebilir olarak) `errorCode: INSUFFICIENT_CARDS` ile yakın sayı
- `cardCount: 150 / 150` (en iyi durum) veya en az 130/150
- `bad cards: 0`
- `stats.fillAttempts ≤ 5`, `totalOpenAICalls ≤ 12`

Eğer success=false dönüyorsa → log'a bak: `cat /tmp/tabul_server.log | tail -50`. Eğer fill loop garanti tutmuyorsa: prompt sıkılaştır veya MAX_FILL_ATTEMPTS artır (config.js).

- [ ] **Step 3: Log kontrolü**

```bash
cat /tmp/tabul_server.log | grep "req-" | tail -30
```

Expected: `start`, her chunk için bir satır, `merge`, varsa `fill N`, `DONE` satırı görünür.

- [ ] **Step 4: Server'ı durdur**

```bash
pkill -f "node server.js" 2>/dev/null; sleep 1
```

- [ ] **Step 5: (sadece deviation varsa) Plan'a notlar ekle**

Eğer 150/150 garanti tutmadıysa: `docs/superpowers/plans/2026-04-16-card-generation-reliability.md`'ye `## Findings` bölümü ekle, gözlenen davranışı not et.

- [ ] **Step 6: Commit (varsa değişiklikler)**

Eğer config.js'de tweak yaptıysan veya plan'a not eklediysen:
```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt
git add -A
git commit -m "test(server): stress test 150-card generation, tune fill loop params"
```

Aksi halde bu task'i sadece checked olarak işaretle.

---

## Self-Review Notları (planı yazana not)

**Spec coverage:**
- ✅ Strict garanti → Task 7 (fill loop + final cards.length kontrolü)
- ✅ Chunking → Task 7 (`buildChunkSizes`, paralel `Promise.all`)
- ✅ Fill loop + no-progress + total call guard → Task 7
- ✅ Forbidden cleanup (self-ref, dup) → Task 3-4
- ✅ Forbidden 5'ten fazlaysa slice → Task 4
- ✅ Boş word filtreleme → Task 4
- ✅ JSON mode → Task 6 (`response_format`)
- ✅ Timeout (90s) → Task 6
- ✅ 429 retry + backoff → Task 6
- ✅ AUTH/QUOTA tespiti → Task 6
- ✅ Model whitelist + default değişikliği → Task 1, Task 8
- ✅ Input validation (prompt, count, model) → Task 8
- ✅ Logger + req-id → Task 2
- ✅ Stats response field → Task 7
- ✅ INSUFFICIENT_CARDS error + kısmi cards → Task 7
- ✅ Smoke + stress test → Task 8-9

**Placeholder scan:** Yok.

**Type/method consistency:** `cardGenerator.generate()`, `validateCards()`, `dedupCards()`, `buildInitialMessages()`, `buildFillMessages()`, `callOpenAI()`, `OpenAIError.code` — hepsi tutarlı.

**Bilinen riskler:**
- Test framework yok → manuel test üzerinden gidiyoruz. İleri iterasyonda Vitest eklenmeli.
- Stress test'te (Task 9) gerçek OpenAI çağrısı yapılır → cost ~$0.05-0.20 arası bir istek (gpt-4o). Quota olmazsa Task 9 skip edilir.
- gpt-4.1 modelinin OpenAI'da hesabınızda mevcut olup olmadığı doğrulanmalı; yoksa allowedModels'tan kaldırılır (Task 1).
