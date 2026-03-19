# Chat Question System v2 — Design Spec

## Overview

Chat'teki soru sisteminin tamamen yeniden tasarlanması. Soru oluşturma ücretsiz hale gelecek, cevaplama sırasında power kullanımıyla mor elmas ekonomisi devreye girecek. Discover quiz'deki power/diamond mantıkları chat sorularında da geçerli olacak (kod tekrarı olmadan). Ödül medya (fotoğraf/ses), güç engeli mekanizması, taslak sistemi ve chat kilidi gibi yeni mekanikler eklenecek.

## Mevcut Durum

- Soru oluşturma: 5💜 (normal) veya 15💜 (unmatch riskli) — **kaldırılacak**
- 2 şıklı (A/B) sorular — **2 veya 4 şıklı olacak**
- Doğru cevapta soru sahibine %50 yeşil ödül — **%30 olacak, sadece power kullanıldığında**
- `create_question_sheet.dart` bottom sheet — **full screen stepper sayfaya dönüşecek**
- Power kullanımı yok — **discover quiz power sistemi entegre edilecek**

## Soru Oluşturma

### Full Screen + Stepper

Mevcut bottom sheet kaldırılacak. Yeni full screen sayfa stepper ile çalışacak. Bu sayfa mevcut profil soru oluşturma ekranından **ayrı** olacak — kendi logic'i, kendi dosyaları.

**Adım 1 — Soru İçeriği:**
- Şık sayısı seçimi: 2 veya 4 (toggle/segment)
- Soru metni (min 3, max 200 karakter)
- Şıklar (2 şık: A/B, 4 şık: A/B/C/D — her biri max 100 karakter)
- Doğru cevap işaretleme (radio)
- Tüm şıklar soru sahibi tarafından yazılır, AI desteği yok

