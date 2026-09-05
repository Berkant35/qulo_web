import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { COUNTRIES } from "@/lib/constants/countries";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.country[locale] || PAGE_SEO.country.en;
  const pageUrl = `${SITE_URL}/${locale}/country`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages = alternateLanguages("/country");

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
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
      images: ogImages(),
    },
  };
}

const LABELS: Record<string, { heading: string; subtitle: string; breadcrumb: string }> = {
  tr: { heading: "Ulkelerde Dating", subtitle: "Dunya capinda ulkelerde Qulo ile tanisin.", breadcrumb: "Ulkeler" },
  en: { heading: "Dating by Country", subtitle: "Meet people with Qulo in countries worldwide.", breadcrumb: "Countries" },
  de: { heading: "Dating nach Land", subtitle: "Treffen Sie Menschen mit Qulo in Landern weltweit.", breadcrumb: "Lander" },
  fr: { heading: "Dating par pays", subtitle: "Rencontrez des gens avec Qulo dans les pays du monde entier.", breadcrumb: "Pays" },
  es: { heading: "Citas por pais", subtitle: "Conoce gente con Qulo en paises de todo el mundo.", breadcrumb: "Paises" },
  ar: { heading: "المواعدة حسب الدولة", subtitle: "تعرف على أشخاص مع Qulo في دول حول العالم.", breadcrumb: "الدول" },
  ru: { heading: "Знакомства по странам", subtitle: "Встречайте людей с Qulo в странах по всему миру.", breadcrumb: "Страны" },
  pt: { heading: "Namoro por pais", subtitle: "Conheca pessoas com Qulo em paises ao redor do mundo.", breadcrumb: "Paises" },
  it: { heading: "Incontri per paese", subtitle: "Incontra persone con Qulo nei paesi di tutto il mondo.", breadcrumb: "Paesi" },
  ja: { heading: "国別デート", subtitle: "世界中の国でQuloと出会いましょう。", breadcrumb: "国" },
  ko: { heading: "국가별 데이팅", subtitle: "전 세계 국가에서 Qulo로 사람들을 만나세요.", breadcrumb: "국가" },
  zh: { heading: "按国家约会", subtitle: "在世界各国用Qulo认识人。", breadcrumb: "国家" },
  nl: { heading: "Dating per land", subtitle: "Ontmoet mensen met Qulo in landen wereldwijd.", breadcrumb: "Landen" },
  pl: { heading: "Randki wedlug kraju", subtitle: "Poznaj ludzi z Qulo w krajach na calym swiecie.", breadcrumb: "Kraje" },
  sv: { heading: "Dejting efter land", subtitle: "Traffa manniskor med Qulo i lander varlden over.", breadcrumb: "Lander" },
  hi: { heading: "देश के अनुसार डेटिंग", subtitle: "दुनिया भर के देशों में Qulo से लोगों से मिलें।", breadcrumb: "देश" },
};

/** JSON-LD helper — uses only static server constants, no user input */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      /* Static server constants only — no user input, safe from XSS */
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default async function CountryIndexPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = LABELS[locale] || LABELS.en;

  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: labels.heading,
    url: `${SITE_URL}/${locale}/country`,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: COUNTRIES.map((country, i) => ({
        "@type": "ListItem",
        position: i + 1,
        url: `${SITE_URL}/${locale}/country/${country.slug}`,
        name: country.names[locale] || country.names.en,
      })),
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <JsonLd data={collectionJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: labels.breadcrumb }]} />

          {/* Header */}
          <header className="mb-12 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              Qulo
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4">
              {labels.heading}
            </h1>
            <p className="text-qulo-text-secondary text-base max-w-xl mx-auto">
              {labels.subtitle}
            </p>
          </header>

          {/* Country cards */}
          <div className="space-y-4">
            {COUNTRIES.map((country) => {
              const countryName = country.names[locale] || country.names.en;

              return (
                <Link
                  key={country.slug}
                  href={`/${locale}/country/${country.slug}`}
                  className="group flex items-center gap-4 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-5 sm:p-6 transition-all duration-200 hover:border-qulo-purple/30 hover:bg-white/[0.05]"
                >
                  <span className="text-3xl flex-shrink-0">{country.emoji}</span>
                  <div className="flex-1 min-w-0">
                    <h2 className="text-lg font-bold text-white group-hover:text-qulo-purple transition-colors">
                      {countryName}
                    </h2>
                    <p className="text-xs text-qulo-text-secondary">
                      {country.topCities[locale] || country.topCities.en}
                    </p>
                  </div>
                  <span className="text-sm font-semibold text-qulo-green flex-shrink-0">
                    {country.population}
                  </span>
                </Link>
              );
            })}
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
