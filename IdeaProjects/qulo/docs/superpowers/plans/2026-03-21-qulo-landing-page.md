# Qulo Landing Page Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** quloapp.com için Next.js tabanlı futuristik landing page, deep link handler ve legal sayfalar oluşturmak.

**Architecture:** Next.js 14 App Router ile static export. `qulo/web/` monorepo altında. `[locale]` route-based i18n (TR/EN) next-intl static mode ile. Animasyonlar katmanlı: hero CSS-only, below-fold Framer Motion, App Preview GSAP dynamic import.

**Tech Stack:** Next.js 14, Tailwind CSS, Framer Motion, GSAP + ScrollTrigger, next-intl, next-sitemap, Netlify

**Spec:** `docs/superpowers/specs/2026-03-21-qulo-landing-page-design.md`

---

## Task 1: Project Scaffolding & Config

**Files:**
- Create: `web/package.json`
- Create: `web/next.config.js`
- Create: `web/tailwind.config.ts`
- Create: `web/tsconfig.json`
- Create: `web/postcss.config.js`
- Create: `web/netlify.toml`
- Create: `web/.gitignore`

- [ ] **Step 1: Initialize Next.js project**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
npx create-next-app@14 web --typescript --tailwind --eslint --app --src-dir --no-import-alias
```

- [ ] **Step 2: Install dependencies**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web
npm install framer-motion gsap next-intl next-sitemap clsx tailwind-merge
```

- [ ] **Step 3: Configure next.config.js for static export**

```js
// web/next.config.js
const withNextIntl = require('next-intl/plugin')('./src/i18n/request.ts');

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  images: {
    unoptimized: true,
  },
};

module.exports = withNextIntl(nextConfig);
```

- [ ] **Step 4: Configure Tailwind with Qulo theme tokens**

```ts
// web/tailwind.config.ts
import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        qulo: {
          purple: { light: "#BB86FC", DEFAULT: "#BB86FC", dark: "#9C27B0" },
          green: { light: "#69F0AE", DEFAULT: "#69F0AE", dark: "#4CAF50" },
          bg: { DEFAULT: "#050508", card: "#0D0D0D", surface: "#1A1A1A" },
          text: { primary: "#FFFFFF", secondary: "#888888", muted: "#555555" },
          error: "#CF6679",
          success: "#69F0AE",
          warning: "#FFB74D",
        },
      },
      fontFamily: {
        sans: ["var(--font-inter)", "system-ui", "sans-serif"],
      },
      animation: {
        "float-slow": "float 6s ease-in-out infinite",
        "float-medium": "float 4s ease-in-out infinite",
        "float-fast": "float 3s ease-in-out infinite",
        "glow-pulse": "glowPulse 4s ease-in-out infinite",
        "mesh-move": "meshMove 12s ease infinite",
        "scanline": "scanline 8s linear infinite",
        "morph-blob": "morphBlob 15s ease-in-out infinite",
        "rotate-border": "rotateBorder 4s linear infinite",
        "pulse-ring": "pulseRing 4s ease-out infinite",
        "border-glow": "borderGlow 4s ease-in-out infinite",
      },
    },
  },
  plugins: [],
};

export default config;
```

- [ ] **Step 5: Create netlify.toml**

```toml
# web/netlify.toml
[build]
  base = "web/"
  command = "npm run build"
  publish = "out/"

[[redirects]]
  from = "/"
  to = "/tr/"
  status = 302

[[redirects]]
  from = "/invite/*"
  to = "/tr/invite/index.html"
  status = 200

[[redirects]]
  from = "/:locale/invite/*"
  to = "/:locale/invite/index.html"
  status = 200

[[headers]]
  for = "/.well-known/apple-app-site-association"
  [headers.values]
    Content-Type = "application/json"
    Access-Control-Allow-Origin = "*"

[[headers]]
  for = "/.well-known/assetlinks.json"
  [headers.values]
    Content-Type = "application/json"
    Access-Control-Allow-Origin = "*"
```

- [ ] **Step 6: Verify project builds**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web
npm run build
```

Expected: Build succeeds, `out/` directory created.

- [ ] **Step 7: Commit**

```bash
git add web/
git commit -m "feat(web): scaffold Next.js project with Tailwind, Framer Motion, GSAP, i18n"
```

---

## Task 2: i18n Setup & Constants

**Files:**
- Create: `web/src/lib/i18n/config.ts`
- Create: `web/src/lib/i18n/dictionaries/tr.json`
- Create: `web/src/lib/i18n/dictionaries/en.json`
- Create: `web/src/lib/constants/colors.ts`
- Create: `web/src/lib/constants/links.ts`
- Create: `web/src/lib/constants/metadata.ts`
- Create: `web/src/lib/utils/detect-platform.ts`
- Create: `web/src/i18n/request.ts` (next-intl config)

- [ ] **Step 1: Create i18n config for next-intl static mode**

```ts
// web/src/lib/i18n/config.ts
export const locales = ["tr", "en"] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = "tr";
```

```ts
// web/src/i18n/request.ts
import { getRequestConfig } from "next-intl/server";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";

