// tabul_server/lib/cards/generator.js
// Strict-count card generation orchestrator (guarantee-grade):
// - Multi-tema parser → her temayı ayrı sub-job, sonra birleştir
// - Over-provisioning (cardCount * 1.33 chunk talep et)
// - Paralel chunk çağrıları + dedup + validate
// - Aggressive fill loop (10 attempt, no-progress 3, küçük batch)
// - Adaptive prompts (her attempt'te yeni dimension hint)
// - Rescue round (2 paralel, temperature=1.0)
// - Sayı garanti edilirse success, edilmezse INSUFFICIENT_CARDS

const config = require('./config');
const { validateCards } = require('./validator');
const { dedupCards } = require('./deduper');
const { buildInitialMessages, buildFillMessages, getLanguageName } = require('./prompt-builder');
const { callOpenAI, OpenAIError } = require('./openai-client');
const { detectThemes, distributeCards } = require('./theme-parser');
const { getHintForAttempt } = require('./adaptive-prompt');

/**
 * cardCount'u CHUNK_SIZE'a göre parçalar.
 * Örn. 200 → [50, 50, 50, 50]; 60 → [50, 10]; 30 → [30]
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
 * Over-provision sayısını hesapla. Yalnız ≥ MIN_COUNT için aktif.
 */
function applyOverProvision(targetCount) {
  if (targetCount < config.OVERPROVISION_MIN_COUNT) return targetCount;
  return Math.ceil(targetCount * config.OVERPROVISION_FACTOR);
}

/**
 * Tek bir tema için kart üretir. Akış:
 *   chunk → birleştir → fill loop (adaptive hints) → rescue round → cap
 *
 * @returns {Promise<{
 *   cards: Array,
 *   themeTitle: string,
 *   stats: {
 *     chunks: number,
 *     fillAttempts: number,
 *     duplicatesRemoved: number,
 *     invalidDropped: number,
 *     invalidByReason: object,
 *     chunkFailures: number,
 *     openAICalls: number,
 *     rescueUsed: boolean,
 *     rescueAddedCards: number,
 *     adaptiveHintsUsed: string[],
 *     overProvisionFactor: number,
 *     fatalError?: { code: string, message: string },
 *   }
 * }>}
 */
