# Qulo Landing Page & Deep Link Website — Design Spec

## Overview

Qulo dating uygulaması için quloapp.com adresinde yayınlanacak tanıtım web sitesi. Landing page, deep link handler ve legal sayfaları tek bir Next.js projesinde barındıran statik site.

**Domain:** quloapp.com (GoDaddy'de mevcut)
**Deploy:** Netlify (static export)
**Proje konumu:** `qulo/web/` (monorepo)

## Goals

1. **App Store yönlendirme** — iOS/Android store butonlarıyla indirme dönüşümü
2. **Marketing landing page** — Qulo'nun ne olduğunu anlatan, özel güçler ve AI soru oluşturma gibi killer feature'ları öne çıkaran cezbedici sayfa
3. **Deep link handler** — `/invite/:code` linkleri için platform algılama ve yönlendirme
4. **Legal sayfalar** — Privacy Policy ve Terms of Service (TR/EN)
5. **SEO** — "AI Dating", "Sorularla Tanışma", "Question-based Dating App" anahtar kelimeleri hedefleme

## Tech Stack

| Teknoloji | Amaç |
|---|---|
| Next.js 14 (App Router) | Framework, static export |
| Tailwind CSS | Styling, Qulo tema renkleriyle konfigüre |
| Framer Motion | Kart animasyonları, scroll-triggered reveal, layout transitions |
| GSAP + ScrollTrigger | 3D perspektif, parallax, advanced scroll animasyonları |
| next-intl | i18n (TR/EN) |
| Netlify | Hosting, DNS, `_redirects` |

## Visual Identity

Uygulamadaki mevcut tema web'e taşınacak:

| Token | Değer |
|---|---|
| Primary (Purple Neon) | `#BB86FC` (light), `#9C27B0` (dark) |
| Secondary (Green Neon) | `#69F0AE` (bright), `#4CAF50` (dark) |
| Background | `#050508` (site bg), `#0D0D0D` (card bg), `#1A1A1A` (surface) |
| Text Primary | `#FFFFFF` |
| Text Secondary | `#888888` |
| Text Muted | `#555555` |
| Font | Helvetica (uygulamayla aynı TTF) |
| Error | `#CF6679` |
| Success | `#69F0AE` |
| Warning | `#FFB74D` |

**Tasarım dili:**
- Futuristik dark theme
- Glassmorphism kartlar (backdrop-filter blur + şeffaf border)
- Grid overlay arka plan (cyberpunk hissi)
- Neon glow text efektleri
- Scanline animasyonu
- Morphing blob ambient ışıklar
- Rotating conic-gradient kart border'ları
- Pulse ring animasyonları
- Cyber line bölüm ayırıcıları

## Project Structure

```
qulo/web/
├── public/
│   ├── fonts/Helvetica.ttf
│   ├── images/                      # OG image, favicon, app screenshots
│   ├── .well-known/
│   │   ├── apple-app-site-association  # AASA (universal links)
│   │   └── assetlinks.json             # Android app links
│   └── videos/                      # Promo video (varsa)
├── src/
│   ├── app/
│   │   ├── [locale]/                # i18n routing (tr, en)
│   │   │   ├── layout.tsx
│   │   │   ├── page.tsx             # Landing page
│   │   │   ├── privacy-policy/page.tsx
│   │   │   ├── terms/page.tsx
│   │   │   └── invite/[code]/page.tsx  # Deep link handler
│   │   ├── layout.tsx               # Root layout
│   │   └── globals.css
│   ├── components/
│   │   ├── hero/
│   │   │   ├── Hero.tsx             # Hero section orchestrator
│   │   │   ├── CardStack.tsx        # Animated question card stack
│   │   │   └── StoreButtons.tsx     # App Store / Play Store butonları
│   │   ├── how-it-works/
│   │   │   ├── HowItWorks.tsx       # Timeline section
│   │   │   └── StepCard.tsx         # Her adım kartı
│   │   ├── features/
│   │   │   ├── Features.tsx         # Features grid
│   │   │   ├── FeatureCard.tsx      # Tekil feature kartı
│   │   │   ├── DiamondSystem.tsx    # Elmas sistemi detayı
│   │   │   ├── SpecialPowers.tsx    # Özel güçler (Boost, filtreler vb.)
│   │   │   └── AIQuestions.tsx      # AI soru oluşturma feature
│   │   ├── app-preview/
│   │   │   ├── AppPreview.tsx       # 3D telefon mockup section
│   │   │   └── PhoneMockup.tsx      # CSS 3D dönen telefon
│   │   ├── testimonials/
│   │   │   └── Testimonials.tsx     # Kullanıcı yorumları carousel
│   │   ├── download-cta/
│   │   │   └── DownloadCTA.tsx      # Son indirme çağrısı
│   │   ├── footer/
│   │   │   └── Footer.tsx           # Footer + legal linkler
│   │   └── shared/
│   │       ├── Navbar.tsx           # Fixed navbar (glassmorphism)
│   │       ├── LanguageSwitcher.tsx  # TR/EN toggle
│   │       ├── StoreButton.tsx      # Tekil store butonu
│   │       ├── GlassCard.tsx        # Reusable glassmorphism kart
│   │       ├── NeonButton.tsx       # Neon gradient buton
│   │       ├── SectionDivider.tsx   # Cyber line ayırıcı
│   │       └── GridOverlay.tsx      # Background grid pattern
│   ├── lib/
│   │   ├── i18n/
│   │   │   ├── dictionaries/
│   │   │   │   ├── tr.json          # Türkçe çeviriler
│   │   │   │   └── en.json          # İngilizce çeviriler
│   │   │   └── config.ts            # Locale config, default: tr
│   │   ├── constants/
│   │   │   ├── colors.ts            # Renk paleti (app ile senkron)
│   │   │   ├── links.ts             # Store linkleri, sosyal medya URL'leri
│   │   │   └── metadata.ts          # SEO meta, OG tags
│   │   └── utils/
│   │       └── detect-platform.ts   # iOS/Android/Desktop algılama
│   └── styles/
│       └── animations.css           # Global keyframe tanımları
├── next.config.js                   # Static export config
├── tailwind.config.ts               # Qulo tema token'ları
├── package.json
└── netlify.toml                     # Deploy config, redirects
```

## Page Sections

### 1. Navbar (Fixed)

- Glassmorphism arka plan (`rgba(5,5,8,0.8)` + `backdrop-filter: blur(20px)`)
- Sol: Qulo logosu (glitch text efektli)
- Sağ: Dil değiştirici (TR/EN) + "İndir" neon butonu
- Scroll'da border-bottom neon glow aktif

### 2. Hero Section

- **Tam ekran** (100vh), gradient mesh arka plan
- **Sol:** Tagline ("Sorularla Tanış."), açıklama metni, App Store + Play Store butonları
- **Sağ:** 3 katlı floating soru kartı stack
  - Ön kart: Rotating conic-gradient border, detaylı soru içeriği
  - Orta kart: Yarı şeffaf, farklı soru
  - Arka kart: Çok şeffaf, placeholder
  - Arkada: Pulse ring animasyonları
- **Arka plan efektleri:** Morphing blob'lar, floating particle'lar, scanline
- **Animasyonlar:**
  - Kartlar sürekli float (farklı hızlarda)
  - Sayfa yüklenince text fadeInUp + stagger
  - Mouse parallax (kartlar ve blob'lar ayrı katmanlarda)

### 3. Nasıl Çalışır (How It Works)

- Timeline layout (dikey çizgi + numaralı adımlar)
- 3 adım:
  1. **Soru Hazırla** — "2-10 soru oluştur, kişiliğini yansıt" + mini kart preview
  2. **Keşfet & Çöz** — "Diğer kullanıcıların sorularını cevapla"
  3. **Eşleş** — "Doğru cevaplayan kişiyle bağlan" + match animasyonu
- Her adım kartı glassmorphism + animated border glow
- **Animasyonlar:** Scroll'a girince stagger fadeIn, numara daireleri scale-up bounce, 3. adımda pulse ring

### 4. Özellikler (Features)

Grid layout, her feature glassmorphism kart:

- **💎 Elmas Sistemi** — Yeşil elmas (kazan), Mor elmas (satın al). Güç çarpanı açıklaması
- **🏆 Gamification** — Rozetler, seviyeler, ilerleme sistemi
- **⚡ Özel Güçler** — Boost (30dk görünürlük), Super Like, filtreler, sınırsız keşif. Her güç kartı ayrı ikon + açıklama ile
- **🤖 AI Soru Oluşturma** — Yapay zeka ile otomatik soru üretimi. "AI-powered dating" USP'si olarak öne çıkarılacak
- **🔒 Premium** — Tüm güçlere erişim, reklamsız deneyim

**Animasyonlar:** Scroll'a girince kartlar stagger ile fadeIn + scale. Hover'da glow intensify + slight lift.

### 5. App Preview

- CSS 3D transform ile dönen telefon mockup
- Telefon içinde gerçek app ekran görüntüleri (discover, soru, match)
- Scroll'da ekranlar arası geçiş
- **Animasyonlar:** Scroll-linked telefon rotasyonu, ekran fade geçişi

### 6. Testimonials

- Otomatik kayan yatay carousel
- Glassmorphism yorum kartları
- Başlangıçta placeholder içerik (ileride gerçek kullanıcı yorumları)
- **Animasyonlar:** Infinite scroll, hover'da pause

### 7. Download CTA

- Büyük ambient glow arka plan
- "Hemen Başla." neon glow heading
- Büyük neon gradient buton
- App Store + Play Store badge'leri
- **Animasyonlar:** Buton pulse, ambient glow breathe

### 8. Footer

- Minimal dark tasarım
- Sol: Qulo logo + copyright
- Sağ: Legal linkler (Privacy Policy, Terms), Sosyal medya (Instagram, TikTok)
- Dil değiştirici

## Deep Link Handler

### `/invite/:code` Route

```
Kullanıcı quloapp.com/invite/ABC123'e tıklıyor
  │
  ├─ Universal Link / App Link çalışırsa
  │   └─ Uygulama doğrudan açılır (iOS AASA / Android AssetLinks)
  │
  └─ Web sayfası açılırsa (uygulama yüklü değil)
      ├─ User Agent ile platform algıla
      ├─ iOS → App Store'a yönlendir (3sn sonra otomatik)
      ├─ Android → Play Store'a yönlendir (3sn sonra otomatik)
      └─ Desktop → Landing page + "Telefonundan indir" mesajı
```

### AASA & AssetLinks

Mevcut Railway server'dan quloapp.com'a taşınacak:

**`public/.well-known/apple-app-site-association`:**
```json
{
  "applinks": {
    "apps": [],
    "details": [{
      "appID": "5W2U3NK284.com.wordpress.calikusuberkant.qulorelease",
      "paths": ["/invite/*"]
    }]
  }
}
```

**`public/.well-known/assetlinks.json`:**
```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.wordpress.calikusuberkant.qulo",
    "sha256_cert_fingerprints": ["<ANDROID_SHA256_FINGERPRINT>"]
  }
}]
```

**Netlify config** (`netlify.toml`):
```toml
[[headers]]
  for = "/.well-known/*"
  [headers.values]
    Content-Type = "application/json"
    Access-Control-Allow-Origin = "*"
```

## Legal Pages

### `/privacy-policy`

- MDX içerik, i18n destekli (TR/EN)
- Minimal dark tasarım, okunabilir tipografi
- Son güncelleme tarihi otomatik gösterilecek
- İçerik statik olarak `dictionaries/` altında tutulacak

### `/terms`

- Aynı yapı, Terms of Service içeriği
- TR/EN çevirileri

## i18n Strategy

- **next-intl** ile route-based i18n: `/tr/`, `/en/`
- Default locale: `tr`
- Çeviri dosyaları: `src/lib/i18n/dictionaries/tr.json`, `en.json`
- Legal içerikler de aynı dictionary yapısında (uzun metin olarak)
- Navbar'da dil değiştirici (TR/EN toggle)

## SEO Strategy

- **Primary keywords:** "AI Dating", "Sorularla Tanışma", "Question-based Dating App"
- **Meta tags:** Her sayfa için özel title, description, OG image
- **Structured data:** App schema markup (SoftwareApplication)
- **Sitemap:** Otomatik generate (next-sitemap)
- **robots.txt:** Standart, legal sayfalar indexlenebilir

## Performance Targets

- **Lighthouse:** 90+ (Performance, Accessibility, SEO)
- **LCP:** < 2.5s
- **CLS:** < 0.1
- **FID:** < 100ms
- Animasyonlar `will-change` ve GPU-accelerated transform/opacity ile optimize
- GSAP/Framer Motion lazy load (above-the-fold'da sadece CSS animasyonları)

## Deployment

1. `next.config.js` → `output: 'export'` (static HTML)
2. Netlify'a git push ile otomatik deploy
3. GoDaddy DNS → Netlify'a CNAME/A record
4. SSL otomatik (Netlify Let's Encrypt)

**`netlify.toml`:**
```toml
[build]
  base = "web/"
  command = "npm run build"
  publish = "out/"

[[redirects]]
  from = "/.well-known/apple-app-site-association"
  to = "/.well-known/apple-app-site-association"
  status = 200
  force = true

[[headers]]
  for = "/.well-known/*"
  [headers.values]
    Content-Type = "application/json"
```

## Future Scope (Backlog)

Bu spec kapsamında DEĞİL, ileride eklenecek:

- [ ] Backoffice CMS entegrasyonu (qulo-server'a public API endpoint'leri)
- [ ] Blog / içerik sayfaları
- [ ] A/B testing (hero varyantları)
- [ ] Analytics dashboard (Netlify Analytics veya Plausible)
- [ ] Gerçek kullanıcı testimonialleri
- [ ] Video içerik (promo video embed)

## Dependencies

- quloapp.com DNS → Netlify'a yönlendirme (GoDaddy)
- Android SHA-256 fingerprint (`ANDROID_SHA256_FINGERPRINT`)
- App Store / Play Store linkleri (henüz yoksa placeholder)
- Privacy Policy ve Terms of Service metin içerikleri (TR/EN)
