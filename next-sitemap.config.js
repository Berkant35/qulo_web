/** @type {import('next-sitemap').IConfig} */
module.exports = {
  siteUrl: "https://quloapp.com",
  generateRobotsTxt: true,
  outDir: "./out",
  alternateRefs: [
    { href: "https://quloapp.com/tr", hreflang: "tr" },
    { href: "https://quloapp.com/en", hreflang: "en" },
    { href: "https://quloapp.com/de", hreflang: "de" },
    { href: "https://quloapp.com/fr", hreflang: "fr" },
    { href: "https://quloapp.com/es", hreflang: "es" },
    { href: "https://quloapp.com/ar", hreflang: "ar" },
    { href: "https://quloapp.com/ru", hreflang: "ru" },
    { href: "https://quloapp.com/pt", hreflang: "pt" },
    { href: "https://quloapp.com/it", hreflang: "it" },
    { href: "https://quloapp.com/ja", hreflang: "ja" },
    { href: "https://quloapp.com/ko", hreflang: "ko" },
    { href: "https://quloapp.com/zh", hreflang: "zh" },
    { href: "https://quloapp.com/nl", hreflang: "nl" },
    { href: "https://quloapp.com/pl", hreflang: "pl" },
    { href: "https://quloapp.com/sv", hreflang: "sv" },
    { href: "https://quloapp.com/hi", hreflang: "hi" },
  ],
  robotsTxtOptions: {
    policies: [
      { userAgent: "*", allow: "/" },
      { userAgent: "*", disallow: ["/api/", "/_next/"] },
    ],
    additionalSitemaps: [],
  },
};
