import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import { ADVICE_GUIDES } from "@/lib/constants/advice";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.advice[locale] || PAGE_SEO.advice.en;
  const pageUrl = `${SITE_URL}/${locale}/advice`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages = alternateLanguages("/advice");

  return {
    title: seo.title,
    description: seo.description,
    keywords: [
      "dating advice",
      "dating tips",
      "relationship advice",
      "online dating guide",
      "dating tavsiyeleri",
      "ilişki tavsiyeleri",
    ],
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: ogLocale,
      images: ogImages(),
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
      images: ogImages(),
    },
  };
}

const LABELS: Record<string, { heading: string; subheading: string; readTime: string; readMore: string }> = {
  tr: { heading: "Dating Tavsiyeleri", subheading: "Uzman rehberleri ile daha iyi dating deneyimi", readTime: "dk okuma", readMore: "Rehberi Oku" },
  en: { heading: "Dating Advice", subheading: "Better dating experience with expert guides", readTime: "min read", readMore: "Read Guide" },
  de: { heading: "Dating-Ratgeber", subheading: "Besseres Dating-Erlebnis mit Expertenleitfäden", readTime: "Min. Lesezeit", readMore: "Leitfaden lesen" },
  fr: { heading: "Conseils Dating", subheading: "Meilleure expérience de dating avec guides experts", readTime: "min de lecture", readMore: "Lire le guide" },
  es: { heading: "Consejos de Citas", subheading: "Mejor experiencia de citas con guías expertas", readTime: "min de lectura", readMore: "Leer guía" },
};

function formatDate(iso: string, locale: string): string {
  const d = new Date(iso);
  const localeMap: Record<string, string> = {
    tr: "tr-TR", en: "en-US", de: "de-DE", fr: "fr-FR", es: "es-ES",
    ar: "ar-SA", ja: "ja-JP", ko: "ko-KR", zh: "zh-CN", ru: "ru-RU",
    pt: "pt-BR", it: "it-IT", nl: "nl-NL", pl: "pl-PL", sv: "sv-SE", hi: "hi-IN",
  };
  try {
    return d.toLocaleDateString(localeMap[locale] || "en-US", {
      year: "numeric",
      month: "long",
      day: "numeric",
    });
  } catch {
    return iso;
  }
}

/**
 * JSON-LD structured data — trusted server-side constants only (no user input).
 * Standard Next.js Server Component pattern for SEO rich snippets.
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

export default async function AdviceIndexPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = LABELS[locale] || LABELS.en;
  const sortedGuides = [...ADVICE_GUIDES].sort(
    (a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: labels.heading,
    description: labels.subheading,
    url: `${SITE_URL}/${locale}/advice`,
    inLanguage: locale,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: sortedGuides.map((guide, i) => ({
        "@type": "ListItem",
        position: i + 1,
        url: `${SITE_URL}/${locale}/advice/${guide.slug}`,
        name: guide.titles[locale] || guide.titles.en,
      })),
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <JsonLd data={collectionJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: labels.heading }]}
          />

          {/* Header */}
          <header className="mb-14 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              Qulo · Guides
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4">{labels.heading}</h1>
            <p className="text-qulo-text-secondary text-base max-w-2xl mx-auto">
              {labels.subheading}
            </p>
          </header>

          {/* Guide cards — grid layout */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {sortedGuides.map((guide) => {
              const title = guide.titles[locale] || guide.titles.en;
              const description = guide.descriptions[locale] || guide.descriptions.en;

              return (
                <article
                  key={guide.slug}
                  className="group rounded-2xl border border-white/[0.08] bg-white/[0.03] p-7 transition-all duration-200 hover:border-qulo-purple/30 hover:bg-white/[0.05] flex flex-col"
                >
                  <Link href={`/${locale}/advice/${guide.slug}`} className="block flex-1 flex flex-col">
                    <div className="text-4xl mb-4" aria-hidden="true">{guide.emoji}</div>

                    <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-3">
                      <time dateTime={guide.publishedAt}>
                        {formatDate(guide.publishedAt, locale)}
                      </time>
                      <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
                      <span>
                        {guide.readingTime} {labels.readTime}
                      </span>
                    </div>

                    <h2 className="text-lg sm:text-xl font-bold text-white mb-3 group-hover:text-qulo-purple transition-colors leading-snug">
                      {title}
                    </h2>

                    <p className="text-sm text-qulo-text-secondary leading-relaxed line-clamp-3 flex-1">
                      {description}
                    </p>

                    <div className="mt-5 flex items-center justify-between">
                      <span className="text-sm text-qulo-green font-semibold">
                        {labels.readMore} &rarr;
                      </span>
                      <span className="text-[10px] px-2 py-1 rounded-full border border-qulo-purple/20 text-qulo-purple uppercase tracking-wide">
                        {guide.category}
                      </span>
                    </div>
                  </Link>
                </article>
              );
            })}
          </div>

          {/* Footer note */}
          <div className="mt-16 rounded-2xl border border-white/[0.08] bg-white/[0.02] p-8 text-center">
            <p className="text-sm text-qulo-text-secondary leading-relaxed max-w-2xl mx-auto">
              {locale === "tr"
                ? "Qulo ekibi tarafından hazırlanan bu rehberler, gerçek dating deneyimlerine ve psikoloji araştırmalarına dayanır. Sürekli güncellenir."
                : locale === "de"
                ? "Diese vom Qulo-Team erstellten Leitfäden basieren auf echten Dating-Erfahrungen und psychologischer Forschung. Regelmäßig aktualisiert."
                : locale === "fr"
                ? "Ces guides créés par l'équipe Qulo sont basés sur des expériences réelles de dating et la recherche en psychologie. Régulièrement mis à jour."
                : locale === "es"
                ? "Estas guías creadas por el equipo Qulo se basan en experiencias reales de citas e investigación psicológica. Se actualizan continuamente."
                : "These guides created by the Qulo team are based on real dating experiences and psychology research. Continuously updated."}
            </p>
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
