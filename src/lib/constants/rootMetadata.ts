import type { Metadata } from "next";

/**
 * Metadata shared by both root layouts (the localized tree and the standalone
 * routes). Page-level `generateMetadata` overrides title/description/canonical
 * on top of this.
 */
export const ROOT_METADATA: Metadata = {
  icons: {
    icon: [
      { url: "/favicon.svg", type: "image/svg+xml" },
      { url: "/favicon-32.png", sizes: "32x32", type: "image/png" },
      { url: "/favicon-16.png", sizes: "16x16", type: "image/png" },
    ],
    apple: "/apple-touch-icon.png",
  },
  metadataBase: new URL("https://quloapp.com"),
  // iOS Safari Smart App Banner — sitenin ustunde "AC" / "GORUNTULE" cubugu.
  // Universal link ile KARISTIRILMAMALI: universal link yalnizca baska bir
  // uygulamadan link'e DOKUNULDUGUNDA calisir; adres cubuguna yazilan URL'de
  // Apple onu kasitli olarak tetiklemez. Sitedeyken uygulama onerisini gosteren
  // tek mekanizma bu banner.
  itunes: { appId: "1626734572" },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  verification: {
    // Deliberately empty: both properties are already claimed, and neither is
    // claimed with a meta tag.
    //
    // Search Console — a DOMAIN property (`sc-domain:quloapp.com`), verified on
    // 2026-09-18 with a TXT record on the apex in Netlify DNS
    // (`google-site-verification=...`). A meta tag could not have been used
    // here anyway: `/` answers 302 to `/<locale>/` and varies by
    // Accept-Language, so Google's verifier never sees a stable document at the
    // URL it checks. The domain property also covers www and every subdomain,
    // which a URL-prefix property would not.
    //
    // Bing Webmaster Tools — imported from Search Console on the same day, so
    // it inherits that verification and needs no `msvalidate.01` of its own.
    // This matters more than Bing's traffic share suggests: ChatGPT Search and
    // Copilot retrieve through Bing's index, so a page Bing has not crawled is
    // a page those engines cannot cite. On 2026-09-18 Bing's URL inspection
    // reported the /tr/answers/which-dating-app-... page — published a week
    // earlier, on 2026-09-11 — as "not known to Bing" while the /tr/ homepage
    // was indexed, and AI Performance showed 0 citations over 3 months. `scripts/indexnow.mjs` notifies Bing of changes; Webmaster
    // Tools is the only place that shows what Bing actually holds.
    //
    // So: do NOT paste verification codes here. If a property ever has to be
    // re-verified, fix it where it lives (DNS / the Bing import), not with a
    // meta tag that would silently claim the site for a second account.
  },
};
