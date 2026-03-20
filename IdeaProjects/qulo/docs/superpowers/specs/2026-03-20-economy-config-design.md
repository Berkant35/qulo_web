# Economy Config System — Design Spec

**Tarih:** 2026-03-20
**Durum:** Draft
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
  changed_by UUID REFERENCES admin_users(id),
  change_reason TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_active_economy_config
  ON economy_config_versions(is_active) WHERE is_active = true;
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
      "chatQuestionDaily": 2
    },
    "plus": {
      "dailyDiscovers": 999999,
      "maxQuestions": 6,
      "dailyUndos": 3,
      "monthlyPurpleBonus": 500,
      "chatQuestionDaily": 5
    },
    "premium": {
      "dailyDiscovers": 999999,
      "maxQuestions": 10,
      "dailyUndos": 999999,
      "monthlyPurpleBonus": 1500,
      "chatQuestionDaily": 999999
    }
  },
  "rewards": {
    "milestones": {
      "25": 5,
      "50": 15,
      "75": 30,
      "100": 50
    },
    "referralPurple": 25
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

  async getActiveConfig(): Promise<EconomyConfig>
  async createVersion(config, changedBy, reason): Promise<EconomyConfigVersion>
  async getHistory(limit): Promise<EconomyConfigVersion[]>
  async getVersion(version): Promise<EconomyConfigVersion>
  async compareVersions(v1, v2): Promise<ConfigDiff>
  invalidateCache(): void
}
```

Tüm mevcut servisler (`exchange.service.ts`, `quiz.service.ts`, `diamond.service.ts`, `daily-stats.service.ts`) hardcoded sabitleri bırakıp `EconomyConfigService.getActiveConfig()` kullanacak.

### Kaldırılacak Hardcoded Sabitler (types/index.ts)

- `GREEN_TO_PURPLE_RATIO`
- `GREEN_DIAMOND_REWARD_RATIO`
- `QUESTION_COUNT_MULTIPLIERS`
- `SUBSCRIPTION_LIMITS`
- `CHAT_QUESTION_LIMITS`

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

Sınır dışı değer tespit edilirse uyarı mesajı gösterilir.

---

## 6. Migration Stratejisi

1. Yeni migration: `economy_config_versions` tablosu oluştur
2. Mevcut hardcoded değerleri version=1 olarak seed et
3. Server'da `EconomyConfigService` oluştur
4. Mevcut servisleri tek tek migrate et (hardcoded → service)
5. Flutter'da provider oluştur, splash'a ekle
6. Flutter'daki hardcoded değerleri tek tek kaldır
7. Admin panel sayfalarını ekle
8. Economy watchdog skill'i yaz

## 7. Kapsam Dışı

- IAP ürün fiyatları (store yönetiyor)
- A/B test / segment bazlı config
- Zamanlanmış config aktivasyonu
- Power fiyatları (zaten `powers` tablosunda, ayrı yönetiliyor)
