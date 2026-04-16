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
