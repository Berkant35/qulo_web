# Economy Config System — Design Spec

**Tarih:** 2026-03-20
**Durum:** Reviewed
**Kapsam:** Hardcoded ekonomi sabitlerini sunucu tarafına taşıma + admin panel + versiyon geçmişi + economy watchdog skill

---

## Problem

Flutter'da 40+ yerde hardcoded ekonomi değeri var (boost maliyeti, reward oranları, abonelik limitleri, milestone ödülleri vb.). Herhangi bir fiyat/oran değişikliği app update gerektiriyor. Bu hem yavaş hem riskli.

## Karar Özeti

| Soru | Karar |
|------|-------|
| Kapsam | Full — taşıma + admin panel + versiyon geçmişi |
| Config yapısı | Tek JSONB bloğu, atomik versiyonlama |
| A/B test | Yok — sadece geçmiş versiyon karşılaştırma |
| Fetch başarısızlığı | Hybrid — cache varsa kullan, yoksa hardcoded fallback |
| Config aktivasyonu | Anında — admin kaydedince aktif |
| IAP ürünleri | Kapsam dışı — store tarafından yönetiliyor |

---

## 1. Veritabanı

### Tablo: `economy_config_versions`

```sql
CREATE TABLE economy_config_versions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  version INT NOT NULL,
  config JSONB NOT NULL,
  is_active BOOLEAN DEFAULT false,
  changed_by UUID REFERENCES admin_users(id) ON DELETE SET NULL,  -- nullable for seed row
  change_reason TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_active_economy_config
  ON economy_config_versions(is_active) WHERE is_active = true;
```

**Versiyon aktivasyonu transaction gerektirir:**

```sql
BEGIN;
  UPDATE economy_config_versions SET is_active = false WHERE is_active = true;
  INSERT INTO economy_config_versions (version, config, is_active, changed_by, change_reason)
  VALUES ($1, $2, true, $3, $4);
COMMIT;
```

### Config JSON Yapısı

```json
{
  "core": {
    "boostCostGreen": 30,
    "boostDurationMinutes": 30,
    "greenDiamondRewardRatio": 0.30,
    "greenToPurpleRatio": 3,
    "questionCountMultipliers": {
      "2": 0.5,
      "3": 0.75,
      "4": 1.0,
      "5": 1.25,
      "6": 1.5
    }
  },
  "subscriptionLimits": {
    "free": {
      "dailyDiscovers": 50,
      "maxQuestions": 4,
      "dailyUndos": 0,
      "monthlyPurpleBonus": 0,
      "chatQuestionDaily": 2,
      "chatQuestionUnmatchRisk": 1,
      "passportMode": false,
      "hasAds": true
    },
    "plus": {
      "dailyDiscovers": 999999,
      "maxQuestions": 6,
      "dailyUndos": 3,
      "monthlyPurpleBonus": 500,
      "chatQuestionDaily": 5,
      "chatQuestionUnmatchRisk": 2,
      "passportMode": false,
      "hasAds": false
    },
    "premium": {
      "dailyDiscovers": 999999,
      "maxQuestions": 10,
      "dailyUndos": 999999,
      "monthlyPurpleBonus": 1500,
      "chatQuestionDaily": 999999,
      "chatQuestionUnmatchRisk": 999999,
      "passportMode": true,
      "hasAds": false
    }
  },
  "rewards": {
    "milestones": {
      "25": 5,
      "50": 15,
      "75": 30,
      "100": 50
    },
    "referralPurple": 25,
    "maxCompletedReferrals": 10
  },
  "timing": {
    "questionTimeSeconds": 30,
    "timeExtendSeconds": 15,
    "timePresets": [15, 30, 60, 90]
  }
}
```

---

## 2. Server API

### Public Endpoint

```
GET /api/v1/app/economy
```

Response:
```json
{
  "version": 3,
  "config": { ... }
}
```

Auth gerektirmez. Aktif config'i (is_active=true) döner.

### EconomyConfigService

```typescript
class EconomyConfigService {
  private cachedConfig: EconomyConfig | null = null;
  private cacheExpiry: number = 0;
  private readonly CACHE_TTL_MS = 5 * 60 * 1000; // 5 dakika TTL

  async getActiveConfig(): Promise<EconomyConfig>
  async createVersion(config, changedBy, reason): Promise<EconomyConfigVersion>
  async getHistory(limit): Promise<EconomyConfigVersion[]>
  async getVersion(version): Promise<EconomyConfigVersion>
  async compareVersions(v1, v2): Promise<ConfigDiff>
  validateConfig(config: EconomyConfig): ValidationResult  // Zod schema ile doğrulama
  invalidateCache(): void
}
```

