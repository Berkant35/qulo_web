import type { Metadata } from "next";
import { NextIntlClientProvider } from "next-intl";
import { getMessages, getTranslations, setRequestLocale } from "next-intl/server";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { SEO, SITE_URL, SITE_NAME, OG_LOCALES, APP_JSON_LD_ID } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { JsonLd } from "@/components/shared/JsonLd";
import { RootHtml } from "@/components/layout/RootHtml";
import { ROOT_METADATA } from "@/lib/constants/rootMetadata";
import { StickyInstallBar } from "@/components/shared/StickyInstallBar";
import { Analytics } from "@/components/analytics/Analytics";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = SEO[locale] || SEO.tr;
  const pageUrl = `${SITE_URL}/${locale}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";
  const alternateOgLocales = locales
    .filter((l) => l !== locale)
    .map((l) => OG_LOCALES[l] || "en_US");

  const languages = alternateLanguages("");

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
  const nav = await getTranslations("nav");

  const dir = rtlLocales.includes(locale) ? "rtl" : "ltr";

  const seoData = SEO[locale] || SEO.en;
  const jsonLd = [
    {
      "@context": "https://schema.org",
      "@type": "SoftwareApplication",
      // Same `@id` as the plans block on /pricing, so the two are one app
      // rather than two that disagree about what it costs. Here: free to
      // install. There: the paid tiers, on the page that lists them.
      "@id": APP_JSON_LD_ID,
      name: SITE_NAME,
      applicationCategory: "SocialNetworkingApplication",
      operatingSystem: "iOS, Android",
      url: SITE_URL,
      description: seoData.description,
      // No `offers` here on purpose. This node and the one on /pricing share an
      // `@id`, so a consumer merges them — declaring a single free Offer here
      // and three there would leave the merged app with a duplicate Free tier.
      // The plans live on the page that shows them; "free to start" is the
      // price-0 Offer in that list.
      featureList: [
        "Question-based matching",
        "Ready-made question suggestions",
        `${locales.length} language support`,
        "Quiz dating",
        "Real-time chat",
        "Voice messages in chat",
      ],
    },
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      name: SITE_NAME,
      url: SITE_URL,
      inLanguage: [...locales],
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
      // Stable identity. /press declares a richer Organization (founder,
      // address, contactPoint); sharing an `@id` makes the two one entity
      // instead of two competing ones on that page.
      "@id": `${SITE_URL}/#organization`,
      name: SITE_NAME,
      url: SITE_URL,
      logo: `${SITE_URL}/images/og-image.png`,
      sameAs: [
        "https://twitter.com/quloapp",
        "https://instagram.com/quloapp",
        "https://www.tiktok.com/@quloapp",
      ],
      foundingDate: "2026",
      description: seoData.description,
    },
    // FAQPage lives on the homepage, next to the visible FAQ it describes —
    // emitting it site-wide marked up Q&A that appears on none of those pages.
  ];

  return (
    <RootHtml lang={locale} dir={dir} skipLabel={nav("skipToContent")}>
      <NextIntlClientProvider locale={locale} messages={messages}>
        {/* JSON-LD structured data — static server constants only, no user input */}
        <JsonLd data={jsonLd} />
        {children}
        <StickyInstallBar />
        <Analytics />
      </NextIntlClientProvider>
    </RootHtml>
  );
}
