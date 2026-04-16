// tabul_server/lib/cards/config.js
// Kart üretim akışının tüm sabit parametreleri tek noktada.

module.exports = {
  // Strateji
  CHUNK_SIZE: 50,                    // Tek OpenAI çağrısında üretilecek max kart
  PARALLEL_CHUNKS: true,             // Chunk'lar paralel mi sıralı mı çağrılsın
  FILL_BATCH_SIZE: 15,               // Fill attempt başına istenecek max kart (küçük batch = AI uyumu daha iyi)

  // Garanti & guard
  MAX_FILL_ATTEMPTS: 10,             // Eksik kart için max ek istek (agresif)
  MAX_TOTAL_OPENAI_CALLS: 15,        // Bir istek için OpenAI çağrı tavanı (cost guard)
  NO_PROGRESS_LIMIT: 3,              // Ardışık 0 yeni kart sonrası fill loop'u kır

  // Over-provisioning (≥ MIN_COUNT için fazladan iste)
  OVERPROVISION_FACTOR: 1.33,        // 150 kart → 200 raw iste (dedup sonrası ~150 unique)
  OVERPROVISION_MIN_COUNT: 100,      // 100+ kart için aktif

  // Server-side model upgrade (yüksek kart sayılarında zayıf model güçlendirilir)
  MODEL_UPGRADE_MIN_COUNT: 100,
  MODEL_UPGRADE_FROM: ['gpt-4o-mini'],
  MODEL_UPGRADE_TO: 'gpt-4o',

  // Rescue round (fill loop tükendiğinde son şans)
  RESCUE_ENABLED: true,
  RESCUE_PARALLEL_CALLS: 2,          // Paralel rescue çağrı sayısı
  RESCUE_TEMPERATURE: 1.0,           // Yaratıcılık max → daha çeşitli kelimeler

  // Timeout & retry
  OPENAI_TIMEOUT_MS: 90000,          // Chunk başına HTTP timeout
  OPENAI_RETRY_ON_429: 1,            // 429 için retry sayısı
  OPENAI_RETRY_BACKOFF_MS: 2000,     // 429 retry öncesi bekleme
  DEFAULT_TEMPERATURE: 0.8,          // Normal çağrılar için (rescue dışı)

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
