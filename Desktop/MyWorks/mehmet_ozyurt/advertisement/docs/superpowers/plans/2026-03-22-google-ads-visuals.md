# Google Ads Visuals Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 20 Google Ads gorseli (3 boyut) mevcut brand asset'lerden HTML/CSS ile olusturup Puppeteer ile PNG'ye cevirmek.

**Architecture:** 3 HTML template (square/portrait/landscape) + config.json + Puppeteer capture script. Her template URL hash'ten ad ID alir, ilgili layout'u gosterir. Capture script sirayla 20 gorseli render eder.

**Tech Stack:** HTML/CSS (static), Puppeteer (puppeteer-core), Node.js, Google Fonts (Poppins)

**Spec:** `docs/superpowers/specs/2026-03-22-google-ads-visuals-design.md`

---

## File Structure

```
advertisement/google_ads/
  config.json                     # 20 ad entry — spec'ten birebir kopyalanacak
  package.json                    # puppeteer-core dependency
  capture.mjs                     # Puppeteer render + QA script
  preview.html                    # Output QA grid sayfasi
  templates/
    _base.css                     # Ortak stiller: shapes, fonts, renkler, efektler, phone mockup
    square.html                   # 1080x1080 — 8 layout (ad 1-8)
    portrait.html                 # 1080x1350 — 6 layout (ad 9-14)
    landscape.html                # 1200x628 — 6 layout (ad 15-20)
  output/                         # Uretilen PNG'ler (gitignore)
```

---

## Task 1: Proje Iskeleti (config.json + package.json)

**Files:**
- Create: `google_ads/config.json`
- Create: `google_ads/package.json`
- Create: `google_ads/output/.gitkeep`

