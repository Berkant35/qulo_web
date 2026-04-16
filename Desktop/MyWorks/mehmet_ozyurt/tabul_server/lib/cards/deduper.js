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
