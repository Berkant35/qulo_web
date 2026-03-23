# Qulo Web

Marketing website and legal pages for the **Qulo** dating app — meet through questions.

**Live:** [quloapp.com](https://quloapp.com)

## Tech Stack

- **Framework:** Next.js 14 (App Router, Static Export)
- **Language:** TypeScript 5
- **Styling:** Tailwind CSS 3.4
- **Animation:** Framer Motion, GSAP, Lottie
- **i18n:** next-intl (16 languages)
- **Deployment:** Netlify

## Supported Languages

| Code | Language | Scope |
|------|----------|-------|
| `en` | English | Full site |
| `tr` | Turkish | Full site |
| `de` `fr` `es` `ar` `ru` `pt` `it` `ja` `ko` `zh` `nl` `pl` `sv` `hi` | 14 languages | Legal pages |

Arabic (`ar`) includes RTL layout support.

## Project Structure

```
src/
├── app/
│   ├── [locale]/
│   │   ├── page.tsx            # Home (EN/TR)
│   │   ├── privacy-policy/     # Privacy Policy (16 langs)
│   │   ├── terms/              # Terms of Service (16 langs)
│   │   └── invite/             # Deep link redirect
│   ├── layout.tsx              # Root layout
│   └── page.tsx                # / → /en/ redirect
├── components/
│   ├── shared/                 # Navbar, Icon, GlassCard
│   ├── hero/                   # Hero section
│   ├── features/               # Feature cards
│   ├── how-it-works/           # Steps timeline
│   ├── app-preview/            # Phone mockup + GSAP
│   ├── why-different/          # Comparison cards
│   ├── download-cta/           # CTA section
│   └── footer/                 # Footer
├── lib/
│   ├── i18n/
│   │   ├── config.ts           # 16 locales + RTL config
│   │   └── dictionaries/       # JSON language files
│   ├── constants/              # Metadata, links
│   └── utils/                  # cn(), detectPlatform()
└── i18n/
    └── request.ts              # next-intl with EN fallback
```

## Getting Started

```bash
npm install
npm run dev          # http://localhost:3000
npm run build        # Static export → out/
npm run lint         # ESLint
```

Requires Node.js >= 20.

## Legal Pages

Privacy Policy and Terms of Service available in 16 languages:

- **GDPR** compliant (EU General Data Protection Regulation)
- **KVKK** compliant (Turkish Data Protection Law No. 6698)
- Section-based rendering with RTL support for Arabic

Content stored in `src/lib/i18n/dictionaries/*.json`.

## Deep Links

| Path | Purpose |
|------|---------|
| `/.well-known/apple-app-site-association` | iOS Universal Links |
| `/.well-known/assetlinks.json` | Android App Links |
| `/invite/:code` | Referral redirect |

## Deployment

Static site deployed to **Netlify** via `netlify.toml`.

Key redirects:
- `/` → `/en/`
- `/privacy` → `/en/privacy-policy/`
- `/terms` → `/en/terms/`
