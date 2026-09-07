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
    // Both are empty because nobody has claimed the properties yet. Each needs
    // an account and a code, so this is a person's task, not a code change —
    // paste the code in and it ships on the next deploy.
    //
    // google: Search Console. The only place Google reports impressions, the
    // queries a page ranks for, and indexing errors. Without it we are blind to
    // whether any SEO work moved anything.
    //
    // other.["msvalidate.01"]: Bing Webmaster Tools. Higher stakes than its
    // traffic share suggests — ChatGPT Search and Copilot retrieve through
    // Bing's index, so a page Bing has not re-crawled is a page those engines
    // answer about from a stale copy. That is not theoretical: an audit on
    // 2026-09-06 found AI answers still repeating claims removed from this site
    // days earlier. `scripts/indexnow.mjs` pushes changes to Bing without an
    // account, but only Webmaster Tools shows what Bing actually holds.
    //
    // google: "your-verification-code",
    // other: { "msvalidate.01": "your-bing-code" },
  },
};
