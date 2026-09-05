import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { ADVICE_GUIDES } from "@/lib/constants/advice";
import { ArticleBlocks, type LocalizedArticle } from "@/components/blog/ArticleBlocks";
import { firstDateTips } from "./_content/first-date-tips";
import { datingProfileGuide } from "./_content/dating-profile-guide";
import { redFlagsOnlineDating } from "./_content/red-flags-online-dating";
import { longDistanceRelationships } from "./_content/long-distance-relationships";

/* ------------------------------------------------------------------ */
/*  Static params                                                      */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const guide of ADVICE_GUIDES) {
      params.push({ locale, slug: guide.slug });
    }
  }
  return params;
}

/* ------------------------------------------------------------------ */
/*  Metadata                                                           */
/* ------------------------------------------------------------------ */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const guide = ADVICE_GUIDES.find((g) => g.slug === slug);
  if (!guide) return {};

  const title = guide.titles[locale] || guide.titles.en;
  const description = guide.descriptions[locale] || guide.descriptions.en;
  const pageUrl = `${SITE_URL}/${locale}/advice/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/advice/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/advice/${slug}`;

  return {
    title: `${title} — Qulo`,
    description,
    keywords: guide.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
      publishedTime: guide.publishedAt,
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImages(),
    },
  };
}

/* ------------------------------------------------------------------ */
/*  Helpers                                                            */
/* ------------------------------------------------------------------ */
function formatDate(iso: string, locale: string): string {
  const d = new Date(iso);
  const localeMap: Record<string, string> = {
    tr: "tr-TR", en: "en-US", de: "de-DE", fr: "fr-FR", es: "es-ES",
    ar: "ar-SA", ja: "ja-JP", ko: "ko-KR", zh: "zh-CN", ru: "ru-RU",
    pt: "pt-BR", it: "it-IT", nl: "nl-NL", pl: "pl-PL", sv: "sv-SE", hi: "hi-IN",
  };
  try {
    return d.toLocaleDateString(localeMap[locale] || "en-US", {
      year: "numeric", month: "long", day: "numeric",
    });
  } catch {
    return iso;
  }
}

/**
 * JSON-LD helper — renders structured data from static server constants.
 * No user input is involved; all values come from hardcoded advice.ts / metadata.ts.
 */
function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      // eslint-disable-next-line react/no-danger
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

const READ_LABELS: Record<string, { readTime: string; backToAdvice: string; relatedGuides: string }> = {
  tr: { readTime: "dk okuma", backToAdvice: "Tüm Rehberler", relatedGuides: "Diğer Rehberler" },
  en: { readTime: "min read", backToAdvice: "All Guides", relatedGuides: "Related Guides" },
  de: { readTime: "Min. Lesezeit", backToAdvice: "Alle Leitfäden", relatedGuides: "Weitere Leitfäden" },
  fr: { readTime: "min de lecture", backToAdvice: "Tous les guides", relatedGuides: "Guides connexes" },
  es: { readTime: "min de lectura", backToAdvice: "Todas las guías", relatedGuides: "Guías relacionadas" },
};

/* ------------------------------------------------------------------ */
/*  Content router                                                     */
/* ------------------------------------------------------------------ */
/**
 * Guides authored as structured, fully localized data. Every article carries
 * all 16 locales, so no reader is served English under a translated canonical.
 * The per-locale JSX components this replaced shipped `tr` and `en` only.
 *
 * Every slug in `ADVICE_GUIDES` must appear here; a missing one renders an
 * empty body rather than silently falling back to English.
 */
const STRUCTURED_GUIDES: Record<string, LocalizedArticle> = {
  "first-date-tips": firstDateTips,
  "dating-profile-guide": datingProfileGuide,
  "red-flags-online-dating": redFlagsOnlineDating,
  "long-distance-relationships": longDistanceRelationships,
};

/** Word count of a guide's body in this locale, for the Article JSON-LD. */
function structuredWordCount(slug: string, locale: string): number | undefined {
  const blocks = STRUCTURED_GUIDES[slug]?.[locale] ?? STRUCTURED_GUIDES[slug]?.en;
  if (!blocks) return undefined;

  return blocks.reduce((total, block) => {
    const text = block.type === "ul" ? block.items.join(" ") : block.text;
    return total + text.split(/\s+/).filter(Boolean).length;
  }, 0);
}

function AdviceContent({ slug, locale }: { slug: string; locale: string }) {
  const article = STRUCTURED_GUIDES[slug];
  if (!article) return null;
  return <ArticleBlocks blocks={article[locale] || article.en} locale={locale} />;
}