**Cache stratejisi:** In-memory cache + 5dk TTL. Admin kaydettiğinde anında invalidate. TTL sayesinde tek instance'da bile stale config max 5dk yaşar. Railway tek instance olduğundan Realtime gerekmiyor.

**Config doğrulama:** Zod schema ile hem admin POST'ta hem de seed'de doğrulanır. Watchdog skill'deki sınır değerleriyle aynı kaynaktan beslenir.

Tüm mevcut servisler (`exchange.service.ts`, `quiz.service.ts`, `diamond.service.ts`, `daily-stats.service.ts`, `chat-question.service.ts`) hardcoded sabitleri bırakıp `EconomyConfigService.getActiveConfig()` kullanacak.

### Kaldırılacak Hardcoded Sabitler

**types/index.ts:**
- `GREEN_TO_PURPLE_RATIO`
- `GREEN_DIAMOND_REWARD_RATIO`
- `QUESTION_COUNT_MULTIPLIERS`
- `SUBSCRIPTION_LIMITS`
- `CHAT_QUESTION_LIMITS`

**utils/math.ts:**
- `calculatePowerCost()` ve `calculateGreenReward()` fonksiyonları config parametresi alacak şekilde güncellenir (import yerine parametre injection)

---

## 3. Admin Panel

### Sayfalar

Mevcut admin panel pattern'ini (EJS + Tailwind) takip eder.

**`/admin/economy-config`** — Ana düzenleme formu:
- Section bazlı form (Core, Subscription Limits, Rewards, Timing)
- Her input'ta min/max sınır kontrolü (client + server)
- "Değişiklik Sebebi" zorunlu textarea
- Kaydet → yeni versiyon INSERT, eski versiyon is_active=false, cache invalidate

**`/admin/economy-config/history`** — Versiyon geçmişi:
- Tablo: versiyon no, tarih, değiştiren admin, sebep
- Her satırda "Görüntüle" ve "Karşılaştır" butonları

**`/admin/economy-config/compare?v1=3&v2=5`** — Versiyon karşılaştırma:
- JSON diff, değişen değerler highlight'lı (eski→yeni)

### Admin Routes

```
GET  /admin/economy-config          → Düzenleme sayfası
POST /admin/economy-config          → Yeni versiyon kaydet
GET  /admin/economy-config/history  → Versiyon geçmişi
GET  /admin/economy-config/compare  → Karşılaştırma (?v1=X&v2=Y)
```

---

## 4. Flutter Entegrasyonu

### Yeni Model: `EconomyConfigModel`

```dart
class EconomyConfigModel {
  final int version;
  final EconomyCoreConfig core;
  final Map<String, SubscriptionLimitConfig> subscriptionLimits;
  final RewardsConfig rewards;
  final TimingConfig timing;
}
```

### Yeni Provider: `EconomyConfigNotifier`

Startup akışı (SplashScreen):
1. API çağrısı (`GET /api/v1/app/economy`)
2. Başarılı → state'e yaz + SharedPreferences'a cache'le
3. Başarısız + cache var → cache'ten yükle
4. Başarısız + cache yok → hardcoded fallback (son çare)

Arka planda: API başarısız olduysa retry mekanizması.

### Flutter'da Kaldırılacak Hardcoded Değerler

| Dosya | Ne kalkıyor | Yerine |
|-------|-------------|--------|
| `app_constants.dart` | `boostCostGreen`, `boostDurationMinutes`, `greenDiamondRewardRatio` | `economyConfigProvider` |
| `subscription_model.dart` | Hardcoded free/plus/premium limitleri | `economyConfig.subscriptionLimits` |
| `daily_stats_model.dart` | Fallback 50/0/4 | Economy config fallback |
| `daily_stats_provider.dart` | Hardcoded free tier defaults | Economy config fallback |
| `edit_profile_screen_mixin.dart` | Milestone 5/15/30/50 | `economyConfig.rewards.milestones` |
| `diamonds_screen.dart` | Referral 25 | `economyConfig.rewards.referralPurple` |
| `quiz_screen_mixin.dart` | Fallback cost 20 | Economy config core |
| `convert_section.dart` | Fallback ratio 3 | Economy config core |
| `paywall_bottom_sheet.dart` | Bonus 500/1500 | `subscriptionLimits[tier].monthlyPurpleBonus` |
| `subscription_model.dart` | `SubscriptionInfo` computed getters (dailyDiscoverLimit, maxQuestions vb.) | Economy config'den, çift kaynak ortadan kalkar |
| Localization dosyaları | "25 mor elmas" hardcoded text | Dinamik string interpolation |

