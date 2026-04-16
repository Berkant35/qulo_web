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