/* ------------------------------------------------------------------ */
/*  Page component                                                     */
/* ------------------------------------------------------------------ */
export default async function AdvicePostPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const guide = ADVICE_GUIDES.find((g) => g.slug === slug);
  if (!guide) notFound();

  const title = guide.titles[locale] || guide.titles.en;
  const description = guide.descriptions[locale] || guide.descriptions.en;
  const labels = READ_LABELS[locale] || READ_LABELS.en;

  const otherGuides = ADVICE_GUIDES.filter((g) => g.slug !== slug);
  const wordCount = structuredWordCount(slug, locale);

  // Article JSON-LD
  const articleJsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: title,
    description,
    datePublished: guide.publishedAt,
    dateModified: guide.publishedAt,
    author: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
    },
    publisher: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
      logo: {
        "@type": "ImageObject",
        url: `${SITE_URL}/images/og-image.png`,
      },
    },
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": `${SITE_URL}/${locale}/advice/${slug}`,
    },
    keywords: guide.keywords.join(", "),
    articleSection: guide.category,
    // Counted from the rendered content; omitted for slugs whose body is still
    // per-locale JSX, since a guessed number is worse than no number.
    ...(wordCount !== undefined ? { wordCount } : {}),
    inLanguage: locale,
  };

  const CTA_LABELS: Record<string, { ctaTitle: string; ctaDesc: string }> = {
    tr: { ctaTitle: "Qulo'yu Indir", ctaDesc: "Sorularla tanismanin yeni yolunu kesfet. Hemen dene, ucretsiz!" },
    en: { ctaTitle: "Download Qulo", ctaDesc: "Discover the new way to meet through questions. Try it now, for free!" },
    de: { ctaTitle: "Qulo herunterladen", ctaDesc: "Entdecken Sie den neuen Weg, sich durch Fragen kennenzulernen." },
    fr: { ctaTitle: "Telecharger Qulo", ctaDesc: "Decouvrez la nouvelle facon de se rencontrer par les questions." },
    es: { ctaTitle: "Descargar Qulo", ctaDesc: "Descubre la nueva forma de conocerse a traves de preguntas." },
  };

  const cta = CTA_LABELS[locale] || CTA_LABELS.en;
  const adviceHeading = READ_LABELS[locale]?.backToAdvice || READ_LABELS.en.backToAdvice;

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* Article JSON-LD — trusted static constants only.
          BreadcrumbList JSON-LD is rendered by the <Breadcrumb /> component below. */}
      <JsonLd data={articleJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: adviceHeading, href: `/${locale}/advice` },
              { label: title },
            ]}
          />

          {/* Back to advice */}
          <nav className="mb-8">
            <Link
              href={`/${locale}/advice`}
              className="text-sm text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              &larr; {labels.backToAdvice}
            </Link>
          </nav>

          {/* Article header */}
          <header className="mb-10">
            <div className="text-5xl mb-4" aria-hidden="true">{guide.emoji}</div>
            <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-4 flex-wrap">
              <time dateTime={guide.publishedAt}>
                {formatDate(guide.publishedAt, locale)}
              </time>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
              <span>
                {guide.readingTime} {labels.readTime}
              </span>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
              <span className="px-2 py-0.5 rounded-full border border-qulo-purple/20 text-qulo-purple uppercase tracking-wide">
                {guide.category}
              </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-bold leading-tight mb-4">
              {title}
            </h1>
            <p className="text-lg text-qulo-text-secondary leading-relaxed">
              {description}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              {guide.keywords.map((kw) => (
                <span
                  key={kw}
                  className="text-[10px] px-2 py-0.5 rounded-full border border-white/[0.08] text-qulo-text-secondary"
                >
                  {kw}
                </span>
              ))}
            </div>
          </header>

          {/* Divider */}
          <div
            className="w-full h-px mb-10"
            style={{
              background: "linear-gradient(90deg, transparent 0%, rgba(187,134,252,0.3) 50%, transparent 100%)",
            }}
            aria-hidden="true"
          />

          {/* Article body */}
          <article className="prose-qulo">
            <AdviceContent slug={slug} locale={locale} />
          </article>

          {/* CTA Section */}
          <section className="mt-16 text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">{cta.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{cta.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons campaign="web-advice" />
            </div>
          </section>

          {/* Related guides */}
          {otherGuides.length > 0 && (
            <section className="mt-16">
              <h2 className="text-xl font-bold text-white mb-6">{labels.relatedGuides}</h2>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {otherGuides.map((rg) => (
                  <Link
                    key={rg.slug}
                    href={`/${locale}/advice/${rg.slug}`}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 hover:border-qulo-purple/30 hover:bg-white/[0.05] transition-all duration-200"
                  >
                    <div className="text-2xl mb-2" aria-hidden="true">{rg.emoji}</div>
                    <h3 className="text-sm font-semibold text-white mb-1">
                      {rg.titles[locale] || rg.titles.en}
                    </h3>
                    <p className="text-xs text-qulo-text-secondary line-clamp-2">
                      {rg.descriptions[locale] || rg.descriptions.en}
                    </p>
                  </Link>
                ))}
              </div>
            </section>
          )}

          {/* Cross-link to blog + glossary */}
          <section className="mt-12 rounded-xl border border-white/[0.08] bg-white/[0.02] p-6 text-center">
            <p className="text-sm text-qulo-text-secondary">
              {locale === "tr" && (
                <>Daha fazla içerik için <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Qulo Blog</Link> ve <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Dating Sözlüğü</Link>&apos;nü ziyaret edin.</>
              )}
              {locale === "en" && (
                <>For more content, visit the <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Qulo Blog</Link> and <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Dating Glossary</Link>.</>
              )}
              {locale === "de" && (
                <>Für mehr Inhalte besuchen Sie den <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Qulo Blog</Link> und das <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Dating-Glossar</Link>.</>
              )}
              {locale === "fr" && (
                <>Pour plus de contenu, visitez le <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Blog Qulo</Link> et le <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Glossaire du Dating</Link>.</>
              )}
              {locale === "es" && (
                <>Para más contenido, visita el <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Blog de Qulo</Link> y el <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Glosario de Citas</Link>.</>
              )}
              {!["tr", "en", "de", "fr", "es"].includes(locale) && (
                <>For more content, visit the <Link href={`/${locale}/blog`} className="text-qulo-purple hover:underline">Qulo Blog</Link> and <Link href={`/${locale}/glossary`} className="text-qulo-purple hover:underline">Dating Glossary</Link>.</>
              )}
            </p>
          </section>
        </div>
      </div>

      <Footer />
    </main>
  );
}
