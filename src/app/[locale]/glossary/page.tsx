import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { GLOSSARY_TERMS } from "@/lib/constants/glossary";

/** Per-locale breadcrumb label for the Glossary page */
const GLOSSARY_LABELS: Record<string, string> = {
  tr: "Sözlük", en: "Glossary", de: "Glossar", fr: "Glossaire", es: "Glosario",
  ar: "قاموس", ru: "Глоссарий", pt: "Glossário", it: "Glossario", ja: "用語集",
  ko: "용어집", zh: "术语表", nl: "Woordenlijst", pl: "Słowniczek", sv: "Ordlista", hi: "शब्दावली",
};

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.glossary[locale] || PAGE_SEO.glossary.en;
  const pageUrl = `${SITE_URL}/${locale}/glossary`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/glossary`;
  languages["x-default"] = `${SITE_URL}/tr/glossary`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      images: ogImages(),
    },
  };
}

/** Collect unique first letters from sorted terms */
function getLetterIndex(terms: typeof GLOSSARY_TERMS): string[] {
  const letters = new Set<string>();
  for (const term of terms) {
    letters.add(term.slug.charAt(0).toUpperCase());
  }
  return Array.from(letters).sort();
}

/** JSON-LD renderer — only static trusted content from constants */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default async function GlossaryPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const isTr = locale === "tr";
  const sortedTerms = [...GLOSSARY_TERMS].sort((a, b) =>
    a.slug.localeCompare(b.slug)
  );
  const letters = getLetterIndex(sortedTerms);

  // JSON-LD: DefinedTermSet schema — all values from static constants, no user input
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "DefinedTermSet",
    name: isTr ? "Dating Sozlugu" : "Dating Glossary",
    description: isTr
      ? "Online dating dunyasinin A'dan Z'ye terimleri"
      : "A to Z terms of the online dating world",
    url: `${SITE_URL}/${locale}/glossary`,
    inLanguage: locale,
    hasDefinedTerm: sortedTerms.map((term) => ({
      "@type": "DefinedTerm",
      name: term.terms[locale] || term.terms.en,
      description: term.definitions[locale] || term.definitions.en,
      url: `${SITE_URL}/${locale}/glossary#${term.slug}`,
    })),
  };

  const heroTitle = isTr ? "Dating Sozlugu" : "Dating Glossary";
  const heroSubtitle = isTr
    ? "Dating dunyasinin A'dan Z'ye terimleri"
    : "A to Z terms of the dating world";
  const quickNavLabel = isTr ? "Hizli Navigasyon" : "Quick Navigation";

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* JSON-LD — static trusted constants only */}
      <JsonLd data={jsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: GLOSSARY_LABELS[locale] || GLOSSARY_LABELS.en }]}
          />

          {/* Hero */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {isTr ? "Referans" : "Reference"}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {heroSubtitle}
            </p>
          </header>

          {/* Quick navigation — A-Z anchors */}
          <nav
            aria-label={quickNavLabel}
            className="mb-12 flex flex-wrap justify-center gap-2"
          >
            {letters.map((letter) => (
              <a
                key={letter}
                href={`#letter-${letter}`}
                className="w-9 h-9 flex items-center justify-center rounded-lg border border-white/[0.08] bg-white/[0.03] text-sm font-semibold text-qulo-purple hover:bg-qulo-purple/20 transition-colors"
              >
                {letter}
              </a>
            ))}
          </nav>

          {/* Terms grouped by first letter */}
          <div className="space-y-10">
            {letters.map((letter) => {
              const group = sortedTerms.filter(
                (t) => t.slug.charAt(0).toUpperCase() === letter
              );
              return (
                <section key={letter} id={`letter-${letter}`}>
                  <div className="sticky top-20 z-10 bg-qulo-bg/95 backdrop-blur-sm py-2 mb-4 border-b border-white/[0.08]">
                    <span className="text-2xl font-bold text-qulo-green">
                      {letter}
                    </span>
                  </div>
                  <div className="space-y-6">
                    {group.map((term) => {
                      const name = term.terms[locale] || term.terms.en;
                      const definition =
                        term.definitions[locale] || term.definitions.en;
                      return (
                        <article
                          key={term.slug}
                          id={term.slug}
                          className="rounded-xl border border-white/[0.08] bg-white/[0.03] p-6 scroll-mt-28"
                        >
                          <h2 className="text-xl font-bold text-white mb-2">
                            <span className="mr-2" aria-hidden="true">
                              {term.emoji}
                            </span>
                            <dfn className="not-italic">{name}</dfn>
                          </h2>
                          <p className="text-qulo-text-secondary leading-relaxed text-sm">
                            {definition}
                          </p>
                        </article>
                      );
                    })}
                  </div>
                </section>
              );
            })}
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
