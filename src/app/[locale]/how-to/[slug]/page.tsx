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
import { alternateLanguages } from "@/lib/seo/alternates";
import { HOW_TO_GUIDES } from "@/lib/constants/howto";

/* ------------------------------------------------------------------ */
/*  Static params                                                      */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const guide of HOW_TO_GUIDES) {
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
  const guide = HOW_TO_GUIDES.find((g) => g.slug === slug);
  if (!guide) return {};

  const title = guide.titles[locale] || guide.titles.en;
  const description = guide.descriptions[locale] || guide.descriptions.en;
  const pageUrl = `${SITE_URL}/${locale}/how-to/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages = alternateLanguages(`/how-to/${slug}`);

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

function formatTotalTime(iso: string, locale: string): string {
  const match = iso.match(/PT(\d+)M/);
  if (!match) return iso;
  const minutes = match[1];
  const unit: Record<string, string> = {
    tr: "dk", en: "min", de: "Min.", fr: "min", es: "min",
    ar: "د", ja: "分", ko: "분", zh: "分钟", ru: "мин",
    pt: "min", it: "min", nl: "min", pl: "min", sv: "min", hi: "मिनट",
  };
  return `${minutes} ${unit[locale] || "min"}`;
}

/**
 * JSON-LD renderer — data sourced entirely from server-side static constants
 * (howto.ts) and route params validated by generateStaticParams against a fixed
 * list. No user input is serialized. This is the canonical Next.js pattern for
 * structured data and is identical to the approach used in /advice pages.
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

const LABELS: Record<
  string,
  {
    totalTime: string;
    stepsCount: string;
    backToHub: string;
    relatedGuides: string;
    step: string;
    readyToStart: string;
    introBadge: string;
  }
> = {
  tr: {
    totalTime: "Toplam süre",
    stepsCount: "adım",
    backToHub: "Tüm Rehberler",
    relatedGuides: "Diğer Rehberler",
    step: "Adım",
    readyToStart: "Hazır mısınız?",
    introBadge: "Adım adım rehber",
  },
  en: {
    totalTime: "Total time",
    stepsCount: "steps",
    backToHub: "All Guides",
    relatedGuides: "Other Guides",
    step: "Step",
    readyToStart: "Ready to start?",
    introBadge: "Step-by-step guide",
  },
  de: {
    totalTime: "Gesamtzeit",
    stepsCount: "Schritte",
    backToHub: "Alle Anleitungen",
    relatedGuides: "Weitere Anleitungen",
    step: "Schritt",
    readyToStart: "Bereit anzufangen?",
    introBadge: "Schritt-für-Schritt-Anleitung",
  },
  fr: {
    totalTime: "Temps total",
    stepsCount: "étapes",
    backToHub: "Tous les guides",
    relatedGuides: "Autres guides",
    step: "Étape",
    readyToStart: "Prêt à commencer ?",
    introBadge: "Guide étape par étape",
  },
  es: {
    totalTime: "Tiempo total",
    stepsCount: "pasos",
    backToHub: "Todas las guías",
    relatedGuides: "Otras guías",
    step: "Paso",
    readyToStart: "¿Listo para empezar?",
    introBadge: "Guía paso a paso",
  },
};

/* ------------------------------------------------------------------ */
/*  Page component                                                     */
/* ------------------------------------------------------------------ */
export default async function HowToDetailPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const guide = HOW_TO_GUIDES.find((g) => g.slug === slug);
  if (!guide) notFound();

  const title = guide.titles[locale] || guide.titles.en;
  const description = guide.descriptions[locale] || guide.descriptions.en;
  const labels = LABELS[locale] || LABELS.en;

  const otherGuides = HOW_TO_GUIDES.filter((g) => g.slug !== slug);

  // HowTo JSON-LD — critical for Google step-by-step rich snippet
  const howToJsonLd = {
    "@context": "https://schema.org",
    "@type": "HowTo",
    name: title,
    description,
    totalTime: guide.totalTime,
    inLanguage: locale,
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
      "@id": `${SITE_URL}/${locale}/how-to/${slug}`,
    },
    step: guide.steps.map((step, index) => ({
      "@type": "HowToStep",
      position: index + 1,
      name: step.names[locale] || step.names.en,
      text: step.texts[locale] || step.texts.en,
      url: `${SITE_URL}/${locale}/how-to/${slug}#step-${index + 1}`,
    })),
  };

  const CTA_LABELS: Record<string, { ctaTitle: string; ctaDesc: string }> = {
    tr: { ctaTitle: "Qulo'yu Indir", ctaDesc: "Sorularla tanismanin yeni yolunu kesfet. Hemen dene, ucretsiz!" },
    en: { ctaTitle: "Download Qulo", ctaDesc: "Discover the new way to meet through questions. Try it now, for free!" },
    de: { ctaTitle: "Qulo herunterladen", ctaDesc: "Entdecken Sie den neuen Weg, sich durch Fragen kennenzulernen." },
    fr: { ctaTitle: "Telecharger Qulo", ctaDesc: "Decouvrez la nouvelle facon de se rencontrer par les questions." },
    es: { ctaTitle: "Descargar Qulo", ctaDesc: "Descubre la nueva forma de conocerse a traves de preguntas." },
  };

  const cta = CTA_LABELS[locale] || CTA_LABELS.en;

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* HowTo JSON-LD — enables Google step-by-step rich snippet.
          BreadcrumbList JSON-LD is rendered by <Breadcrumb /> below. */}
      <JsonLd data={howToJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: labels.backToHub, href: `/${locale}/how-to` },
              { label: title },
            ]}
          />

          {/* Back link */}
          <nav className="mb-8">
            <Link
              href={`/${locale}/how-to`}
              className="text-sm text-qulo-text-secondary hover:text-qulo-green transition-colors"
            >
              &larr; {labels.backToHub}
            </Link>
          </nav>

          {/* Header */}
          <header className="mb-10">
            <div className="text-5xl mb-4" aria-hidden="true">{guide.emoji}</div>
            <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-4 flex-wrap">
              <span className="px-2 py-0.5 rounded-full border border-qulo-green/20 text-qulo-green uppercase tracking-wide">
                {labels.introBadge}
              </span>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-green/50" />
              <time dateTime={guide.publishedAt}>
                {formatDate(guide.publishedAt, locale)}
              </time>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-green/50" />
              <span>
                {labels.totalTime}: {formatTotalTime(guide.totalTime, locale)}
              </span>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-green/50" />
              <span>
                {guide.steps.length} {labels.stepsCount}
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
              background:
                "linear-gradient(90deg, transparent 0%, rgba(105,240,174,0.3) 50%, transparent 100%)",
            }}
            aria-hidden="true"
          />

          {/* Ordered step list — semantic <ol> for HowTo rich snippet */}
          <ol className="space-y-6 list-none p-0 m-0">
            {guide.steps.map((step, index) => {
              const stepName = step.names[locale] || step.names.en;
              const stepText = step.texts[locale] || step.texts.en;
              const stepNumber = index + 1;
              return (
                <li
                  key={step.nameKey}
                  id={`step-${stepNumber}`}
                  className="scroll-mt-24"
                >
                  <article className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-7 transition-colors hover:border-qulo-green/25">
                    <div className="flex items-start gap-5">
                      {/* Step number badge */}
                      <div
                        className="flex-shrink-0 w-11 h-11 rounded-full border-2 border-qulo-green/40 flex items-center justify-center font-bold text-qulo-green bg-qulo-green/[0.08]"
                        aria-hidden="true"
                      >
                        {stepNumber}
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-[10px] uppercase tracking-[0.2em] text-qulo-green/80 font-semibold mb-2">
                          {labels.step} {stepNumber}
                        </p>
                        <h2 className="text-xl sm:text-2xl font-bold text-white mb-3 leading-snug">
                          {stepName}
                        </h2>
                        <p className="text-sm sm:text-base text-qulo-text-secondary leading-relaxed">
                          {stepText}
                        </p>
                      </div>
                    </div>
                  </article>
                </li>
              );
            })}
          </ol>

          {/* CTA Section */}
          <section className="mt-16 text-center rounded-2xl border border-qulo-green/20 bg-qulo-green/[0.04] p-10">
            <p className="text-xs uppercase tracking-[0.2em] text-qulo-green font-semibold mb-2">
              {labels.readyToStart}
            </p>
            <h2 className="text-2xl font-bold text-white mb-3">{cta.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{cta.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons campaign="web-howto" />
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
                    href={`/${locale}/how-to/${rg.slug}`}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 hover:border-qulo-green/30 hover:bg-white/[0.05] transition-all duration-200"
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
        </div>
      </div>

      <Footer />
    </main>
  );
}