- [ ] **Step 1: google_ads/ klasorunu ve output/ olustur**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/advertisement
mkdir -p google_ads/output google_ads/templates
touch google_ads/output/.gitkeep
```

- [ ] **Step 2: package.json olustur**

```json
{
  "name": "tabul-google-ads",
  "version": "1.0.0",
  "description": "TabuL Google Ads visual generator",
  "type": "module",
  "scripts": {
    "capture": "node capture.mjs",
    "capture:single": "node capture.mjs --id"
  },
  "dependencies": {
    "puppeteer-core": "^24.39.1"
  }
}
```

- [ ] **Step 3: config.json olustur**

Spec'teki tam 20 entry'lik JSON'u birebir kopyala. Dosya: `docs/superpowers/specs/2026-03-22-google-ads-visuals-design.md` satir 163-459.

- [ ] **Step 3b: .gitignore olustur (output PNG'leri haric tut)**

`google_ads/.gitignore`:
```
output/*.png
node_modules/
```

- [ ] **Step 4: npm install**

```bash
cd google_ads && npm install
```

Expected: `node_modules/` olusur, `puppeteer-core` yuklenir.

- [ ] **Step 5: Commit**

```bash
git add google_ads/package.json google_ads/config.json google_ads/output/.gitkeep google_ads/.gitignore
git commit -m "feat(ads): scaffold google_ads project with config and dependencies"
```

---

## Task 2: Base CSS (_base.css)

**Files:**
- Create: `google_ads/templates/_base.css`

Bu dosya tum template'lerde `<link rel="stylesheet">` ile import edilir. temp1 referansli.

- [ ] **Step 1: _base.css olustur**

Icermesi gereken bolumler (sirayla):

**Google Fonts import:**
```css
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800;900&display=swap');
```

**Reset + body base:**
```css
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
  overflow: hidden;
  font-family: 'Poppins', 'Inter', sans-serif;
  background: #1a1f3d;
  color: #FFFFFF;
}
```

**CSS custom properties (brand renkler):**
```css
:root {
  --red: #E8637A;
  --red-dark: #F35764;
  --blue: #2D3561;
  --blue-dark: #1a1f3d;
  --lavender: #8188C9;
  --cream: #FCC1A2;
  --white: #FFFFFF;
  --green: #4CAF50;
  --gold: #FFC91F;
}
```

**Brand shapes base class (temp1 pattern):**
```css
.sh {
  position: absolute;
  opacity: var(--op, 0.25);
  z-index: 1;
  pointer-events: none;
}
.sh img { width: 100%; height: 100%; }
```

**Text utility classes:**
```css
.text-red { color: var(--red); }
.text-glow { text-shadow: 0 0 30px rgba(232,99,122,0.5); }
.text-shadow { text-shadow: 0 4px 12px rgba(0,0,0,0.3); }
```

**Card/image shadow:**
```css
.card-shadow { box-shadow: 0 12px 40px rgba(0,0,0,0.25); }
.logo-shadow { filter: drop-shadow(0 8px 24px rgba(0,0,0,0.4)); }
```

**Glassmorphism utility:**
```css
.glass {
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 24px;
}
```

**Phone mockup (CSS-only, temp1 referansli):**
```css
.phone-frame {
  position: relative;
  background: #000;
  border-radius: 40px;
  border: 4px solid #444;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5), 0 0 0 2px #555;
}
.phone-frame::before {
  content: '';
  position: absolute;
  top: 0; left: 50%;
  transform: translateX(-50%);
  width: 120px; height: 28px;
  background: #000;
  border-radius: 0 0 16px 16px;
  z-index: 10;
}
.phone-frame img {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
}
```

**Logo positioning:**
```css
.logo-top-left {
  position: absolute;
  top: 40px; left: 40px;
  z-index: 10;
}
.logo-top-center {
  position: absolute;
  top: 40px; left: 50%;
  transform: translateX(-50%);
  z-index: 10;
}
.logo-center {
  position: absolute;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
  z-index: 10;
}
```

**Ad container (her template body'sinde kullanilir):**
```css
.ad {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  display: none; /* JS ile aktif olan gorunur */
}
.ad.active { display: block; }
```

**Gradient arka planlar:**
```css
.bg-dark { background: linear-gradient(180deg, #1a1f3d 0%, #2D3561 100%); }
.bg-blue { background: linear-gradient(180deg, #2D3561 0%, #3a4080 100%); }
.bg-dark-reverse { background: linear-gradient(180deg, #2D3561 0%, #1a1f3d 100%); }
```

**Store badge (Ad #19):**
```css
.store-badge {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: #000;
  border: 1.5px solid rgba(255,255,255,0.3);
  border-radius: 12px;
  padding: 12px 20px;
  color: #fff;
}
.store-badge img { width: 28px; height: 28px; }
.store-badge .store-label { font-size: 10px; opacity: 0.7; line-height: 1; }
.store-badge .store-name { font-size: 18px; font-weight: 700; line-height: 1; }
```

- [ ] **Step 2: Commit**

```bash
git add google_ads/templates/_base.css
git commit -m "feat(ads): add base CSS with brand styles, utilities, and phone mockup"
```

---

## Task 3: Square Template (square.html) — Ad 1-8

**Files:**
- Create: `google_ads/templates/square.html`

**Referans dosyalar (okumalisin):**
- `temp1/iphone_6_7/index.html` — shape yerlesimi, glassmorphism, metin stilleri
- `feature_graphic_v3.html` — kare kompozisyon ornegi
- `assets/brand_config.json` — asset path'leri

- [ ] **Step 1: square.html iskelet**

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="_base.css">
<style>
  body { width: 1080px; height: 1080px; }
  /* Layout-specific styles buraya */
</style>
</head>
<body>
  <!-- Ad 1-8 her biri .ad div icinde -->
  <script>
    const id = parseInt(location.hash.replace('#ad=','')) || 1;
    document.querySelectorAll('.ad').forEach(el => {
      el.classList.toggle('active', parseInt(el.dataset.adId) === id);
    });
  </script>
</body>
</html>
```

- [ ] **Step 2: 5 brand shape inline SVG ekle (tum ad'lerde ortak arka plan)**

Her square ad'in icine 5 dekoratif shape yerlestir. temp1 pattern'i:
- Ust sol: cream blob (`vector_42.svg` icerigi inline, opacity 0.2, w:140px)
- Alt sag: cream blob (ayni, rotate 180deg, opacity 0.15)
- Sol orta: lavender dalga (`vector_46.svg` inline, opacity 0.2)
- Sag ust: teal ucgen (`polygon_7.svg` inline, opacity 0.15)
- Alt sol: pembe daire (`ellipse_2102.svg` inline, fill #E8637A, opacity 0.15)

**NOT:** SVG'leri inline olarak yaz (img tag degil), boylece renk ve boyut CSS ile kontrol edilir. Her `.ad` div'inde bu 5 shape tekrarlanir.

- [ ] **Step 3: Ad 1 layout — `text-left-asset-right`**

```html
<div class="ad bg-dark" data-ad-id="1">
  <!-- shapes buraya -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:48px;">
  <div style="position:absolute; top:0; left:0; width:55%; height:100%; display:flex; flex-direction:column; justify-content:center; padding:60px; z-index:5;">
    <p style="font-size:18px; font-weight:600; color:var(--lavender); margin-bottom:12px; letter-spacing:3px;">POWERED BY AI</p>
    <h1 style="font-size:64px; font-weight:900; line-height:1.15; color:#fff;">Create Any<br>Deck with <span class="text-red text-glow">AI</span></h1>
  </div>
  <div style="position:absolute; top:50%; right:40px; transform:translateY(-50%); z-index:5;">
    <img src="../../assets/images/png/img_three_tabul_color.png" style="height:520px; filter:drop-shadow(0 15px 40px rgba(0,0,0,0.4));">
  </div>
</div>
```

- [ ] **Step 4: Ad 2 layout — `text-top-asset-bottom` (phone mockup)**

```html
<div class="ad bg-blue" data-ad-id="2">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <div style="position:absolute; top:60px; left:0; width:100%; text-align:center; z-index:5; padding:0 40px;">
    <h1 style="font-size:56px; font-weight:900; line-height:1.2;">İstediğin Konuda<br><span class="text-red text-glow">Deste Yarat</span></h1>
  </div>
  <div class="phone-frame" style="position:absolute; bottom:-80px; left:50%; transform:translateX(-50%); width:380px; height:760px; z-index:5;">
    <img src="../../assets/images/advertising/6_02.png">
  </div>
</div>
```

- [ ] **Step 5: Ad 3 layout — `center-text-floating`**

Merkez metin + 3 adet `img_tabul_card_front.png` farkli rotation'larla:
- Sol: rotate(-15deg), top:35%, left:5%
- Merkez arkada: rotate(0deg), top:30%, left:50% transform translateX(-50%), opacity 0.4, scale 0.85
- Sag: rotate(12deg), top:35%, right:5%

```html
<div class="ad bg-dark" data-ad-id="3">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-center" style="height:40px;">
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); text-align:center; z-index:8; width:80%;">
    <h1 style="font-size:60px; font-weight:900; line-height:1.2;">Dein Thema,<br><span class="text-red text-glow">Dein Spiel</span></h1>
  </div>
  <img src="../../assets/images/png/img_tabul_card_front.png" class="card-shadow" style="position:absolute; top:35%; left:5%; height:340px; transform:rotate(-15deg); z-index:3; opacity:0.7;">
  <img src="../../assets/images/png/img_tabul_card_front.png" class="card-shadow" style="position:absolute; top:30%; left:50%; transform:translateX(-50%) scale(0.85); height:340px; z-index:2; opacity:0.3;">
  <img src="../../assets/images/png/img_tabul_card_front.png" class="card-shadow" style="position:absolute; top:35%; right:5%; height:340px; transform:rotate(12deg); z-index:3; opacity:0.7;">
</div>
```

- [ ] **Step 6: Ad 4 layout — `text-left-screenshot-right`**

Sol metin + sag tilted screenshot. Ad 6 da ayni layout'u kullanir (farkli metin/asset).

```html
<div class="ad bg-dark" data-ad-id="4">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <div style="position:absolute; top:0; left:0; width:50%; height:100%; display:flex; flex-direction:column; justify-content:center; padding:50px; z-index:5;">
    <h1 style="font-size:52px; font-weight:900; line-height:1.2;">¡Barajas<br>Infinitas<br>con <span class="text-red text-glow">IA!</span></h1>
  </div>
  <div style="position:absolute; top:50%; right:30px; transform:translateY(-50%) rotate(3deg); z-index:5;">
    <div class="phone-frame" style="width:320px; height:640px;">
      <img src="../../assets/images/advertising/6_01.jpg">
    </div>
  </div>
</div>
```

- [ ] **Step 7: Ad 5 layout — `center-glow`**

Sade merkez metin + yoagun shapes + neon glow. Asset yok.

```html
<div class="ad bg-dark-reverse" data-ad-id="5">
  <!-- shapes: 8-10 adet, normalden daha yoagun, daha buyuk, opacity 0.3 -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-center" style="height:40px;">
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); text-align:center; z-index:8;">
    <h1 style="font-size:60px; font-weight:900; line-height:1.2; text-shadow: 0 0 40px rgba(232,99,122,0.6), 0 0 80px rgba(129,136,201,0.3);">Créez vos decks<br>avec <span class="text-red" style="text-shadow: 0 0 50px rgba(232,99,122,0.8);">l'IA</span></h1>
  </div>
  <!-- Buyuk gradient glow blob arkada -->
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); width:600px; height:600px; background:radial-gradient(circle, rgba(232,99,122,0.15) 0%, rgba(129,136,201,0.1) 40%, transparent 70%); z-index:2;"></div>
</div>
```

- [ ] **Step 8: Ad 6 layout — `text-left-screenshot-right` (Ad 4 ile ayni layout, farkli content)**

```html
<div class="ad bg-blue" data-ad-id="6">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <div style="position:absolute; top:0; left:0; width:50%; height:100%; display:flex; flex-direction:column; justify-content:center; padding:50px; z-index:5;">
    <h1 style="font-size:48px; font-weight:900; line-height:1.2;">Non limitarti<br>a carte <span class="text-red text-glow">fisse</span></h1>
  </div>
  <div style="position:absolute; top:50%; right:30px; transform:translateY(-50%) rotate(-2deg); z-index:5;">
    <div class="phone-frame" style="width:320px; height:640px;">
      <img src="../../assets/images/advertising/6_04.png">
    </div>
  </div>
</div>
```

- [ ] **Step 9: Ad 7 layout — `text-top-asset-bottom` (kart spread)**

```html
<div class="ad bg-dark" data-ad-id="7">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <div style="position:absolute; top:80px; left:0; width:100%; text-align:center; z-index:5; padding:0 40px;">
    <h1 style="font-size:58px; font-weight:900; line-height:1.2;">Diversão com<br><span class="text-red text-glow">Amigos</span></h1>
  </div>
  <div style="position:absolute; bottom:-20px; left:50%; transform:translateX(-50%); z-index:5;">
    <img src="../../assets/images/png/img_three_gold_back.png" style="height:480px; filter:drop-shadow(0 15px 40px rgba(0,0,0,0.4));">
  </div>
</div>
```

- [ ] **Step 10: Ad 8 layout — `glassmorphism-icon`**

Premium glassmorphism efekti icinde app icon. Logo gosterilmez (logo=false, icon zaten logo).

```html
<div class="ad bg-dark-reverse" data-ad-id="8">
  <!-- shapes: minimal, 3 adet kucuk -->
  <div class="glass" style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); width:400px; height:400px; border-radius:80px; display:flex; align-items:center; justify-content:center; z-index:5;">
    <img src="../../assets/images/png/app_icon.png" style="width:300px; height:300px; border-radius:60px; box-shadow: 0 20px 60px rgba(0,0,0,0.4);">
  </div>
  <!-- Arka plan gradient glow -->
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); width:700px; height:700px; background:radial-gradient(circle, rgba(232,99,122,0.12) 0%, rgba(129,136,201,0.08) 40%, transparent 70%); z-index:2;"></div>
  <!-- Alt metin -->
  <p style="position:absolute; bottom:80px; left:50%; transform:translateX(-50%); font-size:22px; font-weight:700; color:rgba(255,255,255,0.5); letter-spacing:4px; z-index:5;">AI WORD GAME</p>
</div>
```

- [ ] **Step 11: Test — square.html'i tarayicida ac**

```bash
open google_ads/templates/square.html#ad=1
```

Sirasyla `#ad=1` den `#ad=8`'e kadar kontrol et. Her layout dogru gorunmeli. Asset'ler yuklenmeli.

- [ ] **Step 12: Commit**

```bash
git add google_ads/templates/square.html
git commit -m "feat(ads): add square template with 8 layouts (1080x1080)"
```

---

## Task 4: Portrait Template (portrait.html) — Ad 9-14

**Files:**
- Create: `google_ads/templates/portrait.html`

**Referans dosyalar:**
- `temp1/iphone_6_7/index.html` — phone mockup, card layout
- `google_ads/templates/_base.css` — ortak stiller
- `google_ads/templates/square.html` — ayni pattern

- [ ] **Step 1: portrait.html iskelet**

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="_base.css">
<style>
  body { width: 1080px; height: 1350px; }
</style>
</head>
<body>
  <!-- Ad 9-14 -->
  <script>
    const id = parseInt(location.hash.replace('#ad=','')) || 9;
    document.querySelectorAll('.ad').forEach(el => {
      el.classList.toggle('active', parseInt(el.dataset.adId) === id);
    });
  </script>
</body>
</html>
```

- [ ] **Step 2: Ad 9 — `text-top-asset-bottom` (phone mockup)**

```html
<div class="ad bg-blue" data-ad-id="9">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <div style="position:absolute; top:60px; left:0; width:100%; text-align:center; z-index:5; padding:0 40px;">
    <h1 style="font-size:64px; font-weight:900; line-height:1.15;">Ready for<br><span class="text-red text-glow">Party Chaos?</span></h1>
  </div>
  <div class="phone-frame" style="position:absolute; bottom:-100px; left:50%; transform:translateX(-50%); width:400px; height:800px; z-index:5;">
    <img src="../../assets/images/advertising/6_03.png">
  </div>
</div>
```

- [ ] **Step 3: Ad 10 — `split-vertical`**

```html
<div class="ad" data-ad-id="10" style="display:none;">
  <img src="../../assets/images/png/img_logo.png" class="logo-top-center" style="height:40px; z-index:20;">
  <!-- Ust orta metin -->
  <div style="position:absolute; top:50px; left:0; width:100%; text-align:center; z-index:15; padding:0 40px;">
    <h1 style="font-size:52px; font-weight:900; line-height:1.2;">Sabit Deste<br>Devri <span class="text-red text-glow">Bitti</span></h1>
  </div>
  <!-- Sol: eski (gri/soluk) -->
  <div style="position:absolute; top:0; left:0; width:50%; height:100%; background:#2a2a3a; display:flex; align-items:center; justify-content:center; overflow:hidden;">
    <img src="../../assets/images/png/Red_TabuLCard.png" style="height:280px; opacity:0.4; filter:grayscale(100%); transform:rotate(-3deg);">
    <p style="position:absolute; bottom:40px; left:50%; transform:translateX(-50%); font-size:16px; font-weight:700; color:rgba(255,255,255,0.3); letter-spacing:4px;">ESKİ</p>
  </div>
  <!-- Sag: yeni (parlak) -->
  <div style="position:absolute; top:0; right:0; width:50%; height:100%; background:linear-gradient(180deg, #2D3561 0%, #3a4080 100%); display:flex; align-items:center; justify-content:center; overflow:hidden;">
    <img src="../../assets/images/png/img_tabul_card_front.png" style="height:360px; filter:drop-shadow(0 12px 30px rgba(0,0,0,0.4)); transform:rotate(3deg);">
    <p style="position:absolute; bottom:40px; left:50%; transform:translateX(-50%); font-size:16px; font-weight:700; color:var(--red); letter-spacing:4px;">YENİ</p>
  </div>
  <!-- Ortadaki ayirici cizgi -->
  <div style="position:absolute; top:0; left:50%; width:2px; height:100%; background:rgba(255,255,255,0.1); z-index:10;"></div>
</div>
```

- [ ] **Step 4: Ad 11 — `blur-bg-logo-center`**

```html
<div class="ad" data-ad-id="11" style="display:none;">
  <!-- Blurlanmis arka plan screenshot -->
  <img src="../../assets/images/advertising/6_01.jpg" style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover; filter:blur(12px) brightness(0.4); z-index:1; transform:scale(1.1);">
  <!-- Merkez app icon -->
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); z-index:5; text-align:center;">
    <img src="../../assets/images/png/app_icon.png" class="logo-shadow" style="width:280px; height:280px; border-radius:56px; box-shadow: 0 20px 60px rgba(0,0,0,0.5), 0 0 80px rgba(232,99,122,0.2);">
    <p style="margin-top:30px; font-size:24px; font-weight:700; color:rgba(255,255,255,0.6); letter-spacing:3px;">AI WORD GAME</p>
  </div>
</div>
```

- [ ] **Step 5: Ad 12 — `floating-folders`**

```html
<div class="ad bg-dark" data-ad-id="12">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-center" style="height:40px;">
  <div style="position:absolute; top:60px; left:0; width:100%; text-align:center; z-index:8; padding:0 40px;">
    <h1 style="font-size:56px; font-weight:900; line-height:1.2;">Unlimited<br><span class="text-red text-glow">AI Decks</span></h1>
  </div>
  <!-- Floating folder kartlari -->
  <img src="../../assets/images/png/img_tabul_folder_back_bronze.png" class="card-shadow" style="position:absolute; top:40%; left:10%; height:320px; transform:rotate(-8deg); z-index:4;">
  <img src="../../assets/images/png/img_tabul_folder_back_silver.png" class="card-shadow" style="position:absolute; top:35%; left:50%; transform:translateX(-50%) rotate(3deg); height:320px; z-index:5;">
  <img src="../../assets/images/png/img_tabul_folder_gold.png" class="card-shadow" style="position:absolute; top:42%; right:10%; height:320px; transform:rotate(10deg); z-index:4;">
</div>
```

- [ ] **Step 6: Ad 13 — `screenshot-logo-overlay`**

```html
<div class="ad" data-ad-id="13" style="display:none;">
  <!-- Screenshot arka plan -->
  <img src="../../assets/images/advertising/6_02.png" style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover; opacity:0.6; z-index:1;">
  <!-- Karartma gradient overlay -->
  <div style="position:absolute; top:0; left:0; width:100%; height:100%; background:linear-gradient(180deg, rgba(26,31,61,0.8) 0%, rgba(26,31,61,0.3) 40%, rgba(26,31,61,0.7) 100%); z-index:2;"></div>
  <!-- Merkez app icon -->
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); z-index:5; text-align:center;">
    <img src="../../assets/images/png/app_icon.png" class="logo-shadow" style="width:240px; height:240px; border-radius:48px;">
    <p style="margin-top:24px; font-size:22px; font-weight:700; color:rgba(255,255,255,0.5); letter-spacing:3px;">AI WORD GAME</p>
  </div>
</div>
```

- [ ] **Step 7: Ad 14 — `old-vs-new`**

```html
<div class="ad bg-dark" data-ad-id="14">
  <!-- shapes -->
  <div style="position:absolute; top:50px; left:0; width:100%; text-align:center; z-index:8; padding:0 40px;">
    <h1 style="font-size:56px; font-weight:900; line-height:1.2;">No More<br><span class="text-red text-glow">Memorizing</span></h1>
  </div>
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:40px;">
  <!-- Sol: soluk eski kartlar -->
  <div style="position:absolute; top:50%; left:60px; transform:translateY(-30%); z-index:3;">
    <img src="../../assets/images/png/img_three_tabul_back.png" style="height:400px; opacity:0.25; filter:grayscale(80%); transform:rotate(-5deg);">
  </div>
  <!-- Sag: parlak phone mockup -->
  <div style="position:absolute; top:50%; right:60px; transform:translateY(-30%) rotate(3deg); z-index:5;">
    <div class="phone-frame" style="width:300px; height:600px;">
      <img src="../../assets/images/advertising/6_03.png">
    </div>
  </div>
</div>
```

- [ ] **Step 8: Test ve commit**

```bash
open google_ads/templates/portrait.html#ad=9
# 9-14 arasi hepsini kontrol et
git add google_ads/templates/portrait.html
git commit -m "feat(ads): add portrait template with 6 layouts (1080x1350)"
```

---

## Task 5: Landscape Template (landscape.html) — Ad 15-20

**Files:**
- Create: `google_ads/templates/landscape.html`

- [ ] **Step 1: landscape.html iskelet**

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="_base.css">
<style>
  body { width: 1200px; height: 628px; }
</style>
</head>
<body>
  <!-- Ad 15-20 -->
  <script>
    const id = parseInt(location.hash.replace('#ad=','')) || 15;
    document.querySelectorAll('.ad').forEach(el => {
      el.classList.toggle('active', parseInt(el.dataset.adId) === id);
    });
  </script>
</body>
</html>
```

- [ ] **Step 2: Ad 15 — `text-left-wide-screenshot`**

```html
<div class="ad bg-dark" data-ad-id="15">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:36px;">
  <!-- Sol metin -->
  <div style="position:absolute; top:0; left:0; width:40%; height:100%; display:flex; flex-direction:column; justify-content:center; padding:40px; z-index:5;">
    <h1 style="font-size:44px; font-weight:900; line-height:1.2;">Sınırsız<br>Eğlence<br><span class="text-red text-glow">Başladı</span></h1>
  </div>
  <!-- Sag phone mockup -->
  <div style="position:absolute; top:50%; right:60px; transform:translateY(-50%) rotate(2deg); z-index:5;">
    <div class="phone-frame" style="width:260px; height:520px;">
      <img src="../../assets/images/advertising/6_05.png">
    </div>
  </div>
</div>
```

- [ ] **Step 3: Ad 16 — `folder-banner`**

```html
<div class="ad bg-blue" data-ad-id="16">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:36px;">
  <div style="position:absolute; top:30px; left:0; width:100%; text-align:center; z-index:8;">
    <h1 style="font-size:40px; font-weight:900; line-height:1.2;">Challenge Your <span class="text-red text-glow">Friends</span></h1>
  </div>
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-40%); display:flex; gap:30px; align-items:center; z-index:5;">
    <img src="../../assets/images/png/img_tabul_folder_back_bronze.png" class="card-shadow" style="height:320px; transform:rotate(-6deg);">
    <img src="../../assets/images/png/img_tabul_folder_back_silver.png" class="card-shadow" style="height:340px; transform:rotate(2deg);">
    <img src="../../assets/images/png/img_tabul_folder_gold.png" class="card-shadow" style="height:320px; transform:rotate(8deg);">
  </div>
</div>
```

- [ ] **Step 4: Ad 17 — `minimal-logo-asset`**

```html
<div class="ad bg-dark-reverse" data-ad-id="17">
  <!-- shapes: minimal -->
  <div style="position:absolute; top:0; left:0; width:100%; height:100%; display:flex; align-items:center; justify-content:center; gap:60px; z-index:5;">
    <!-- Sol: text logo -->
    <img src="../../assets/images/png/img_logo.png" style="height:60px; filter:drop-shadow(0 4px 12px rgba(0,0,0,0.3));">
    <!-- Ayirici -->
    <div style="width:1px; height:200px; background:rgba(255,255,255,0.15);"></div>
    <!-- Sag: kart fan -->
    <img src="../../assets/images/png/img_three_tabul_color.png" style="height:380px; filter:drop-shadow(0 12px 30px rgba(0,0,0,0.4));">
  </div>
</div>
```

- [ ] **Step 5: Ad 18 — `collage`**

```html
<div class="ad bg-dark" data-ad-id="18">
  <!-- shapes -->
  <img src="../../assets/images/png/img_logo.png" class="logo-top-left" style="height:32px;">
  <!-- Sol metin -->
  <div style="position:absolute; top:0; left:0; width:35%; height:100%; display:flex; flex-direction:column; justify-content:center; padding:36px; z-index:5;">
    <h1 style="font-size:38px; font-weight:900; line-height:1.2;">The Ultimate<br><span class="text-red text-glow">Word Game</span></h1>
  </div>
  <!-- Sag: screenshot collage -->
  <div style="position:absolute; top:50%; right:20px; transform:translateY(-50%); display:grid; grid-template-columns:repeat(3,1fr); gap:10px; z-index:5; width:62%;">
    <img src="../../assets/images/advertising/6_01.jpg" style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.3);">
    <img src="../../assets/images/advertising/6_02.png" style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.3);">
    <img src="../../assets/images/advertising/6_03.png" style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.3);">
    <img src="../../assets/images/advertising/6_04.png" style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.3);">
    <img src="../../assets/images/advertising/6_05.png" style="width:100%; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.3);">
  </div>
</div>
```

- [ ] **Step 6: Ad 19 — `store-cta`**

```html
<div class="ad bg-dark-reverse" data-ad-id="19">
  <!-- shapes: minimal -->
  <div style="position:absolute; top:0; left:0; width:100%; height:100%; display:flex; align-items:center; justify-content:center; gap:50px; z-index:5;">
    <!-- Sol: app icon -->
    <img src="../../assets/images/png/app_icon.png" class="logo-shadow" style="width:160px; height:160px; border-radius:32px;">
    <!-- Orta: text logo -->
    <img src="../../assets/images/png/img_logo.png" style="height:50px;">
    <!-- Sag: store badge'ler -->
    <div style="display:flex; flex-direction:column; gap:12px;">
      <div class="store-badge">
        <img src="../../assets/images/svg/ic_apple.svg">
        <div>
          <div class="store-label">Download on the</div>
          <div class="store-name">App Store</div>
        </div>
      </div>
      <div class="store-badge">
        <img src="../../assets/images/svg/ic_google.svg">
        <div>
          <div class="store-label">GET IT ON</div>
          <div class="store-name">Google Play</div>
        </div>
      </div>
    </div>
  </div>
</div>
```

- [ ] **Step 7: Ad 20 — `frame-crop-logo`**

```html
<div class="ad" data-ad-id="20" style="display:none;">
  <!-- Video frame arka plan -->
  <img src="../../temp5/frames/frame_00700.png" style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:cover; object-position:center; z-index:1;">
  <!-- Karartma overlay -->
  <div style="position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(26,31,61,0.4); z-index:2;"></div>
  <!-- Merkez app icon -->
  <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); z-index:5; text-align:center;">
    <img src="../../assets/images/png/app_icon.png" class="logo-shadow" style="width:200px; height:200px; border-radius:40px;">
    <p style="margin-top:20px; font-size:20px; font-weight:700; color:rgba(255,255,255,0.6); letter-spacing:3px;">AI WORD GAME</p>
  </div>
</div>
```

- [ ] **Step 8: Test ve commit**

```bash
open google_ads/templates/landscape.html#ad=15
# 15-20 arasi kontrol et
git add google_ads/templates/landscape.html
git commit -m "feat(ads): add landscape template with 6 layouts (1200x628)"
```

---

## Task 6: Capture Script (capture.mjs)

**Files:**
- Create: `google_ads/capture.mjs`

**Referans:**
- `temp5/capture.mjs` — Puppeteer pattern, Chrome path, viewport ayarlari

- [ ] **Step 1: capture.mjs olustur**

```javascript
import puppeteer from 'puppeteer-core';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Config oku
const config = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf-8'));
const outputDir = path.join(__dirname, config.output_dir);
if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });

// Tek gorsel render icin: node capture.mjs --id 5
const singleId = process.argv.includes('--id')
  ? parseInt(process.argv[process.argv.indexOf('--id') + 1])
  : null;

const adsToRender = singleId
  ? config.ads.filter(a => a.id === singleId)
  : config.ads;

if (adsToRender.length === 0) {
  console.error(`Ad ID ${singleId} bulunamadi.`);
  process.exit(1);
}

// Asset dogrulama (fail-fast)
function validateAssets() {
  const missing = [];
  for (const ad of adsToRender) {
    const assets = ad.assets || {};
    for (const [key, val] of Object.entries(assets)) {
      if (key === 'extras' && Array.isArray(val)) {
        val.forEach(p => {
          const full = path.join(__dirname, config.base_asset_path, p);
          if (!fs.existsSync(full)) missing.push(`Ad ${ad.id}: ${p}`);
        });
      } else if (typeof val === 'string') {
        // primary ve temp5 frame icin ozel path
        const full = val.startsWith('../../')
          ? path.join(__dirname, val)
          : path.join(__dirname, config.base_asset_path, val);
        if (!fs.existsSync(full)) missing.push(`Ad ${ad.id}: ${val}`);
      }
    }
  }
  if (missing.length > 0) {
    console.error('EKSIK ASSET\'LER:');
    missing.forEach(m => console.error(`  - ${m}`));
    process.exit(1);
  }
  console.log(`Asset dogrulama OK (${adsToRender.length} ad)`);
}

// Template mapping
const templateMap = {
  square: 'templates/square.html',
  portrait: 'templates/portrait.html',
  landscape: 'templates/landscape.html',
};

async function run() {
  validateAssets();

  const browser = await puppeteer.launch({
    executablePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    headless: true,
    args: ['--no-sandbox', '--disable-gpu', '--hide-scrollbars'],
  });

  const results = [];

  for (const ad of adsToRender) {
    const page = await browser.newPage();
    await page.setViewport({ width: ad.width, height: ad.height, deviceScaleFactor: 1 });

    const htmlPath = path.join(__dirname, templateMap[ad.template]);
    await page.goto(`file://${htmlPath}#ad=${ad.id}`, { waitUntil: 'networkidle0' });

    // Font yuklenmesini bekle
    await page.waitForFunction(() => document.fonts.ready.then(() => true), { timeout: 5000 }).catch(() => {});
    // Ek render bekleme
    await new Promise(r => setTimeout(r, 500));

    const outputPath = path.join(outputDir, `${ad.output_name}.png`);
    await page.screenshot({
      path: outputPath,
      clip: { x: 0, y: 0, width: ad.width, height: ad.height },
    });

    const stats = fs.statSync(outputPath);
    const sizeKB = Math.round(stats.size / 1024);
    const status = sizeKB > 500 ? 'ERROR' : sizeKB > 150 ? 'WARN' : 'OK';
    results.push({ id: ad.id, name: ad.output_name, sizeKB, status });

    console.log(`[${status}] Ad ${ad.id}: ${ad.output_name}.png (${sizeKB}KB)`);
    await page.close();
  }

  await browser.close();

  // Ozet rapor
  console.log('\n=== RAPOR ===');
  console.log(`Toplam: ${results.length} gorsel`);
  console.log(`OK: ${results.filter(r => r.status === 'OK').length}`);
  console.log(`WARN (>150KB): ${results.filter(r => r.status === 'WARN').length}`);
  console.log(`ERROR (>500KB): ${results.filter(r => r.status === 'ERROR').length}`);

  // Preview HTML olustur
  generatePreview(results);
}

function generatePreview(results) {
  const cards = config.ads.map(ad => {
    const r = results.find(r => r.id === ad.id);
    const sizeInfo = r ? `${r.sizeKB}KB — ${r.status}` : 'Not rendered';
    return `
    <div class="card">
      <img src="output/${ad.output_name}.png" alt="Ad ${ad.id}">
      <div class="info">
        <strong>#${ad.id}</strong> ${ad.output_name}<br>
        ${ad.width}x${ad.height} | ${ad.lang} | ${sizeInfo}
      </div>
    </div>`;
  }).join('\n');

  const html = `<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>TabuL Google Ads — Preview</title>
<style>
  body { font-family: system-ui; background: #1a1a2e; color: #fff; padding: 20px; }
  h1 { text-align: center; margin-bottom: 20px; }
  .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
  .card { background: #16213e; border-radius: 12px; overflow: hidden; }
  .card img { width: 100%; display: block; }
  .info { padding: 10px; font-size: 12px; line-height: 1.5; }
</style></head>
<body>
  <h1>TabuL Google Ads — Preview (${results.length} gorsel)</h1>
  <div class="grid">${cards}</div>
</body></html>`;

  fs.writeFileSync(path.join(__dirname, 'preview.html'), html);
  console.log('Preview: google_ads/preview.html');
}

run().catch(console.error);
```

- [ ] **Step 2: Commit**

```bash
git add google_ads/capture.mjs
git commit -m "feat(ads): add Puppeteer capture script with asset validation and QA preview"
```

---

## Task 7: Render ve QA

**Files:**
- Output: `google_ads/output/*.png`
- Output: `google_ads/preview.html`

- [ ] **Step 1: Tum 20 gorseli render et**

```bash
cd /Users/berkantcalikusu/Desktop/MyWorks/mehmet_ozyurt/advertisement/google_ads
node capture.mjs
```

Expected: 20 satir log, her biri `[OK]` veya `[WARN]` + rapor ozeti + preview.html olusur.

- [ ] **Step 2: Preview kontrol**

```bash
open preview.html
```

Tarayicida 20 gorseli grid'de kontrol et:
- Her gorsel dogru boyutta mi?
- Metinler okunakli mi?
- Logo gorunuyor mu?
- Brand renkleri tutarli mi?
- Asset'ler dogru yuklenmi mi?

- [ ] **Step 3: Sorunlu goerselleri tek tek duzelt**

Eger bir gorsel bozuk gorunuyorsa:
```bash
node capture.mjs --id 5    # Tek gorseli render et
open output/05_square_fr.png
```

Template HTML'deki ilgili `.ad` div'ini duzelt, tekrar render et.

- [ ] **Step 4: Final commit**

```bash
git add google_ads/preview.html
git commit -m "feat(ads): render all 20 Google Ads visuals and generate QA preview"
```

**NOT:** `output/*.png` dosyalari buyuk oldugu icin commit'e eklenmez. `.gitignore`'a eklenebilir veya manual olarak paylasilir.

---

## Paralel Calisma Stratejisi

Task'lar su sekilde paralel calistirilabilir:

```
Phase 1 (paralel — 4 subagent):
  ├── Subagent A: Task 1 (iskelet) + Task 2 (_base.css)
  ├── Subagent B: Task 3 (square.html) — Task 1-2 tamamlandiktan sonra
  ├── Subagent C: Task 4 (portrait.html) — Task 1-2 tamamlandiktan sonra
  └── Subagent D: Task 5 (landscape.html) — Task 1-2 tamamlandiktan sonra

Phase 2 (seri — 1 subagent):
  └── Subagent E: Task 6 (capture.mjs) + Task 7 (render + QA)
```

**Bagimliliklar:**
- Task 3, 4, 5 → Task 1, 2'ye bagimli (_base.css ve config.json olmali)
- Task 6 → Task 3, 4, 5'e bagimli (template'ler olmali)
- Task 7 → Task 6'ya bagimli (capture script olmali)

**Gercekci paralel plan:**
- Subagent A: Task 1 + Task 2 (config + base CSS) — hizli, ~3dk
- Subagent A bittikten sonra B, C, D paralel baslar
- B, C, D bittikten sonra E baslar (capture + render + QA)
