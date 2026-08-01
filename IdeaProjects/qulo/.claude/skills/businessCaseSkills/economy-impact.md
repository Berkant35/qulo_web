---
name: economy-impact
description: |
  Qulo V2 ekonomi etki analizi. Feature geliştirmeden önce otomatik çalışır.
  Elmas, güç, abonelik, IAP, boost, ödül sistemlerini analiz eder.
  Tetikleyiciler: 'risk analizi', 'economy impact', 'ekonomi etkisi', 'etki analizi',
  yeni feature geliştirme başlangıcı, brainstorming → plan geçişi.
---

# Economy Impact Analysis

Qulo V2 projesinde feature geliştirmeden önce ekonomi etkisini analiz et.

## Akış

1. Feature açıklamasını al (kullanıcıdan veya mevcut context'ten)
2. Dinamik doğrulama yap (güncellik kontrolü)
3. Etki matrisine göre analiz et
4. Risk skoru hesapla
5. Rapor sun veya otomatik devam et
6. Memory'ye logla

## Adım 1: Dinamik Doğrulama

Önce güncelliği kontrol et. Şu dosyaları oku ve skill'deki modelle karşılaştır:

- `qulov2/lib/data/models/economy_config_model.dart` — parametre yapısı
- `qulo-server/src/services/economy-config.service.ts` — server defaults
- `qulov2/lib/data/models/power_model.dart` — güç tipleri

Kontrol: Yeni parametre, yeni güç tipi, yeni tier var mı? Varsa kullanıcıya uyar:

```
⚠️ Economy config'de skill'de tanımlı olmayan parametreler bulundu:
  - [parametre adı] ([dosya:satır])
Skill güncellenmeli. Güncellememi ister misin?
```

Fark yoksa devam et.

## Adım 2: Statik Ekonomi Modeli

### Temel Formüller

```
powerCost       = ceil(baseCost × questionCountMultiplier[questionCount])
greenEarned     = floor(purpleEquivalent × greenDiamondRewardRatio)
purpleFromGreen = greenAmount / greenToPurpleRatio
boostCost       = boostCostGreen
```

### Sabitler

| Sabit | Değer |
|-------|-------|
| greenDiamondRewardRatio | 0.30 |
| greenToPurpleRatio | 3 |
| boostCostGreen | 30 |
| boostDurationMinutes | 30 |
| questionTimeSeconds | 30 |
| timeExtendSeconds | 15 |
| referralPurple | 25 |
| maxCompletedReferrals | 10 |

### Güç Maliyetleri (Base)

| Güç | Green | Purple |
|-----|-------|--------|
| ORACLE | 15 | 5 |
| HALF | 30 | 10 |
| SKIP | 60 | 20 |
| SKIP_ALL | 180 | 60 |
| TIME_EXTEND | 15 | 5 |
| HINT | 24 | 8 |
| POWER_BLOCK | 45 | 15 |
| POWER_UNBLOCK | 45 | 15 |

### Soru Sayısı Çarpanları

| Soru | Çarpan |
|------|--------|
| 2 | 0.50 |
| 3 | 0.75 |
| 4 | 1.00 |
| 5 | 1.25 |
| 6+ | 1.50 |

### Abonelik Tier Limitleri

| Özellik | Free | Plus | Premium |
|---------|------|------|---------|
| Günlük Discover | 50 | ∞ | ∞ |
| Max Soru | 4 | 6 | 10 |
| Günlük Undo | 0 | 3 | ∞ |
| Chat Question/Gün | 2 | 5 | ∞ |
| Unmatch Risk/Gün | 1 | 2 | ∞ |
| Aylık Purple Bonus | 0 | 500 | 1500 |
| Passport | Yok | Yok | Var |
| Reklam | Var | Yok | Yok |

### IAP Ürünleri

qulopurple50 (50), qulopurple150 (150), qulopurple400 (400), qulopurple1000 (1000), qulopurple2500 (2500), qulopurple6000 (6000)

### Milestone Ödülleri

**Profil tamamlama yüzdesi** eşikleri (cevap sayısı DEĞİL) — `user.service.ts` `recalculateProfileCompletion`:

%25 → 5 PD, %50 → 15 PD, %75 → 30 PD, %100 → 50 PD (+ %100'de 24 saat boost)

Toplam 100 PD, kişi başı tek sefer (`users.completion_rewards_claimed` jsonb).

## Adım 3: Etki Matrisi Analizi

Feature açıklamasını şu 8 kategoriyle karşılaştır:

| # | Kategori | Örnek Tetikleyiciler |
|---|----------|---------------------|
| 1 | **Elmas Akışı** | Yeni kazanım kaynağı, ödül değişikliği, harcama noktası |
| 2 | **Güç Sistemi** | Güç ekleme/kaldırma, maliyet ayarı, yeni mekanik |
| 3 | **Abonelik Limitleri** | Limit değişikliği, yeni tier özelliği, bonus ayarı |
| 4 | **IAP / Monetizasyon** | Yeni ürün, fiyat değişikliği, satın alma akışı |
| 5 | **Günlük Limitler** | Discover/undo/chat limit artış/azalış |
| 6 | **Boost / Görünürlük** | Boost mekaniği, maliyet, süre değişikliği |
| 7 | **Ödül Sistemi** | Yeni milestone, referral değişikliği, conversion oranı |
| 8 | **Zamanlama** | Soru süresi, time extend değişikliği |

### Etki Zincirleri

Bir parametreyi değiştirmek zincirleme etki yaratabilir:

- `greenDiamondRewardRatio` → Tüm green kazanım → exchange dengesi → green→purple oranı
- `greenToPurpleRatio` → Exchange → green değeri → power satın alma tercihi
- `questionCountMultiplier` → Power maliyetleri → soru oluşturma teşviki → green kazanım
- `powerCosts.*` → Güç kullanım oranı → green kazanım (SKIP) → monetizasyon
- `subscriptionLimits.*` → Kullanıcı davranışı → churn → upsell potansiyeli
- `monthlyPurpleBonus` → Subscription değeri → IAP cannibalization
- `dailyDiscovers` → Engagement → upsell fırsatı → reklam geliri
- `milestones.*` → Retention → purple enflasyonu
- `referralPurple` → Organik büyüme → purple enflasyonu
- `boostCostGreen` → Green demand → boost kullanım oranı

## Adım 4: Risk Skoru Hesapla

**Skorlama kuralları:**
- Her etkilenen kategori: +1 puan
- Doğrudan monetizasyon etkisi (IAP, subscription): +2 puan
- Birden fazla tier etkileniyorsa: +1 puan
- Enflasyon/deflasyon riski: +2 puan
- Geri alınamaz değişiklik: +1 puan

**Seviyeler:**

| Seviye | Skor | Aksiyon |
|--------|------|---------|
| YOK | 0 | Otomatik devam |
| DÜŞÜK | 1-2 | Bilgi ver, otomatik devam |
| ORTA | 3-4 | Kullanıcı onayı bekle |
| YÜKSEK | 5-7 | Detaylı rapor, onay bekle |
| KRİTİK | 8+ | Plan moduna geç, tam analiz |

## Adım 5: Raporlama

### Etki YOK veya DÜŞÜK ise:

```
Ekonomi Etkisi: [SEVİYE] ([skor])
[Feature adı] — [kısa açıklama]. Devam ediliyor.
```

### Etki ORTA ve üzeri ise:

```
┌─────────────────────────────────────┐
│ EKONOMİ ETKİ ANALİZİ               │
├─────────────────────────────────────┤
│ Feature: [Feature adı]             │
│ Etki Seviyesi: [SEVİYE] ([skor])   │
├─────────────────────────────────────┤
│ Etkilenen Alanlar:                  │
│  • [Kategori] — [açıklama]         │
├─────────────────────────────────────┤
│ Riskler:                            │
│  1. [Risk + matematiksel etki]     │
├─────────────────────────────────────┤
│ Öneriler:                           │
│  1. [Öneri + formül/değer]         │
├─────────────────────────────────────┤
│ Gecmis Pattern:                     │
│  [Memory'den benzer analizler]     │
└─────────────────────────────────────┘

Devam? [Evet / Ayarla / İptal]
```

### Kullanıcı kararına göre:
- **Evet** → Log'a yaz, implementation'a geç
- **Ayarla** → Parametre önerisi al, yeni analiz yap
- **İptal** → Log'a "iptal" yaz, dur

## Adım 6: Memory'ye Logla

Her analiz sonucunu memory'ye kaydet:

**Dosya:** `memory/economy_impact_log.md`

```markdown
## YYYY-MM-DD — [Feature Adı]
- **Etki:** [SEVİYE] ([skor])
- **Alanlar:** [etkilenen kategoriler]
- **Risk:** [risk açıklaması veya "Yok"]
- **Öneri:** [yapılan öneri veya "Yok"]
- **Karar:** [Devam / Ayarlandı / İptal]
```

**Öneri dosyası:** `memory/economy_suggestions.md`
- Analiz sırasında tespit edilen fırsatlar (ör: kullanılmayan güç, dengesiz oran)
- Enflasyon/deflasyon uyarıları
- Tier dengesizlikleri

## Geçmiş Pattern Analizi

Memory'deki `economy_impact_log.md`'yi oku. Aynı kategorideki önceki analizleri bul:
- Benzer feature'larda hangi riskler çıkmış?
- Kullanıcı hangi önerileri kabul/red etmiş?
- Tekrar eden pattern varsa proaktif uyar
