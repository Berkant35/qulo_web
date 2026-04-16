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
 * @param {object} params
 * @param {string} params.prompt
 * @param {number} params.count
 * @param {string} params.langName
 * @param {string[]} params.excludeWords Daha önce üretilmiş word listesi
 * @param {{id:string,text:string}=} params.hint Opsiyonel adaptive hint
 */
function buildFillMessages({ prompt, count, langName, excludeWords, hint }) {
  const baseMessages = buildInitialMessages({ prompt, count, langName, includeThemeTitle: false });
  const excludeListStr = excludeWords.length > 0
    ? excludeWords.map(w => `"${w}"`).join(', ')
    : '(none)';

  const hintLine = hint && hint.text
    ? `\n- HINT: ${hint.text}`
    : '';

  // System mesajına ek kural ekle
  baseMessages[0].content += `

ADDITIONAL FILL CONSTRAINT:
- The following ${excludeWords.length} words are ALREADY in the deck. You MUST NOT generate any card whose "word" is in this list (case-insensitive):
${excludeListStr}
- Generate ${count} BRAND-NEW cards that are different from the excluded words. Be creative; choose less obvious but still theme-relevant options.${hintLine}`;

  baseMessages[1].content = `Generate ${count} ADDITIONAL Tabul cards in ${langName} for theme "${prompt}", excluding the listed words. Stay strictly on theme.`;

  return baseMessages;
}

module.exports = { buildInitialMessages, buildFillMessages, getLanguageName, LANGUAGE_NAMES };
