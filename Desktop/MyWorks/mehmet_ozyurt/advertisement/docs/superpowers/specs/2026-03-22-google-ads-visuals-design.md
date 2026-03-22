# Google Ads Goerselleri — TabuL

## Ozet

Excel dosyasindaki (GoogleAds_Görseller_TabuL.xlsx) 20 satirdaki Google Ads goersellerini, mevcut brand asset'leri kullanarak HTML/CSS ile olusturup Puppeteer ile PNG'ye cevirme sistemi.

**Yaklasim:** AI gorsel uretimi YOK. Tamamen mevcut asset'ler (logo, kart gorselleri, app screenshot'lari, video frame'leri) + HTML/CSS kompozisyon + metin overlay.

**Referans:** temp1/iphone_6_7/index.html stil ve pattern'leri (brand shapes, gradient bg, glassmorphism, Poppins font).

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
      02_square_tr.png
      ...
      20_landscape_global.png
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
- Google Fonts Poppins: weight 600, 700, 800, 900
- Fallback: Inter (assets/fonts/)

### Renk Paleti (brand_config.json)
- Primary Red: `#E8637A` — vurgu metinler, CTA
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

---

## Template Detaylari

### 1. Square Template (1080x1080) — 8 gorsel

Her gorsel `data-ad-id` attribute ile secilir. Template icindeki layout CSS `[data-ad-id="X"]` selector'leri ile degisir.

| ID | Dil | Metin | Layout | Asset |
|----|-----|-------|--------|-------|
| 1 | EN | Create Any Deck with AI | Sol metin (60%) + sag kart fan (40%) | `img_three_tabul_color.png` |
| 2 | TR | Istedigin Konuda Deste Yarat | Ust metin + alt phone mockup | `6_02.png` (phone frame icinde) |
| 3 | DE | Dein Thema, Dein Spiel | Merkez metin + 3 floating kart | `img_tabul_card_front.png` x3 rotated |
| 4 | ES | Barajas Infinitas con IA! | Sol metin + sag screenshot tilted | `6_01.jpg` |
| 5 | FR | Creez vos decks avec l'IA | Neon cizgi efekt + merkez metin | Shapes + gradient glow |
| 6 | IT | Non limitarti a carte fisse | Split: metin sol, screenshot sag | `6_04.png` |
| 7 | PT | Diversao com Amigos | Ust metin + alt kart spread | `img_three_gold_back.png` |
| 8 | Global | (Sadece Logo) | Premium glassmorphism app icon | `app_icon.png` + CSS glow |

### 2. Portrait Template (1080x1350) — 6 gorsel

| ID | Dil | Metin | Layout | Asset |
|----|-----|-------|--------|-------|
| 9 | EN | Ready for Party Chaos? | Ust buyuk metin + alt phone mockup | `6_03.png` phone frame icinde |
| 10 | TR | Sabit Deste Devri Bitti | Split dikey: sol gri eski / sag renkli AI | `Red_TabuLCard.png` vs `img_tabul_card_front.png` |
| 11 | Global | (Sadece Logo) | Screenshot arka plan blur + logo merkez | `6_01.jpg` blurred bg |
| 12 | EN | Unlimited AI Decks | Floating niche topic kartlari | `img_tabul_folder_*` cesitli renkler |
| 13 | Global | (Sadece Logo) | AI uretim ekrani + logo | `6_02.png` + logo overlay |
| 14 | EN | No More Memorizing | Kirik fiziksel kart vs telefon | `img_three_tabul_back.png` soluk + phone mockup |

### 3. Landscape Template (1200x628) — 6 gorsel

