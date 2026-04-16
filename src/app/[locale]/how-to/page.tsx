import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { HOW_TO_GUIDES } from "@/lib/constants/howto";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.howto[locale] || PAGE_SEO.howto.en;
  const pageUrl = `${SITE_URL}/${locale}/how-to`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/how-to`;
  languages["x-default"] = `${SITE_URL}/tr/how-to`;

  return {
    title: seo.title,
    description: seo.description,
    keywords: [
      "how to use qulo",
      "qulo tutorial",
      "qulo guide",
      "qulo nasıl kullanılır",
      "how to create dating profile",
      "how to get matches",
      "dating app tutorial",
    ],
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: ogLocale,
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
    },
  };
}

const LABELS: Record<
  string,
  {
    heading: string;
    subheading: string;
    totalTime: string;
    readGuide: string;
    steps: string;
    introTitle: string;
    introBody: string;
  }
> = {
  tr: {
    heading: "Qulo Nasıl Kullanılır",
    subheading: "Adım adım rehberlerle Qulo'dan en iyi şekilde faydalanın",
    totalTime: "Toplam süre",
    readGuide: "Rehbere Başla",
    steps: "adım",
    introTitle: "Resmi Kullanım Rehberleri",
    introBody:
      "Bu rehberler Qulo ekibi tarafından hazırlandı. Uygulamayı ilk kez kullananlar için sıfırdan, deneyimliler için optimizasyon ipuçları.",
  },
  en: {
    heading: "How to Use Qulo",
    subheading: "Get the most out of Qulo with step-by-step guides",
    totalTime: "Total time",
    readGuide: "Start Guide",
    steps: "steps",
    introTitle: "Official Usage Guides",
    introBody:
      "These guides are created by the Qulo team. From zero for newcomers, to optimization tips for experienced users.",
  },
  de: {
    heading: "Wie man Qulo benutzt",
    subheading: "Hole das Beste aus Qulo mit Schritt-für-Schritt-Anleitungen",
    totalTime: "Gesamtzeit",
    readGuide: "Anleitung starten",
    steps: "Schritte",
    introTitle: "Offizielle Nutzungsanleitungen",
    introBody:
      "Diese Anleitungen wurden vom Qulo-Team erstellt. Von Grund auf für Anfänger, mit Optimierungstipps für erfahrene Nutzer.",
  },
  fr: {
    heading: "Comment utiliser Qulo",
    subheading: "Tirez le meilleur parti de Qulo avec des guides étape par étape",
    totalTime: "Temps total",
    readGuide: "Commencer le guide",
    steps: "étapes",
    introTitle: "Guides d'utilisation officiels",
    introBody:
      "Ces guides sont créés par l'équipe Qulo. De zéro pour les nouveaux venus, des conseils d'optimisation pour les utilisateurs expérimentés.",
  },
  es: {
    heading: "Cómo usar Qulo",
    subheading: "Aprovecha al máximo Qulo con guías paso a paso",
    totalTime: "Tiempo total",
    readGuide: "Iniciar guía",
    steps: "pasos",
    introTitle: "Guías de uso oficiales",
    introBody:
      "Estas guías están creadas por el equipo de Qulo. Desde cero para los recién llegados, con consejos de optimización para usuarios experimentados.",
  },
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

/** Converts ISO 8601 duration (e.g. "PT15M") to "15 min" localized string. */
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
 * JSON-LD structured data renderer — the source data is built entirely from
 * server-side static constants (howto.ts, metadata.ts) and route params that
 * are validated against a fixed list in generateStaticParams. No user input is
 * serialized. This is the standard pattern for SEO rich snippets.
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

export default async function HowToIndexPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = LABELS[locale] || LABELS.en;
  const sortedGuides = [...HOW_TO_GUIDES].sort(
    (a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: labels.heading,
    description: labels.subheading,
    url: `${SITE_URL}/${locale}/how-to`,
    inLanguage: locale,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: sortedGuides.map((guide, i) => ({
        "@type": "ListItem",
        position: i + 1,
        url: `${SITE_URL}/${locale}/how-to/${guide.slug}`,
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
            <p className="text-qulo-green text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              Qulo · How-to
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4">{labels.heading}</h1>
            <p className="text-qulo-text-secondary text-base max-w-2xl mx-auto">
              {labels.subheading}
            </p>
          </header>

          {/* Intro block — differentiates how-to from advice hub */}
          <section className="mb-10 rounded-2xl border border-qulo-green/20 bg-qulo-green/[0.04] p-6 sm:p-8">
            <h2 className="text-lg font-semibold text-qulo-green mb-2">
              {labels.introTitle}
            </h2>
            <p className="text-sm text-qulo-text-secondary leading-relaxed">
              {labels.introBody}
            </p>
          </section>

          {/* Guide cards — grid layout */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {sortedGuides.map((guide) => {
              const title = guide.titles[locale] || guide.titles.en;
              const description = guide.descriptions[locale] || guide.descriptions.en;

              return (
                <article
                  key={guide.slug}
                  className="group rounded-2xl border border-white/[0.08] bg-white/[0.03] p-7 transition-all duration-200 hover:border-qulo-green/30 hover:bg-white/[0.05] flex flex-col"
                >
                  <Link href={`/${locale}/how-to/${guide.slug}`} className="block flex-1 flex flex-col">
                    <div className="text-4xl mb-4" aria-hidden="true">{guide.emoji}</div>

                    <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-3">
                      <time dateTime={guide.publishedAt}>
                        {formatDate(guide.publishedAt, locale)}
                      </time>
                      <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-green/50" />
                      <span>
                        {labels.totalTime}: {formatTotalTime(guide.totalTime, locale)}
                      </span>
                    </div>

                    <h2 className="text-lg sm:text-xl font-bold text-white mb-3 group-hover:text-qulo-green transition-colors leading-snug">
                      {title}
                    </h2>

                    <p className="text-sm text-qulo-text-secondary leading-relaxed line-clamp-3 flex-1">
                      {description}
                    </p>

                    <div className="mt-5 flex items-center justify-between">
                      <span className="text-sm text-qulo-green font-semibold">
                        {labels.readGuide} &rarr;
                      </span>
                      <span className="text-[10px] px-2 py-1 rounded-full border border-qulo-green/20 text-qulo-green uppercase tracking-wide">
                        {guide.steps.length} {labels.steps}
                      </span>
                    </div>
                  </Link>
                </article>
              );
            })}
          </div>

          {/* Cross-link to advice hub */}
          <div className="mt-16 rounded-2xl border border-white/[0.08] bg-white/[0.02] p-8 text-center">
            <p className="text-sm text-qulo-text-secondary leading-relaxed max-w-2xl mx-auto">
              {locale === "tr" && (
                <>
                  Daha genel dating tavsiyeleri mi arıyorsunuz?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Dating Tavsiyeleri
                  </Link>{" "}
                  hub&apos;ına göz atın.
                </>
              )}
              {locale === "en" && (
                <>
                  Looking for general dating advice?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Visit the Advice hub
                  </Link>
                  .
                </>
              )}
              {locale === "de" && (
                <>
                  Suchen Sie allgemeine Dating-Ratschläge?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Besuchen Sie den Ratgeber-Hub
                  </Link>
                  .
                </>
              )}
              {locale === "fr" && (
                <>
                  Vous cherchez des conseils généraux de dating ?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Visitez le hub Conseils
                  </Link>
                  .
                </>
              )}
              {locale === "es" && (
                <>
                  ¿Buscas consejos generales de citas?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Visita el hub de Consejos
                  </Link>
                  .
                </>
              )}
              {!["tr", "en", "de", "fr", "es"].includes(locale) && (
                <>
                  Looking for general dating advice?{" "}
                  <Link href={`/${locale}/advice`} className="text-qulo-purple hover:underline">
                    Visit the Advice hub
                  </Link>
                  .
                </>
              )}
            </p>
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
