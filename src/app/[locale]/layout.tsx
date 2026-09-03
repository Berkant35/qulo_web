import type { Metadata } from "next";
import { NextIntlClientProvider } from "next-intl";
import { getMessages, setRequestLocale } from "next-intl/server";
import { locales, rtlLocales, type Locale } from "@/lib/i18n/config";
import { SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { JsonLd } from "@/components/shared/JsonLd";
import { RootHtml } from "@/components/layout/RootHtml";
import { ROOT_METADATA } from "@/lib/constants/rootMetadata";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = SEO[locale as Locale] || SEO.tr;
  const pageUrl = `${SITE_URL}/${locale}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";
  const alternateOgLocales = locales
    .filter((l) => l !== locale)
    .map((l) => OG_LOCALES[l] || "en_US");

  // hreflang alternates for all 16 languages + x-default
  const languages: Record<string, string> = {};
  for (const l of locales) {
    languages[l] = `${SITE_URL}/${l}`;
  }
  languages["x-default"] = `${SITE_URL}/tr`;

  return {
    ...ROOT_METADATA,
    title: seo.title,
    description: seo.description,
    alternates: {
      canonical: pageUrl,
      languages,
    },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: ogLocale,
      alternateLocale: alternateOgLocales,
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
      images: ogImages(),
    },
  };
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const messages = await getMessages();

  const dir = rtlLocales.includes(locale) ? "rtl" : "ltr";

  const seoData = SEO[locale as Locale] || SEO.en;
  const jsonLd = [
    {
      "@context": "https://schema.org",
      "@type": "SoftwareApplication",
      name: SITE_NAME,
      applicationCategory: "SocialNetworkingApplication",
      operatingSystem: "iOS, Android",
      url: SITE_URL,
      description: seoData.description,
      offers: {
        "@type": "Offer",
        price: "0",
        priceCurrency: "USD",
      },
      featureList: [
        "Question-based matching",
        "AI-powered question suggestions",
        "16 language support",
        "Quiz dating",
        "Real-time chat",
        "Voice and video calls",
      ],
    },
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      name: SITE_NAME,
      url: SITE_URL,
      inLanguage: locales as unknown as string[],
      potentialAction: {
        "@type": "SearchAction",
        target: {
          "@type": "EntryPoint",
          urlTemplate: `${SITE_URL}/${locale}/glossary?q={search_term_string}`,
        },
        "query-input": "required name=search_term_string",
      },
    },
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
      logo: `${SITE_URL}/images/og-image.png`,
      sameAs: [
        "https://twitter.com/quloapp",
        "https://instagram.com/quloapp",
        "https://www.tiktok.com/@quloapp",
        "https://github.com/quloapp",
      ],
      foundingDate: "2026",
      description: seoData.description,
    },
    // FAQPage lives on the homepage, next to the visible FAQ it describes —
    // emitting it site-wide marked up Q&A that appears on none of those pages.
  ];

  return (
    <RootHtml lang={locale} dir={dir}>
      <NextIntlClientProvider locale={locale} messages={messages}>
        {/* JSON-LD structured data — static server constants only, no user input */}
        <JsonLd data={jsonLd} />
        {children}
      </NextIntlClientProvider>
    </RootHtml>
  );
}
