# Website — question-based dating app

Marketing site for a dating app where people match by answering each other's questions. A static Next.js export in 18 languages, hosted on Netlify.

## What's inside

- **Next.js 14** static export to `out/`: about 1,800 pages across 18 locales
- **next-intl** routing under `src/app/[locale]/`; Netlify redirects visitors to their browser language
- Blog and glossary content, a web version of the question quiz, and a feed and sitemap generated at build time
- **Tailwind CSS** and **GSAP** animations
- SEO: `next-sitemap` and IndexNow pings
- Content checks in `scripts/`: broken links, brand and claim consistency, analytics setup, Netlify locale redirects

## Run it

```bash
npm ci
npm run dev        # http://localhost:3000
npm run build      # static export to out/
npm run verify     # content, brand, claims and deploy checks
npm test
```

---

Built and run end to end by [@Berkant35](https://github.com/Berkant35) — see also the [mobile app](https://github.com/Berkant35/qulov2) and the [backend](https://github.com/Berkant35/qulo-server).
