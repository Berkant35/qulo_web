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
    // Add Google Search Console verification when available
    // google: "your-verification-code",
  },
};
