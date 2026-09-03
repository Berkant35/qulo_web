import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { ANSWER_PAGES, answerQuestion, answerSummary } from "@/lib/constants/answers";
import { ANSWER_LABELS } from "@/lib/constants/answerLabels";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const labels = ANSWER_LABELS[locale] || ANSWER_LABELS.en;
  const pageUrl = `${SITE_URL}/${locale}/answers`;

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/answers`;
  languages["x-default"] = `${SITE_URL}/tr/answers`;

  return {
    title: `${labels.hubTitle} — ${SITE_NAME}`,
    description: labels.hubIntro,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: `${labels.hubTitle} — ${SITE_NAME}`,
      description: labels.hubIntro,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: OG_LOCALES[locale] || "en_US",
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title: `${labels.hubTitle} — ${SITE_NAME}`,
      description: labels.hubIntro,
      images: ogImages(),
    },
  };
}

export default async function AnswersHubPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const labels = ANSWER_LABELS[locale] || ANSWER_LABELS.en;

  // Every question and its answer is visible on this page, so the markup
  // describes real on-page content rather than hidden data.
  const faqJsonLd = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: ANSWER_PAGES.map((page) => ({
      "@type": "Question",
      name: answerQuestion(page, locale),
      acceptedAnswer: { "@type": "Answer", text: answerSummary(page, locale) },
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <JsonLd data={faqJsonLd} />
      <Navbar />
      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <div className="max-w-2xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: labels.hubTitle }]} />

          <h1 className="text-4xl font-bold text-qulo-purple mb-3">
            {labels.hubTitle}
          </h1>
          <p className="text-qulo-text-secondary text-sm mb-10 leading-relaxed">
            {labels.hubIntro}
          </p>

          <div className="space-y-4">
            {ANSWER_PAGES.map((page) => (
              <article
                key={page.slug}
                className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6"
              >
                <h2 className="text-lg font-semibold text-white mb-2">
                  <Link
                    href={`/${locale}/answers/${page.slug}`}
                    className="hover:text-qulo-purple"
                  >
                    {answerQuestion(page, locale)}
                  </Link>
                </h2>
                <p className="text-sm text-qulo-text-secondary leading-relaxed">
                  {answerSummary(page, locale)}
                </p>
              </article>
            ))}
          </div>
        </div>
      </div>
      <Footer />
    </main>
  );
}
