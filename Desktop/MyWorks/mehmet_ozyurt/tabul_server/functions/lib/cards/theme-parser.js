// tabul_server/lib/cards/theme-parser.js
// Multi-tema heuristic detection. Prompt'u parçalayıp N tema sayısı çıkarır.
// "TabuL kart" anahtar kelimesi içeren ve uzunluğu yeterli olan satırlar tema sayılır.

const KEYWORD_REGEX = /tabul|kart|card/i;
const MIN_THEME_LEN = 80;

/**
 * Prompt'u tema bloklarına böler. Multi-tema değilse [tek_tema] döner.
 * @param {string} prompt
 * @returns {string[]}
 */
function detectThemes(prompt) {
  const trimmed = String(prompt || '').trim();
  if (!trimmed) return [trimmed];

  // Önce satır bazlı böl, boşları at
  const blocks = trimmed
    .split(/\n+/)
    .map(s => s.trim())
    .filter(s => s.length > 0);

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
 * Örn. 150/3 = [50,50,50]; 100/3 = [34,33,33]; 50/1 = [50]
 * @param {number} cardCount
 * @param {number} themeCount
 * @returns {number[]}
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
