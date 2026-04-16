import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { CITIES } from "@/lib/constants/cities";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.dating[locale] || PAGE_SEO.dating.en;
  const pageUrl = `${SITE_URL}/${locale}/dating`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/dating`;
  languages["x-default"] = `${SITE_URL}/tr/dating`;

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
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
    },
  };
}

const LABELS: Record<string, { heading: string; subtitle: string }> = {
  tr: { heading: "Sehirlerde Dating", subtitle: "Dunyanin en buyuk sehirlerinde Qulo ile tanisin." },
  en: { heading: "Dating in Cities", subtitle: "Meet people with Qulo in the world's biggest cities." },
  de: { heading: "Dating in Stadten", subtitle: "Treffen Sie Menschen mit Qulo in den grossten Stadten der Welt." },
  fr: { heading: "Dating dans les villes", subtitle: "Rencontrez des gens avec Qulo dans les plus grandes villes du monde." },
  es: { heading: "Citas en ciudades", subtitle: "Conoce gente con Qulo en las ciudades mas grandes del mundo." },
  ar: { heading: "المواعدة في المدن", subtitle: "تعرف على أشخاص مع Qulo في أكبر مدن العالم." },
  ru: { heading: "Знакомства в городах", subtitle: "Встречайте людей с Qulo в крупнейших городах мира." },
  pt: { heading: "Namoro em cidades", subtitle: "Conheca pessoas com Qulo nas maiores cidades do mundo." },
  it: { heading: "Incontri nelle citta", subtitle: "Incontra persone con Qulo nelle piu grandi citta del mondo." },
  ja: { heading: "都市でデート", subtitle: "世界の大都市でQuloと出会いましょう。" },
  ko: { heading: "도시에서 데이팅", subtitle: "세계 최대 도시에서 Qulo로 사람들을 만나세요." },
  zh: { heading: "城市约会", subtitle: "在世界最大的城市用Qulo认识人。" },
  nl: { heading: "Dating in steden", subtitle: "Ontmoet mensen met Qulo in de grootste steden ter wereld." },
  pl: { heading: "Randki w miastach", subtitle: "Poznaj ludzi z Qulo w najwiekszych miastach swiata." },
  sv: { heading: "Dejting i stader", subtitle: "Traffa manniskor med Qulo i varldens storsta stader." },
  hi: { heading: "शहरों में डेटिंग", subtitle: "दुनिया के सबसे बड़े शहरों में Qulo से लोगों से मिलें।" },
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

export default async function DatingIndexPage({
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
    url: `${SITE_URL}/${locale}/dating`,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: CITIES.map((city, i) => ({
        "@type": "ListItem",
        position: i + 1,
        url: `${SITE_URL}/${locale}/dating/${city.slug}`,
        name: city.names[locale] || city.names.en,
      })),
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <JsonLd data={collectionJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
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

          {/* City cards */}
          <div className="space-y-4">
            {CITIES.map((city) => {
              const cityName = city.names[locale] || city.names.en;
              const countryName = city.country[locale] || city.country.en;

              return (
                <Link
                  key={city.slug}
                  href={`/${locale}/dating/${city.slug}`}
                  className="group flex items-center gap-4 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-5 sm:p-6 transition-all duration-200 hover:border-qulo-purple/30 hover:bg-white/[0.05]"
                >
                  <span className="text-3xl flex-shrink-0">{city.emoji}</span>
                  <div className="flex-1 min-w-0">
                    <h2 className="text-lg font-bold text-white group-hover:text-qulo-purple transition-colors">
                      {cityName}
                    </h2>
                    <p className="text-xs text-qulo-text-secondary">
                      {countryName}
                    </p>
                  </div>
                  <span className="text-sm font-semibold text-qulo-green flex-shrink-0">
                    {city.population}
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
