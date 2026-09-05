import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import Link from "next/link";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { rtlLocales } from "@/lib/i18n/config";
import { LANDING_PAGES } from "@/lib/constants/landings";
import { landingLabels } from "@/lib/constants/landingLabels";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";

/* ---------- Metadata ---------- */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.features?.[locale] || PAGE_SEO.features?.en;
  if (!seo) return {};

  const pageUrl = `${SITE_URL}/${locale}/features`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages = alternateLanguages("/features");

  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: ogLocale,
      images: ogImages(),
    },
  };
}

/* ---------- Page ---------- */
export default async function FeaturesIndexPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = landingLabels(locale);

  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: labels.section,
    url: `${SITE_URL}/${locale}/features`,
    isPartOf: { "@type": "WebSite", name: SITE_NAME, url: SITE_URL },
    hasPart: LANDING_PAGES.map((lp) => ({
      "@type": "WebPage",
      name: lp.titles[locale] || lp.titles.en,
      url: `${SITE_URL}/${locale}/features/${lp.slug}`,
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={collectionJsonLd} />

      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <div className="max-w-3xl mx-auto">

          <Breadcrumb locale={locale} items={[{ label: labels.section }]} />

          <header className="mb-12 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {labels.section}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4 leading-tight">
              {labels.hubTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {labels.hubIntro}
            </p>
          </header>

          <div className="space-y-6">
            {LANDING_PAGES.map((lp) => {
              const title = lp.titles[locale] || lp.titles.en;
              const desc = lp.descriptions[locale] || lp.descriptions.en;
              return (
                <Link
                  key={lp.slug}
                  href={`/${locale}/features/${lp.slug}`}
                  className="block rounded-2xl border border-white/[0.08] bg-white/[0.03] p-8 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-qulo-green text-xs font-semibold uppercase tracking-[0.15em] mb-2">
                    {lp.primaryKeyword}
                  </p>
                  <h2 className="text-xl font-bold text-white mb-2">{title}</h2>
                  <p className="text-sm text-qulo-text-secondary leading-relaxed">
                    {desc}
                  </p>
                </Link>
              );
            })}
          </div>

        </div>
      </div>
    </main>
  );
}