export default getRequestConfig(async ({ requestLocale }) => {
  const locale = await requestLocale;
  if (!locales.includes(locale as Locale)) notFound();

  return {
    locale,
    messages: (await import(`@/lib/i18n/dictionaries/${locale}.json`)).default,
  };
});
```

- [ ] **Step 2: Create Turkish dictionary**

```json
// web/src/lib/i18n/dictionaries/tr.json
{
  "meta": {
    "title": "Qulo — Sorularla Tanış",
    "description": "Soru hazırla, paylaş, doğru cevaplayan kişiyle eşleş. AI destekli yeni nesil tanışma uygulaması."
  },
  "nav": {
    "download": "İndir"
  },
  "hero": {
    "label": "Yeni nesil tanışma",
    "title1": "Sorularla",
    "title2": "Tanış.",
    "description": "Soru hazırla, paylaş, doğru cevaplayan kişiyle eşleş. Gerçek bağlantılar kur.",
    "realConnections": "Gerçek bağlantılar"
  },
  "howItWorks": {
    "label": "Süreç",
    "title1": "Nasıl",
    "title2": "Çalışır?",
    "step1Title": "Soru Hazırla",
    "step1Desc": "2-10 soru oluştur, kişiliğini yansıt",
    "step1Detail": "Her soru seni tanıtan bir pencere.",
    "step2Title": "Keşfet & Çöz",
    "step2Desc": "Diğer kullanıcıların sorularını cevapla",
    "step2Detail": "Discover ekranında soruları keşfet, cevapla, puan topla.",
    "step3Title": "Eşleş",
    "step3Desc": "Doğru cevaplayan kişiyle bağlan",
    "step3Detail": "Match! Sohbete başla, gerçek bağlantını kur."
  },
  "features": {
    "label": "Özellikler",
    "title1": "Neden",
    "title2": "Qulo?",
    "diamonds": {
      "title": "Elmas Sistemi",
      "subtitle": "Kazan & Harca",
      "desc": "Soruların çözüldükçe yeşil elmas kazan. Mor elmaslarla güçlerini artır."
    },
    "gamification": {
      "title": "Gamification",
      "subtitle": "Rozetler & Seviyeler",
      "desc": "İlerledikçe rozetler kazan, seviye atla. Profilini zenginleştir."
    },
    "powers": {
      "title": "Özel Güçler",
      "subtitle": "Boost, Filtreler & Daha Fazlası",
      "desc": "30dk Boost ile görünürlüğünü artır, gelişmiş filtrelerle arama yap, sınırsız keşfet."
    },
    "ai": {
      "title": "AI Soru Oluşturma",
      "subtitle": "Yapay Zeka Destekli",
      "desc": "Yapay zeka ile ilgi çekici sorular oluştur. Kişiliğini en iyi yansıtan soruları bul."
    },
    "premium": {
      "title": "Premium",
      "subtitle": "Tüm Güçlere Erişim",
      "desc": "Reklamsız deneyim, tüm özel güçler ve sınırsız eşleşme."
    }
  },
  "appPreview": {
    "label": "Uygulama",
    "title1": "Uygulamayı",
    "title2": "Keşfet"
  },
  "testimonials": {
    "label": "Kullanıcılar",
    "title1": "Başarı",
    "title2": "Hikayeleri"
  },
  "cta": {
    "title": "Hemen Başla.",
    "desc": "Sorularınla tanış, gerçek bağlantılar kur.",
    "button": "Uygulamayı İndir"
  },
  "footer": {
    "legal": "Legal",
    "privacy": "Gizlilik Politikası",
    "terms": "Kullanım Koşulları",
    "social": "Sosyal",
    "copyright": "© 2026 Qulo. Tüm hakları saklıdır."
  },
  "invite": {
    "title": "Qulo'ya Davet Edildin!",
    "desc": "Uygulamayı indir ve davet kodunu kullan.",
    "redirecting": "Yönlendiriliyorsun...",
    "downloadPrompt": "Telefonundan indir",
    "code": "Davet kodu"
  },
  "notFound": {
    "title": "Sayfa Bulunamadı",
    "desc": "Aradığın sayfa mevcut değil.",
    "back": "Ana Sayfaya Dön"
  },
  "privacyPolicy": {
    "title": "Gizlilik Politikası",
    "lastUpdated": "Son güncelleme: 21 Mart 2026",
    "content": "Gizlilik politikası içeriği buraya eklenecektir."
  },
  "termsOfService": {
    "title": "Kullanım Koşulları",
    "lastUpdated": "Son güncelleme: 21 Mart 2026",
    "content": "Kullanım koşulları içeriği buraya eklenecektir."
  }
}
```

- [ ] **Step 3: Create English dictionary**

`en.json` — TR dictionary'nin İngilizce çevirisi (aynı key yapısı).

- [ ] **Step 4: Create constants files**

```ts
// web/src/lib/constants/colors.ts
export const COLORS = {
  purple: { light: "#BB86FC", dark: "#9C27B0" },
  green: { light: "#69F0AE", dark: "#4CAF50" },
  bg: { site: "#050508", card: "#0D0D0D", surface: "#1A1A1A" },
  text: { primary: "#FFFFFF", secondary: "#888888", muted: "#555555" },
  error: "#CF6679",
  success: "#69F0AE",
  warning: "#FFB74D",
} as const;
```

```ts
// web/src/lib/constants/links.ts
export const APP_STORE_URL = "#"; // Store'a çıkınca güncelle
export const PLAY_STORE_URL = "#"; // Store'a çıkınca güncelle
export const SOCIAL = {
  instagram: "https://instagram.com/quloapp",
  tiktok: "https://tiktok.com/@quloapp",
} as const;
```

```ts
// web/src/lib/constants/metadata.ts
export const SITE_URL = "https://quloapp.com";
export const SITE_NAME = "Qulo";
export const SEO = {
  tr: {
    title: "Qulo — Sorularla Tanış | AI Dating Uygulaması",
    description: "Soru hazırla, paylaş, doğru cevaplayan kişiyle eşleş. AI destekli yeni nesil tanışma uygulaması.",
  },
  en: {
    title: "Qulo — Meet Through Questions | AI Dating App",
    description: "Create questions, share them, match with the person who answers correctly. AI-powered next-gen dating app.",
  },
} as const;
```

- [ ] **Step 5: Create platform detection utility**

```ts
// web/src/lib/utils/detect-platform.ts
export type Platform = "ios" | "android" | "desktop";

