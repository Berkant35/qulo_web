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
