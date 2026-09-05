import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { SORTED_GLOSSARY_TERMS } from "@/lib/constants/glossary";
import { GLOSSARY_LABELS } from "@/lib/constants/glossaryLabels";
import { GLOSSARY_CONTENT } from "./_content";

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
  const languages = alternateLanguages("/glossary");
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

/**
 * The letters the terms actually group under, in this language. Grouping keys
 * off the localized term rather than the slug, so the Japanese page indexes by
 * the Japanese heading instead of a Latin slug the reader never sees.
 */
function letterOf(term: string): string {
  return term.charAt(0).toLocaleUpperCase();
}

export default async function GlossaryPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = GLOSSARY_LABELS[locale] || GLOSSARY_LABELS.en;

  // Terms resolved into this locale, then sorted by that language's collation.
  const terms = SORTED_GLOSSARY_TERMS.map((term) => {
    const entry = GLOSSARY_CONTENT[term.slug]?.[locale];
    return entry ? { ...term, name: entry.term, summary: entry.summary } : null;
  })
    .filter((value): value is NonNullable<typeof value> => value !== null)
    .sort((a, b) => a.name.localeCompare(b.name, locale));

  const letters = Array.from(new Set(terms.map((term) => letterOf(term.name)))).sort(
    (a, b) => a.localeCompare(b, locale),
  );

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "DefinedTermSet",
    name: labels.hubTitle,
    description: labels.hubIntro,
    url: `${SITE_URL}/${locale}/glossary`,
    inLanguage: locale,
    hasDefinedTerm: terms.map((term) => ({
      "@type": "DefinedTerm",
      name: term.name,
      description: term.summary,
      url: `${SITE_URL}/${locale}/glossary/${term.slug}`,
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={jsonLd} />

      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <div className="max-w-3xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: labels.hubTitle }]} />

          <header className="mb-14 text-center">
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {labels.hubTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {labels.hubIntro}
            </p>
          </header>

          <nav
            aria-label={labels.quickNav}
            className="mb-12 flex flex-wrap justify-center gap-2"
          >
            {letters.map((letter) => (
              <a
                key={letter}
                href={`#letter-${encodeURIComponent(letter)}`}
                className="min-w-9 h-9 px-2 flex items-center justify-center rounded-lg border border-white/[0.08] bg-white/[0.03] text-sm font-semibold text-qulo-purple hover:bg-qulo-purple/20 transition-colors"
              >
                {letter}
              </a>
            ))}
          </nav>

          <div className="space-y-10">
            {letters.map((letter) => (
              <section key={letter} id={`letter-${encodeURIComponent(letter)}`}>
                <div className="sticky top-20 z-10 bg-qulo-bg/95 backdrop-blur-sm py-2 mb-4 border-b border-white/[0.08]">
                  <span className="text-2xl font-bold text-qulo-green">{letter}</span>
                </div>
                <div className="space-y-4">
                  {terms
                    .filter((term) => letterOf(term.name) === letter)
                    .map((term) => (
                      <article
                        key={term.slug}
                        className="rounded-xl border border-white/[0.08] bg-white/[0.03] p-6 hover:bg-white/[0.05] transition-colors"
                      >
                        <h2 className="text-xl font-bold text-white mb-2">
                          <Link
                            href={`/${locale}/glossary/${term.slug}`}
                            className="hover:text-qulo-green transition-colors"
                          >
                            <span className="mr-2" aria-hidden="true">
                              {term.emoji}
                            </span>
                            {term.name}
                          </Link>
                        </h2>
                        <p className="text-qulo-text-secondary leading-relaxed text-sm">
                          {term.summary}
                        </p>
                      </article>
                    ))}
                </div>
              </section>
            ))}
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
