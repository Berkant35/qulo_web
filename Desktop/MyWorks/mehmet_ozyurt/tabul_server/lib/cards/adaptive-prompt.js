// tabul_server/lib/cards/adaptive-prompt.js
// Fill attempt index → AI'nin yeni kart üretmesini teşvik eden "dimension hint" mapping.
// Her hint, prompt'a eklenecek tek satırlık ek talimat.
// Tekrar eden duplicate'lerden kurtulmak için her attempt'te farklı angle kullanılır.

const HINTS = [
  { id: 'less_common', text: 'Generate less common, less obvious examples within this theme.' },
  { id: 'niche', text: 'Focus on niche or specialized topics within this theme.' },
  { id: 'historical', text: 'Choose historical or classic examples that are still recognizable.' },
  { id: 'modern', text: 'Choose modern or trending examples (recent decades).' },
  { id: 'geographic', text: 'Pick examples from different geographic or cultural contexts.' },
  { id: 'subcategory', text: 'Drill into sub-categories of this theme that have not been used yet.' },
  { id: 'creative', text: 'Be creative; explore unusual or unexpected angles of this theme.' },
];

/**
 * @param {number} attemptIndex 0-based
 * @returns {{id:string, text:string}}
 */
function getHintForAttempt(attemptIndex) {
  if (attemptIndex < HINTS.length) return HINTS[attemptIndex];
  return HINTS[HINTS.length - 1]; // exhausted → fallback to creative
}

module.exports = { getHintForAttempt, HINTS };