**Adım 2 — Ayarlar:**
- **Süre seçimi:** Hızlı seçim chip'leri (15s / 30s / 45s / 60s / 90s)
- **İpucu metni:** Opsiyonel text field (cevaplayıcı HINT power'ı kullandığında gösterilir)
- **Ödül medya:** Opsiyonel fotoğraf veya ses ekleme (doğru cevapta açılır)
- **Unmatch checkbox:** "Yanlış cevap verirse eşleşme biter"
- **Chat kilidi toggle:** "Cevap beklerken sohbet kitlensin" — aktifse soru cevaplanana kadar iki taraf da mesaj atamaz
- **Güç Engeli (Power X):** Envanterden varsa kullan, yoksa anında satın al (maliyet server config'den). Aktifse cevaplayıcının tüm power'ları engellenir

### Maliyet

Soru oluşturma **ücretsiz**. Mevcut 5💜/15💜 diamond harcama kaldırılacak. `chat-question.service.ts` içindeki `spendPurple()` çağrısı silinecek.

### Taslak Sistemi

- **Manuel kaydet:** "Taslak olarak kaydet" butonu — göndermeden kaydeder
- **Geçmiş:** Gönderilmiş sorular listesi — tekrar kullanılabilir (başka match'e gönder)
- Taslak/geçmiş seçildiğinde soru metni + şıklar + doğru cevap + ayarlar kopyalanır, ödül medya hariç
- DB: `chat_question_drafts` tablosu (user_id, question_text, options, correct_option, option_count, time_limit, hint, has_unmatch_risk, has_chat_lock)

### Günlük Limitler

Subscription tier'a göre (server config'den yönetilir):

| Tier | Günlük limit/match | Unmatch riskli limit |
|------|-------------------|---------------------|
| Free | server config | server config |
| Plus | server config | server config |
| Premium | server config | server config |

Sayılar implementasyonda belirlenecek, `app_config` veya sabit config'den okunacak.

## Cevaplama Akışı

### Chat'te Görünüm

Soru chat'te özel bir kart olarak görünür:
- Soru metni
- Ödül medya varsa: **bulanık preview** (fotoğraf bulanık, ses kilitli ikon)
- "Aç" butonu (cevaplayıcı için)
- Soru sahibi için: "Cevap bekleniyor..." durumu
- Chat kilidi aktifse: input bar devre dışı + bilgi mesajı

### Soru Açma

Cevaplayıcı "Aç" butonuna basar → tam ekran soru çözme UI açılır:
- Süre geri sayımı başlar
- Şıklar gösterilir (2 veya 4)
- Power bar gösterilir (kullanılabilir güçler)
- Güç engeli (Power X) aktifse: power bar kilitli + "Güçler engellenmiş" bildirimi + Power Y butonu

### Power Sistemi

**2 şıklı sorularda:**
| Power | Etki |
|-------|------|
| ORACLE (Kahin) | Doğru cevabı %70 doğrulukla önerir |
| SKIP | Soruyu atlar, doğru sayılır |

**4 şıklı sorularda:**
| Power | Etki |
|-------|------|
| ORACLE (Kahin) | Doğru cevabı %70 doğrulukla önerir |
| SKIP | Soruyu atlar, doğru sayılır |
| HALF | 2 yanlış şıkkı eler |
| HINT (İpucu) | Soru sahibinin yazdığı ipucunu gösterir |
| TIME_EXTEND | Süreye 15 saniye ekler |

Power maliyetleri mevcut `powers` tablosundaki `base_cost` değerlerinden gelir. Chat soruları tek soru olduğundan multiplier `QUESTION_COUNT_MULTIPLIERS[1]` uygulanır (veya chat sorularına özel sabit — server config).

### Güç Engeli Mekanizması

**Power X (soru sahibinin gücü):**
- Soru oluştururken aktif edilir
- Maliyet: server config'den (örn. 40💜)
- Envanterden varsa kullanılır, yoksa anında satın alınır
- Etki: cevaplayıcının tüm power'larını engeller

**Power Y (cevaplayıcının anti-gücü):**
- Cevaplayıcı güç engelini kaldırmak isterse kullanır
- Maliyet: server config'den (örn. 50💜)
- Etki: engeli kaldırır, normal güçler açılır
- Ödül: soru sahibine yüksek miktarda yeşil elmas (server config'den, örn. 140💚)
- Envanterden varsa kullanılır, yoksa anında satın alınır

### Süre Bitimi

Süre dolduğunda discover quiz'deki kurtarma ekranı mantığı:
- SKIP gücüyle kurtarabilir (mor elmas)
- Power X aktifse → önce Power Y ile engeli kaldır (50💜) → sonra SKIP kullan → çift maliyet
- Kurtarmazsa → yanlış cevap sayılır
- Unmatch aktifse → unmatch tetiklenir

### Sonuç Ekranı

**Doğru cevap:**
- "Tebrikler" feedback
- Ödül medya varsa: bulanık → netleşme animasyonu (reveal)
- Power kullanıldıysa: soru sahibine %30 yeşil elmas ödülü (`Math.floor`)

**Yanlış cevap:**
- "Yanlış" feedback
- Ödül medya varsa: kilitli kalır ("Ödülü göremezsin")
- Unmatch aktifse: unmatch bildirimi
- Power kullanıldıysa: soru sahibine %30 yeşil elmas yine verilir (power harcandı)

## Ekonomi

### Temel Kurallar

- Soru oluşturma: **ücretsiz**
- Normal cevaplama: **ücretsiz**
- Power kullanımı: **mor elmas** (discover quiz ile aynı ekonomi)
- Yeşil elmas ödülü: power harcanan mor elmasın **%30**'u (`Math.floor` aşağı yuvarlama)
- Oran server config'den: `GREEN_DIAMOND_REWARD_RATIO = 0.3` (mevcut sabit yeniden kullanılır)
- Power X/Y maliyetleri ve ödülleri: server config'den yönetilir

### Kod Tekrarı Önleme

Mevcut servisler yeniden kullanılacak:
- `diamondService.spendPurple()` — power satın alma
- `diamondService.earnGreen()` — yeşil ödül
- `exchangeService.tryUseInventory()` — envanterden power kullanma
- `calculatePowerCost()` — maliyet hesaplama (utils/math.ts)
- `calculateGreenReward()` — yeşil ödül hesaplama (utils/math.ts)

Chat question service, quiz service'deki power handling logic'ini doğrudan çağıracak veya shared bir fonksiyon olarak extract edilecek — **kopyalanmayacak**.

### Power X / Power Y Ekonomisi

| Aksiyon | Harcayan | Maliyet | Kazanan | Ödül |
|---------|----------|---------|---------|------|
| Power X aktif et | Soru sahibi | config💜 (örn. 40) | — | — |
| Power Y kullan | Cevaplayıcı | config💜 (örn. 50) | Soru sahibi | config💚 (örn. 140) |
| Normal power kullan | Cevaplayıcı | power base_cost💜 | Soru sahibi | %30 yeşil |

## Chat Kilidi

- Soru sahibi opsiyonel olarak aktif eder
- Aktifse: soru cevaplanana kadar iki taraf da mesaj atamaz
- Chat input bar devre dışı + bilgi mesajı gösterilir
- Soru cevaplanınca kilit otomatik kalkar
- Backend: `sendMessage()` içinde aktif kilidi olan cevaplanmamış soru kontrolü

## Ödül Medya

- Soru sahibi opsiyonel olarak fotoğraf veya ses ekler
- Chat'te soru kartında: **bulanık preview** (fotoğraf gaussian blur, ses kilitli ikon)
- Doğru cevapta: netleşme animasyonu (reveal)
- Yanlış cevapta: kilitli kalır
- Upload: server üzerinden (`POST /chat/:matchId/upload` — mevcut endpoint)
- DB: `chat_questions` tablosuna `reward_media_url` ve `reward_media_type` ('image' | 'audio') kolonları

## Veritabanı Değişiklikleri

### chat_questions tablosu — yeni kolonlar:
```
option_count INTEGER DEFAULT 2           -- 2 veya 4
option_c TEXT                             -- 4 şıklı için (nullable)
option_d TEXT                             -- 4 şıklı için (nullable)
time_limit_seconds INTEGER DEFAULT 30    -- Süre (15/30/45/60/90)
hint_text TEXT                            -- İpucu (nullable)
reward_media_url TEXT                     -- Ödül medya URL (nullable)
reward_media_type TEXT                    -- 'image' | 'audio' (nullable)
has_chat_lock BOOLEAN DEFAULT false       -- Chat kilidi
has_power_block BOOLEAN DEFAULT false     -- Power X aktif mi
power_block_removed BOOLEAN DEFAULT false -- Power Y kullanıldı mı
powers_used JSONB DEFAULT '[]'           -- Kullanılan güçler [{name, cost, green_reward}]
```

### Yeni tablo: chat_question_drafts
```
id UUID PRIMARY KEY
user_id UUID REFERENCES users(id)
question_text TEXT
option_count INTEGER
option_a TEXT
option_b TEXT
option_c TEXT                             -- nullable
option_d TEXT                             -- nullable
correct_option TEXT                       -- 'A'|'B'|'C'|'D'
time_limit_seconds INTEGER
hint_text TEXT                            -- nullable
has_unmatch_risk BOOLEAN DEFAULT false
has_chat_lock BOOLEAN DEFAULT false
created_at TIMESTAMPTZ
updated_at TIMESTAMPTZ
```

### powers tablosu — yeni kayıtlar:
```
INSERT: POWER_BLOCK (Power X) — base_cost, green_cost, purple_cost
INSERT: POWER_UNBLOCK (Power Y) — base_cost, green_cost, purple_cost, special_green_reward
```

## API Değişiklikleri

### Mevcut endpoint'ler (güncelleme):

**POST /chat/:matchId/questions** — Soru oluşturma
```json
{
  "question_text": "string",
  "option_count": 2 | 4,
  "option_a": "string",
  "option_b": "string",
  "option_c": "string?",
  "option_d": "string?",
  "correct_option": "A" | "B" | "C" | "D",
  "time_limit_seconds": 15 | 30 | 45 | 60 | 90,
  "hint_text": "string?",
  "reward_media_url": "string?",
  "reward_media_type": "image" | "audio" | null,
  "has_unmatch_risk": false,
  "has_chat_lock": false,
  "use_power_block": false
}
```

**POST /chat/questions/:id/answer** — Soru cevaplama (güncelleme)
```json
{
  "selected_option": "A" | "B" | "C" | "D",
  "power_used": "ORACLE" | "SKIP" | "HALF" | "HINT" | "TIME_EXTEND" | null,
  "time_spent": 15
}
```

**Response (güncelleme):**
```json
{
  "question": { ... },
  "is_correct": true,
  "unmatched": false,
  "reward_media_url": "string?",
  "power_result": {
    "suggested_answer_index": "B",
    "removed_indices": ["C", "D"],
    "hint_text": "...",
    "extra_seconds": 15
  }
}
```

### Yeni endpoint'ler:

**POST /chat/questions/:id/use-power** — Power kullanma (cevaplamadan önce)
```json
{ "power_name": "ORACLE" | "HALF" | "HINT" | "TIME_EXTEND" | "POWER_UNBLOCK" }
```

**POST /chat/questions/:id/timeout** — Süre bitimi bildirimi
```json
{}
```
Response: kurtarma seçenekleri (SKIP mevcut mu, Power X aktif mi)

**GET /chat/questions/drafts** — Taslak listesi
**POST /chat/questions/drafts** — Taslak kaydet
**DELETE /chat/questions/drafts/:id** — Taslak sil

**GET /chat/questions/history** — Gönderilmiş soru geçmişi

## Flutter Dosya Yapısı

### Yeni dosyalar:
```
lib/features/chat/screens/create_chat_question_screen.dart  -- Full screen stepper
lib/features/chat/widgets/chat_question_step1.dart           -- Soru içeriği adımı
lib/features/chat/widgets/chat_question_step2.dart           -- Ayarlar adımı
lib/features/chat/widgets/chat_question_solve_screen.dart    -- Cevaplama tam ekranı
lib/features/chat/widgets/chat_question_result.dart          -- Sonuç ekranı
lib/features/chat/widgets/chat_question_rescue.dart          -- Kurtarma ekranı
lib/features/chat/widgets/reward_media_reveal.dart           -- Ödül medya reveal animasyonu
lib/features/chat/widgets/blurred_media_preview.dart         -- Bulanık medya önizleme
lib/features/chat/sheets/draft_history_sheet.dart            -- Taslak/geçmiş seçimi
lib/data/models/chat_question_draft_model.dart               -- Taslak modeli
```

### Değişecek mevcut dosyalar:
```
lib/features/chat/sheets/create_question_sheet.dart          -- Kaldırılacak (full screen'e taşınıyor)
lib/features/chat/widgets/chat_question_card.dart            -- 4 şık desteği, bulanık medya, kilit UI
lib/features/chat/widgets/chat_question_message.dart         -- Power + süre entegrasyonu
lib/features/chat/mixins/chat_screen_mixin.dart              -- Chat kilidi kontrolü
lib/providers/chat_provider.dart                              -- Taslak/geçmiş, kilit state
lib/core/network/services/chat_service.dart                  -- Yeni endpoint'ler
lib/data/repositories/chat_repository.dart                   -- Yeni metotlar
```

### Server değişecek dosyalar:
```
qulo-server/src/services/chat-question.service.ts            -- Power handling, yeni alanlar
qulo-server/src/controllers/chat-question.controller.ts      -- Yeni handler'lar
qulo-server/src/routes/chat.routes.ts                        -- Yeni route'lar
qulo-server/src/validators/chat-question.validator.ts        -- Güncellenen schema
qulo-server/src/services/chat.service.ts                     -- Chat kilidi kontrolü (sendMessage)
```

## Edge Case'ler

| Senaryo | Davranış |
|---------|----------|
| 4 şıklı soru + HALF power | 2 yanlış şık elenir, 2 kalır |
| 2 şıklı soru + HALF power | HALF kullanılamaz (UI'da gizli) |
| 2 şıklı soru + HINT ama hint yazılmamış | HINT kullanılamaz (UI'da gizli) |
| Power X aktif + süre bitti | Kurtarma ekranı: önce Power Y (50💜), sonra SKIP |
| Power X aktif + Power Y yok (yetersiz elmas) | Kurtarma şansı yok, direkt yanlış cevap |
| Chat kilidi aktif + soru cevaplanmadı | İki taraf da mesaj atamaz, input devre dışı |
| Unmatch + yanlış cevap | Match sonlandırılır, chat kapanır |
| Ödül medya + yanlış cevap | Medya kilitli kalır (bulanık) |
| Cevaplayıcı soruyu hiç açmaz | Sonsuz bekler, expire yok |
| Taslaktan soru gönder | Metin + şıklar kopyalanır, ödül medya eklenmez |
| Geçmişten soru tekrar gönder | Aynı — metin + şıklar kopyalanır |
| Power envanterden kullanma | `exchangeService.tryUseInventory()` — diamond harcanmaz, yeşil ödül de yok |
| Power anında satın alma | `diamondService.spendPurple()` + `diamondService.earnGreen()` — %30 ödül |
| Yetersiz mor elmas + power kullanma | Hata mesajı, power uygulanmaz |
| Günlük limit aşımı | Hata mesajı, soru oluşturulamaz |
