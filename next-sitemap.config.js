/**
 * Crawlers we explicitly welcome. `User-agent: *` already allows everything, so
 * these blocks are belt-and-braces: they document intent and keep a future
 * "block the AI bots" edit from silently removing us from AI answers.
 *
 * Google-Extended and Applebot-Extended are grounding/training opt-outs only —
 * disallowing them removes Qulo from Gemini and Apple Intelligence grounding
 * without affecting Search ranking, so we allow both deliberately.
 */
const CITATION_CRAWLERS = [
  "Googlebot",
  "Google-Extended",
  "Bingbot",
  "Applebot",
  "Applebot-Extended",
  "OAI-SearchBot",
  "GPTBot",
  "ChatGPT-User",
  "ClaudeBot",
  "Claude-User",
  "Claude-SearchBot",
  "PerplexityBot",
  "Perplexity-User",
  "Amazonbot",
  "meta-externalagent",
];

/** Utility routes: real pages users land on, but nothing to index. */
const NOINDEX_ROUTES = ["/invite", "/email-verified", "/reset-password"];

/** Higher priority for the pages we actually want surfaced first. */
const PRIORITY_RULES = [
  { test: (path) => /^\/[a-z]{2}\/?$/.test(path), priority: 1.0, changefreq: "daily" },
  // Leaf content — the pages that answer a specific query and are the ones
  // worth landing on directly.
  { test: (path) => /\/(blog|advice|how-to|answers|glossary)\/[^/]+\/?$/.test(path), priority: 0.9, changefreq: "monthly" },
  { test: (path) => /\/(blog|glossary|answers|questions|dating-statistics|trends)/.test(path), priority: 0.8, changefreq: "weekly" },
  { test: (path) => /\/(features|pricing|help|about)/.test(path), priority: 0.8, changefreq: "monthly" },
];

/** @type {import('next-sitemap').IConfig} */
module.exports = {
  siteUrl: "https://quloapp.com",
  generateRobotsTxt: true,
  outDir: "./out",
  // hreflang is handled via HTML <link> tags in generateMetadata (per-page),
  // not via sitemap alternateRefs (which incorrectly double-prefixes locale URLs)
  changefreq: "weekly",
  priority: 0.7,
  // Utility routes carry the homepage's canonical, so indexing them would create
  // duplicate-content signals — they are excluded here and noindexed in-page.
  exclude: ["/404", ...NOINDEX_ROUTES.map((route) => `/*${route}`)],
  transform: async (config, path) => {
    const rule = PRIORITY_RULES.find((candidate) => candidate.test(path));
    return {
      loc: path,
      changefreq: rule?.changefreq ?? config.changefreq,
      priority: rule?.priority ?? config.priority,
      lastmod: config.autoLastmod ? new Date().toISOString() : undefined,
    };
  },
  robotsTxtOptions: {
    // One group per user agent. `/_next/` stays crawlable: Google needs the CSS
    // and JS to render, and blocking it buys nothing for crawlers that don't.
    policies: [
      { userAgent: "*", allow: "/", disallow: ["/api/", "/404"] },
      ...CITATION_CRAWLERS.map((userAgent) => ({ userAgent, allow: "/" })),
    ],
    // sitemap.xml already indexes sitemap-0.xml; listing it again duplicated the entry.
    additionalSitemaps: [],
  },
};
