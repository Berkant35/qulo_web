# Bright Data Partnership — Temu Mobile Scraping PoC

**Tarih:** 2026-05-24
**Sahip:** Berkant Çalıkuşu
**Durum:** Design (onay bekliyor)
**Hedef cevap tarihi:** Marc'a 2026-06-07'ye kadar gerçek sayılarla dönmek (≤2 hafta)

---

## 1. Problem ve Hedef

Bright Data Global Partnerships Manager Marc Hermann-Cohen aktif diyalog halinde. Bizden istediği:

1. Hangi infrastructure ile scrape ediyoruz (web mi, mobile mi)
2. Bir deck
3. **Temu ve Shopee'deki gerçek success rate'lerimiz**

**Sorun:** Mevcut ADB pipeline'ımız Instagram/Reddit/Twitter için kurulu. Temu ve Shopee için henüz hiçbir şey yok. "Yapabiliriz" demek inandırıcı değil — Bright Data'ya satılacak şey **ölçülmüş, kanıtlanmış sayılar.**

**Hedef:** 2 hafta içinde Temu üzerinde derin bir PoC kurmak; ölçülmüş success rate, sample CSV ve mimari diagram ile Marc'a dönmek.

**Stratejik konum:** Bright Data zaten "normal website scraping" yapıyor. Bizim unique value'muz **real Android device + cellular IP + mobile app data extraction**. Bu konumu güçlendirecek tek data ürettiğimiz işe odaklanıyoruz.

---

## 2. Scope (PoC)

