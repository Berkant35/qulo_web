import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { JsonLd } from "@/components/shared/JsonLd";
import { SourceList } from "@/components/shared/SourceList";
import { ArticleBlocks, type LocalizedArticle } from "@/components/blog/ArticleBlocks";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { ANSWER_PAGES, answerQuestion, answerSummary } from "@/lib/constants/answers";
import { ANSWER_LABELS } from "@/lib/constants/answerLabels";
import { howQuestionBasedMatchingWorks } from "../_content/how-question-based-matching-works";
import { isQuloFree } from "../_content/is-qulo-free";
import { isQuloSafe } from "../_content/is-qulo-safe";
import { whatMakesAGoodDatingAppQuestion } from "../_content/what-makes-a-good-dating-app-question";
import { whyAmINotGettingMatches } from "../_content/why-am-i-not-getting-matches";

/** Body content keyed by slug. Every entry in ANSWER_PAGES needs one. */
const ANSWER_BODIES: Record<string, LocalizedArticle> = {
  "how-question-based-matching-works": howQuestionBasedMatchingWorks,
  "is-qulo-free": isQuloFree,
  "is-qulo-safe": isQuloSafe,
  "what-makes-a-good-dating-app-question": whatMakesAGoodDatingAppQuestion,
  "why-am-i-not-getting-matches": whyAmINotGettingMatches,
};

export function generateStaticParams() {
  return locales.flatMap((locale) =>
    ANSWER_PAGES.map((page) => ({ locale, slug: page.slug })),
  );
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const page = ANSWER_PAGES.find((candidate) => candidate.slug === slug);
  if (!page) return {};

  const question = answerQuestion(page, locale);
  const summary = answerSummary(page, locale);
  const pageUrl = `${SITE_URL}/${locale}/answers/${slug}`;

  const languages = alternateLanguages(`/answers/${slug}`);

  return {
    title: `${question} — ${SITE_NAME}`,
    description: summary,
    keywords: page.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: question,
      description: summary,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: OG_LOCALES[locale] || "en_US",
      publishedTime: page.publishedAt,
      modifiedTime: page.updatedAt ?? page.publishedAt,
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title: question,
      description: summary,
      images: ogImages(),
    },
  };
}

function formatDate(iso: string, locale: string): string {
  const localeMap: Record<string, string> = {
    tr: "tr-TR", en: "en-US", de: "de-DE", fr: "fr-FR", es: "es-ES",
    ar: "ar-SA", ja: "ja-JP", ko: "ko-KR", zh: "zh-CN", ru: "ru-RU",
    pt: "pt-BR", it: "it-IT", nl: "nl-NL", pl: "pl-PL", sv: "sv-SE", hi: "hi-IN",
  };
  try {
    return new Date(iso).toLocaleDateString(localeMap[locale] || "en-US", {
      year: "numeric", month: "long", day: "numeric",
    });
  } catch {
    return iso;
  }
}

export default async function AnswerPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const page = ANSWER_PAGES.find((candidate) => candidate.slug === slug);
  if (!page) notFound();

  const question = answerQuestion(page, locale);
  const summary = answerSummary(page, locale);
  const body = ANSWER_BODIES[slug];
  const labels = ANSWER_LABELS[locale] || ANSWER_LABELS.en;
  const others = ANSWER_PAGES.filter((candidate) => candidate.slug !== slug);
  const updated = page.updatedAt ?? page.publishedAt;

  // The visible question and its visible answer — the markup describes content
  // that is actually on the page, which is the only case worth marking up.
  const faqJsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: [
      {
        "@type": "Question",
        name: question,
        acceptedAnswer: { "@type": "Answer", text: summary },
      },
    ],
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <JsonLd data={faqJsonLd} />
      <Navbar />
      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <article className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: labels.hubTitle, href: `/${locale}/answers` },
              { label: question },
            ]}
          />

          <h1 className="text-3xl sm:text-4xl font-bold text-white mb-4 leading-tight">
            {question}
          </h1>

          {/* The direct answer. Kept first and visually distinct because this is
              the passage a search snippet or an AI assistant lifts. */}
          <div className="rounded-2xl border border-qulo-green/30 bg-qulo-green/[0.06] p-6 mb-8">
            <p className="text-base text-white leading-relaxed">{summary}</p>
          </div>

          <p className="text-xs text-qulo-text-muted mb-10">
            {labels.updated}: <time dateTime={updated}>{formatDate(updated, locale)}</time>
          </p>

          {body ? <ArticleBlocks blocks={body[locale] || body.en} locale={locale} /> : null}

          {page.sources && page.sources.length > 0 ? (
            <div className="mt-14">
              <SourceList
                sources={page.sources}
                heading={labels.sourcesHeading}
                intro={labels.sourcesIntro}
              />
            </div>
          ) : null}

          <section className="mt-4" aria-labelledby="related-answers">
            <h2 id="related-answers" className="text-xl font-bold text-qulo-purple mb-4">
              {labels.related}
            </h2>
            <ul className="space-y-2">
              {others.map((other) => (
                <li key={other.slug}>
                  <Link
                    href={`/${locale}/answers/${other.slug}`}
                    className="text-qulo-text-secondary hover:text-white underline underline-offset-4"
                  >
                    {answerQuestion(other, locale)}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          <div className="mt-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6">
            <h2 className="text-lg font-semibold text-white mb-2">{labels.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-4">{labels.ctaDesc}</p>
            {/* Store buttons rather than a link to the home page. Analytics
                shows roughly one page per visitor, so a reader who has to click
                through to the home page to find a download link does not. */}
            <StoreButtons campaign="web-answers" />
          </div>
        </article>
      </div>
      <Footer />
    </main>
  );
}
