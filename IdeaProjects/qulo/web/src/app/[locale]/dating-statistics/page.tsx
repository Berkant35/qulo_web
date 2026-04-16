import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import {
  PAGE_SEO,
  SITE_URL,
  SITE_NAME,
  OG_LOCALES,
} from "@/lib/constants/metadata";
import {
  STAT_CATEGORIES,
  getHighlightStats,
  getLabel,
  getCategoryTitle,
  type DatingStat,
  type StatCategory,
} from "@/lib/constants/stats";

const PAGE_SLUG = "dating-statistics";
const PUBLISHED_AT = "2026-04-16";
const MODIFIED_AT = "2026-04-16";

/** Per-locale breadcrumb label for the Dating Statistics page */
const STATISTICS_LABELS: Record<string, string> = {
  tr: "İstatistikler", en: "Statistics", de: "Statistiken", fr: "Statistiques", es: "Estadísticas",
  ar: "إحصائيات", ru: "Статистика", pt: "Estatísticas", it: "Statistiche", ja: "統計",
  ko: "통계", zh: "统计", nl: "Statistieken", pl: "Statystyki", sv: "Statistik", hi: "आंकड़े",
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
  const seo = PAGE_SEO.statistics[locale] || PAGE_SEO.statistics.en;
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/${PAGE_SLUG}`;
  languages["x-default"] = `${SITE_URL}/tr/${PAGE_SLUG}`;
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
      locale: OG_LOCALES[locale] || "en_US",
      publishedTime: PUBLISHED_AT,
      modifiedTime: MODIFIED_AT,
    },
    twitter: {
      card: "summary_large_image",
      title: seo.title,
      description: seo.description,
    },
  };
}

/**
 * JSON-LD renderer — only static trusted content from constants.
 * Uses dangerouslySetInnerHTML because Next.js requires it for
 * application/ld+json scripts. Content is fully static (no user input):
 * derived from constants/stats.ts + constants/metadata.ts + locale slug.
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

/** Per-locale UI strings — kept inline for simple maintenance */
type UiCopy = {
  eyebrow: string;
  heroTitle: string;
  heroSubtitle: string;
  lastUpdated: string;
  citeThisReport: string;
  highlightHeading: string;
  contextParagraphs: Record<string, string>;
  citationHeading: string;
  citationIntro: string;
  citationApaLabel: string;
  citationMlaLabel: string;
  citationLinkLabel: string;
  shareHeading: string;
  shareTwitter: string;
  shareLinkedIn: string;
  methodologyHeading: string;
  methodologyText: string;
  aboutHeading: string;
  aboutText: string;
  ctaHeading: string;
  ctaText: string;
  relatedHeading: string;
  relatedSwipeFatigue: string;
  relatedQuizDating: string;
  relatedAbout: string;
  relatedGlossary: string;
  source: string;
};

function getCopy(locale: string): UiCopy {
  const isTr = locale === "tr";
  return {
    eyebrow: isTr ? "Veri Raporu" : "Data Report",
    heroTitle: isTr ? "Dating İstatistikleri 2026" : "Dating Statistics 2026",
    heroSubtitle: isTr
      ? "Online dating dünyasından kapsamlı veri raporu — kullanım, swipe yorgunluğu, eşleşme oranları, demografik veriler ve 2026 trendleri."
      : "A comprehensive data report from the online dating world — usage, swipe fatigue, match rates, demographics and 2026 trends.",
    lastUpdated: isTr
      ? "Son güncelleme: Nisan 2026"
      : "Last updated: April 2026",
    citeThisReport: isTr ? "Bu Raporu Kaynak Göster" : "Cite This Report",
    highlightHeading: isTr ? "Öne Çıkan Veriler" : "Key Highlights",
    contextParagraphs: {
      usage: isTr
        ? "Dating uygulamaları artık global bir fenomen. Dünya genelinde 381 milyondan fazla aktif kullanıcı, mobil dating endüstrisinin ne kadar büyüdüğünü gösteriyor. Ancak bu yoğun kullanım, beraberinde önemli sorunları da getiriyor."
        : "Dating apps have become a global phenomenon. With more than 381 million active users worldwide, it's clear how massive the mobile dating industry has become. But this heavy usage brings serious problems too.",
      fatigue: isTr
        ? "Yüksek kullanım rakamlarının altında ciddi bir tükenmişlik problemi yatıyor. Kullanıcıların büyük çoğunluğu dating app deneyiminden hoşnutsuz. Bu durum, swipe tabanlı modelin sınırlılıklarını net şekilde ortaya koyuyor."
        : "Beneath the high usage numbers lies a serious burnout problem. The vast majority of users are unhappy with their dating app experience, clearly exposing the limits of the swipe-based model.",
      matching: isTr
        ? "Eşleşme istatistikleri özellikle düşündürücü. Yapılan eşleşmelerin sadece küçük bir kısmı gerçek bir bağlantıya dönüşüyor. Bu, dating app'lerin temel vaadinin sorgulanmasına yol açıyor."
        : "Matching statistics are particularly striking. Only a small fraction of matches translate into real connections, which raises questions about the core promise of dating apps.",
      demographics: isTr
        ? "Z kuşağı dating uygulamalarını en aktif kullanan grup, ancak aynı zamanda swipe yorgunluğunu en çok yaşayan grup. Bu çelişki, yeni nesil dating çözümlerine olan ihtiyacı gösteriyor."
        : "Gen Z is the most active dating app generation, but they also experience swipe fatigue the most. This contradiction signals the need for next-generation dating solutions.",
      trends: isTr
        ? "2026'nın en belirgin dating trendi: kullanıcılar daha derin, daha anlamlı ve daha az yüzeysel deneyimler arıyor. Quiz dating, slow dating ve AI destekli eşleşme gibi yaklaşımlar yükselişte."
        : "The clearest dating trend of 2026: users are seeking deeper, more meaningful and less superficial experiences. Quiz dating, slow dating and AI-powered matching are on the rise.",
    },
    citationHeading: isTr ? "Bu Raporu Kaynak Gösterin" : "Cite This Report",
    citationIntro: isTr
      ? "Bu raporu makalenizde, blog yazınızda veya araştırmanızda kaynak göstermek için aşağıdaki formatlardan birini kullanabilirsiniz."
      : "Use one of the formats below to cite this report in your article, blog post or research.",
    citationApaLabel: "APA",
    citationMlaLabel: "MLA",
    citationLinkLabel: isTr ? "Düz bağlantı" : "Plain link",
    shareHeading: isTr ? "Sosyal Medyada Paylaş" : "Share on Social Media",
    shareTwitter: "Twitter / X",
    shareLinkedIn: "LinkedIn",
    methodologyHeading: isTr ? "Metodoloji" : "Methodology",
    methodologyText: isTr
      ? "Bu raporda yer alan veriler Statista, Pew Research Center ve Stanford Üniversitesi gibi tanınmış araştırma kuruluşlarından derlenmiştir. Ek olarak Qulo platformunun kendi anonim kullanım verileri analiz edilmiştir. Tüm rakamlar Nisan 2026 itibarıyla en güncel halleridir ve yıllık olarak güncellenir."
      : "The data in this report is compiled from established research organizations such as Statista, Pew Research Center and Stanford University. Anonymous usage data from the Qulo platform is also analyzed. All figures are current as of April 2026 and updated annually.",
    aboutHeading: isTr
      ? "Bu Raporu Kim Yayınlıyor?"
      : "Who Publishes This Report?",
    aboutText: isTr
      ? "Qulo, soru tabanlı eşleşme ile dating sektörüne yenilik getiren bir uygulamadır. Swipe yerine quiz mekaniği kullanarak daha derin ve anlamlı bağlantılar kurmayı amaçlar."
      : "Qulo is a dating app that brings innovation to the industry with question-based matching. Instead of swiping, it uses quiz mechanics to enable deeper and more meaningful connections.",
    ctaHeading: isTr
      ? "Yeni Nesil Dating Deneyimini Keşfet"
      : "Discover the Next Generation of Dating",
    ctaText: isTr
      ? "Swipe yorgunluğuna son. Sorularla tanış, gerçek bağlantılar kur."
      : "End swipe fatigue. Meet through questions, build real connections.",
    relatedHeading: isTr ? "İlgili İçerikler" : "Related Content",
    relatedSwipeFatigue: isTr
      ? "Swipe Yorgunluğu Nedir?"
      : "What is Swipe Fatigue?",
    relatedQuizDating: isTr
      ? "Quiz Dating: Eşleşmenin Geleceği"
      : "Quiz Dating: The Future of Matching",
    relatedAbout: isTr ? "Qulo Hakkında" : "About Qulo",
    relatedGlossary: isTr ? "Dating Sözlüğü" : "Dating Glossary",
    source: isTr ? "Kaynak" : "Source",
  };
}

export default async function DatingStatisticsPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const copy = getCopy(locale);
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const seo = PAGE_SEO.statistics[locale] || PAGE_SEO.statistics.en;
  const highlightStats = getHighlightStats();

  // JSON-LD: Article schema — trusted constants only
  const articleJsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: seo.title,
    description: seo.description,
    url: pageUrl,
    inLanguage: locale,
    datePublished: PUBLISHED_AT,
    dateModified: MODIFIED_AT,
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
        url: `${SITE_URL}/brand/purple_diamond.svg`,
      },
    },
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": pageUrl,
    },
  };

  // JSON-LD: Dataset schema — each stat as PropertyValue (QuantitativeValue)
  const variableMeasured = STAT_CATEGORIES.flatMap((cat) =>
    cat.stats.map((stat) => ({
      "@type": "PropertyValue",
      name: getLabel(stat, locale),
      value: stat.value,
      ...(stat.source ? { description: stat.source } : {}),
    }))
  );

  const datasetJsonLd = {
    "@context": "https://schema.org",
    "@type": "Dataset",
    name: seo.title,
    description: seo.description,
    url: pageUrl,
    inLanguage: locale,
    datePublished: PUBLISHED_AT,
    dateModified: MODIFIED_AT,
    keywords: [
      "dating statistics",
      "online dating",
      "swipe fatigue",
      "dating trends 2026",
      "quiz dating",
    ],
    creator: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
    },
    variableMeasured,
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* JSON-LD — static trusted constants only, no user input */}
      <JsonLd data={articleJsonLd} />
      <JsonLd data={datasetJsonLd} />

      <article className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: STATISTICS_LABELS[locale] || STATISTICS_LABELS.en }]}
          />

          {/* Hero */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {copy.eyebrow}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {copy.heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-2xl mx-auto mb-6">
              {copy.heroSubtitle}
            </p>
            <div className="flex flex-wrap items-center justify-center gap-4 text-xs text-qulo-text-secondary">
              <time dateTime={MODIFIED_AT}>{copy.lastUpdated}</time>
              <span aria-hidden="true">•</span>
              <a
                href="#cite"
                className="text-qulo-green hover:underline focus:underline"
              >
                {copy.citeThisReport}
              </a>
            </div>
          </header>

          {/* Highlight Stats — 3 prominent cards */}
          <section aria-labelledby="highlights" className="mb-20">
            <h2
              id="highlights"
              className="text-2xl font-bold text-qulo-green mb-6 text-center"
            >
              {copy.highlightHeading}
            </h2>
            <dl className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              {highlightStats.slice(0, 3).map((stat) => (
                <div
                  key={`${stat.category}-${stat.value}`}
                  className="rounded-2xl border border-qulo-purple/30 bg-gradient-to-br from-qulo-purple/10 to-qulo-green/5 p-6 text-center"
                >
                  <dt className="sr-only">{getLabel(stat, locale)}</dt>
                  <dd>
                    <p className="text-4xl sm:text-5xl font-bold text-qulo-purple mb-3">
                      {stat.value}
                    </p>
                    <p className="text-sm text-white leading-snug">
                      {getLabel(stat, locale)}
                    </p>
                    {stat.source && (
                      <p className="mt-3 text-[10px] uppercase tracking-wider text-qulo-text-secondary">
                        {copy.source}: {stat.source}
                      </p>
                    )}
                  </dd>
                </div>
              ))}
            </dl>
          </section>

          {/* Categories */}
          {STAT_CATEGORIES.map((cat: StatCategory) => {
            const title = getCategoryTitle(cat, locale);
            const context = copy.contextParagraphs[cat.key];
            return (
              <section
                key={cat.key}
                aria-labelledby={`cat-${cat.key}`}
                className="mb-16"
              >
                <h2
                  id={`cat-${cat.key}`}
                  className="text-2xl sm:text-3xl font-bold text-qulo-purple mb-6 flex items-center gap-3"
                >
                  <span aria-hidden="true">{cat.emoji}</span>
                  <span>{title}</span>
                </h2>

                {context && (
                  <p className="text-qulo-text-secondary leading-relaxed text-sm mb-6 max-w-3xl">
                    {context}
                  </p>
                )}

                <dl className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  {cat.stats.map((stat: DatingStat) => (
                    <div
                      key={`${stat.category}-${stat.value}-${stat.labels.en}`}
                      className={`rounded-xl border p-5 ${
                        stat.highlight
                          ? "border-qulo-green/40 bg-qulo-green/5"
                          : "border-white/[0.08] bg-white/[0.03]"
                      }`}
                    >
                      <dt className="sr-only">{getLabel(stat, locale)}</dt>
                      <dd>
                        <p
                          className={`text-3xl sm:text-4xl font-bold mb-2 ${
                            stat.highlight
                              ? "text-qulo-green"
                              : "text-qulo-purple"
                          }`}
                        >
                          {stat.value}
                        </p>
                        <p className="text-sm text-white leading-snug">
                          {getLabel(stat, locale)}
                        </p>
                        {stat.source && (
                          <p className="mt-3 text-[10px] uppercase tracking-wider text-qulo-text-secondary">
                            {copy.source}: {stat.source}
                          </p>
                        )}
                      </dd>
                    </div>
                  ))}
                </dl>
              </section>
            );
          })}

          {/* Citation Section — backlink magnet */}
          <section
            id="cite"
            aria-labelledby="cite-heading"
            className="mb-16 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-8 scroll-mt-28"
          >
            <h2
              id="cite-heading"
              className="text-2xl font-bold text-qulo-green mb-3"
            >
              {copy.citationHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-6">
              {copy.citationIntro}
            </p>

            <div className="space-y-4 text-sm">
              <div>
                <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-purple mb-2">
                  {copy.citationApaLabel}
                </p>
                <code className="block w-full rounded-lg border border-white/[0.08] bg-black/40 p-3 text-xs text-white whitespace-pre-wrap break-words">
                  Qulo (2026). {copy.heroTitle}. {pageUrl}
                </code>
              </div>
              <div>
                <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-purple mb-2">
                  {copy.citationMlaLabel}
                </p>
                <code className="block w-full rounded-lg border border-white/[0.08] bg-black/40 p-3 text-xs text-white whitespace-pre-wrap break-words">
                  Qulo. &quot;{copy.heroTitle}.&quot; Qulo, 2026. Web. {pageUrl}
                </code>
              </div>
              <div>
                <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-purple mb-2">
                  {copy.citationLinkLabel}
                </p>
                <code className="block w-full rounded-lg border border-white/[0.08] bg-black/40 p-3 text-xs text-qulo-green whitespace-pre-wrap break-words">
                  &lt;a href=&quot;{pageUrl}&quot;&gt;{copy.heroTitle} —
                  Qulo&lt;/a&gt;
                </code>
              </div>
            </div>

            <div className="mt-8">
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-green mb-3">
                {copy.shareHeading}
              </p>
              <div className="flex flex-wrap gap-3">
                <a
                  href={`https://twitter.com/intent/tweet?text=${encodeURIComponent(
                    copy.heroTitle
                  )}&url=${encodeURIComponent(pageUrl)}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="rounded-lg border border-white/[0.1] bg-white/[0.04] px-4 py-2 text-xs text-white hover:bg-white/[0.08] transition-colors"
                >
                  {copy.shareTwitter}
                </a>
                <a
                  href={`https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(
                    pageUrl
                  )}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="rounded-lg border border-white/[0.1] bg-white/[0.04] px-4 py-2 text-xs text-white hover:bg-white/[0.08] transition-colors"
                >
                  {copy.shareLinkedIn}
                </a>
              </div>
            </div>
          </section>

          {/* Methodology */}
          <section className="mb-16">
            <h2 className="text-2xl font-bold text-qulo-purple mb-4">
              {copy.methodologyHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary leading-relaxed max-w-3xl">
              {copy.methodologyText}
            </p>
          </section>

          {/* About Qulo */}
          <section className="mb-16">
            <h2 className="text-2xl font-bold text-qulo-green mb-4">
              {copy.aboutHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary leading-relaxed max-w-3xl mb-3">
              {copy.aboutText}
            </p>
            <Link
              href={`/${locale}/about`}
              className="text-sm text-qulo-purple hover:underline focus:underline"
            >
              {copy.relatedAbout} →
            </Link>
          </section>

          {/* CTA */}
          <section className="mb-16 text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">
              {copy.ctaHeading}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-6 max-w-xl mx-auto">
              {copy.ctaText}
            </p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>

          {/* Internal Links */}
          <section aria-labelledby="related-heading">
            <h2
              id="related-heading"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {copy.relatedHeading}
            </h2>
            <ul className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <li>
                <Link
                  href={`/${locale}/blog/what-is-swipe-fatigue`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedSwipeFatigue}
                  </p>
                </Link>
              </li>
              <li>
                <Link
                  href={`/${locale}/blog/quiz-dating-future-of-matching`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedQuizDating}
                  </p>
                </Link>
              </li>
              <li>
                <Link
                  href={`/${locale}/about`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedAbout}
                  </p>
                </Link>
              </li>
              <li>
                <Link
                  href={`/${locale}/glossary`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedGlossary}
                  </p>
                </Link>
              </li>
            </ul>
          </section>
        </div>
      </article>

      <Footer />
    </main>
  );
}