| ID | Dil | Metin | Layout | Asset |
|----|-----|-------|--------|-------|
| 15 | TR | Sinirsiz Eglence Basladi | Sol metin (45%) + sag genis screenshot | `6_05.png` |
| 16 | EN | Challenge Your Friends | Tema kartlari banner: folder'lar yan yana | `img_tabul_folder_*` (bronze/silver/gold) |
| 17 | Global | (Sadece Logo) | Minimal: logo + kart fan sag | `img_three_tabul_color.png` |
| 18 | EN | The Ultimate Word Game | Dinamik collage: kucuk thumbnail'ler | `6_01-05` screenshots |
| 19 | Global | (Sadece Logo) | Store CTA banner: icon sol, badge'ler sag | `app_icon.png` + store badge SVG |
| 20 | Global | (Sadece Logo) | Cauldron sahne: video frame crop | `temp5/frames/frame_00700.png` + logo |

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
      "subtext": "",
      "layout": "text-left-asset-right",
      "assets": {
        "primary": "images/png/img_three_tabul_color.png"
      },
      "logo": true,
      "output_name": "01_square_en"
    }
  ]
}
```

Her entry'nin alanlari:
- `id`: Excel satir numarasi
- `template`: "square" | "portrait" | "landscape"
- `width`, `height`: Piksel boyutlari
- `lang`: Dil kodu (en/tr/de/es/fr/it/pt/global)
- `text`: Ana metin ("(Sadece Logo)" ise bos)
- `subtext`: Varsa alt metin
- `layout`: Template icindeki layout varyasyonu
- `assets.primary`: Ana gorsel path (base_asset_path'e relative)
- `assets.secondary`: Opsiyonel ikinci gorsel
- `logo`: Logo gosterilsin mi
- `output_name`: Cikti dosya adi (uzantisiz)

---

## Capture Script (capture.mjs)

temp5/capture.mjs pattern'ini baz alir:

```
1. config.json oku
2. Her ad entry icin:
   a. Dogru template HTML'i sec
   b. Puppeteer ile ac (viewport: width x height)
   c. URL hash ile ad ID'yi gecir (#ad=1)
   d. Template JS'i hash'ten ID'yi okur, ilgili layout'u aktif eder
   e. 500ms bekle (font yuklenmesi)
   f. Screenshot al → output/{output_name}.png
3. Browser'i kapat
```

### Paralel Calistirma

Script seri calisir ama hizli (~1sn/gorsel). 20 gorsel icin ~20sn.

Alternatif: 20 subagent her biri 1 gorsel olusturur (HTML + capture). Ama template paylasimi nedeniyle seri daha mantikli.

**Onerilen subagent dagitimi:**
- 3 subagent: Her biri 1 template HTML'i olusturur (square, portrait, landscape) — paralel
- 1 subagent: config.json + capture.mjs olusturur
- 1 subagent: Tum render'lari calistirir ve dogrular

Toplam: 5 subagent (3 paralel template + 1 config + 1 render)

---

## Logo Kullanimi

- **Text logo** (`img_logo.png`): Metin iceren goersellerde sol ust veya ust merkez
- **App icon** (`app_icon.png`): "Sadece Logo" goersellerinde buyuk merkez
- **SVG logo** (`ic_tabul.svg`): Kucuk badge olarak gerektiginde

---

## Mevcut Asset Envanteri

### Kullanilacak Gorseller
| Asset | Kullanim Yeri |
|-------|---------------|
| `app_icon.png` | Logo goerselleri (8, 11, 13, 17, 19, 20) |
| `img_logo.png` | Text logo, tum goersellerde |
| `img_three_tabul_color.png` | Kart fan (1, 17) |
| `img_tabul_card_front.png` | Floating kartlar (3, 10) |
| `img_three_gold_back.png` | Kart spread (7) |
| `img_three_tabul_back.png` | Eski kart konsepti (14) |
| `img_tabul_folder_back_bronze.png` | Tema kartlari (12, 16) |
| `img_tabul_folder_back_silver.png` | Tema kartlari (12, 16) |
| `img_tabul_folder_gold.png` | Tema kartlari (12, 16) |
| `Red_TabuLCard.png` | Eski vs yeni karsilastirma (10) |
| `6_01.jpg` | Screenshot: ana ekran (4, 11, 18) |
| `6_02.png` | Screenshot: AI uretim (2, 13, 18) |
| `6_03.png` | Screenshot: gameplay (9, 18) |
| `6_04.png` | Screenshot: sonuc ekrani (6, 18) |
| `6_05.png` | Screenshot: deste listesi (15, 18) |
| `temp5/frames/frame_00700.png` | Video frame: cauldron sahnesi (20) |

### Brand Shapes (assets/shapes/)
- ellipse_*.svg — yuvarlak dekoratif seklller
- polygon_*.svg — ucgen/cokgen seklller
- vector_*.svg — dalga/cizgi seklller

---

## Basari Kriterleri

1. 20 PNG dosyasi dogru boyutlarda uretilmis olmali
2. Her gorsel brand tutarliligi tasimali (renk paleti, font, shapes)
3. Metinler okunakli ve dogru dilde olmali
4. Logo tum goersellerde gorunur olmali
5. Goerseller Google Ads spec'lerine uygun olmali (dosya boyutu < 150KB ideal)
6. temp1 kalitesinde premium his vermeli
