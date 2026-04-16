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
