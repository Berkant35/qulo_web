import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Qulo",
  description: "AI-powered dating app",
  icons: {
    icon: "/favicon.svg",
  },
  metadataBase: new URL("https://quloapp.com"),
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

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <meta
          httpEquiv="Content-Security-Policy"
          content="default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self' https://qulo-server-production.up.railway.app; frame-ancestors 'none'"
        />
        {/* DNS prefetch for external resources */}
        <link rel="dns-prefetch" href="https://qulo-server-production.up.railway.app" />
        <link rel="preconnect" href="https://qulo-server-production.up.railway.app" crossOrigin="anonymous" />
        {/* PWA manifest */}
        <link rel="manifest" href="/manifest.json" />
        {/* RSS feed for Qulo Blog */}
        <link
          rel="alternate"
          type="application/rss+xml"
          title="Qulo Blog"
          href="/feed.xml"
        />
        {/* Theme color for mobile browsers */}
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
