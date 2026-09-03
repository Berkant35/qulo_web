import { Inter } from "next/font/google";
import "@/app/globals.css";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

interface RootHtmlProps {
  /** BCP 47 language tag stamped on <html>. */
  lang: string;
  /** Text direction — "rtl" for Arabic, "ltr" everywhere else. */
  dir?: "ltr" | "rtl";
  children: React.ReactNode;
}

/**
 * The <html>/<head>/<body> shell.
 *
 * The site has two root layouts — one for the localized `[locale]` tree and one
 * for the standalone routes — because only a layout that receives the `locale`
 * param can stamp the right `lang` on <html>. Both render this component so the
 * head stays in one place.
 *
 * Why it matters: `lang` used to be hardcoded to "en" and corrected afterwards by
 * a client script. AI crawlers and search fetchers do not execute JavaScript, so
 * every localized page declared itself English to exactly the clients that decide
 * what language a page is in.
 */
export function RootHtml({ lang, dir = "ltr", children }: RootHtmlProps) {
  return (
    <html lang={lang} dir={dir} suppressHydrationWarning>
      <head>
        {/* Content-Security-Policy is served as a real HTTP header from
            netlify.toml. It is not repeated here: frame-ancestors is ignored
            in a <meta> policy, and a second copy only drifts out of sync. */}
        <link rel="dns-prefetch" href="https://qulo-server-production.up.railway.app" />
        <link
          rel="preconnect"
          href="https://qulo-server-production.up.railway.app"
          crossOrigin="anonymous"
        />
        <link rel="manifest" href="/manifest.json" />
        <link
          rel="alternate"
          type="application/rss+xml"
          title="Qulo Blog"
          href="/feed.xml"
        />
        <meta name="theme-color" content="#050508" />
        <meta name="color-scheme" content="dark" />
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta name="apple-mobile-web-app-title" content="Qulo" />
      </head>
      <body
        className={`${inter.variable} font-sans bg-qulo-bg text-white antialiased`}
      >
        {/* Skip to main content — accessibility + SEO */}
        <a
          href="#main-content"
          className="sr-only focus:not-sr-only focus:fixed focus:top-4 focus:left-4 focus:z-[100] focus:px-4 focus:py-2 focus:bg-qulo-purple focus:text-white focus:rounded-lg focus:text-sm"
        >
          Skip to content
        </a>
        {children}
      </body>
    </html>
  );
}