export function detectPlatform(): Platform {
  if (typeof window === "undefined") return "desktop";
  const ua = navigator.userAgent;
  if (/iPad|iPhone|iPod/.test(ua)) return "ios";
  if (/Android/.test(ua)) return "android";
  return "desktop";
}
```

- [ ] **Step 6: Commit**

```bash
git add web/src/lib/ web/src/i18n/
git commit -m "feat(web): add i18n config, dictionaries (TR/EN), constants, and platform utils"
```

---

## Task 3: Root Layout, Locale Layout & Global Styles

**Files:**
- Modify: `web/src/app/layout.tsx`
- Create: `web/src/app/[locale]/layout.tsx`
- Create: `web/src/app/[locale]/page.tsx` (placeholder)
- Create: `web/src/app/not-found.tsx`
- Modify: `web/src/app/globals.css`
- Create: `web/src/styles/animations.css`

- [ ] **Step 1: Setup root layout with Inter font**

```tsx
// web/src/app/layout.tsx
import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });

export const metadata: Metadata = {
  title: "Qulo",
  description: "AI-powered dating app",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="tr" suppressHydrationWarning>
      <body className={`${inter.variable} font-sans bg-qulo-bg text-white antialiased`}>
        {children}
      </body>
    </html>
  );
}
```

- [ ] **Step 2: Create locale layout with next-intl provider and generateStaticParams**

```tsx
// web/src/app/[locale]/layout.tsx
import { NextIntlClientProvider } from "next-intl";
import { getMessages } from "next-intl/server";
import { locales } from "@/lib/i18n/config";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  const messages = await getMessages();

  // Set html lang attribute for SEO (locale is from generateStaticParams, safe hardcoded value)
  return (
    <>
      <NextIntlClientProvider locale={locale} messages={messages}>
        {children}
      </NextIntlClientProvider>
    </>
  );
}

// Note: html lang attribute is set in root layout as "tr" default.
// For EN pages, add a client component that updates document.documentElement.lang on mount.
```

- [ ] **Step 3: Create placeholder landing page**

```tsx
// web/src/app/[locale]/page.tsx
export default function Home() {
  return (
    <main className="min-h-screen flex items-center justify-center">
      <h1 className="text-4xl font-bold text-qulo-purple">Qulo</h1>
    </main>
  );
}
```

- [ ] **Step 4: Create 404 page**

```tsx
// web/src/app/not-found.tsx
import Link from "next/link";