---

## 5. Economy Watchdog Skill

### Tetiklenme

- **Manuel:** `/economy` komutu
- **Otomatik:** Hook ile ekonomi dosyalarına dokunulduğunda

### Hook Tanımı

Ekonomi ile ilgili dosyalar değiştirildiğinde tetiklenir:
- `app_constants.dart`
- `types/index.ts`
- `exchange.service.ts`
- `diamond.service.ts`
- `quiz.service.ts`
- `economy` içeren dosyalar

### Mod A — Otomatik Kontrol (dosya tetiklemesi)

1. Değiştirilen dosyada yeni hardcoded ekonomi değeri var mı? → Uyar
2. Sunucu config ile Flutter fallback'ler uyumlu mu? → Drift varsa uyar
3. Yeni sabit economy config'e mi ait? → Taşınması gerekiyorsa söyle

### Mod B — Rapor (`/economy` manuel)

1. Sunucudan aktif economy config'i çek, göster
2. Son 5 versiyon değişikliğini listele
3. Flutter fallback vs sunucu config karşılaştırma tablosu
4. Sağlık skoru: kaç değer senkronize, kaçı drift'te

### Mod C — Güvenlik Kuralları (her zaman aktif)

Sınır tanımları:

| Değer | Min | Max |
|-------|-----|-----|
| `greenDiamondRewardRatio` | 0.10 | 0.50 |
| `boostCostGreen` | 5 | 200 |
| `greenToPurpleRatio` | 1 | 10 |
| `dailyDiscovers` (free) | 10 | 200 |
| `maxQuestions` (free) | 2 | 6 |
| `referralPurple` | 5 | 100 |
| `questionTimeSeconds` | 10 | 120 |
| `timeExtendSeconds` | 5 | 60 |
| `boostDurationMinutes` | 5 | 120 |
| `monthlyPurpleBonus` (plus) | 100 | 2000 |
| `monthlyPurpleBonus` (premium) | 500 | 5000 |
| `chatQuestionDaily` (free) | 1 | 10 |
| `chatQuestionUnmatchRisk` (free) | 1 | 5 |
| `questionCountMultipliers` (her değer) | 0.1 | 3.0 |

Sınır dışı değer tespit edilirse uyarı mesajı gösterilir.

---

## 6. Rollout Stratejisi

### Fazlar

**Faz 1 — Server tarafı (eski client'lar etkilenmez):**
1. Migration: `economy_config_versions` tablosu + v1 seed (mevcut değerlerle)
2. `EconomyConfigService` + Zod validasyon şeması
3. `GET /api/v1/app/economy` endpoint
4. Mevcut servisleri migrate et (hardcoded → service)
5. Admin panel sayfaları

**Faz 2 — Flutter tarafı:**
6. `EconomyConfigModel` + provider + splash entegrasyonu
7. Hardcoded değerleri tek tek kaldır (fallback = v1 değerleri)
8. `SubscriptionInfo` computed getter'ları temizle

**Faz 3 — Watchdog:**
9. Economy skill yazılır
10. Hook'lar settings.json'a eklenir

### Geriye Uyumluluk

- Faz 1 tamamlanana kadar server her iki kaynaktan da okuyabilir (config yoksa mevcut sabitler)
- Faz 2'de Flutter fallback değerleri v1 config ile birebir aynı olmalı — bu garanti eder ki cache boşken davranış değişmez
- Eski app versiyonları economy endpoint'i çağırmaz, server kendi config'ini kullanır — çift taraflı tutarlılık sağlanır

## 7. Kapsam Dışı

- IAP ürün fiyatları (store yönetiyor)
- IAP product-to-amount mapping'leri (store ID'leri statik, değiştiğinde yeni ürün gerekir)
- A/B test / segment bazlı config
- Zamanlanmış config aktivasyonu
- Power fiyatları (zaten `powers` tablosunda, ayrı yönetiliyor)
- `CHAT_QUESTION_POWERS_2` / `CHAT_QUESTION_POWERS_4` (power set tanımları, fiyat değil — gameplay mekaniği)
- `IAP_PRODUCT_MAP` / `SUBSCRIPTION_PRODUCT_MAP` (store ürün ID→miktar eşleşmesi, store tarafından yönetiliyor)
