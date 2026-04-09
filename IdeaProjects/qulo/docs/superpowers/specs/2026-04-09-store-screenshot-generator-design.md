# Store Screenshot Generator — Design Spec

**Tarih:** 2026-04-09
**Durum:** Onaylandı

## Özet

Next.js web projesine `/store-screenshots` sayfası eklenerek, manuel sağlanan uygulama ekran görüntülerinden App Store / Play Store pazarlama görselleri üretilecek. Basit bir araç — sadece üretim amaçlı.

## Ekranlar

5 adet screenshot üretilecek:

1. **Discover** — Ana keşif ekranı
2. **Soru Oluşturma** — Soru hazırlama akışı
3. **Chat** — Mesajlaşma ekranı
4. **Profil** — Kullanıcı profili
5. **Eşleşme** — Match ekranı

## Diller

16 dil desteklenecek: `tr`, `en`, `de`, `fr`, `es`, `ar`, `ru`, `pt`, `it`, `ja`, `ko`, `zh`, `nl`, `pl`, `sv`, `hi`

- Arapça (`ar`) RTL desteği gerektirir (metin hizalama + light streak yönü)

## Template Stili: Light Streak

- **Arka plan:** Saf siyah (`#050508`)
- **Light streak:** Çapraz ışık çizgisi — `linear-gradient` ile mor-mavi (`#667eea` → `#764ba2`), -35° açıyla, hafif blur
- **Telefon:** Koyu çerçeve, minimal border (`rgba(255,255,255,0.06)`), drop shadow
- **Tipografi:** Beyaz başlık (20px, weight 600, letter-spacing -0.3px), açıklama `rgba(255,255,255,0.35)` (12px, weight 300, letter-spacing 0.5px)
- **Başlık + açıklama:** Telefonun altında

## Screenshot Kaynağı

- Manuel PNG dosyaları olarak sağlanır
- Konum: `web/public/store-screenshots/{screen_name}.png`
- Dosya adları: `discover.png`, `question-create.png`, `chat.png`, `profile.png`, `match.png`

## Metin Kaynağı

Ayrı bir JSON dosyası: `web/src/data/store-screenshot-texts.json`

```json
{
  "discover": {
    "tr": { "title": "Keşfet", "subtitle": "Sorularla eşleş, birini bul" },
    "en": { "title": "Discover", "subtitle": "Match through questions, find someone" },
    ...
  },
  ...
}
```

## Export Boyutları

### Apple (zorunlu)
- iPhone 6.7": 1320 × 2868 px
- iPhone 6.5": 1284 × 2778 px
- iPhone 5.5": 1242 × 2208 px

### Apple (iPad — opsiyonel)
- iPad 12.9" (3rd gen): 2048 × 2732 px
- iPad 12.9" (6th gen): 2064 × 2752 px

### Google Play
- 1080 × 1920 px (veya benzeri 9:16)

## Sayfa Yapısı

`web/src/app/[locale]/store-screenshots/page.tsx`

### UI Bileşenleri

1. **Dil seçici** — Dropdown, 16 dil
2. **Ekran seçici** — 5 ekranı tab/buton ile geçiş
3. **Boyut seçici** — Export hedef boyutu
4. **Canlı preview** — Seçilen dil + ekran + boyutta template preview'ı
5. **Export butonu** — `html-to-image` ile PNG export (kullanıcı onayıyla)
6. **Toplu export** — Seçilen dil × tüm ekranlar × seçilen boyut (onay sonrası)

### Bileşen Ağacı

```
StoreScreenshotPage
├── ControlBar (dil, ekran, boyut seçicileri)
├── ScreenshotPreview (canlı preview)
│   └── PhoneMockup (telefon çerçevesi + screenshot)
└── ExportControls (tek export + toplu export butonları)
```

## PhoneMockup

- Skill'deki hazır iPhone 15 Pro mockup PNG'si kullanılır (`mockup.png`, 1022×2082px)
- Screen inset: left 52px, top 46px, width 918px, height 1990px
- Screenshot bu viewport'a yerleştirilir

## Teknik Detaylar

- **Export kütüphanesi:** `html-to-image` (npm install gerekli)
- **Font:** Mevcut web projesindeki fontlar
- **RTL:** Arapça seçildiğinde `dir="rtl"` + metin hizalama sağa + light streak yönü ayna
- **Export çift-çağrı:** `html-to-image` font rendering için iki kez çağrılır (ilki warm-up, ikincisi gerçek export — skill'de belgelenmiş trick)

## Kapsam Dışı

- Otomatik screenshot capture (simülatör/emülatör)
- CI/CD entegrasyonu
- Tema varyasyonları (sadece Light Streak)
- A/B test desteği
- Figma entegrasyonu