export default function NotFound() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white">
      <h1 className="text-6xl font-bold text-qulo-purple mb-4">404</h1>
      <p className="text-qulo-text-secondary mb-8">Sayfa bulunamadı</p>
      <Link
        href="/tr/"
        className="px-6 py-3 bg-gradient-to-r from-qulo-purple to-qulo-purple-dark rounded-full font-semibold hover:shadow-[0_0_30px_rgba(187,134,252,0.4)] transition-shadow"
      >
        Ana Sayfaya Dön
      </Link>
    </main>
  );
}
```

- [ ] **Step 5: Create global CSS with animations**

```css
/* web/src/styles/animations.css */
@keyframes float {
  0%, 100% { transform: translateY(0) rotate(-2deg); }
  50% { transform: translateY(-18px) rotate(1deg); }
}
@keyframes glowPulse {
  0%, 100% { box-shadow: 0 0 20px rgba(187,134,252,0.3); }
  50% { box-shadow: 0 0 40px rgba(187,134,252,0.6); }
}
@keyframes meshMove {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}
@keyframes scanline {
  0% { top: -10%; }
  100% { top: 110%; }
}
@keyframes morphBlob {
  0%, 100% { border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%; }
  33% { border-radius: 30% 60% 70% 40% / 50% 60% 30% 60%; }
  66% { border-radius: 50% 50% 40% 60% / 40% 70% 50% 50%; }
}
@keyframes rotateBorder {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
@keyframes pulseRing {
  0% { transform: scale(0.8); opacity: 1; }
  100% { transform: scale(2.5); opacity: 0; }
}
@keyframes borderGlow {
  0%, 100% { border-color: rgba(187,134,252,0.4); box-shadow: 0 0 20px rgba(187,134,252,0.15); }
  50% { border-color: rgba(105,240,174,0.4); box-shadow: 0 0 20px rgba(105,240,174,0.15); }
}
@keyframes glitchText {
  0%, 95%, 100% { text-shadow: 0 0 40px rgba(187,134,252,0.6); }
  96% { text-shadow: -2px 0 #69F0AE, 2px 0 #BB86FC; }
  97% { text-shadow: 2px 0 #69F0AE, -2px 0 #BB86FC; }
}
```

Import `animations.css` in `globals.css` and add base dark theme styles.

- [ ] **Step 6: Verify build**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web && npm run build
```

Expected: Static export succeeds with `out/tr/index.html` and `out/en/index.html`.

- [ ] **Step 7: Commit**

```bash
git add web/src/app/ web/src/styles/
git commit -m "feat(web): add root layout, locale layout with i18n, 404 page, global animations"
```

---

## Task 4: Shared Components

**Files:**
- Create: `web/src/components/shared/Navbar.tsx`
- Create: `web/src/components/shared/LanguageSwitcher.tsx`
- Create: `web/src/components/shared/StoreButton.tsx`
- Create: `web/src/components/shared/GlassCard.tsx`
- Create: `web/src/components/shared/NeonButton.tsx`
- Create: `web/src/components/shared/SectionDivider.tsx`
- Create: `web/src/components/shared/GridOverlay.tsx`

- [ ] **Step 1: Create GridOverlay — background grid pattern**

```tsx
// web/src/components/shared/GridOverlay.tsx
export function GridOverlay() {
  return (
    <div
      className="fixed inset-0 z-0 pointer-events-none"
      style={{
        backgroundImage:
          "linear-gradient(rgba(187,134,252,0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(187,134,252,0.03) 1px, transparent 1px)",
        backgroundSize: "60px 60px",
      }}
    />
  );
}
```

- [ ] **Step 2: Create GlassCard — reusable glassmorphism container**

```tsx
// web/src/components/shared/GlassCard.tsx
import { cn } from "@/lib/utils/cn";

interface GlassCardProps {
  children: React.ReactNode;
  className?: string;
  borderColor?: string;
}

export function GlassCard({ children, className, borderColor }: GlassCardProps) {
  return (
    <div
      className={cn(
        "bg-white/[0.03] backdrop-blur-xl border border-white/[0.08] rounded-2xl",
        className
      )}
      style={borderColor ? { borderColor } : undefined}
    >
      {children}
    </div>
  );
}
```

Also create `web/src/lib/utils/cn.ts` (clsx + tailwind-merge already installed in Task 1):
```ts
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
export function cn(...inputs: ClassValue[]) { return twMerge(clsx(inputs)); }
```

- [ ] **Step 3: Create NeonButton**

```tsx
// web/src/components/shared/NeonButton.tsx
import { cn } from "@/lib/utils/cn";

interface NeonButtonProps {
  children: React.ReactNode;
  href?: string;
  className?: string;
  disabled?: boolean;
}

export function NeonButton({ children, href, className, disabled }: NeonButtonProps) {
  const classes = cn(
    "inline-flex items-center gap-2 bg-gradient-to-r from-qulo-purple to-qulo-purple-dark",
    "text-white font-bold px-7 py-3.5 rounded-full",
    "shadow-[0_0_30px_rgba(187,134,252,0.4)] hover:shadow-[0_0_50px_rgba(187,134,252,0.6)]",
    "transition-all duration-300 hover:-translate-y-0.5",
    disabled && "opacity-50 cursor-not-allowed hover:translate-y-0",
    className
  );

  if (href && !disabled) {
    return <a href={href} className={classes}>{children}</a>;
  }
  return <span className={classes}>{children}</span>;
}
```

- [ ] **Step 4: Create SectionDivider (cyber line)**

```tsx
// web/src/components/shared/SectionDivider.tsx
export function SectionDivider() {
  return (
    <div className="max-w-[900px] mx-auto my-16">
      <div className="h-px bg-gradient-to-r from-transparent via-qulo-purple/25 to-transparent" />
    </div>
  );
}
```

- [ ] **Step 5: Create StoreButton**

```tsx
// web/src/components/shared/StoreButton.tsx
import { GlassCard } from "./GlassCard";

interface StoreButtonProps {
  platform: "ios" | "android";
  href: string;
}

export function StoreButton({ platform, href }: StoreButtonProps) {
  const disabled = href === "#";
  const content = platform === "ios" ? {
    icon: "🍎", label: "Download on the", store: "App Store",
  } : {
    icon: "▶️", label: "GET IT ON", store: "Google Play",
  };

  const Wrapper = disabled ? "div" : "a";
  return (
    <Wrapper
      {...(!disabled && { href, target: "_blank", rel: "noopener noreferrer" })}
      className={disabled ? "opacity-50 cursor-not-allowed" : "cursor-pointer"}
    >
      <GlassCard className="px-4 py-3 flex items-center gap-3 hover:border-qulo-purple/30 transition-colors">
        <span className="text-2xl">{content.icon}</span>
        <div>
          <div className="text-qulo-text-muted text-[9px] uppercase tracking-wider">{content.label}</div>
          <div className="text-white text-sm font-bold">{content.store}</div>
        </div>
      </GlassCard>
    </Wrapper>
  );
}
```

- [ ] **Step 6: Create LanguageSwitcher**

```tsx
// web/src/components/shared/LanguageSwitcher.tsx
"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";

export function LanguageSwitcher({ currentLocale }: { currentLocale: string }) {
  const pathname = usePathname();
  const otherLocale = currentLocale === "tr" ? "en" : "tr";
  const newPath = pathname.replace(`/${currentLocale}`, `/${otherLocale}`);

  return (
    <div className="flex items-center gap-1 text-xs font-medium tracking-widest">
      <span className={currentLocale === "tr" ? "text-qulo-purple" : "text-qulo-text-muted"}>TR</span>
      <span className="text-qulo-text-muted mx-1">/</span>
      <Link href={newPath} className={currentLocale === "en" ? "text-qulo-purple" : "text-qulo-text-muted hover:text-qulo-purple transition-colors"}>
        EN
      </Link>
    </div>
  );
}
```

- [ ] **Step 7: Create Navbar**

```tsx
// web/src/components/shared/Navbar.tsx
"use client";

import { useTranslations } from "next-intl";
import { LanguageSwitcher } from "./LanguageSwitcher";
import { NeonButton } from "./NeonButton";
import { APP_STORE_URL } from "@/lib/constants/links";

export function Navbar({ locale }: { locale: string }) {
  const t = useTranslations("nav");

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 px-6 py-4 flex justify-between items-center bg-qulo-bg/80 backdrop-blur-xl border-b border-qulo-purple/10">
      <span className="text-qulo-purple text-2xl font-black tracking-tight animate-[glitchText_5s_infinite]">
        Qulo
      </span>
      <div className="flex items-center gap-4">
        <LanguageSwitcher currentLocale={locale} />
        <NeonButton href={APP_STORE_URL} className="text-xs px-5 py-2">
          {t("download")} ↗
        </NeonButton>
      </div>
    </nav>
  );
}
```

- [ ] **Step 8: Verify build**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web && npm run build
```

- [ ] **Step 9: Commit**

```bash
git add web/src/components/shared/ web/src/lib/utils/cn.ts
git commit -m "feat(web): add shared components — Navbar, GlassCard, NeonButton, GridOverlay, etc."
```

---

## Task 5: Hero Section

**Files:**
- Create: `web/src/components/hero/Hero.tsx`
- Create: `web/src/components/hero/CardStack.tsx`
- Create: `web/src/components/hero/StoreButtons.tsx`

- [ ] **Step 1: Create CardStack — animated floating question cards**

3 katlı soru kartı stack. CSS keyframe float animasyonları (hero'da JS dependency yok). Rotating conic-gradient border ön kartta. Pulse ring arka planda.

```tsx
// web/src/components/hero/CardStack.tsx
// Spec'teki wireframe'den: 3 kart (ön/orta/arka), her biri farklı hızda float
// Ön kart: rotating border, soru detayları, "Cevapla →" butonu
// Orta kart: opacity-55, farklı soru
// Arka kart: opacity-25, placeholder
// Pulse ring animasyonları arka planda
```

Implement full component with Tailwind classes matching the futuristic wireframe.

- [ ] **Step 2: Create StoreButtons — App Store / Play Store**

```tsx
// web/src/components/hero/StoreButtons.tsx
import { StoreButton } from "@/components/shared/StoreButton";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";

export function StoreButtons() {
  return (
    <div className="flex gap-3 mt-8">
      <StoreButton platform="ios" href={APP_STORE_URL} />
      <StoreButton platform="android" href={PLAY_STORE_URL} />
    </div>
  );
}
```

- [ ] **Step 3: Create Hero — full section orchestrator**

```tsx
// web/src/components/hero/Hero.tsx
// Spec'ten:
// - Tam ekran (100vh), gradient mesh arka plan
// - Sol: section-label + h1 tagline + description + StoreButtons
// - Sağ: CardStack
// - Morphing blob'lar (CSS-only, position:absolute)
// - Scanline efekti (CSS animation)
// - Floating particles (CSS-only)
```

Implement with `animate-mesh-move` bg, `animate-scanline` overlay, `animate-morph-blob` ambient blobs.

- [ ] **Step 4: Wire Hero into landing page**

```tsx
// web/src/app/[locale]/page.tsx
import { Hero } from "@/components/hero/Hero";
import { Navbar } from "@/components/shared/Navbar";
import { GridOverlay } from "@/components/shared/GridOverlay";

export default async function Home({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  return (
    <main className="relative overflow-hidden">
      <GridOverlay />
      <Navbar locale={locale} />
      <Hero />
    </main>
  );
}
```

- [ ] **Step 5: Test locally**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web && npm run dev
```

Open http://localhost:3000/tr — verify hero renders with animations.

- [ ] **Step 6: Commit**

```bash
git add web/src/components/hero/ web/src/app/
git commit -m "feat(web): add Hero section with animated card stack, particles, glassmorphism"
```

---

## Task 6: How It Works Section

**Files:**
- Create: `web/src/components/how-it-works/HowItWorks.tsx`
- Create: `web/src/components/how-it-works/StepCard.tsx`

- [ ] **Step 1: Create StepCard — individual timeline step**

Glassmorphism kart, animated border-glow, numara dairesi (gradient bg + glow shadow). Framer Motion `useInView` ile scroll'a girince fadeIn.

- [ ] **Step 2: Create HowItWorks — timeline section with 3 steps**

Dikey timeline çizgi (gradient line), 3 StepCard stagger ile. Step 1: mini soru preview. Step 3: match animasyonu (iki avatar + kalp).

- [ ] **Step 3: Wire into landing page**

```tsx
// page.tsx'e ekle:
import { HowItWorks } from "@/components/how-it-works/HowItWorks";
import { SectionDivider } from "@/components/shared/SectionDivider";
// ... Hero'dan sonra:
// <SectionDivider />
// <HowItWorks />
```

- [ ] **Step 4: Test locally — scroll to section, verify animations**

- [ ] **Step 5: Commit**

```bash
git add web/src/components/how-it-works/
git commit -m "feat(web): add How It Works section with timeline layout and scroll animations"
```

---

## Task 7: Features Section

**Files:**
- Create: `web/src/components/features/Features.tsx`
- Create: `web/src/components/features/FeatureCard.tsx`

- [ ] **Step 1: Create FeatureCard — individual feature glass card**

Glassmorphism kart, ambient glow (radial gradient, position:absolute), emoji ikon, label + title + description. Framer Motion: scroll-triggered fadeIn + scale, hover glow intensify + lift.

- [ ] **Step 2: Create Features — grid section with 5 feature cards**

Grid layout (auto-fit, minmax 240px). 5 feature: Elmas Sistemi (💎), Gamification (🏆), Özel Güçler (⚡), AI Soru Oluşturma (🤖), Premium (🔒). Her kart farklı accent color (purple/green alternating).

**Not:** Spec'te `DiamondSystem.tsx`, `SpecialPowers.tsx`, `AIQuestions.tsx` ayrı bileşenler olarak listeleniyor. MVP'de bunlar `FeatureCard` üzerinden tek grid'de render edilecek — FeatureCard yeterince esnek olacak (ikon, label, title, description, accent color props). İleride detaylı alt bileşenlere ayrılabilir.

- [ ] **Step 3: Wire into landing page**

- [ ] **Step 4: Test locally**

- [ ] **Step 5: Commit**

```bash
git add web/src/components/features/
git commit -m "feat(web): add Features section with diamond, gamification, powers, AI, premium cards"
```

---

## Task 8: App Preview Section

**Files:**
- Create: `web/src/components/app-preview/AppPreview.tsx`
- Create: `web/src/components/app-preview/PhoneMockup.tsx`

- [ ] **Step 1: Create PhoneMockup — CSS 3D phone frame**

CSS 3D transform ile telefon çerçevesi. İçinde placeholder ekran görüntüleri (gradient placeholder, ileride gerçek screenshot'lar). `perspective` + `rotateY` ile 3D efekt.

- [ ] **Step 2: Create AppPreview — section with GSAP ScrollTrigger**

GSAP ile scroll-linked telefon rotasyonu. `"use client"` directive gerekli. GSAP `useEffect` içinde initialize edilmeli (`ssr: false` benzeri güvenlik):

```tsx
"use client";
import { useEffect, useRef } from "react";

export function AppPreview() {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Dynamic import GSAP only on client
    const initGSAP = async () => {
      const { gsap } = await import("gsap");
      const { ScrollTrigger } = await import("gsap/ScrollTrigger");
      gsap.registerPlugin(ScrollTrigger);
      // ... scroll-linked phone rotation setup
    };
    initGSAP();
  }, []);
  // ...
}
```

- [ ] **Step 3: Wire into landing page**

- [ ] **Step 4: Test locally**

- [ ] **Step 5: Commit**

```bash
git add web/src/components/app-preview/
git commit -m "feat(web): add App Preview section with 3D phone mockup and GSAP scroll animation"
```

---

## Task 9: Testimonials Section

**Files:**
- Create: `web/src/components/testimonials/Testimonials.tsx`

- [ ] **Step 1: Create Testimonials — horizontal auto-scroll carousel**

Glassmorphism yorum kartları, CSS infinite scroll animation (`translateX`). Hover'da pause. Placeholder yorumlar (3-5 adet). Framer Motion `useInView` ile section giriş animasyonu.

- [ ] **Step 2: Wire into landing page**

- [ ] **Step 3: Test locally**

- [ ] **Step 4: Commit**

```bash
git add web/src/components/testimonials/
git commit -m "feat(web): add Testimonials section with auto-scrolling carousel"
```

---

## Task 10: Download CTA Section

**Files:**
- Create: `web/src/components/download-cta/DownloadCTA.tsx`

- [ ] **Step 1: Create DownloadCTA — final call to action**

Büyük ambient glow (radial gradient), "Hemen Başla." neon glow heading, büyük NeonButton, App Store + Play Store badge'leri. CSS `animate-glow-pulse` buton efekti.

- [ ] **Step 2: Wire into landing page**

- [ ] **Step 3: Test locally**

- [ ] **Step 4: Commit**

```bash
git add web/src/components/download-cta/
git commit -m "feat(web): add Download CTA section with ambient glow and neon button"
```

---

## Task 11: Footer

**Files:**
- Create: `web/src/components/footer/Footer.tsx`

- [ ] **Step 1: Create Footer — minimal dark footer**

Sol: Qulo logo + copyright. Sağ: Legal linkler (privacy-policy, terms) + sosyal medya (Instagram, TikTok) + LanguageSwitcher. Border-top neon subtle. Footer `locale` prop alır ve `LanguageSwitcher` render eder.

- [ ] **Step 2: Wire into landing page and verify full page scroll**

- [ ] **Step 3: Commit**

```bash
git add web/src/components/footer/
git commit -m "feat(web): add Footer with legal links and social media"
```

---

## Task 12: Deep Link Handler & Well-Known Files

**Files:**
- Create: `web/src/app/[locale]/invite/page.tsx`
- Create: `web/public/.well-known/apple-app-site-association`
- Create: `web/public/.well-known/assetlinks.json`

- [ ] **Step 1: Create invite page — client-side deep link handler**

```tsx
// web/src/app/[locale]/invite/page.tsx
"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { detectPlatform } from "@/lib/utils/detect-platform";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";
import { NeonButton } from "@/components/shared/NeonButton";

export default function InvitePage() {
  const t = useTranslations("invite");
  const [code, setCode] = useState<string | null>(null);
  const [platform, setPlatform] = useState<"ios" | "android" | "desktop">("desktop");

  useEffect(() => {
    // Parse invite code from URL: /tr/invite/ABC123 or /invite/ABC123
    const segments = window.location.pathname.split("/");
    const inviteIdx = segments.indexOf("invite");
    if (inviteIdx !== -1 && segments[inviteIdx + 1]) {
      setCode(segments[inviteIdx + 1]);
    }
    setPlatform(detectPlatform());
  }, []);

  useEffect(() => {
    if (!code) return;
    if (platform === "ios" && APP_STORE_URL !== "#") {
      const timer = setTimeout(() => window.location.href = APP_STORE_URL, 3000);
      return () => clearTimeout(timer);
    }
    if (platform === "android" && PLAY_STORE_URL !== "#") {
      const timer = setTimeout(() => window.location.href = PLAY_STORE_URL, 3000);
      return () => clearTimeout(timer);
    }
  }, [code, platform]);

  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white px-6">
      <h1 className="text-4xl font-bold text-qulo-purple mb-4">{t("title")}</h1>
      {code && (
        <p className="text-qulo-text-secondary mb-2">
          {t("code")}: <span className="text-qulo-green font-mono">{code}</span>
        </p>
      )}
      {platform !== "desktop" && (
        <p className="text-qulo-text-muted mb-8 animate-pulse">{t("redirecting")}</p>
      )}
      {platform === "desktop" && (
        <p className="text-qulo-text-secondary mb-8">{t("downloadPrompt")}</p>
      )}
      <div className="flex gap-4">
        <NeonButton href={APP_STORE_URL} disabled={APP_STORE_URL === "#"}>
          App Store
        </NeonButton>
        <NeonButton href={PLAY_STORE_URL} disabled={PLAY_STORE_URL === "#"}>
          Google Play
        </NeonButton>
      </div>
    </main>
  );
}
```

- [ ] **Step 2: Create AASA file**

```json
// web/public/.well-known/apple-app-site-association
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "5W2U3NK284.com.wordpress.calikusuberkant.qulorelease",
        "paths": ["/invite/*"]
      }
    ]
  }
}
```

- [ ] **Step 3: Create assetlinks.json**

```json
// web/public/.well-known/assetlinks.json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.wordpress.calikusuberkant.qulo",
      "sha256_cert_fingerprints": ["TODO:ADD_YOUR_SHA256_FINGERPRINT"]
    }
  }
]
```

- [ ] **Step 4: Test locally — navigate to /tr/invite/TEST123**

- [ ] **Step 5: Commit**

```bash
git add web/src/app/*/invite/ web/public/.well-known/
git commit -m "feat(web): add deep link handler and well-known files (AASA, assetlinks)"
```

---

## Task 13: Legal Pages (Privacy Policy & Terms)

**Files:**
- Create: `web/src/app/[locale]/privacy-policy/page.tsx`
- Create: `web/src/app/[locale]/terms/page.tsx`

- [ ] **Step 1: Create Privacy Policy page**

```tsx
// web/src/app/[locale]/privacy-policy/page.tsx
import { getTranslations } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";

export default async function PrivacyPolicyPage({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  const t = await getTranslations("privacyPolicy");
  // Dark theme, readable typography, i18n content from dictionary
  // Section structure: Introduction, Data Collection, Usage, Third Parties, Contact
  // Use `t("title")`, `t("content")` etc. — server component, no "use client" needed
}
```

Placeholder content in dictionary — real content to be added later.

**Not:** Legal sayfalar server component'tır — `getTranslations` kullanılır, `useTranslations` değil.

- [ ] **Step 2: Create Terms of Service page**

Same structure as Privacy Policy, different dictionary keys.

- [ ] **Step 3: Verify links from Footer work**

- [ ] **Step 4: Commit**

```bash
git add web/src/app/*/privacy-policy/ web/src/app/*/terms/
git commit -m "feat(web): add Privacy Policy and Terms of Service pages (i18n)"
```

---

## Task 14: SEO, Sitemap & Metadata

**Files:**
- Create: `web/next-sitemap.config.js`
- Modify: `web/src/app/[locale]/layout.tsx` (metadata)
- Create: `web/public/images/og-image.png` (placeholder)

- [ ] **Step 1: Configure next-sitemap**

```js
// web/next-sitemap.config.js
/** @type {import('next-sitemap').IConfig} */
module.exports = {
  siteUrl: "https://quloapp.com",
  generateRobotsTxt: true,
  outDir: "./out",
};
```

Add to `package.json` scripts: `"postbuild": "next-sitemap"`

- [ ] **Step 2: Add metadata to locale layout**

Dynamic metadata per locale using `generateMetadata` — title, description, OG image. Add JSON-LD structured data as `<script type="application/ld+json">` in layout:

```tsx
// Locale layout'un metadata'sına ekle:
const jsonLd = {
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  name: "Qulo",
  operatingSystem: "iOS, Android",
  applicationCategory: "SocialNetworkingApplication",
  description: seo.description,
  offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
};
// <script type="application/ld+json">{JSON.stringify(jsonLd)}</script> body'ye ekle
```

- [ ] **Step 3: Create placeholder OG image**

Simple gradient image (1200x630) with "Qulo" text. Can be created with a simple HTML canvas or placeholder.

- [ ] **Step 4: Full build and verify**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web
npm run build
```

Verify: `out/sitemap.xml`, `out/robots.txt`, `out/tr/index.html`, `out/en/index.html` all exist.

- [ ] **Step 5: Commit**

```bash
git add web/next-sitemap.config.js web/src/app/ web/public/images/ web/package.json
git commit -m "feat(web): add SEO metadata, sitemap, robots.txt, OG image"
```

---

## Task 15: Final Integration & Polish

**Files:**
- Modify: `web/src/app/[locale]/page.tsx` (assemble all sections)
- Test: Full page scroll, all animations, both languages, deep links

- [ ] **Step 1: Assemble complete landing page**

Verify all sections are wired in correct order:
1. GridOverlay + Navbar
2. Hero
3. SectionDivider
4. HowItWorks
5. SectionDivider
6. Features
7. SectionDivider
8. AppPreview
9. SectionDivider
10. Testimonials
11. SectionDivider
12. DownloadCTA
13. Footer

- [ ] **Step 2: Test TR locale — full page scroll**

```bash
npm run dev
# Open http://localhost:3000/tr
```

Verify: All sections render, animations trigger on scroll, cards float, glassmorphism works.

- [ ] **Step 3: Test EN locale**

Navigate to http://localhost:3000/en — verify all text switches to English.

- [ ] **Step 4: Test deep link handler**

Navigate to http://localhost:3000/tr/invite/TEST123 — verify code display and platform detection.

- [ ] **Step 5: Test 404 page**

Navigate to http://localhost:3000/nonexistent — verify custom 404.

- [ ] **Step 6: Full static build**

```bash
npm run build
```

Verify `out/` directory has all expected files.

- [ ] **Step 6.5: Verify .well-known files in build output**

```bash
ls -la /Users/berkantcalikusu/IdeaProjects/qulo/web/out/.well-known/
```

Expected: `apple-app-site-association` ve `assetlinks.json` dosyaları mevcut. Eğer kopyalanmamışsa, `next.config.js`'e copy script ekle veya `netlify.toml`'da `[[redirects]]` ile `public/.well-known/` dosyalarını serve et.

- [ ] **Step 6.6: Responsive test — mobil görünüm**

```bash
npm run dev
# Tarayıcıda DevTools → mobil görünüm (375px, 768px, 1024px)
```

Kontrol et:
- Hero: Kart stack mobilde alt alta geçmeli (flex-wrap)
- Features: Grid tek sütuna düşmeli
- Navbar: Kompakt kalmalı
- Footer: Stack layout

- [ ] **Step 7: Run dev server on port 5000 for local testing**

```bash
npx serve out -l 5000
```

Verify http://localhost:5000 works (redirects to /tr/).

- [ ] **Step 8: Final commit**

```bash
git add web/
git commit -m "feat(web): complete Qulo landing page — all sections, i18n, deep links, SEO"
```