async function generateForTheme({
  themePrompt, targetCount, model, language, langName, apiKey, logger, callBudget, themeLabel,
}) {
  const stats = {
    chunks: 0,
    fillAttempts: 0,
    duplicatesRemoved: 0,
    invalidDropped: 0,
    invalidByReason: { empty_word: 0, invalid_forbidden_count: 0 },
    chunkFailures: 0,
    openAICalls: 0,
    rescueUsed: false,
    rescueAddedCards: 0,
    adaptiveHintsUsed: [],
    overProvisionFactor: 1.0,
  };

  // 1) Over-provisioned chunking
  const requestCount = applyOverProvision(targetCount);
  if (requestCount !== targetCount) {
    stats.overProvisionFactor = config.OVERPROVISION_FACTOR;
  }
  const chunkSizes = buildChunkSizes(requestCount);
  stats.chunks = chunkSizes.length;
  logger.info(`${themeLabel} chunks: ${JSON.stringify(chunkSizes)} (target=${targetCount}, requesting=${requestCount}, over-prov=${stats.overProvisionFactor})`);

  // Chunk runner
  async function runChunk(size, idx) {
    const label = `${themeLabel} chunk ${idx + 1}/${chunkSizes.length}`;
    const messages = buildInitialMessages({
      prompt: themePrompt, count: size, langName,
      includeThemeTitle: idx === 0,
    });
    try {
      const t0 = Date.now();
      const { parsed } = await callOpenAI({
        apiKey, model, messages, expectedCount: size, logger, label,
      });
      const elapsedMs = Date.now() - t0;
      const { rawCards, themeTitle } = extractCardsAndTitle(parsed);
      const validation = validateCards(rawCards);
      logger.info(`${label} → ${validation.valid.length}/${size} cards in ${(elapsedMs / 1000).toFixed(1)}s (${validation.totalDropped} dropped)`);
      return { ok: true, valid: validation.valid, themeTitle, dropped: validation.dropped, totalDropped: validation.totalDropped };
    } catch (err) {
      logger.warn(`${label} failed: ${err.code || 'ERR'} | ${err.message}`);
      return { ok: false, error: err };
    }
  }

  let chunkResults;
  if (config.PARALLEL_CHUNKS) {
    chunkResults = await Promise.all(chunkSizes.map((size, i) => {
      stats.openAICalls += 1;
      callBudget.used += 1;
      return runChunk(size, i);
    }));
  } else {
    chunkResults = [];
    for (let i = 0; i < chunkSizes.length; i += 1) {
      stats.openAICalls += 1;
      callBudget.used += 1;
      chunkResults.push(await runChunk(chunkSizes[i], i));
    }
  }

  // 2) Sonuçları topla
  let allValidCards = [];
  let firstThemeTitle = '';
  for (const r of chunkResults) {
    if (!r.ok) {
      stats.chunkFailures += 1;
      if (r.error instanceof OpenAIError && (r.error.code === 'AUTH' || r.error.code === 'QUOTA')) {
        stats.fatalError = { code: r.error.code, message: r.error.message };
        return { cards: [], themeTitle: '', stats };
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

  // 3) Dedup
  let dedupResult = dedupCards(allValidCards);
  let cards = dedupResult.unique;
  stats.duplicatesRemoved += dedupResult.removedCount;
  let knownKeys = dedupResult.allKeys;

  logger.info(`${themeLabel} merge: ${cards.length} unique (${stats.duplicatesRemoved} duplicates removed)`);

  // 4) Fill loop (eksikse)
  let consecutiveZeroProgress = 0;
  while (cards.length < targetCount) {
    if (callBudget.used >= callBudget.max) {
      logger.warn(`${themeLabel} fill aborted: global call budget reached (${callBudget.used}/${callBudget.max})`);
      break;
    }
    if (stats.fillAttempts >= config.MAX_FILL_ATTEMPTS) {
      logger.warn(`${themeLabel} fill aborted: MAX_FILL_ATTEMPTS (${config.MAX_FILL_ATTEMPTS})`);
      break;
    }
    if (consecutiveZeroProgress >= config.NO_PROGRESS_LIMIT) {
      logger.warn(`${themeLabel} fill aborted: ${config.NO_PROGRESS_LIMIT} consecutive zero-progress attempts`);
      break;
    }

    const missing = targetCount - cards.length;
    const requestSize = Math.min(missing, config.FILL_BATCH_SIZE);
    const excludeWords = cards.map(c => c.word);
    const hint = getHintForAttempt(stats.fillAttempts);
    stats.adaptiveHintsUsed.push(hint.id);
    const messages = buildFillMessages({
      prompt: themePrompt, count: requestSize, langName, excludeWords, hint,
    });
    stats.fillAttempts += 1;
    stats.openAICalls += 1;
    callBudget.used += 1;
    const label = `${themeLabel} fill ${stats.fillAttempts}(hint=${hint.id})`;
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
        stats.fatalError = { code: err.code, message: err.message };
        return { cards, themeTitle: firstThemeTitle, stats };
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
      logger.info(`${label} progress=+${progress}, total=${cards.length}/${targetCount}`);
    }

    if (cards.length > targetCount) {
      cards = cards.slice(0, targetCount);
    }
  }

  // 5) Rescue round (hâlâ eksikse, tek seferlik)
  if (config.RESCUE_ENABLED && cards.length < targetCount) {
    const remainingBudget = callBudget.max - callBudget.used;
    if (remainingBudget < config.RESCUE_PARALLEL_CALLS) {
      logger.warn(`${themeLabel} rescue skipped: insufficient call budget (${remainingBudget} < ${config.RESCUE_PARALLEL_CALLS})`);
    } else {
      const missing = targetCount - cards.length;
      logger.info(`${themeLabel} RESCUE: ${config.RESCUE_PARALLEL_CALLS} parallel calls (temp=${config.RESCUE_TEMPERATURE}, missing=${missing})`);

      const excludeWords = cards.map(c => c.word);
      const rescueRequestSize = Math.max(config.FILL_BATCH_SIZE, Math.ceil(missing * 1.5));

      const rescuePromises = [];
      for (let i = 0; i < config.RESCUE_PARALLEL_CALLS; i += 1) {
        const hint = getHintForAttempt(config.MAX_FILL_ATTEMPTS + i); // overflow → creative
        const messages = buildFillMessages({
          prompt: themePrompt, count: rescueRequestSize, langName, excludeWords, hint,
        });
        const label = `${themeLabel} rescue ${i + 1}/${config.RESCUE_PARALLEL_CALLS}`;
        stats.openAICalls += 1;
        callBudget.used += 1;
        rescuePromises.push((async () => {
          try {
            const { parsed } = await callOpenAI({
              apiKey, model, messages, expectedCount: rescueRequestSize, logger, label,
              temperature: config.RESCUE_TEMPERATURE,
            });
            const { rawCards } = extractCardsAndTitle(parsed);
            const validation = validateCards(rawCards);
            for (const reason of Object.keys(validation.dropped)) {
              stats.invalidByReason[reason] = (stats.invalidByReason[reason] || 0) + validation.dropped[reason];
            }
            stats.invalidDropped += validation.totalDropped;
            logger.info(`${label} → ${validation.valid.length} valid (raw=${rawCards.length})`);
            return { ok: true, valid: validation.valid };
          } catch (err) {
            logger.warn(`${label} failed: ${err.code || 'ERR'} | ${err.message}`);
            return { ok: false, error: err };
          }
        })());
      }

      const rescueResults = await Promise.all(rescuePromises);
      stats.rescueUsed = true;
      const rescueValidPool = [];
      for (const r of rescueResults) {
        if (r.ok) rescueValidPool.push(...r.valid);
      }
      const rescueDedup = dedupCards(rescueValidPool, knownKeys);
      const before = cards.length;
      cards = cards.concat(rescueDedup.unique);
      stats.duplicatesRemoved += rescueDedup.removedCount;
      stats.rescueAddedCards = cards.length - before;
      logger.info(`${themeLabel} rescue merged: +${stats.rescueAddedCards} unique cards, total=${cards.length}/${targetCount}`);

      if (cards.length > targetCount) {
        cards = cards.slice(0, targetCount);
      }
    }
  }

  return {
    cards,
    themeTitle: firstThemeTitle,
    stats,
  };
}

/**
 * Ana giriş noktası. Multi-tema → her temayı ayrı sub-job; tek tema → direkt akış.
 */
async function generate({ prompt, cardCount, model, language, apiKey, logger }) {
  const langName = getLanguageName(language);
  const startedAt = Date.now();

  // Multi-tema detection
  const themes = detectThemes(prompt);
  const themeCounts = distributeCards(cardCount, themes.length);
  const isMulti = themes.length >= 2;

  logger.info(`themes detected: ${themes.length}${isMulti ? ` (sub-counts=${JSON.stringify(themeCounts)})` : ''}`);

  // Global call budget (tüm temalar arası ortak)
  const callBudget = { used: 0, max: config.MAX_TOTAL_OPENAI_CALLS };

  const aggregateStats = {
    chunks: 0,
    fillAttempts: 0,
    duplicatesRemoved: 0,
    invalidDropped: 0,
    invalidByReason: { empty_word: 0, invalid_forbidden_count: 0 },
    chunkFailures: 0,
    totalOpenAICalls: 0,
    elapsedMs: 0,
    themesDetected: themes.length,
    rescueUsed: false,
    rescueAddedCards: 0,
    adaptiveHintsUsed: [],
    overProvisionFactor: 1.0,
    modelUpgraded: false, // server.js bunu set eder, biz pas geçeriz
  };

  // Her temayı çalıştır (multi-tema için paralel; tek tema için direkt)
  const themeJobs = themes.map((themePrompt, idx) => generateForTheme({
    themePrompt,
    targetCount: themeCounts[idx],
    model, language, langName, apiKey, logger, callBudget,
    themeLabel: isMulti ? `theme ${idx + 1}/${themes.length}` : 'main',
  }));

  let themeResults;
  if (isMulti) {
    // Multi-tema: SIRALI çalıştır, çünkü hepsi aynı callBudget'i tüketiyor
    // (paralel çalıştırırsak budget hesabı bozulur)
    themeResults = [];
    for (const job of themeJobs) {
      themeResults.push(await job);
    }
  } else {
    themeResults = [await themeJobs[0]];
  }

  // Fatal error kontrolü
  for (const r of themeResults) {
    if (r.stats.fatalError) {
      const fe = r.stats.fatalError;
      aggregateStats.totalOpenAICalls = callBudget.used;
      aggregateStats.elapsedMs = Date.now() - startedAt;
      return {
        success: false,
        errorCode: fe.code === 'AUTH' ? 'OPENAI_AUTH_ERROR' : 'OPENAI_QUOTA',
        message: fe.message,
        data: {
          theme: prompt, themeTitle: '',
          cardCount: 0, requestedCount: cardCount,
          language, languageName: langName, model,
          cards: [], stats: aggregateStats,
        },
      };
    }
  }

  // Birleştir: tüm tema sonuçları → global dedup
  let firstThemeTitle = '';
  let allCards = [];
  for (const r of themeResults) {
    allCards.push(...r.cards);
    if (!firstThemeTitle && r.themeTitle) firstThemeTitle = r.themeTitle;

    aggregateStats.chunks += r.stats.chunks;
    aggregateStats.fillAttempts += r.stats.fillAttempts;
    aggregateStats.duplicatesRemoved += r.stats.duplicatesRemoved;
    aggregateStats.invalidDropped += r.stats.invalidDropped;
    aggregateStats.chunkFailures += r.stats.chunkFailures;
    aggregateStats.adaptiveHintsUsed.push(...r.stats.adaptiveHintsUsed);
    if (r.stats.rescueUsed) aggregateStats.rescueUsed = true;
    aggregateStats.rescueAddedCards += r.stats.rescueAddedCards;
    aggregateStats.overProvisionFactor = Math.max(
      aggregateStats.overProvisionFactor,
      r.stats.overProvisionFactor,
    );
    for (const reason of Object.keys(r.stats.invalidByReason)) {
      aggregateStats.invalidByReason[reason] = (aggregateStats.invalidByReason[reason] || 0) + r.stats.invalidByReason[reason];
    }
  }

  // Global dedup (multi-tema için tema arası duplicate temizliği)
  if (isMulti) {
    const globalDedup = dedupCards(allCards);
    const before = allCards.length;
    allCards = globalDedup.unique;
    const removed = before - allCards.length;
    if (removed > 0) {
      aggregateStats.duplicatesRemoved += removed;
      logger.info(`global merge: ${allCards.length} unique (${removed} cross-theme duplicates removed)`);
    }
  }

  aggregateStats.totalOpenAICalls = callBudget.used;
  aggregateStats.elapsedMs = Date.now() - startedAt;
  const themeTitle = firstThemeTitle || extractThemeTitleFromPrompt(prompt);

  if (allCards.length >= cardCount) {
    const finalCards = allCards.slice(0, cardCount);
    logger.info(`DONE ${finalCards.length}/${cardCount} | calls=${callBudget.used} elapsed=${(aggregateStats.elapsedMs / 1000).toFixed(1)}s | rescueUsed=${aggregateStats.rescueUsed}`);
    return {
      success: true,
      message: 'Kartlar basariyla olusturuldu',
      data: {
        theme: prompt, themeTitle,
        cardCount: finalCards.length, requestedCount: cardCount,
        language, languageName: langName, model,
        cards: finalCards, stats: aggregateStats,
      },
    };
  }

  // Sayı garanti edilmedi (beklenen %0.5)
  logger.error(`INSUFFICIENT ${allCards.length}/${cardCount} | calls=${callBudget.used} elapsed=${(aggregateStats.elapsedMs / 1000).toFixed(1)}s | rescueUsed=${aggregateStats.rescueUsed}`);
  return {
    success: false,
    errorCode: 'INSUFFICIENT_CARDS',
    message: `${cardCount} kart üretilemedi (${allCards.length}/${cardCount}). Tekrar deneyin.`,
    data: {
      theme: prompt, themeTitle,
      cardCount: allCards.length, requestedCount: cardCount,
      language, languageName: langName, model,
      cards: allCards, stats: aggregateStats,
    },
  };
}

module.exports = { generate, buildChunkSizes, applyOverProvision };