**Dahil:**
- Tek bir platform: **Temu** (Shopee 2. faza)
- Tek data tipi: **Daily price + stock tracking** (100 SKU'luk fix bir liste, her gün taranır → time-series)
- Tek cihaz: 1 adet Android telefon, USB ile sürekli bağlı
- 7 günlük continuous data toplama → success rate, latency, error pattern istatistikleri
- Marc'a gönderilecek deck + sample CSV + benchmark dokümanı

**Hariç (out of scope):**
- Shopee scraper (Faz 2)
- Multi-device farm
- Full catalog crawling (sadece izlenen 100 SKU)
- Production-grade auth/account rotation
- Bright Data marketplace entegrasyonu (önce ürün, sonra entegrasyon)

**Başarı kriteri:**
- 7 ardışık günde günlük success rate ortalaması ≥ %85
- Toplam ≥ 500 başarılı data point (100 SKU × 7 gün × ≥%85)
- Sample CSV temiz, parse hatasız, tarih-damgalı
- Telegram alarm sistemi en az 1 gerçek olayda (örn elle scraper'ı bozma) doğru tetiklenmiş

---

## 3. Üç Katmanlı Mimari

```
+-------------------+      +-------------------+      +-------------------+
| L1: Daemon        |      | L2: Health        |      | L3: Claude        |
| (Python, no AI)   | ---> | Monitor           | ---> | Supervisor        |
| Cron-scheduled    |      | (Python, no AI)   |      | (CronCreate,      |
| ADB + parse       |      | Success rate +    |      |  ephemeral)       |
|                   |      | heartbeat + alert |      | Patch + canary    |
+-------------------+      +-------------------+      +-------------------+
        |                          |                          |
        v                          v                          v
+--------------------------------------------------------------------+
|             SQLite DB (data + runs + alerts + heartbeats)          |
+--------------------------------------------------------------------+
                                  |
                                  v
                       +----------------------+
                       | Telegram Bot         |
                       | L1 daily / L2 warn / |
                       | L3 critical          |
                       +----------------------+
```

### 3.1 L1 — Deterministic Daemon (Python, no AI)

**Sorumluluk:** Her gün belirli saatte Temu'dan veri çekmek.

**Tetikleyici:** macOS `launchd` (her gün 09:00, sleep'ten uyanma desteği ile).

**Akış:**
1. ADB üzerinden telefon hazır mı kontrol et (`adb devices`, ekran açık mı, Temu yüklü mü, şarj ≥ %30)
2. Hazır değilse: Telegram L2 alarm + exit
3. 100 SKU'luk listeyi `targets.json`'dan oku
4. Her SKU için: Temu app'i aç → arama veya direkt URL deep link → ürün sayfası → screenshot al → koordinat-bazlı parse → SQLite'a yaz
5. Run sonunda istatistikleri (`runs` tablosu) ve heartbeat'i yaz

**Bağımsız çalışma garantisi:** AI yok, Python + adb + sqlite3 + Pillow (OCR fallback için). Tek bir Python virtualenv.

**Dosya yapısı:**
```
scraper/
  daemon.py            # main entry
  adb_client.py        # ADB wrapper
  temu_actions.py      # selector koordinatları + flow (PATCH HEDEFİ)
  parser.py            # screenshot → structured data
  storage.py           # SQLite I/O
  targets.json         # 100 SKU listesi
```

**Patch hedefi:** `temu_actions.py` — Claude bu dosyayı patchler. İçinde sadece koordinatlar, swipe miktarları, bekleme süreleri, retry sayıları, OCR bölgeleri var. Diğer dosyalar Claude tarafından **değiştirilmez**.

### 3.2 L2 — Health Monitor (Python, no AI)

**Sorumluluk:** Her run sonrası sağlık metriklerini hesaplamak ve eşik aşımlarında alarm üretmek.

**Tetikleyici:** Daemon'ın sonunda doğrudan çağrılır.

**Eşikler:**
| Seviye | Koşul | Aksiyon |
|---|---|---|
| L1 (info) | success_rate ≥ 90% | Hiçbir şey (günlük 09:30 özet zaten gönderilir) |
| L2 (warn) | success_rate 50-90% veya parse error > 10 | Telegram'a "uyarı: bugün %X" mesajı + Claude supervisor next run flag set |
| L3 (critical) | success_rate < 50%, **ya da** daemon hiç çalışmamış (heartbeat > 24h), **ya da** telefon offline | Telegram'a "KRITIK" + Mac terminal banner + sesli bildirim |

**Heartbeat:** Her başarılı run sonu `heartbeats` tablosuna timestamp yazılır. Bağımsız cron job (saatte bir) heartbeat 24h+ ise L3 alarm tetikler.

### 3.3 L3 — Claude Supervisor (ephemeral session, CronCreate)

**Sorumluluk:** Sadece sistem kırıldığında devreye girip patch denemek.

**Tetikleyici:** `CronCreate` ile günde 4 kez (örn 10:00, 14:00, 18:00, 22:00 — her seferinde **yeni session**).

**Kritik karar — Session lifecycle:**
- `/loop` değil, `CronCreate` kullanılır.
- Her tetikleme = sıfırdan Claude session. Context birikmez, /compact derdi yok.
- Bir session maksimum 10 dakika, kendisini bu süre sonra sonlandırır.
- Her session başı maliyet: ~5K token (~$0.10), günlük ~$0.40.

**Akış:**
1. `sandbox_data/scraper/state/` altına bak: son 24h içinde L2 veya L3 flag dosyası var mı?
2. Flag YOKSA → "Sistem sağlıklı, çıkıyorum." → exit, hiç token harcama
3. Flag VARSA:
   a. Son 3 run'ın log + screenshot'larını oku
   b. Hata pattern'ini analiz et (UI değişti mi? Captcha mı? Banlanma mı?)
   c. Eğer **UI selector değişikliği** → `temu_actions.py`'da patch öner
   d. Patch'i `temu_actions_candidate.py` olarak yaz, **production dosyaya henüz dokunma**
   e. **Canary çalıştır:** `daemon.py --canary --candidate-file=temu_actions_candidate.py --limit=5`
   f. Canary başarı oranı ≥ %80 ise: `temu_actions_candidate.py` → `temu_actions.py` üzerine yaz, git commit (auto-message: "patch: temu_actions selector update — canary 5/5"), Telegram'a "patch uygulandı" gönder. Sen `git log` ile her zaman Claude'un yaptığı tüm patch'leri görebilirsin.
   g. Canary başarısız: candidate sil, flag'i upgrade et L3'e, Telegram'a "patch denedim, başaramadım, müdahale gerek" gönder

**Claude'un dokunamayacağı dosyalar:** `daemon.py`, `storage.py`, `parser.py` ana logic — sadece selector dosyası `temu_actions.py` patch edilir. Bu izolasyon silent corruption riskini düşürür.

**Canary güvenlik kuralı:** Canary 5 üründen <80% başarılıysa otomatik production'a gitmez. Bu kural değiştirilemez (config'e değil, koda gömülü).

---

## 4. Telegram Bildirim Sistemi

**Bot kurulumu:** BotFather'dan yeni bot, token .env'ye, chat_id berkant'ın özel chat'i.

**Mesaj tipleri:**

| Tip | Örnek | Saat |
|---|---|---|
| L1 daily | "✅ 24 May: 94 SKU başarılı / 100 (%94). Latency 23m. Tüm sistem sağlıklı." | Her gün 09:30 |
| L2 warn | "⚠️ 24 May: success %72. Parse hatası 18. Claude supervisor 14:00'da bakacak." | Anında |
| L3 critical | "🚨 KRITIK: Daemon 26 saattir çalışmıyor. Telefon ADB'de görünmüyor." | Anında + ses |
| Claude patch ok | "🔧 Patch uygulandı: search_button koordinat (300,1200)→(350,1100). Canary 5/5 başarılı." | Patch sonrası |
| Claude patch fail | "❌ Patch deneyip başaramadım. Manuel müdahale gerek. Detay: state/last_failure.md" | Patch sonrası |

---

## 5. Edge Case Handling

| Edge case | Tespit | Aksiyon |
|---|---|---|
| Telefon USB kopması | `adb devices` boş | L3 alarm, daemon exit |
| Telefon restart sonrası unlock screen | Screenshot'ta lock pattern | L2 alarm, retry 3 kez sonra exit |
| Şarj < %30 | `adb shell dumpsys battery` | L2 alarm, daemon exit |
| Sen telefonu kullanıyorsun (foreground app != Temu) | `adb shell dumpsys window` kontrolü | Run skip + log, alarm yok |
| Temu app update sonrası UI değişti | Parse success rate düşüşü | Otomatik L2 → Claude supervisor → patch flow |
| Captcha tetiklendi | Screenshot'ta captcha keyword OCR | L3 alarm — Claude'a verilmiyor (insan gerek) |
| Hesap banlandı | "Account suspended" pattern | L3 alarm, daemon kalıcı durdurulur, manuel müdahale |
| Mac sleep'te kaldı | `pmset repeat wakeorpoweron MTWRFSU 08:55:00` ile Mac 08:55'te uyandırılır; launchd 09:00'da daemon'ı tetikler | Energy Saver → "Wake for network access" açık; "Prevent automatic sleeping when display is off" açık |
| Mac restart sonrası autostart | `launchd` plist'i LaunchAgents'a kurulu | Otomatik başlar, manuel müdahale yok |
| Disk dolması | Her run öncesi free disk check (<5GB → alarm) | L2 alarm + 30 gün önceki screenshot'ları sil (LRU) |
| Network kesintisi | İlk request timeout | Retry 3x exponential backoff, sonra L2 |
| Claude yanlış patch attı | Canary < %80 → otomatik rollback | Halihazırda mimari koruma var |
| Silent data corruption | Schema validation her insert öncesi (price > 0, stock ≥ 0, vb) | Validation fail → L2 + insert reject |

---

## 6. Veri Modeli (SQLite)

```sql
-- İzlenen SKU'lar (manuel olarak doldurulur, 100 satır)
CREATE TABLE targets (
  sku_id TEXT PRIMARY KEY,
  temu_url TEXT NOT NULL,
  category TEXT,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Her gün her SKU için bir satır (time-series)
CREATE TABLE price_observations (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES targets(sku_id),
  observed_at TIMESTAMP NOT NULL,
  price_usd REAL,
  original_price_usd REAL,  -- indirim öncesi
  in_stock BOOLEAN,
  sold_count INTEGER,        -- "10k+ sold"
  rating REAL,
  review_count INTEGER,
  seller_name TEXT,
  ships_from TEXT,           -- lokasyon
  raw_screenshot_path TEXT,
  parse_confidence REAL,     -- 0.0-1.0
  UNIQUE(sku_id, observed_at)
);

-- Her run için metrik
CREATE TABLE runs (
  id INTEGER PRIMARY KEY,
  started_at TIMESTAMP,
  finished_at TIMESTAMP,
  status TEXT,               -- 'success', 'partial', 'failed'
  attempted INTEGER,
  succeeded INTEGER,
  parse_errors INTEGER,
  alert_level TEXT,          -- 'info', 'warn', 'critical'
  notes TEXT
);

-- Heartbeat (life signal)
CREATE TABLE heartbeats (
  ts TIMESTAMP PRIMARY KEY,
  component TEXT,            -- 'daemon', 'monitor', 'supervisor'
  status TEXT
);

-- Claude'un attığı patch'ler
CREATE TABLE patches (
  id INTEGER PRIMARY KEY,
  applied_at TIMESTAMP,
  file_path TEXT,
  diff TEXT,
  canary_result TEXT,        -- '5/5', '3/5', 'failed'
  status TEXT                -- 'applied', 'rejected', 'rolled_back'
);
```

---

## 7. Marc'a Gönderilecek Deliverable (Hafta Sonu)

**1. Deck (Google Slides, 8-10 slayt):**
- Slide 1: Kim biziz, mobile-first scraping
- Slide 2: Bright Data'nın güçlü olmadığı tarafı: real device + cellular IP + mobile app
- Slide 3: Mimari diagram (yukarıdaki 3-layer)
- Slide 4: Temu PoC sonuçları — **7 günlük çubuk grafik, success rate**
- Slide 5: Sample data (CSV ekran görüntüsü, 10 satır)
- Slide 6: Edge case handling — anti-bot ile nasıl baş ediyoruz
- Slide 7: Genişleme planı — Shopee, geolocation diversity, multi-device
- Slide 8: Önerilen partnership modeli (dataset publisher veya custom request fulfillment)
- Slide 9: Pricing tartışması (per-1000-records ya da subscription)
- Slide 10: Sonraki adımlar + CTA (call talebi)

**2. Sample CSV (Google Drive link):**
- 500+ data point, gerçek 7 günlük data
- Schema: sku_id, observed_at, price, stock, sold_count, rating, ships_from, seller

**3. Benchmark dokümanı (1 sayfa PDF):**
- Success rate: günlük + 7-day rolling
- Average latency per SKU
- Error breakdown (parse, network, app crash)
- Comparison: "Bright Data datacenter scraper bu siteden veri çekebiliyor mu?" — eğer çekemiyorsa bu bizim moat'ımız

**Email tonu:** Kısa, profesyonel, deck + Drive linki. "Marc, demo done — here are the real numbers" gibi.

---

## 8. Risk Listesi

| Risk | Olasılık | Etki | Azaltma |
|---|---|---|---|
| Temu Türkiye'den US ürünleri farklı gösteriyor | Yüksek | Orta | VPN + locale ayarı + ships_from kolonu ile şeffaf raporlama |
| Hesap 3-4 gün içinde banlanır | Orta | Yüksek | Login gerektirmeyen public listing endpoint'leri kullan, mümkün olduğu kadar misafir mode |
| Claude patch'leri silent corruption üretir | Düşük (canary var) | Yüksek | Schema validation + manual review her 7. günde |
| 2 haftada bitiremezsin | Orta | Düşük | Scope kesilebilir: 100→50 SKU, 7→4 gün observation |
| Mac sleep nedeniyle veri kaybı | Orta | Orta | launchd plist + Energy Saver ayarları + heartbeat |
| Marc başka bir partner buldu | Düşük | Yüksek | Hafta arası kısa progress email at ("PoC ilerliyor, X gün sonra hazır") — momentum tut |

---

## 9. Açık Sorular (Implementation öncesi netleşmesi gereken)

1. **SKU seçimi:** 100 SKU'yu nasıl seçeceğiz? (Önerilen: Temu'da en çok satan 100 ürün — bunlar zaten popular, demo etkisi yüksek)
2. **Coğrafi konum:** Cellular SIM ABD mi Türkiye mi? (Önerilen: SIM Türkiye, app US locale — gerçek mobile diversity'yi göstermek için)
3. **Hesap kullanımı:** Giriş yapalım mı? (Önerilen: HAYIR — guest mode, ban riski sıfır)
4. **Telefon hangi model:** Mevcut Android telefonu modelini bilmemiz lazım (Pixel/Samsung ekran çözünürlüğü = farklı koordinatlar)
5. **Aynı session içinde tüm SKU mu, ayrı session'lar mı:** (Önerilen: 25 SKU bloklar halinde, her blok sonrası app kill + restart, fingerprint reset)

---

## 10. Mimari Onayı Sonrası Adımlar

Bu spec onaylanırsa:
1. `writing-plans` skill'i ile detaylı implementation plan (her dosya, her fonksiyon)
2. Hafta 1: L1 daemon + SQLite + Telegram bot — 5 SKU'lu mini test
3. Hafta 1 sonu: 100 SKU full daemon, gerçek 7 günlük observation başlar
4. Hafta 2: L2 monitor + L3 Claude supervisor + canary flow
5. Hafta 2 sonu: deck + CSV + benchmark hazır, Marc'a email
