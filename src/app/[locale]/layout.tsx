import type { Metadata } from "next";
import { NextIntlClientProvider } from "next-intl";
import { getMessages, setRequestLocale } from "next-intl/server";
import { locales, rtlLocales, type Locale } from "@/lib/i18n/config";
import { SEO, SITE_URL, SITE_NAME, OG_LOCALES, FAQ_DATA } from "@/lib/constants/metadata";

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
      images: [
        {
          url: `${SITE_URL}/images/og-image.png`,
          width: 1200,
          height: 630,
          alt: SITE_NAME,
        },
      ],
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
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
  const langScript = `document.documentElement.lang="${locale}";document.documentElement.dir="${dir}";`;

  const seoData = SEO[locale as Locale] || SEO.en;
  const jsonLd = JSON.stringify([
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
    },
    {
      "@context": "https://schema.org",
      "@type": "WebSite",
      name: SITE_NAME,
      url: SITE_URL,
      inLanguage: locales as unknown as string[],
    },
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
      logo: `${SITE_URL}/images/og-image.png`,
    },
    // FAQPage schema for rich snippets
    ...(FAQ_DATA[locale]
      ? [
          {
            "@context": "https://schema.org",
            "@type": "FAQPage",
            mainEntity: FAQ_DATA[locale].map((faq) => ({
              "@type": "Question",
              name: faq.q,
              acceptedAnswer: {
                "@type": "Answer",
                text: faq.a,
              },
            })),
          },
        ]
      : []),
  ]);

  return (
    <NextIntlClientProvider locale={locale} messages={messages}>
      {/* Set lang/dir on <html> for static export — locale is a static param from generateStaticParams, not user input */}
      <script dangerouslySetInnerHTML={{ __html: langScript }} />
      {/* JSON-LD structured data — static server constants only, no user input */}
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: jsonLd }} />
      {children}
    </NextIntlClientProvider>
  );
}
