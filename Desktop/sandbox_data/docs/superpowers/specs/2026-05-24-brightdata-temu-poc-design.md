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

## 1.5 Phase 0 — Day 0 Feasibility Test (KRİTİK, kod yazmadan önce)

**Süre:** 1-2 saat (tek oturum, 2 haftalık PoC'den ÖNCE).

**Amaç:** Temu'nun hangi veri çekme yöntemine açık olduğunu doğrulamak. Çıktıya göre 2 haftalık planın stratejisi (ve süresi) belirlenir.

**Test adımları:**
1. Bir Android telefonu USB ile Mac'e bağla, Temu app'i yükle (en güncel sürüm), bir ürün sayfası aç
2. `adb shell uiautomator dump /sdcard/dump.xml && adb pull /sdcard/dump.xml`
3. XML'i editörde aç, şu field'ları ara:
   - Ürün başlığı (text node var mı?)
   - Fiyat (resource-id ile bulunuyor mu?)
   - Stok / sold count
   - Rating ve review count
   - Seller / ships_from
4. Eksik kalan field'lar için: `adb exec-out screencap -p > screen.png`, Pillow ile ilgili bölgeyi crop, Tesseract OCR test
5. (Opsiyonel bonus): `mitmproxy` ile telefonu proxy üzerinden geçir, Temu ürün sayfası açtığında API çağrılarını yakala. Endpoint görünüyor mu? Signing var mı?

**Karar matrisi:**

| Senaryo | Bulgu | Strateji | 2 hafta gerçekçi mi? |
|---|---|---|---|
| 🟢 **A: XML zengin** | Tüm field'lar XML'de var | UI Automator only, kolay yol | EVET, hatta erken bitebilir |
| 🟡 **B: XML kısmi** | Bazı field'lar XML'de (örn fiyat var ama sold_count yok) | XML + region OCR hibrit | EVET (1 hafta scraper + 1 hafta observation) |
| 🟠 **C: XML boş/kapalı** | uiautomator dump kullanılabilir text vermiyor | Full screenshot + OCR — yavaş, hatalı, koordinat-hassas | RİSKLİ — 3-4 haftaya çıkabilir, scope kıs |
| 🟢 **D: API yakalanır** | mitmproxy ile clean API endpoint bulundu | Telefon hiç gerekmez, Mac'ten direkt | ÇOK HIZLI — 1 hafta yeterli |

**Eğer C çıkarsa:** Marc'a "PoC 4 haftaya kaydı, alternatif yöntem deniyoruz" diye ara update emaili at, momentum'u kaybetme.

**Day 0 çıktısı:** Bir markdown raporu (`docs/superpowers/specs/2026-05-24-day0-feasibility-report.md`) — hangi senaryo (A/B/C/D), kanıt screenshot'ları, XML dump örneği, karar.

## 2. Scope (PoC)

**Dahil:**
- Tek bir platform: **Temu** (Shopee 2. faza)
- **Full ürün capture** (sadece fiyat değil): başlık, fiyat, indirim, stok, sold count, rating, rating dağılımı, kargo bilgisi, kupon, **tüm varyantlar (her renk/beden için ayrı fiyat ve stok)**, özellikler/specifications, görsel URL'leri
- **Yorum içerikleri HARİÇ** (sadece yorum sayısı + yıldız dağılımı; metin/fotoğraf çekilmez — hızı korur)
- 100 SKU'luk fix bir liste, her gün taranır → multi-table time-series
- Tek cihaz: 1 adet Android telefon, USB ile sürekli bağlı
- 7 günlük continuous data toplama → success rate, latency, error pattern istatistikleri
- Marc'a gönderilecek deck + denormalized CSV sample + benchmark dokümanı

**Hariç (out of scope):**
- Shopee scraper (Faz 2)
- Multi-device farm
- Full catalog crawling (sadece izlenen 100 SKU)
- Production-grade auth/account rotation
- Bright Data marketplace entegrasyonu (önce ürün, sonra entegrasyon)

**Başarı kriteri:**
- 7 ardışık günde günlük success rate ortalaması ≥ %85
- Toplam ≥ 500 başarılı `product_observations` (ürün-gün satırı) + ≥ 3000 `variant_observations` (varyant-gün satırı)
- Sample CSV (denormalized, Marc için) temiz, parse hatasız, tarih-damgalı, varyant ve özellik JSON'ları dahil
- Telegram alarm sistemi en az 1 gerçek olayda (örn elle scraper'ı bozma) doğru tetiklenmiş
- Günlük run ≤ 2 saat tamamlanır (100 SKU × ~55s)

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

**Sorumluluk:** Her gün belirli saatte tüm registered device'lardan paralel veri çekmek.

**Tetikleyici:** macOS `launchd` (her gün 09:00, sleep'ten uyanma desteği ile).

**Device pool pattern (day-1 multi-device ready):**
- `devices.json` dosyası registered cihazların listesi (PoC'de 1 satır, gelecekte N satır)
- Daemon `adb devices` ile fiziksel olarak bağlı tüm cihazları görür, `devices.json` ile eşler
- Her cihaz için ayrı bir worker thread başlatır
- Worker'lar paralel çalışır, sadece kendi cihazlarını kullanır
- Bir worker çökerse sadece o cihazın job'ları başarısız, diğerleri etkilenmez

**Job dağıtımı:**
- 100 SKU consistent hash ile cihazlara dağıtılır (`sku_id → device_id`)
- Aynı SKU her zaman aynı cihazda → fingerprint tutarlılığı (Temu aynı kullanıcı sanıyor)
- Cihaz sayısı değişirse: rehash, ama gradual migration ile (1 hafta over-provision)

**Akış (worker başına):**
1. `adb -s <device_id>` ile cihaz hazır mı kontrol et (ekran açık, Temu yüklü, şarj ≥ %30)
2. Hazır değilse: Telegram L2 alarm (cihaz adı ile) + worker exit
3. Bu cihaza atanan SKU listesini al
4. Her SKU için **full capture flow**:
   a. Temu app'i deep link ile direkt o ürün sayfasına aç (`am start -a VIEW -d temu://product/<id>`) — search yapmadan
   b. Sayfanın yüklenmesini bekle (sleep + uiautomator polling)
   c. **Ana ürün XML dump**: `adb shell uiautomator dump` → lxml parse → title, ana fiyat, indirim, sold count, rating, rating dağılımı, kargo, kupon, ships_from, seller_name, görsel URL'leri çıkar
   d. **Özellikler bölümü**: Sayfayı features section'a scroll et → tekrar XML dump → her özellik için key-value çıkar
   e. **Varyant matrisi**: Varyant seçici görünüyorsa, her varyant butonuna tek tek tap → her tap sonrası kısa bekleme → XML dump → o varyantın fiyat ve stok bilgisini çıkar. Bu döngü tüm renk × beden kombinasyonları için
   f. XML'de eksik field varsa: `adb exec-out screencap -p` → Pillow ile bilinen koordinatlardan crop → Tesseract OCR (fallback)
   g. Parse edilen veriyi schema validation'dan geçir → ilgili tablolara yaz (`products`, `product_observations`, `variants`, `variant_observations`, `product_features`, `product_images`)
   h. Çıkıp app'i kill et (next SKU için fingerprint reset)
   i. Bir sonraki SKU'ya geç
5. Worker sonunda kendi `runs` satırını ve heartbeat'i yaz

**Süre tahmini (SKU başına):**
- Ana dump: ~5s
- Özellikler dump: ~5s
- Varyant döngüsü (ortalama 6 varyant): ~45s (her varyant: tap + 2s bekleme + dump + parse)
- Kill + restart: ~5s
- **Toplam: ~55-60s per SKU**
- 100 SKU → ~90-100 dakika günlük run

**Veri çekme yöntemi (öncelik sırası):**
1. **UI Automator XML dump** (ana yöntem, %90 senaryo) — accessibility tree'den structured text. AI yok, OCR yok, pixel okumak yok. Düz XML parsing.
2. **Region OCR fallback** (Pillow + Tesseract) — sadece XML'de olmayan field'lar için, bilinen bounding box'tan crop + OCR. Klasik algoritma, AI değil.
3. **API doğrudan çağırma** (Day 0'da araştırılır) — eğer Temu mobile API'si mitmproxy ile yakalanıp signing reverse edilebilirse, telefon hiç gerekmez. Bonus.

**Bağımsız çalışma garantisi:** AI yok, Python + adb + sqlite3 + Pillow. Tek bir Python virtualenv. `concurrent.futures.ThreadPoolExecutor` ile N worker.

**Dosya yapısı:**
```
scraper/
  daemon.py            # main entry, device pool orchestration
  adb_client.py        # ADB wrapper (cihaz-id parametreli)
  device_pool.py       # devices.json okuma, worker spawn, sku → device hash
  temu_actions.py      # selector koordinatları + flow (PATCH HEDEFİ)
  parser.py            # screenshot → structured data
  storage.py           # SQLite I/O (device_id kolonlu)
  targets.json         # 100 SKU listesi
  devices.json         # registered device listesi
```

**`devices.json` örneği (PoC = 1 satır):**
```json
[
  {
    "device_id": "phone_01",
    "adb_serial": "R3CR70XXXX",
    "model": "Pixel 7",
    "screen_resolution": "1080x2400",
    "active": true,
    "added_at": "2026-05-24"
  }
]
```

**10-15 cihaza geçince:** Sadece bu JSON'a satır eklenir. Daemon kodu **değişmez**. Yeni cihaz için bir kerelik koordinat kalibrasyonu (farklı ekran çözünürlüğü ise) gerekebilir — `temu_actions.py` model-aware olarak yazılır.

**Patch hedefi:** `temu_actions.py` — Claude bu dosyayı patchler. İçinde model-bazlı koordinatlar, swipe miktarları, bekleme süreleri, retry sayıları, OCR bölgeleri var. Diğer dosyalar Claude tarafından **değiştirilmez**.

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
| Mac restart (planlı veya power outage) | launchd RunAtLoad → heartbeat tick | Otomatik resume, Telegram'a "system back online" |
| Bir cihaz çöktü (multi-device senaryo) | Worker exception, ADB unreachable | Sadece o cihazın worker'ı durur, diğerleri devam; o cihaza assignment'lar bir sonraki run'da rehash |
| USB hub gücü yetmedi (multi-device) | Sporadic ADB disconnect | L2 alarm — powered hub'a geçme uyarısı |
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

## 6. Veri Modeli (SQLite, normalized multi-table)

### 6.1 İç Saklama (analitik + time-series için doğru tasarım)

```sql
-- İzlenen SKU'lar (manuel olarak doldurulur, 100 satır)
CREATE TABLE targets (
  sku_id TEXT PRIMARY KEY,
  temu_url TEXT NOT NULL,
  category TEXT,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Registered devices (PoC: 1 satır, gelecekte N)
CREATE TABLE devices (
  device_id TEXT PRIMARY KEY,
  adb_serial TEXT NOT NULL,
  model TEXT,
  screen_resolution TEXT,
  active BOOLEAN DEFAULT 1,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ürün temel bilgisi (yavaş değişen, 1 satır per SKU)
CREATE TABLE products (
  sku_id TEXT PRIMARY KEY REFERENCES targets(sku_id),
  title TEXT,
  description TEXT,
  category TEXT,
  brand TEXT,
  seller_name TEXT,
  ships_from TEXT,
  first_seen_at TIMESTAMP,
  last_seen_at TIMESTAMP
);

-- Günlük ürün snapshot'ı (price, rating, stock, vb — her gün 1 satır per SKU)
CREATE TABLE product_observations (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  device_id TEXT NOT NULL REFERENCES devices(device_id),
  observed_at TIMESTAMP NOT NULL,
  price_usd REAL,
  original_price_usd REAL,
  discount_pct REAL,
  in_stock BOOLEAN,
  sold_count_text TEXT,        -- "10k+"
  sold_count_estimate INTEGER, -- 10000 (parsed)
  rating_avg REAL,
  review_count INTEGER,
  rating_5_count INTEGER,
  rating_4_count INTEGER,
  rating_3_count INTEGER,
  rating_2_count INTEGER,
  rating_1_count INTEGER,
  has_free_shipping BOOLEAN,
  shipping_cost_usd REAL,
  delivery_eta_days_min INTEGER,
  delivery_eta_days_max INTEGER,
  has_coupon BOOLEAN,
  coupon_value_usd REAL,
  raw_xml_path TEXT,
  raw_screenshot_path TEXT,
  parse_confidence REAL,
  UNIQUE(sku_id, observed_at)
);

-- Varyantlar (renk × beden × diğer kombinasyonlar, 1 satır per unique kombinasyon)
CREATE TABLE variants (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  variant_key TEXT NOT NULL,   -- canonicalized: "color:Red|size:M"
  attributes_json TEXT,        -- {"color":"Red","size":"M"}
  first_seen_at TIMESTAMP,
  last_seen_at TIMESTAMP,
  UNIQUE(sku_id, variant_key)
);

-- Günlük varyant snapshot'ı (her gün her varyant için 1 satır)
CREATE TABLE variant_observations (
  id INTEGER PRIMARY KEY,
  variant_id INTEGER NOT NULL REFERENCES variants(id),
  observed_at TIMESTAMP NOT NULL,
  price_usd REAL,
  in_stock BOOLEAN,
  stock_estimate INTEGER,      -- "only 3 left" gibi varsa
  UNIQUE(variant_id, observed_at)
);

-- Ürün özellikleri (key-value, her gözlemde upsert)
CREATE TABLE product_features (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  observed_at TIMESTAMP NOT NULL,
  feature_key TEXT,            -- "Material", "Weight", "Origin"
  feature_value TEXT,
  UNIQUE(sku_id, observed_at, feature_key)
);

-- Görsel URL'leri (indirilmez, sadece URL kaydedilir)
CREATE TABLE product_images (
  id INTEGER PRIMARY KEY,
  sku_id TEXT NOT NULL REFERENCES products(sku_id),
  observed_at TIMESTAMP NOT NULL,
  image_url TEXT,
  image_position INTEGER       -- 0=main, 1=2nd, etc.
);

-- Her run için metrik (device başına ayrı satır)
CREATE TABLE runs (
  id INTEGER PRIMARY KEY,
  device_id TEXT NOT NULL REFERENCES devices(device_id),
  started_at TIMESTAMP,
  finished_at TIMESTAMP,
  status TEXT,                 -- 'success', 'partial', 'failed'
  attempted INTEGER,
  succeeded INTEGER,
  parse_errors INTEGER,
  variants_captured INTEGER,
  alert_level TEXT,            -- 'info', 'warn', 'critical'
  notes TEXT
);

-- Heartbeat (life signal)
CREATE TABLE heartbeats (
  ts TIMESTAMP PRIMARY KEY,
  component TEXT,              -- 'daemon', 'monitor', 'supervisor'
  status TEXT
);

-- Claude'un attığı patch'ler
CREATE TABLE patches (
  id INTEGER PRIMARY KEY,
  applied_at TIMESTAMP,
  file_path TEXT,
  diff TEXT,
  canary_result TEXT,          -- '5/5', '3/5', 'failed'
  status TEXT                  -- 'applied', 'rejected', 'rolled_back'
);
```

### 6.2 Marc'a Gönderilen Düz Tablo (denormalized export view)

Marc'a CSV gönderilirken iç schema 7 tablodan düzleştirilir. Tek satır = 1 ürün × 1 gün:

```csv
sku_id,observed_at,title,category,seller,ships_from,
  price_usd,original_price,discount_pct,in_stock,sold_count,
  rating_avg,review_count,rating_5,rating_4,rating_3,rating_2,rating_1,
  free_shipping,shipping_cost,delivery_min_days,delivery_max_days,has_coupon,coupon_value,
  variants_json,features_json,image_urls_json,
  parse_confidence
```

**Örnek satır:**
```csv
601099001,2026-05-25,"Bluetooth Earbuds Pro","Electronics","TopSeller","CN",
  15.99,29.99,46.7,true,"10k+",10000,
  4.7,3421,2100,800,300,150,71,
  true,0.00,7,15,true,3.00,
  "[{""color"":""Black"",""size"":""M"",""price"":15.99,""stock"":true},{""color"":""White"",""size"":""M"",""price"":16.99,""stock"":false}]",
  "{""Battery"":""24h"",""Bluetooth"":""5.3"",""IP_rating"":""IPX4""}",
  "[""https://img.temu.com/...1.jpg"",""https://img.temu.com/...2.jpg""]",
  0.94
```

Bu CSV bir Python script ile (`scripts/export_csv.py`) SQLite'tan üretilir, Marc'a Google Drive linki olarak gönderilir.

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

## 7.5 Bootstrap, Auto-restart ve Operations

### 7.5.1 İlk Kurulum (one-time)

Kullanıcı tek bir komut çalıştırır, sonra **terminal'i bir daha açmaz**:

```bash
cd ~/sandbox_data
./install.sh
```

`install.sh` adımları:
1. Python 3.11 venv oluştur, `requirements.txt` yükle (adb-python yok — sistem `adb` binary'sini kullan)
2. `~/Library/Application Support/scraper/` altında SQLite DB oluştur, migration'ları çalıştır
3. `devices.json` örnek dosyası yaz, kullanıcıdan ilk cihazın ADB serial'ını sor (interactive)
4. `~/Library/LaunchAgents/` altına 3 plist yaz:
   - `com.berkant.scraper.daemon.plist` (her gün 09:00, RunAtLoad=true)
   - `com.berkant.scraper.heartbeat.plist` (her saat — heartbeat eksikse alarm)
   - `com.berkant.scraper.supervisor.plist` (günde 4 kez — Claude supervisor cron)
5. `launchctl bootstrap gui/$(id -u) <plist>` ile aktive et
6. `sudo pmset repeat wakeorpoweron MTWRFSU 08:55:00` — Mac'i 08:55'te uyandır
7. `.env` dosyasından Telegram bot token + chat_id oku, health check at
8. İlk başarılı health check sonrası: "✅ System installed and active. Daemon runs daily at 09:00."

**Bundan sonra:** Sistem 7×24 çalışır. Sen sadece Telegram'a bakarsın.

### 7.5.2 Bilgisayar Restart / Power Loss Senaryosu

```
Mac kapanır (planlı ya da power outage)
         ↓
Mac açılır → macOS boot
         ↓
launchd boot stage 'ta plist'leri yükler
         ↓
RunAtLoad=true olan plist'ler hemen çalışır
         ↓
Heartbeat plist çalışır → "system back online" → Telegram'a "✅ System restarted, all healthy"
         ↓
Bir sonraki 09:00'da daemon normal çalışır
```

**Kullanıcı dahil değil.** Login bile gerekmez (LaunchAgent değil LaunchDaemon kullanırsak — system-wide). Ama LaunchAgent'ta da auto-login açıksa otomatik başlar.

**Kritik macOS ayarları (install.sh kontrol eder ve kullanıcıyı uyarır):**
- System Settings → Energy: "Prevent automatic sleeping when display is off" → AÇIK
- System Settings → Energy: "Wake for network access" → AÇIK
- System Settings → Login: Auto-login user → AÇIK (LaunchAgent için)
- Power outage recovery: BIOS'ta "Restore after power loss" varsa AÇIK

### 7.5.3 Multi-Device Scale Roadmap

**PoC (1 cihaz, Mevcut tasarım):**
- 1 USB kablo direkt Mac'e
- `devices.json`'da 1 satır
- Tek bir daemon process, 1 worker thread

**Faz 2 (2-7 cihaz):**
- Powered USB hub (örn. Anker 7-port, 60W)
- `devices.json`'a yeni satırlar
- Yeni model ise `temu_actions.py` model-aware kalibrasyon (bir kerelik koordinat haritası)
- Daemon kod **değişmez** — sadece JSON güncellenir

**Faz 3 (8-15 cihaz):**
- 2 adet powered USB hub (12+ port toplam)
- Dedicated Mac mini (sessiz, az elektrik, her zaman açık)
- Ethernet bağlantısı (Wi-Fi 15 cihaz parallelism'i için yetmeyebilir)
- Job queue: artık SQLite job table; daemon job'ları cihazlara assign eder
- Monitoring dashboard (basit web UI, `localhost:8080` → her cihazın canlı durumu)

**Faz 4 (15+ cihaz, eğer Bright Data deal büyürse):**
- Multiple Mac minis (örn. 3 Mac × 15 cihaz = 45 cihaz farm)
- Central PostgreSQL (SQLite'tan migrate)
- Job orchestrator (Celery / Temporal)
- Bu nokta artık ayrı bir spec'in konusu

**Kritik yatırım sırası:**
1. PoC bitsin, Marc'a numbers gitsin
2. Marc deal'i onaylarsa → 5-7 cihaz al, Mac mini ayır
3. Aylık $X gelir gelmeye başlarsa → 15 cihaza çık
4. Stable cash flow → Mac mini cluster

**Yanlış zamana yatırım yapmama kuralı:** Cihaz almadan önce **gelir kanıtı** ol. PoC sadece 1 cihazla yapılabilir.

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
1. **Day 0 — Feasibility test** (1-2 saat): XML/OCR/API hangisi çalışıyor → karar matrisi → senaryo seçimi
2. `writing-plans` skill'i ile detaylı implementation plan (her dosya, her fonksiyon, Day 0 sonucuna göre)
3. Hafta 1: L1 daemon + SQLite + Telegram bot — 5 SKU'lu mini test
4. Hafta 1 sonu: 100 SKU full daemon, gerçek 7 günlük observation başlar
5. Hafta 2: L2 monitor + L3 Claude supervisor + canary flow
6. Hafta 2 sonu: deck + CSV + benchmark hazır, Marc'a email

**Önemli:** Day 0 sonucu C (XML kapalı) çıkarsa plan revize edilir, scope kısılır veya alternatif yöntem (mitmproxy araştırması) ile devam edilir.
