/** @type {import('next-sitemap').IConfig} */
module.exports = {
  siteUrl: "https://quloapp.com",
  generateRobotsTxt: true,
  outDir: "./out",
  // hreflang is handled via HTML <link> tags in generateMetadata (per-page),
  // not via sitemap alternateRefs (which incorrectly double-prefixes locale URLs)
  changefreq: "weekly",
  priority: 0.7,
  exclude: ["/404"],
  robotsTxtOptions: {
    policies: [
      { userAgent: "*", allow: "/" },
      { userAgent: "*", disallow: ["/api/", "/_next/", "/404"] },
    ],
    additionalSitemaps: [
      "https://quloapp.com/sitemap-0.xml",
    ],
  },
};
