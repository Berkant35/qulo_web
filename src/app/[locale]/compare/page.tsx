import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES, PAGE_SEO } from "@/lib/constants/metadata";
import { COMPARISONS } from "@/lib/constants/comparisons";

/** Per-locale breadcrumb label for the Compare page */
const COMPARE_LABELS: Record<string, string> = {
  tr: "Karşılaştır", en: "Compare", de: "Vergleichen", fr: "Comparer", es: "Comparar",
  ar: "قارن", ru: "Сравнить", pt: "Comparar", it: "Confronta", ja: "比較",
  ko: "비교", zh: "比较", nl: "Vergelijken", pl: "Porównaj", sv: "Jämför", hi: "तुलना",
};

/* ------------------------------------------------------------------ */
/*  Metadata                                                           */
/* ------------------------------------------------------------------ */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.compare?.[locale] || PAGE_SEO.compare?.en || {
    title: "Comparisons — Qulo vs Others",
    description: "Compare Qulo with Tinder, Bumble and Hinge.",
  };
  const pageUrl = `${SITE_URL}/${locale}/compare`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/compare`;
  languages["x-default"] = `${SITE_URL}/tr/compare`;

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
  };
}

/* ------------------------------------------------------------------ */
/*  JSON-LD helper — renders static, trusted constants only            */
/* ------------------------------------------------------------------ */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      // Safe: data is constructed from static constants defined in source code, not user input
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

/* ------------------------------------------------------------------ */
/*  i18n labels                                                        */
/* ------------------------------------------------------------------ */
const LABELS: Record<string, Record<string, string>> = {
  title: {
    tr: "Karsilastirmalar",
    en: "Comparisons",
    de: "Vergleiche",
    fr: "Comparaisons",
    es: "Comparaciones",
  },
  subtitle: {
    tr: "Qulo'yu populer dating uygulamalariyla karsilastirin",
    en: "Compare Qulo with popular dating apps",
    de: "Vergleichen Sie Qulo mit beliebten Dating-Apps",
    fr: "Comparez Qulo avec les applications de rencontre populaires",
    es: "Compara Qulo con las aplicaciones de citas populares",
  },
  readMore: {
    tr: "Detayli Karsilastirma",
    en: "Detailed Comparison",
    de: "Detaillierter Vergleich",
    fr: "Comparaison detaillee",
    es: "Comparacion detallada",
  },
};

function label(key: string, locale: string): string {
  const map = LABELS[key];
  if (!map) return key;
  return map[locale] || map.en || key;
}

/* ------------------------------------------------------------------ */
/*  Page                                                               */
/* ------------------------------------------------------------------ */
export default async function ComparePage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  /* CollectionPage JSON-LD — static constants only */
  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: label("title", locale),
    url: `${SITE_URL}/${locale}/compare`,
    description: label("subtitle", locale),
    hasPart: COMPARISONS.map((c) => ({
      "@type": "WebPage",
      name: c.titles[locale] || c.titles.en,
      url: `${SITE_URL}/${locale}/compare/${c.slug}`,
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={collectionJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: COMPARE_LABELS[locale] || COMPARE_LABELS.en }]}
          />

          {/* Hero */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              Qulo vs
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4 leading-tight">
              {label("title", locale)}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {label("subtitle", locale)}
            </p>
          </header>

          {/* Comparison Cards */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-6">
            {COMPARISONS.map((c) => (
              <Link
                key={c.slug}
                href={`/${locale}/compare/${c.slug}`}
                className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 hover:bg-white/[0.06] transition-colors group flex flex-col"
              >
                <div className="text-4xl mb-4">{c.competitorLogo}</div>
                <h2 className="text-lg font-bold text-white mb-2 group-hover:text-qulo-green transition-colors">
                  Qulo vs {c.competitor}
                </h2>
                <p className="text-qulo-text-secondary text-xs leading-relaxed mb-4 flex-1">
                  {c.descriptions[locale] || c.descriptions.en}
                </p>
                <span className="text-qulo-purple text-xs font-semibold group-hover:underline">
                  {label("readMore", locale)} &rarr;
                </span>
              </Link>
            ))}
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
