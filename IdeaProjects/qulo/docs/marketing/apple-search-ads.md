# Apple Search Ads — Qulo Kampanya Takip

> Bu dosya Qulo ASA kampanyalarının kurulum, yayın, optimizasyon ve raporlama süreçlerini takip eder. Her adım buraya işlenir — kararlar, gerekçeler, sonuçlar.

---

## Aktif Kampanya #1 — TR İlk Test → Multi-Country Genişletme

**Durum:** 🟠 Running, ancak 2 gündür 0 impression — bid/budget revize edildi, retest sürüyor
**Başlangıç tarihi:** 2026-06-04
**Planlanan süre:** 3 gün → uzatıldı (bkz. incident)
**Pazar:** Türkiye 🇹🇷 → **8 ülke** (TR App Store'da yayında olmadığı için genişletildi)

### Konfigürasyon

| Alan | Değer | Gerekçe |
|---|---|---|
| **Bid Strategy** | Maximize Conversions | Auto-bidder, kurulum basitliği |
| **Target CPA** | 1.50 USD (~45 TL) | TR dating dikey ortalaması, auto-bidder'a manevra alanı |
| **Daily Budget** | 30 USD (~900 TL) | tCPA × 20 kuralı, yeterli conversion sinyali |
| **Lifetime Budget** | — | Açık bırakıldı |
| **Search Match** | ON (zorunlu) | Apple keyword'leri otomatik keşfedecek |
| **Ad Group** | Tek (default) | 3 günlük testte bölmeye gerek yok |
| **Custom Product Page** | — | Henüz yok, default app listing |
| **Devices** | (Apple seçimi) | — |
| **Audience** | (varsayılan) | — |

### Tamamlanan Adımlar

- [x] **2026-06-04** — Bid Strategy: Maximize Conversions seçildi
  - Tradeoff: Manual control kaybı, ama 3 günlük basit testte gerek yok
- [x] **2026-06-04** — Target CPA: 1.50 USD belirlendi
- [x] **2026-06-04** — Daily Cap: 30 USD belirlendi (sonradan 45 USD'ye çıkarıldı)
- [x] **2026-06-04** — Additional Ad Group: SKIP (tek default ad group)
- [x] **2026-06-04** — Kampanya Apple'a gönderildi (review bekliyor)

### Bekleyen Adımlar

- [ ] **+24 saat** — Apple onayı geldi mi kontrol et (genelde 24h içinde)
- [ ] **+24 saat** — İlk metrik snapshot: Impressions, Taps, TTR, Installs, CPA
- [ ] **+48 saat** — Ara değerlendirme: tCPA tutuyor mu, ad gösteriliyor mu?
- [ ] **+72 saat (3. gün sonu)** — Final rapor:
  - Toplam install
  - Gerçek CPA
  - En çok dönüştüren keyword'ler (Search Term Report)
  - TTR (sektör ortalaması ~%50)
  - Conversion rate (tap → install)
- [ ] **3. gün sonrası karar:**
  - Devam mı, kapat mı?
  - tCPA / budget revize mi?
  - 2. kampanya (brand keywords) açılır mı?

---

## Metrik Takibi (3 günlük test)

| Gün | Impressions | Taps | TTR % | Installs | Conv Rate % | Harcama | Gerçek CPA |
|---|---|---|---|---|---|---|---|
| 1 | — | — | — | — | — | — | — |
| 2 | — | — | — | — | — | — | — |
| 3 | — | — | — | — | — | — | — |
| **Toplam** | — | — | — | — | — | — | — |

> Doldurulacak. Dashboard'dan günlük snapshot alıp buraya işle.

---

## 3 Gün Sonrası Karar Matrisi

| Senaryo | Gerçek CPA | Aksiyon |
|---|---|---|
| 🟢 İdeal | ≤ 1.50 USD | tCPA aynı, budget 2-3 katına çıkar, ölçeklendir |
| 🟡 Sınırda | 1.50–2.50 USD | tCPA 2.00'ya çek, daha fazla veri topla (7 gün) |
| 🔴 Yüksek | > 2.50 USD | Kampanyayı durdur, Manage Bids stratejisine geç, brand-only campaign aç |
| ⚫ Az veri | < 10 install / 3 gün | tCPA 2.00'ya çek, budget aynı bırak, 7 güne uzat |

---

## Gelecek Kampanya Fikirleri (Backlog)

- **Brand Campaign** — "qulo", "qulo dating", "qulo app" exact match → marka koruması, en yüksek conversion
- **Competitor Campaign** — "tinder", "bumble", "hinge" exact match → daha pahalı CPT ama kaliteli kullanıcı
- **Category Campaign** — "dating app", "tanışma uygulaması", "sohbet" → geniş erişim
- **Discovery Campaign** — Search Match ON + Broad Match → keyword keşfi
- **Custom Product Page** entegrasyonu → ad group bazlı farklı creative test (premium odaklı vs free odaklı)
- **Pazar genişletmesi** — TR sonrası: DE, FR, NL, UK (Avrupa dating dikey)

---

## Öğrenilenler / Notlar

- **Para birimi uyarısı:** ASA paneli hesap currency'sinde gösterir. TRY hesabıysa rakamları TL girilir.
- **Öğrenme fazı:** Maximize Conversions için resmi öğrenme süresi 14 gün — 3 günlük test bu fazı tamamlamaz, sonuçlar kesin değil indikatif olarak değerlendirilmeli.
- **Daily Cap kuralı:** Target CPA × 15-20 → auto-bidder'a yeterli sinyal verir.
- **İlk 14 günde dokunma:** tCPA / keyword / budget değiştirmek öğrenme fazını sıfırlar.

---

## Kampanya Öncesi Bulunan Riskler

### 🟠 [TAKİP] 0 Impression — Multi-Country Genişletme + Düşük tCPA (2026-06-06)

**Tespit:** 2026-06-05 ile 2026-06-07 arası kampanya `Running` durumunda ancak:
- **0 impression**
- **$0.00 spend**
- Country: `Multiple 8` (sarı uyarı işareti aktif)
- Status: 🟢 Running

**Plan sapması:** Orijinal plan TR-only tek ad group testiydi. App TR App Store'da yayında olmadığı için kullanıcı 8 farklı ülkeye genişletti — fakat tCPA ve ad group yapısı bu genişletmeye göre revize edilmedi.

**Root cause hipotezleri (öncelik sırasıyla):**

1. **tCPA $1.50 USD pahalı pazarlar için absürd düşük (en güçlü)**
   - US/UK/DE gibi pazarlarda dating CPA tipik aralığı $2-12
   - Spend tam $0.00 = "hiç bid atılmadı" demek (kaybedilen auction olsaydı en az birkaç impression görülürdü)
   - Maximize Conversions auto-bidder tCPA hedefinin altında auction bulamayınca pas geçiyor

2. **Country eligibility** — Eklenen 8 ülkenin hepsi App Store'da "Available for Sale" olmayabilir (sarı uyarı bunu işaret ediyor olabilir)

3. **Currency yanılsaması** — Hesap currency'si USD değilse $1.50 yerine başka birim olarak yorumlanmış olabilir

4. **Tek ad group ile çok pazar** — TR-only için tek ad group doğru karardı, ancak 8 farklı CPA pazarını tek tCPA ile yönetmek imkânsız (her pazarın gerçek CPA'sı farklı)

**Alınan aksiyon (2026-06-06):**
- [x] Bütçe / bid revize edildi (yeni değerler retest sonrası işlenecek)
- [ ] **+24h** — Retest sonucu: impression / spend metriklerini buraya işle
- [ ] Sarı country uyarısı içeriği kontrol edilecek (hangi ülke ineligible?)
- [ ] App Store Connect → Pricing and Availability → 8 ülkenin gerçekten "Available" olduğu doğrulanacak
- [ ] 7 günde hâlâ impression yoksa → Maximize Conversions → Fixed Bid (Manage Bids) stratejisine geçilecek

**Öğrenilen kural (genel):**
> Multi-country kampanyada tek tCPA + tek ad group yapısı çalışmaz. Her pazarın gerçek CPA'sı farklı. TR-only test için "tek ad group" doğru karardı; pazar genişletmesi her zaman ya **pazar başına ayrı ad group** ya da **ülke başına ayrı kampanya** gerektirir.

---

### 🔴 [ÇÖZÜLDÜ] gender_type enum bug (2026-06-04)

**Tespit:** Railway production loglarında 7 günde 5× `[completeProfile] Update failed: invalid input value for enum gender_type: "OTHER"`

**Root cause:**
- Mobile UI (`register_step_gender.dart`) → MAN/WOMAN/OTHER seçenekleri sunuyor
- Server validator (`auth.validator.ts`, `user.validator.ts`) → MAN/WOMAN/OTHER kabul ediyor
- DB enum `gender_type` → sadece `{MAN, WOMAN}` (OTHER yok)

**Etki:** ASA'dan gelecek install'larda "Other" cinsiyet seçen kullanıcılar profile completion'da stuck kalırdı → ölü conversion, boşa CPA.

**Fix:** Migration `024_gender_other.sql` — `ALTER TYPE gender_type ADD VALUE 'OTHER'`
- Supabase'e uygulandı, enum doğrulandı: `{MAN, WOMAN, OTHER}` ✅
- Commit: `fc1dd01` (qulo-server main)
- Railway auto-deploy tetiklendi

**Açık takip:** Discover/matching algoritması OTHER kullanıcıları nasıl ele alıyor? `gender_pref_type = {MAN, WOMAN, BOTH}` — OTHER user'lar şu an discover'da görünmüyor olabilir. Inclusivity için ayrı feature planı gerekebilir.

---

### 🟢 [HAZIR] Dinamik Push Notification Sistemi (2026-06-08 canlı)

Phase 1 production'da. Push notification metinleri admin panelden (`/admin/push-messages`) deploy gerektirmeden değiştirilebiliyor.

**ASA kampanyası için anlamı:** Kötü performans gösteren bir push 2 dakikada A→B'ye geçirilebilir. is_active=false ile bir tipi tamamen susturabilirsin.

**Editlenebilir 6 tip:** `new_message`, `new_message_image`, `new_match`, `new_match_solver`, `new_match_badge`, `chat_question_answered`.

**Detay:**
- Spec: `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`
- Closing spec: `docs/superpowers/specs/2026-06-08-push-panel-phase1-closing-design.md`
- Admin guide: `qulo-server/docs/admin-push-messages-guide.md`

---

_Son güncelleme: 2026-06-06 — Multi-country genişletme + 0 impression incident, bid revize, retest sürüyor_
