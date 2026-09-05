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
import { ogImages } from "@/lib/seo/openGraph";
import {
  FORBES_ONEPOLL_2024,
  HUANG_JPSP_2017,
  type StatSource,
} from "@/lib/constants/stats";
import { SourceLine } from "@/components/shared/SourceLine";
import { SourceList } from "@/components/shared/SourceList";

const PAGE_SLUG = "trends/2026";
const PUBLISHED_AT = "2026-01-15";
const MODIFIED_AT = "2026-09-01";

/** Per-locale breadcrumb labels */
const TRENDS_LABELS: Record<string, string> = {
  tr: "Trendler", en: "Trends", de: "Trends", fr: "Tendances", es: "Tendencias",
  ar: "الاتجاهات", ru: "Тренды", pt: "Tendências", it: "Tendenze", ja: "トレンド",
  ko: "트렌드", zh: "趋势", nl: "Trends", pl: "Trendy", sv: "Trender", hi: "रुझान",
};

const YEAR_LABEL = "2026";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.trends[locale] || PAGE_SEO.trends.en;
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/${PAGE_SLUG}`;
  languages["x-default"] = `${SITE_URL}/tr/${PAGE_SLUG}`;
  return {
    title: seo.title,
    description: seo.description,
    keywords: [
      "dating trends 2026",
      "online dating trends",
      "quiz dating",
      "swipe fatigue",
      "AI dating",
      "slow dating",
      "future of dating",
      "dating 2026",
    ],
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

/**
 * JSON-LD renderer — only static trusted content from constants.
 * Follows the same pattern as dating-statistics/page.tsx: content is fully
 * static (no user input), derived from constants + locale slug.
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

interface TrendCopy {
  title: string;
  body: string;
  /**
   * Required whenever `body` states a figure. This page carries a "cite this
   * report" block, so an unsourced number here is a credibility liability —
   * delete the claim rather than shipping it bare.
   */
  source?: StatSource;
}

interface LocaleCopy {
  eyebrow: string;
  sourcesHeading: string;
  sourcesIntro: string;
  heroTitle: string;
  heroSubtitle: string;
  lastUpdated: string;
  trendsHeading: string;
  conclusionHeading: string;
  conclusionPara1: string;
  conclusionPara2: string;
  ctaHeading: string;
  ctaText: string;
  citationHeading: string;
  citationIntro: string;
  citationApaLabel: string;
  citationMlaLabel: string;
  citationLinkLabel: string;
  relatedHeading: string;
  relatedStatistics: string;
  relatedBlog: string;
  relatedAbout: string;
  relatedFeatures: string;
  trends: TrendCopy[];
}

const COPY_TR: LocaleCopy = {
  eyebrow: "Uzman Analiz",
  sourcesHeading: "Kaynaklar",
  sourcesIntro:
    "Bu sayfadaki her rakam yayımlanmış birincil bir araştırmadan gelir ve yayıncısı, rapor adı, yayın tarihi ve örneklem büyüklüğüyle birlikte verilir. Trend başlıklarının geri kalanı editoryal değerlendirmedir, veri iddiası değildir.",
  heroTitle: "Dating Trendleri 2026",
  heroSubtitle: "Online dating dünyasının 2026 yılının en önemli trendleri",
  lastUpdated: "Son güncelleme: 1 Eylül 2026",
  trendsHeading: "2026'nın 12 Büyük Trendi",
  conclusionHeading: "Sonuç: Dating'in Yeni Çağı",
  conclusionPara1:
    "2026, dating dünyasının dönüşüm yılı olarak tarihe geçiyor. Swipe'ın sınırlarına ulaşıldığı, kullanıcıların daha anlamlı ve daha derin deneyimler aradığı bir yıl. Teknoloji, kullanıcı davranışı ve toplumsal değerler birlikte evrim geçiriyor — dating artık sadece bir eşleşme değil, bir yaşam tarzı seçimi.",
  conclusionPara2:
    "Qulo, bu dönüşümün merkezinde yer alıyor. Soru-cevap tabanlı eşleşme modeliyle, 16 dilde global bir topluluk sunuyor ve Z kuşağının değerlerine, kişilik öncelikli tanışmaya ve etik tasarıma uyum sağlıyor. 2026'da yeni nesil dating'in nasıl görüneceğini merak edenler için cevap net: daha derin, daha kişisel, daha anlamlı.",
  ctaHeading: "Trendin Parçası Ol",
  ctaText: "Swipe'dan quiz'e geç — 2026'nın en büyük trendine katıl.",
  citationHeading: "Bu Raporu Kaynak Göster",
  citationIntro:
    "Bu trend analizini araştırma, makale veya blog yazınızda kaynak göstermek için aşağıdaki formatları kullanabilirsiniz.",
  citationApaLabel: "APA",
  citationMlaLabel: "MLA",
  citationLinkLabel: "Düz bağlantı",
  relatedHeading: "İlgili İçerikler",
  relatedStatistics: "Dating İstatistikleri 2026",
  relatedBlog: "Blog",
  relatedAbout: "Qulo Hakkında",
  relatedFeatures: "Özellikler",
  trends: [
    {
      title: "Quiz Dating Yükselişi",
      body: "Kullanıcılar swipe yerine soru-cevap tabanlı eşleşmeye yöneliyor. Journal of Personality and Social Psychology'de yayımlanan 2017 tarihli bir çalışmada hızlı tanışma etkinliklerinden 1.961 gerçek ikinci buluşma kararı incelendi: karşısındakinin az önce söylediğinin üzerine takip sorusu soranlar, daha fazla ikinci buluşma daveti aldı.",
      source: HUANG_JPSP_2017,
    },
    {
      title: "Swipe Yorgunluğu Zirvesinde",
      body: "Forbes Health/OnePoll'un 2024 anketinde, son bir yıl içinde dating uygulaması kullanmış kişilerin %78'i tükenmişlik bildirdi; oran kadınlarda %80, erkeklerde %74. Bu, swipe modelinin sınırlarına ulaştığına dair en net göstergelerden biri.",
      source: FORBES_ONEPOLL_2024,
    },
    {
      title: "Slow Dating / Yavaş Tanışma",
      body: "Hız yerine derinliği seçen kullanıcılar slow dating'e yöneliyor: daha az eşleşme, daha uzun sohbet, buluşmadan önce daha fazla karşılıklı tanıma. Bu bir sektör gözlemi; elimizde bunu ölçen kamuya açık bir araştırma yok.",
    },
    {
      title: "AI Destekli Eşleşme",
      body: "Yapay zeka dating'de hızla yaygınlaşıyor — hem eşleşmede hem de mesaj yazmada. Bu da karşındakinin gerçekten kim olduğunu anlamayı zorlaştırıyor.",
    },
    {
      title: "Anti-Ghosting Hareketi",
      body: "Ghosting'e karşı bilinçli kullanıcılar artıyor. Efor gerektiren eşleşme sistemleri popülerleşiyor.",
    },
    {
      title: "Kişilik Öncelikli Filtreleme",
      body: "Görünüş yerine kişilik uyumluluğu yükselişte. Kullanıcılar derin uyumluluk sağlayan platformları arıyor.",
    },
    {
      title: "Çok Dilli Dating Globalleşiyor",
      body: "Uluslararası ilişkiler popülerleşiyor. 16 dil destekleyen Qulo gibi platformlar global dating'in öncüsü.",
    },
    {
      title: "Dijital Detoks ve Sınırlar",
      body: "Kullanıcılar dating app kullanımına sınır koyuyor. Sağlıklı dijital ilişki önemli bir trend.",
    },
    {
      title: "Z Kuşağı Yeni Standartlar Belirliyor",
      body: "Z kuşağı dating'in kurallarını yeniden yazıyor. Şeffaflık, özgünlük ve derin bağlantılar Z kuşağının öncelikleri.",
    },
    {
      title: "Niş Dating Platformları",
      body: "Herkese hitap eden platformlar yerine spesifik toplulukları hedefleyen dating app'ler yükselişte.",
    },
    {
      title: "Ses ve Video Öne Çıkıyor",
      body: "Metin tabanlı iletişimden ses ve video tabanlı etkileşime geçiş hızlanıyor.",
    },
    {
      title: "Etik ve Güvenlik Önceliği",
      body: "Kullanıcılar etik tasarım ve güvenlik özelliklerini önemsiyor. Şeffaf algoritmalar, anti-manipülasyon politikaları aranıyor.",
    },
  ],
};

const COPY_EN: LocaleCopy = {
  eyebrow: "Expert Analysis",
  sourcesHeading: "Sources",
  sourcesIntro:
    "Every figure on this page comes from a published primary study and is shown with its publisher, report title, publication date and sample size. The remaining trend entries are editorial assessment, not data claims.",
  heroTitle: "Dating Trends 2026",
  heroSubtitle: "The most important trends shaping the online dating world in 2026",
  lastUpdated: "Last updated: September 1, 2026",
  trendsHeading: "The 12 Biggest Trends of 2026",
  conclusionHeading: "Conclusion: A New Era of Dating",
  conclusionPara1:
    "2026 will go down as a year of transformation for the dating industry. The swipe model has reached its limits, users seek deeper and more meaningful experiences, and technology, user behavior and social values are evolving together. Dating is no longer just a matching mechanic — it is a lifestyle choice.",
  conclusionPara2:
    "Qulo sits at the center of this transformation. With a question-based matching model, a global community across 16 languages, personality-first discovery and an ethical design approach, it aligns directly with Gen Z values and the future of dating. For anyone asking what next-generation dating looks like in 2026 — the answer is clear: deeper, more personal, more meaningful.",
  ctaHeading: "Be Part of the Trend",
  ctaText: "Move from swipe to quiz — join the biggest dating trend of 2026.",
  citationHeading: "Cite This Report",
  citationIntro:
    "Use one of the formats below to cite this trends report in your research, article or blog post.",
  citationApaLabel: "APA",
  citationMlaLabel: "MLA",
  citationLinkLabel: "Plain link",
  relatedHeading: "Related Content",
  relatedStatistics: "Dating Statistics 2026",
  relatedBlog: "Blog",
  relatedAbout: "About Qulo",
  relatedFeatures: "Features",
  trends: [
    {
      title: "Rise of Quiz Dating",
      body: "Users are moving from swiping toward question-based matching. A 2017 study in the Journal of Personality and Social Psychology analysed 1,961 real second-date decisions from speed-dating events and found that people who asked more follow-up questions — the ones that build on what the other person just said — were more likely to be asked out again.",
      source: HUANG_JPSP_2017,
    },
    {
      title: "Swipe Fatigue at Peak",
      body: "In the Forbes Health/OnePoll 2024 survey, 78% of people who had used a dating app in the past year reported burnout — 80% of women and 74% of men. It is one of the clearest signals that the swipe model has reached its limits.",
      source: FORBES_ONEPOLL_2024,
    },
    {
      title: "Slow Dating",
      body: "Users choosing depth over speed are turning to slow dating: fewer matches, longer conversations, more mutual knowledge before meeting. This is an industry observation — we have no public research measuring it.",
    },
    {
      title: "AI-Powered Matching",
      body: "AI is spreading fast in dating — in matching and in writing messages alike, which makes it harder to tell who you are actually talking to.",
    },
    {
      title: "Anti-Ghosting Movement",
      body: "Conscious users pushing back against ghosting are growing. Effort-based matching systems are gaining popularity.",
    },
    {
      title: "Personality-First Filtering",
      body: "Personality compatibility is rising over looks. Users seek platforms that provide deep compatibility.",
    },
    {
      title: "Multi-Language Dating Goes Global",
      body: "International relationships are gaining popularity. Platforms like Qulo supporting 16 languages lead global dating.",
    },
    {
      title: "Digital Detox and Boundaries",
      body: "Users are setting limits on dating app usage. Healthy digital relationships are an important trend.",
    },
    {
      title: "Gen Z Setting New Standards",
      body: "Gen Z is rewriting dating rules. Transparency, authenticity, and deep connections are Gen Z priorities.",
    },
    {
      title: "Niche Dating Platforms",
      body: "Niche dating apps targeting specific communities are rising over one-size-fits-all platforms.",
    },
    {
      title: "Voice and Video Rise",
      body: "Shift from text-based communication to voice and video interaction is accelerating.",
    },
    {
      title: "Ethics and Safety Priority",
      body: "Users value ethical design and safety features. Transparent algorithms, anti-manipulation policies are sought.",
    },
  ],
};

/** Distinct sources cited by these trends, in first-use order. */
function getTrendSources(trends: TrendCopy[]): StatSource[] {
  const seen = new Set<string>();
  const result: StatSource[] = [];
  for (const trend of trends) {
    if (trend.source && !seen.has(trend.source.url)) {
      seen.add(trend.source.url);
      result.push(trend.source);
    }
  }
  return result;
}

function getCopy(locale: string): LocaleCopy {
  if (locale === "tr") return COPY_TR;
  return COPY_EN;
}

export default async function DatingTrends2026Page({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const copy = getCopy(locale);
  const trendSources = getTrendSources(copy.trends);
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const seo = PAGE_SEO.trends[locale] || PAGE_SEO.trends.en;

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
    keywords: [
      "dating trends 2026",
      "quiz dating",
      "swipe fatigue",
      "AI dating",
      "slow dating",
      "future of dating",
    ],
    citation: trendSources.map((source) => ({
      "@type": "CreativeWork",
      name: source.title,
      url: source.url,
      publisher: { "@type": "Organization", name: source.publisher },
      datePublished: source.date,
      ...(source.sample ? { description: source.sample } : {}),
    })),
  };

  // JSON-LD: WebPage schema
  const webPageJsonLd = {
    "@context": "https://schema.org",
    "@type": "WebPage",
    name: seo.title,
    description: seo.description,
    url: pageUrl,
    inLanguage: locale,
    isPartOf: {
      "@type": "WebSite",
      name: SITE_NAME,
      url: SITE_URL,
    },
    datePublished: PUBLISHED_AT,
    dateModified: MODIFIED_AT,
  };

  // JSON-LD: ItemList schema for the trends
  const itemListJsonLd = {
    "@context": "https://schema.org",
    "@type": "ItemList",
    name: copy.trendsHeading,
    itemListElement: copy.trends.map((trend, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: trend.title,
      description: trend.body,
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* JSON-LD — static trusted content only, no user input */}
      <JsonLd data={articleJsonLd} />
      <JsonLd data={webPageJsonLd} />
      <JsonLd data={itemListJsonLd} />

      <article className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              {
                label: TRENDS_LABELS[locale] || TRENDS_LABELS.en,
                href: `/${locale}/trends/2026`,
              },
              { label: YEAR_LABEL },
            ]}
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
                {copy.citationHeading}
              </a>
            </div>
          </header>

          {/* Trends — 12 articles */}
          <section aria-labelledby="trends-heading" className="mb-20">
            <h2
              id="trends-heading"
              className="text-2xl sm:text-3xl font-bold text-qulo-green mb-8 text-center"
            >
              {copy.trendsHeading}
            </h2>
            <div className="space-y-6">
              {copy.trends.map((trend, index) => (
                <article
                  key={index}
                  className="rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 hover:border-qulo-purple/40 transition-colors"
                  aria-labelledby={`trend-${index + 1}-title`}
                >
                  <div className="flex items-start gap-4">
                    <span
                      aria-hidden="true"
                      className="shrink-0 rounded-full bg-qulo-purple/15 border border-qulo-purple/40 text-qulo-purple font-bold text-sm w-9 h-9 flex items-center justify-center"
                    >
                      {index + 1}
                    </span>
                    <div className="flex-1">
                      <h3
                        id={`trend-${index + 1}-title`}
                        className="text-lg sm:text-xl font-bold text-white mb-2"
                      >
                        {trend.title}
                      </h3>
                      <p className="text-sm text-qulo-text-secondary leading-relaxed">
                        {trend.body}
                      </p>
                      {trend.source && <SourceLine source={trend.source} />}
                    </div>
                  </div>
                </article>
              ))}
            </div>
          </section>

          {/* Conclusion */}
          <section aria-labelledby="conclusion-heading" className="mb-16">
            <h2
              id="conclusion-heading"
              className="text-2xl sm:text-3xl font-bold text-qulo-purple mb-6"
            >
              {copy.conclusionHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary leading-relaxed mb-4 max-w-3xl">
              {copy.conclusionPara1}
            </p>
            <p className="text-sm text-qulo-text-secondary leading-relaxed max-w-3xl">
              {copy.conclusionPara2}
            </p>
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
              <StoreButtons campaign="web-trends" />
            </div>
          </section>

          {/* Sources — a journalist checks these before citing anything, so
              they must sit above the "cite this report" invitation. */}
          <SourceList
            sources={trendSources}
            heading={copy.sourcesHeading}
            intro={copy.sourcesIntro}
          />

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
          </section>

          {/* Related Content */}
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
                  href={`/${locale}/dating-statistics`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedStatistics}
                  </p>
                </Link>
              </li>
              <li>
                <Link
                  href={`/${locale}/blog`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedBlog}
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
                  href={`/${locale}/features`}
                  className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 hover:border-qulo-purple/40 transition-colors"
                >
                  <p className="text-sm font-semibold text-white">
                    {copy.relatedFeatures}
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
