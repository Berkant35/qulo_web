# Google Ads Goerselleri — TabuL

## Ozet

Excel dosyasindaki (GoogleAds_Görseller_TabuL.xlsx) 20 satirdaki Google Ads goersellerini, mevcut brand asset'leri kullanarak HTML/CSS ile olusturup Puppeteer ile PNG'ye cevirme sistemi.

**Yaklasim:** AI gorsel uretimi YOK. Tamamen mevcut asset'ler (logo, kart gorselleri, app screenshot'lari, video frame'leri) + HTML/CSS kompozisyon + metin overlay.

**Referans:** temp1/iphone_6_7/index.html stil ve pattern'leri (brand shapes, gradient bg, glassmorphism, Poppins font).

**CTA Karari:** Gorsellerin uzerinde CTA butonu (Download Now vb.) YOK. Google Ads platformu kendi CTA butonunu ekler. Goerseller sadece marka mesaji + gorsel tasir.

---

## Dosya Yapisi

```
advertisement/
  google_ads/
    config.json                    # 20 satirlik master config
    templates/
      _base.css                    # Ortak stiller (shapes, fonts, renkler)
      square.html                  # 1080x1080 (satir 1-8)
      portrait.html                # 1080x1350 (satir 9-14)
      landscape.html               # 1200x628 (satir 15-20)
    capture.mjs                    # Puppeteer render script
    package.json                   # puppeteer dependency
    output/                        # Uretilen PNG'ler
      01_square_en.png
      ...
      20_landscape_global.png
    preview.html                   # Tum 20 gorseli grid'de gosteren QA sayfasi
```

---

## Ortak Stil (temp1 referansli)

Tum template'lerde kullanilacak ortak pattern'ler:

### Arka Plan
- Koyu gradient: `#1a1f3d` → `#2D3561`
- Bazi goersellerde varyasyon: `#2D3561` → `#3a4080`

### Brand Shapes
- `assets/shapes/` altindaki SVG dosyalari (ellipse, polygon, vector)
- Random pozisyonlarda, dusuk opacity (0.15-0.35)
- temp1'deki `.sh` class pattern'i: `position: absolute; opacity: var(--op, 0.5);`

### Font
- **Birincil:** Google Fonts Poppins (weight 600, 700, 800, 900)
- **Yukleme:** `@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800;900&display=swap')` — template HTML'in `<head>` icinde
- **Capture:** Puppeteer `--allow-running-insecure-content` ile acilir ve Google Fonts CDN'den yukler. capture.mjs icinde `waitForFunction(() => document.fonts.ready)` ile font yuklenmesi garanti edilir
- **Fallback:** Inter (assets/fonts/) — CDN erisimi olmazsa

### Renk Paleti (brand_config.json)
- Primary Red: `#E8637A` — vurgu metinler
- Dark Blue: `#2D3561` — arka plan
- Lavender: `#8188C9` — ikincil vurgu
- Cream: `#FCC1A2` — dekoratif
- White: `#FFFFFF` — ana metin
- Dark BG: `#1a1f3d` — gradient bas

### Efektler
- Glassmorphism: `backdrop-filter: blur(20px); background: rgba(255,255,255,0.08);`
- Text glow: `text-shadow: 0 0 30px rgba(232,99,122,0.5);`
- Card shadow: `box-shadow: 0 12px 40px rgba(0,0,0,0.25);`
- Logo drop-shadow: `filter: drop-shadow(0 30px 80px rgba(0,0,0,0.5));`

### Phone Mockup (CSS-only)
Ad #2, #9, #14'te kullanilacak telefon cercevesi tamamen CSS ile olusturulur:
- `border-radius: 40px; border: 4px solid #444; background: #000;`
- Notch: pseudo-element `::before`
- Ekran icerigi: screenshot `object-fit: cover` ile yerlestirilir
- temp1'deki `.phone` class pattern'i referans alinir

---

## Asset Path Haritasi

**ONEMLI:** Asset'ler iki farkli klasorde bulunur:

| Tur | Base Path (config.base_asset_path'e relative) |
|-----|----------------------------------------------|
| Kart gorselleri, logo | `images/png/` |
| App screenshot'lari | `images/advertising/` |
| SVG ikonlar | `images/svg/` |
| Brand shapes | `shapes/` |
| Video frame'ler | Path: `../../temp5/frames/` (google_ads/ klasorune relative) |

---

## Layout Tanimlari

Her template icinde kullanilacak layout key'leri:

| Layout Key | Aciklama |
|-----------|----------|
| `text-left-asset-right` | Sol %55 metin, sag %45 gorsel |
| `text-top-asset-bottom` | Ust metin, alt gorsel (phone mockup veya kart) |
| `center-text-floating` | Merkez metin, etrafinda floating kartlar |
| `text-left-screenshot-right` | Sol metin, sag tilted screenshot |
| `center-glow` | Merkez metin, neon/glow efekt, shapes yoagun |
| `split-vertical` | Dikey ikiye bolunmus: sol eski/sag yeni |
| `blur-bg-logo-center` | Blurlanmis screenshot bg + buyuk logo merkez |
| `screenshot-logo-overlay` | Screenshot bg + logo overlay |
| `floating-folders` | Floating folder kartlari grid |
| `old-vs-new` | Soluk eski kart + parlak phone mockup |
| `glassmorphism-icon` | Premium glassmorphism efektli app icon |
| `text-left-wide-screenshot` | Sol %40 metin, sag %60 genis screenshot |
| `folder-banner` | Yan yana folder kartlari banner |
| `minimal-logo-asset` | Minimal: logo sol, kart fan sag |
| `collage` | Kucuk thumbnail'ler collage |
| `store-cta` | App icon sol + store badge CSS sag |
| `frame-crop-logo` | Video frame crop bg + logo overlay |

---

## Template Detaylari

### 1. Square Template (1080x1080) — 8 gorsel

| ID | Dil | Metin | Layout Key | Primary Asset | Secondary Asset |
|----|-----|-------|-----------|---------------|-----------------|
| 1 | EN | Create Any Deck with AI | `text-left-asset-right` | `images/png/img_three_tabul_color.png` | — |
| 2 | TR | Istedigin Konuda Deste Yarat | `text-top-asset-bottom` | `images/advertising/6_02.png` | — |
| 3 | DE | Dein Thema, Dein Spiel | `center-text-floating` | `images/png/img_tabul_card_front.png` | — |
| 4 | ES | Barajas Infinitas con IA! | `text-left-screenshot-right` | `images/advertising/6_01.jpg` | — |
| 5 | FR | Creez vos decks avec l'IA | `center-glow` | — | — |
| 6 | IT | Non limitarti a carte fisse | `text-left-screenshot-right` | `images/advertising/6_04.png` | — |
| 7 | PT | Diversao com Amigos | `text-top-asset-bottom` | `images/png/img_three_gold_back.png` | — |
| 8 | Global | — | `glassmorphism-icon` | `images/png/app_icon.png` | — |

### 2. Portrait Template (1080x1350) — 6 gorsel

| ID | Dil | Metin | Layout Key | Primary Asset | Secondary Asset |
|----|-----|-------|-----------|---------------|-----------------|
| 9 | EN | Ready for Party Chaos? | `text-top-asset-bottom` | `images/advertising/6_03.png` | — |
| 10 | TR | Sabit Deste Devri Bitti | `split-vertical` | `images/png/img_tabul_card_front.png` | `images/png/Red_TabuLCard.png` |
| 11 | Global | — | `blur-bg-logo-center` | `images/advertising/6_01.jpg` | — |
| 12 | EN | Unlimited AI Decks | `floating-folders` | `images/png/img_tabul_folder_back_bronze.png` | `images/png/img_tabul_folder_back_silver.png` |
| 13 | Global | — | `screenshot-logo-overlay` | `images/advertising/6_02.png` | — |
| 14 | EN | No More Memorizing | `old-vs-new` | `images/png/img_three_tabul_back.png` | `images/advertising/6_03.png` |

### 3. Landscape Template (1200x628) — 6 gorsel

| ID | Dil | Metin | Layout Key | Primary Asset | Secondary Asset |
|----|-----|-------|-----------|---------------|-----------------|
| 15 | TR | Sinirsiz Eglence Basladi | `text-left-wide-screenshot` | `images/advertising/6_05.png` | — |
| 16 | EN | Challenge Your Friends | `folder-banner` | `images/png/img_tabul_folder_back_bronze.png` | `images/png/img_tabul_folder_back_silver.png` |
| 17 | Global | — | `minimal-logo-asset` | `images/png/img_three_tabul_color.png` | — |
| 18 | EN | The Ultimate Word Game | `collage` | `images/advertising/6_01.jpg` | `images/advertising/6_02.png` |
| 19 | Global | — | `store-cta` | `images/png/app_icon.png` | — |
| 20 | Global | — | `frame-crop-logo` | `../../temp5/frames/frame_00700.png` | — |

**Ad #12 ek asset:** `images/png/img_tabul_folder_gold.png` (config'de `assets.tertiary` olarak)
**Ad #18 ek asset'ler:** `images/advertising/6_03.png`, `images/advertising/6_04.png`, `images/advertising/6_05.png` (config'de `assets.extras[]` olarak)

---

## Config Yapisi (config.json)

```json
{
  "base_asset_path": "../assets",
  "output_dir": "output",
  "ads": [
    {
      "id": 1,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "en",
      "text": "Create Any Deck with AI",
      "layout": "text-left-asset-right",
      "assets": {
        "primary": "images/png/img_three_tabul_color.png"
      },
      "logo": true,
      "output_name": "01_square_en"
    },
    {
      "id": 2,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "tr",
      "text": "\u0130stedi\u011fin Konuda Deste Yarat",
      "layout": "text-top-asset-bottom",
      "assets": {
        "primary": "images/advertising/6_02.png"
      },
      "logo": true,
      "output_name": "02_square_tr"
    },
    {
      "id": 3,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "de",
      "text": "Dein Thema, Dein Spiel",
      "layout": "center-text-floating",
      "assets": {
        "primary": "images/png/img_tabul_card_front.png"
      },
      "logo": true,
      "output_name": "03_square_de"
    },
    {
      "id": 4,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "es",
      "text": "\u00a1Barajas Infinitas con IA!",
      "layout": "text-left-screenshot-right",
      "assets": {
        "primary": "images/advertising/6_01.jpg"
      },
      "logo": true,
      "output_name": "04_square_es"
    },
    {
      "id": 5,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "fr",
      "text": "Cr\u00e9ez vos decks avec l'IA",
      "layout": "center-glow",
      "assets": {},
      "logo": true,
      "output_name": "05_square_fr"
    },
    {
      "id": 6,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "it",
      "text": "Non limitarti a carte fisse",
      "layout": "text-left-screenshot-right",
      "assets": {
        "primary": "images/advertising/6_04.png"
      },
      "logo": true,
      "output_name": "06_square_it"
    },
    {
      "id": 7,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "pt",
      "text": "Divers\u00e3o com Amigos",
      "layout": "text-top-asset-bottom",
      "assets": {
        "primary": "images/png/img_three_gold_back.png"
      },
      "logo": true,
      "output_name": "07_square_pt"
    },
    {
      "id": 8,
      "template": "square",
      "width": 1080,
      "height": 1080,
      "lang": "global",
      "text": "",
      "layout": "glassmorphism-icon",
      "assets": {
        "primary": "images/png/app_icon.png"
      },
      "logo": false,
      "output_name": "08_square_global"
    },
    {
      "id": 9,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "en",
      "text": "Ready for Party Chaos?",
      "layout": "text-top-asset-bottom",
      "assets": {
        "primary": "images/advertising/6_03.png"
      },
      "logo": true,
      "output_name": "09_portrait_en"
    },
    {
      "id": 10,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "tr",
      "text": "Sabit Deste Devri Bitti",
      "layout": "split-vertical",
      "assets": {
        "primary": "images/png/img_tabul_card_front.png",
        "secondary": "images/png/Red_TabuLCard.png"
      },
      "logo": true,
      "output_name": "10_portrait_tr"
    },
    {
      "id": 11,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "global",
      "text": "",
      "layout": "blur-bg-logo-center",
      "assets": {
        "primary": "images/advertising/6_01.jpg"
      },
      "logo": true,
      "output_name": "11_portrait_global"
    },
    {
      "id": 12,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "en",
      "text": "Unlimited AI Decks",
      "layout": "floating-folders",
      "assets": {
        "primary": "images/png/img_tabul_folder_back_bronze.png",
        "secondary": "images/png/img_tabul_folder_back_silver.png",
        "tertiary": "images/png/img_tabul_folder_gold.png"
      },
      "logo": true,
      "output_name": "12_portrait_en"
    },
    {
      "id": 13,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "global",
      "text": "",
      "layout": "screenshot-logo-overlay",
      "assets": {
        "primary": "images/advertising/6_02.png"
      },
      "logo": true,
      "output_name": "13_portrait_global"
    },
    {
      "id": 14,
      "template": "portrait",
      "width": 1080,
      "height": 1350,
      "lang": "en",
      "text": "No More Memorizing",
      "layout": "old-vs-new",
      "assets": {
        "primary": "images/png/img_three_tabul_back.png",
        "secondary": "images/advertising/6_03.png"
      },
      "logo": true,
      "output_name": "14_portrait_en"
    },
    {
      "id": 15,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "tr",
      "text": "S\u0131n\u0131rs\u0131z E\u011flence Ba\u015flad\u0131",
      "layout": "text-left-wide-screenshot",
      "assets": {
        "primary": "images/advertising/6_05.png"
      },
      "logo": true,
      "output_name": "15_landscape_tr"
    },
    {
      "id": 16,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "en",
      "text": "Challenge Your Friends",
      "layout": "folder-banner",
      "assets": {
        "primary": "images/png/img_tabul_folder_back_bronze.png",
        "secondary": "images/png/img_tabul_folder_back_silver.png",
        "tertiary": "images/png/img_tabul_folder_gold.png"
      },
      "logo": true,
      "output_name": "16_landscape_en"
    },
    {
      "id": 17,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "global",
      "text": "",
      "layout": "minimal-logo-asset",
      "assets": {
        "primary": "images/png/img_three_tabul_color.png"
      },
      "logo": true,
      "output_name": "17_landscape_global"
    },
    {
      "id": 18,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "en",
      "text": "The Ultimate Word Game",
      "layout": "collage",
      "assets": {
        "primary": "images/advertising/6_01.jpg",
        "secondary": "images/advertising/6_02.png",
        "extras": [
          "images/advertising/6_03.png",
          "images/advertising/6_04.png",
          "images/advertising/6_05.png"
        ]
      },
      "logo": true,
      "output_name": "18_landscape_en"
    },
    {
      "id": 19,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "global",
      "text": "",
      "layout": "store-cta",
      "assets": {
        "primary": "images/png/app_icon.png"
      },
      "logo": true,
      "output_name": "19_landscape_global"
    },
    {
      "id": 20,
      "template": "landscape",
      "width": 1200,
      "height": 628,
      "lang": "global",
      "text": "",
      "layout": "frame-crop-logo",
      "assets": {
        "primary": "../../temp5/frames/frame_00700.png"
      },
      "logo": true,
      "output_name": "20_landscape_global"
    }
  ]
}
```

---

## Ad #19 Store Badge Cozumu

App Store ve Google Play badge'leri harici asset olarak indirilmeyecek. Bunlar **tamamen CSS/HTML ile** olusturulacak:
- Apple ikonu: `assets/images/svg/ic_apple.svg` (mevcut)
- Google ikonu: `assets/images/svg/ic_google.svg` (mevcut)
- Badge container: CSS rounded rect + ikon + "App Store" / "Google Play" metni
- Bu yaklasim harici asset gerektirmez ve mevcut SVG'leri kullanir

---

## Logo Kullanimi

- **Text logo** (`images/png/img_logo.png`): Metin iceren goersellerde sol ust veya ust merkez
- **App icon** (`images/png/app_icon.png`): "Sadece Logo" goersellerinde buyuk merkez (ad #8, #11, #13, #17, #19, #20)
- **SVG logo** (`images/svg/ic_tabul.svg`): Kucuk badge olarak, ozellikle screenshot overlay goersellerinde

---

## Capture Script (capture.mjs)

temp5/capture.mjs pattern'ini baz alir:

```
1. config.json oku
2. Asset path dogrulamasi: Tum referans edilen dosyalarin varligini kontrol et, eksik varsa hata ver (fail-fast)
3. Her ad entry icin:
   a. Dogru template HTML'i sec
   b. Puppeteer ile ac (viewport: width x height)
   c. URL hash ile ad ID'yi gecir (#ad=1)
   d. Template JS'i hash'ten ID'yi okur, ilgili layout'u aktif eder
   e. document.fonts.ready bekle (font yuklenmesi garanti)
   f. Ek 300ms bekle (render tamamlanmasi)
   g. Screenshot al → output/{output_name}.png
4. Post-capture:
   a. Her PNG'nin boyut kontrolu (warning: >150KB, error: >500KB)
   b. Her PNG'nin piksel boyut kontrolu (width x height eslesmesi)
   c. Ozet rapor yazdir
5. Browser'i kapat
```

### Paralel Calistirma

Script seri calisir ama hizli (~1sn/gorsel). 20 gorsel icin ~20sn.

**Onerilen subagent dagitimi:**
- **Phase 1 (paralel):** 3 subagent template HTML + 1 subagent config.json/capture.mjs/package.json
- **Phase 2 (seri):** 1 subagent tum render'lari calistirir, preview.html olusturur, QA kontrol

Toplam: 5 subagent (4 paralel + 1 render/QA)

---

## QA ve Preview

`preview.html` dosyasi:
- Tum 20 gorseli 4 sutunlu grid'de gosterir
- Her gorsel altinda: ID, boyut, dil, dosya boyutu
- Tarayicida acilip manuel kontrol yapilir
- capture.mjs tarafindan otomatik olusturulur

---

## Mevcut Asset Envanteri

### Kullanilacak Gorseller
| Asset | Tam Path (base_asset_path relative) | Kullanim |
|-------|-------------------------------------|----------|
| App icon | `images/png/app_icon.png` | Logo goerselleri (8, 11, 13, 17, 19, 20) |
| Text logo | `images/png/img_logo.png` | Tum metin goerselleri |
| SVG logo | `images/svg/ic_tabul.svg` | Badge overlay |
| Apple SVG | `images/svg/ic_apple.svg` | Ad #19 store badge |
| Google SVG | `images/svg/ic_google.svg` | Ad #19 store badge |
| Kart fan (renkli) | `images/png/img_three_tabul_color.png` | Ad 1, 17 |
| Kart on yuz | `images/png/img_tabul_card_front.png` | Ad 3, 10 |
| Kart arka (gold) | `images/png/img_three_gold_back.png` | Ad 7 |
| Kart arka (standart) | `images/png/img_three_tabul_back.png` | Ad 14 |
| Folder bronze | `images/png/img_tabul_folder_back_bronze.png` | Ad 12, 16 |
| Folder silver | `images/png/img_tabul_folder_back_silver.png` | Ad 12, 16 |
| Folder gold | `images/png/img_tabul_folder_gold.png` | Ad 12, 16 |
| Red card | `images/png/Red_TabuLCard.png` | Ad 10 |
| SS: Ana ekran | `images/advertising/6_01.jpg` | Ad 4, 11, 18 |
| SS: AI uretim | `images/advertising/6_02.png` | Ad 2, 13, 18 |
| SS: Gameplay | `images/advertising/6_03.png` | Ad 9, 14, 18 |
| SS: Sonuc | `images/advertising/6_04.png` | Ad 6, 18 |
| SS: Deste listesi | `images/advertising/6_05.png` | Ad 15, 18 |
| Video frame | `../../temp5/frames/frame_00700.png` | Ad 20 |

### Brand Shapes (assets/shapes/)
- `ellipse_*.svg` — yuvarlak dekoratif sekiller
- `polygon_*.svg` — ucgen/cokgen sekiller
- `vector_*.svg` — dalga/cizgi sekiller

---

## Basari Kriterleri

1. 20 PNG dosyasi dogru boyutlarda uretilmis olmali
2. Her gorsel brand tutarliligi tasimali (renk paleti, font, shapes)
3. Metinler okunakli ve dogru dilde olmali
4. Logo tum goersellerde gorunur olmali
5. Goerseller Google Ads spec'lerine uygun olmali (warning: >150KB, max: 500KB)
6. temp1 kalitesinde premium his vermeli
7. capture.mjs asset dogrulamasi gecmeli (tum dosyalar mevcut)
8. preview.html ile tum goerseller tek sayfada gorsel kontrol yapilabilmeli
