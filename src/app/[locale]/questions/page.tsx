import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { JsonLd } from "@/components/shared/JsonLd";
import { ArticleBlocks } from "@/components/blog/ArticleBlocks";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { EXAMPLE_QUESTIONS, QUESTION_CATEGORIES } from "@/lib/constants/exampleQuestions";
import { QUESTION_LABELS } from "@/lib/constants/questionLabels";
import { writingQuestions } from "./_content/writing-questions";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

function labelsFor(locale: string) {
  return QUESTION_LABELS[locale] || QUESTION_LABELS.en;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.questions?.[locale] || PAGE_SEO.questions?.en;
  const labels = labelsFor(locale);
  const title = seo?.title ?? `${labels.title} — ${SITE_NAME}`;
  const description = seo?.description ?? labels.intro;
  const pageUrl = `${SITE_URL}/${locale}/questions`;

  const languages = alternateLanguages("/questions");

  return {
    title,
    description,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: OG_LOCALES[locale] || "en_US",
      images: ogImages(),
    },
    twitter: { card: "summary_large_image", title, description, images: ogImages() },
  };
}

export default async function QuestionsPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = labelsFor(locale);
  const questions = EXAMPLE_QUESTIONS[locale] || EXAMPLE_QUESTIONS.en;
  const body = writingQuestions[locale] || writingQuestions.en;

  const byCategory = QUESTION_CATEGORIES.map((category) => ({
    category,
    heading: labels.categories[category] || category,
    items: questions.filter((question) => question.category === category),
  })).filter((group) => group.items.length > 0);

  // ItemList over the questions actually printed below. Everything here is
  // static in-repo content, never user input.
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "ItemList",
    name: labels.title,
    description: labels.intro,
    url: `${SITE_URL}/${locale}/questions`,
    inLanguage: locale,
    numberOfItems: questions.length,
    itemListElement: questions.map((question, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: question.question,
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
        <div className="max-w-2xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: labels.title }]} />

          <header className="mb-10">
            <h1 className="text-3xl sm:text-4xl font-bold mb-4 leading-tight">
              {labels.title}
            </h1>
            <p className="text-lg text-qulo-text-secondary">{labels.intro}</p>
          </header>

          <ArticleBlocks blocks={body} locale={locale} />

          <section className="mt-14" aria-labelledby="examples">
            <h2 id="examples" className="text-2xl font-bold text-qulo-purple mb-6">
              {labels.examplesHeading}
            </h2>

            <div className="space-y-10">
              {byCategory.map((group) => (
                <div key={group.category}>
                  <h3 className="text-sm font-semibold uppercase tracking-[0.2em] text-qulo-green mb-4">
                    {group.heading}
                  </h3>
                  <ul className="space-y-4">
                    {group.items.map((question) => (
                      <li
                        key={question.question}
                        className="rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                      >
                        <p className="text-white font-medium mb-3">{question.question}</p>
                        <p className="text-[10px] uppercase tracking-wider text-qulo-text-muted mb-2">
                          {labels.optionsLabel}
                        </p>
                        <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                          {question.answers.map((answer) => (
                            <li
                              key={answer}
                              className="rounded-lg border border-white/[0.06] px-3 py-2 text-sm text-qulo-text-secondary"
                            >
                              {answer}
                            </li>
                          ))}
                        </ul>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          </section>

          <div className="mt-14 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6">
            <h2 className="text-lg font-semibold text-white mb-2">{labels.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-4">{labels.ctaDesc}</p>
            {/* Store buttons rather than a link to the home page. Analytics
                shows roughly one page per visitor, so a reader who has to click
                through to the home page to find a download link does not. */}
            <StoreButtons campaign="web-questions" />
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
