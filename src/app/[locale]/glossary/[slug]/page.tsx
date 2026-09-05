import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { JsonLd } from "@/components/shared/JsonLd";
import { ArticleBlocks } from "@/components/blog/ArticleBlocks";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { GLOSSARY_TERMS, SORTED_GLOSSARY_TERMS } from "@/lib/constants/glossary";
import { GLOSSARY_LABELS } from "@/lib/constants/glossaryLabels";
import { GLOSSARY_CONTENT } from "../_content";

export function generateStaticParams() {
  return locales.flatMap((locale) =>
    GLOSSARY_TERMS.map((term) => ({ locale, slug: term.slug })),
  );
}

/** The localized entry for a term, or undefined if the slug is unknown. */
function entryFor(slug: string, locale: string) {
  const localized = GLOSSARY_CONTENT[slug];
  return localized ? localized[locale] : undefined;
}

/** "What is %s?" filled in with the term as it is said in this language. */
function headline(template: string, term: string): string {
  return template.replace("%s", term);
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const term = GLOSSARY_TERMS.find((candidate) => candidate.slug === slug);
  const entry = entryFor(slug, locale);
  if (!term || !entry) return {};

  const labels = GLOSSARY_LABELS[locale] || GLOSSARY_LABELS.en;
  const title = headline(labels.question, entry.term);
  const pageUrl = `${SITE_URL}/${locale}/glossary/${slug}`;

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/glossary/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/glossary/${slug}`;

  return {
    title: `${title} — ${SITE_NAME}`,
    description: entry.summary,
    keywords: term.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description: entry.summary,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: OG_LOCALES[locale] || "en_US",
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description: entry.summary,
      images: ogImages(),
    },
  };
}

export default async function GlossaryTermPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const term = GLOSSARY_TERMS.find((candidate) => candidate.slug === slug);
  const entry = entryFor(slug, locale);
  if (!term || !entry) notFound();

  const labels = GLOSSARY_LABELS[locale] || GLOSSARY_LABELS.en;
  const title = headline(labels.question, entry.term);
  const related = term.related
    .map((relatedSlug) => {
      const relatedTerm = SORTED_GLOSSARY_TERMS.find((c) => c.slug === relatedSlug);
      const relatedEntry = entryFor(relatedSlug, locale);
      return relatedTerm && relatedEntry
        ? { slug: relatedSlug, emoji: relatedTerm.emoji, name: relatedEntry.term }
        : null;
    })
    .filter((value): value is { slug: string; emoji: string; name: string } => value !== null);

  // DefinedTerm only. The visible <Breadcrumb> component emits its own
  // BreadcrumbList — richer, since it starts at the home page — so declaring a
  // second one here put two competing trails on all 432 term pages.
  const jsonLd = [
    {
      "@context": "https://schema.org",
      "@type": "DefinedTerm",
      name: entry.term,
      description: entry.summary,
      url: `${SITE_URL}/${locale}/glossary/${slug}`,
      inDefinedTermSet: {
        "@type": "DefinedTermSet",
        name: labels.hubTitle,
        url: `${SITE_URL}/${locale}/glossary`,
      },
    },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <JsonLd data={jsonLd} />
      <Navbar />
      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <article className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: labels.hubTitle, href: `/${locale}/glossary` },
              { label: entry.term },
            ]}
          />

          <h1 className="text-3xl sm:text-4xl font-bold text-white mb-6 leading-tight">
            <span className="mr-3" aria-hidden="true">
              {term.emoji}
            </span>
            {title}
          </h1>

          {/* The definition, first and visually distinct — this is the passage a
              search snippet or an AI assistant lifts, so it stands alone. */}
          <div className="rounded-2xl border border-qulo-green/30 bg-qulo-green/[0.06] p-6 mb-10">
            <p className="text-qulo-green text-xs font-semibold uppercase tracking-[0.2em] mb-3">
              {labels.inShort}
            </p>
            <p className="text-base text-white leading-relaxed">
              <dfn className="not-italic font-semibold">{entry.term}</dfn>
              {" — "}
              {entry.summary}
            </p>
          </div>

          <ArticleBlocks blocks={entry.blocks} locale={locale} excludeSlug={slug} />

          {term.article ? (
            <div className="mt-12 rounded-2xl border border-qulo-purple/25 bg-qulo-purple/[0.06] p-6">
              <Link
                href={`/${locale}/${term.article.type}/${term.article.slug}`}
                className="text-qulo-purple font-medium hover:underline underline-offset-4"
              >
                {labels.readMore} →
              </Link>
            </div>
          ) : null}

          {related.length > 0 ? (
            <section className="mt-12" aria-labelledby="related-terms">
              <h2 id="related-terms" className="text-xl font-bold text-qulo-purple mb-4">
                {labels.related}
              </h2>
              <ul className="flex flex-wrap gap-2">
                {related.map((item) => (
                  <li key={item.slug}>
                    <Link
                      href={`/${locale}/glossary/${item.slug}`}
                      className="inline-flex items-center gap-2 rounded-lg border border-white/[0.08] bg-white/[0.03] px-3 py-2 text-sm text-qulo-text-secondary hover:bg-white/[0.06] hover:text-white transition-colors"
                    >
                      <span aria-hidden="true">{item.emoji}</span>
                      {item.name}
                    </Link>
                  </li>
                ))}
              </ul>
            </section>
          ) : null}

          <div className="mt-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6">
            <h2 className="text-lg font-semibold text-white mb-2">{labels.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-4">{labels.ctaDesc}</p>
            {/* Store buttons rather than a link to the home page. Analytics
                shows roughly one page per visitor, so a reader who has to click
                through to the home page to find a download link does not. */}
            <StoreButtons campaign="web-glossary" />
          </div>

          <p className="mt-8">
            <Link
              href={`/${locale}/glossary`}
              className="text-qulo-text-muted text-sm hover:text-white underline underline-offset-4"
            >
              ← {labels.backToGlossary}
            </Link>
          </p>
        </article>
      </div>
      <Footer />
    </main>
  );
}
