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
import { BLOG_POSTS } from "@/lib/constants/blog";
import { ArticleBlocks, type LocalizedArticle } from "@/components/blog/ArticleBlocks";
import { JsonLd } from "@/components/shared/JsonLd";
import { whatActuallyPredictsCompatibility } from "./_content/what-actually-predicts-compatibility";
import { psychologyOfTheFirstMessage } from "./_content/psychology-of-the-first-message";
import { theQuestionDeficit } from "./_content/the-question-deficit";
import { datingAppsWithoutSwiping } from "./_content/dating-apps-without-swiping";
import { whatIsSwipeFatigue } from "./_content/what-is-swipe-fatigue";
import { quizDatingFutureOfMatching } from "./_content/quiz-dating-future-of-matching";
import { onlineDatingSafetyTips } from "./_content/online-dating-safety-tips";
import { quizDatingForIntroverts } from "./_content/quiz-dating-for-introverts";
import { datingAppBurnoutSigns } from "./_content/dating-app-burnout-signs";
import { scienceBehindQuestionBasedMatching } from "./_content/science-behind-question-based-matching";

/* ------------------------------------------------------------------ */
/*  Static params                                                      */
/* ------------------------------------------------------------------ */
export function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of locales) {
    for (const post of BLOG_POSTS) {
      params.push({ locale, slug: post.slug });
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
  const post = BLOG_POSTS.find((p) => p.slug === slug);
  if (!post) return {};

  const title = post.titles[locale] || post.titles.en;
  const description = post.excerpts[locale] || post.excerpts.en;
  const pageUrl = `${SITE_URL}/${locale}/blog/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/blog/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/blog/${slug}`;

  return {
    title: `${title} — Qulo Blog`,
    description,
    keywords: post.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
      publishedTime: post.publishedAt,
      // Post cover when it has one, site-wide OG image otherwise.
      images: ogImages(post.coverImage, title),
    },
    twitter: {
      card: "summary_large_image",
      title,
      description,
      images: ogImages(post.coverImage, title),
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
 * No user input is involved; all values come from hardcoded blog.ts / metadata.ts.
 */
const READ_LABELS: Record<string, { readTime: string; backToBlog: string; relatedPosts: string }> = {
  tr: { readTime: "dk okuma", backToBlog: "Blog'a Dön", relatedPosts: "Diğer Yazılar" },
  en: { readTime: "min read", backToBlog: "Back to Blog", relatedPosts: "Related Posts" },
  de: { readTime: "Min. Lesezeit", backToBlog: "Zurück zum Blog", relatedPosts: "Weitere Artikel" },
  fr: { readTime: "min de lecture", backToBlog: "Retour au Blog", relatedPosts: "Articles connexes" },
  es: { readTime: "min de lectura", backToBlog: "Volver al Blog", relatedPosts: "Artículos relacionados" },
  ar: { readTime: "دقيقة قراءة", backToBlog: "العودة إلى المدونة", relatedPosts: "مقالات ذات صلة" },
  ru: { readTime: "мин чтения", backToBlog: "Назад в блог", relatedPosts: "Похожие статьи" },
  pt: { readTime: "min de leitura", backToBlog: "Voltar ao Blog", relatedPosts: "Artigos relacionados" },
  it: { readTime: "min di lettura", backToBlog: "Torna al Blog", relatedPosts: "Articoli correlati" },
  ja: { readTime: "分で読めます", backToBlog: "ブログへ戻る", relatedPosts: "関連記事" },
  ko: { readTime: "분 분량", backToBlog: "블로그로 돌아가기", relatedPosts: "관련 글" },
  zh: { readTime: "分钟阅读", backToBlog: "返回博客", relatedPosts: "相关文章" },
  nl: { readTime: "min leestijd", backToBlog: "Terug naar blog", relatedPosts: "Gerelateerde artikelen" },
  pl: { readTime: "min czytania", backToBlog: "Powrót do bloga", relatedPosts: "Powiązane artykuły" },
  sv: { readTime: "min läsning", backToBlog: "Tillbaka till bloggen", relatedPosts: "Relaterade artiklar" },
  hi: { readTime: "मिनट पढ़ें", backToBlog: "ब्लॉग पर वापस", relatedPosts: "संबंधित लेख" },
};

/* ------------------------------------------------------------------ */
/*  Content router                                                     */
/* ------------------------------------------------------------------ */

/**
 * Every blog post, authored as structured data and fully translated into all 16
 * locales. New posts go here; there is no per-locale JSX fallback any more.
 */
const STRUCTURED_ARTICLES: Record<string, LocalizedArticle> = {
  "what-actually-predicts-compatibility": whatActuallyPredictsCompatibility,
  "psychology-of-the-first-message": psychologyOfTheFirstMessage,
  "the-question-deficit": theQuestionDeficit,
  "dating-apps-without-swiping": datingAppsWithoutSwiping,
  "what-is-swipe-fatigue": whatIsSwipeFatigue,
  "quiz-dating-future-of-matching": quizDatingFutureOfMatching,
  "online-dating-safety-tips": onlineDatingSafetyTips,
  "quiz-dating-for-introverts": quizDatingForIntroverts,
  "dating-app-burnout-signs": datingAppBurnoutSigns,
  "science-behind-question-based-matching": scienceBehindQuestionBasedMatching,
};

/** Word count of an article, or undefined for a slug with no content. */
function structuredWordCount(slug: string, locale: string): number | undefined {
  const blocks = STRUCTURED_ARTICLES[slug]?.[locale] ?? STRUCTURED_ARTICLES[slug]?.en;
  if (!blocks) return undefined;

  return blocks.reduce((total, block) => {
    const text = block.type === "ul" ? block.items.join(" ") : block.text;
    return total + text.split(/\s+/).filter(Boolean).length;
  }, 0);
}

function BlogContent({ slug, locale }: { slug: string; locale: string }) {
  const article = STRUCTURED_ARTICLES[slug];
  if (!article) return null;

  return <ArticleBlocks blocks={article[locale] || article.en} />;
}

/* ------------------------------------------------------------------ */
/*  Page component                                                     */
/* ------------------------------------------------------------------ */
export default async function BlogPostPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const post = BLOG_POSTS.find((p) => p.slug === slug);
  if (!post) notFound();

  const title = post.titles[locale] || post.titles.en;
  const excerpt = post.excerpts[locale] || post.excerpts.en;
  const labels = READ_LABELS[locale] || READ_LABELS.en;

  const otherPosts = BLOG_POSTS.filter((p) => p.slug !== slug);
  const wordCount = structuredWordCount(slug, locale);

  // BlogPosting JSON-LD
  const blogPostingJsonLd = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: title,
    description: excerpt,
    datePublished: post.publishedAt,
    dateModified: post.updatedAt ?? post.publishedAt,
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
      "@id": `${SITE_URL}/${locale}/blog/${slug}`,
    },
    keywords: post.keywords.join(", "),
    // Omitted rather than guessed if a slug ever ships without body content.
    ...(wordCount ? { wordCount } : {}),
    inLanguage: locale,
    ...(post.coverImage ? { image: `${SITE_URL}${post.coverImage}` } : {}),
    ...(post.citations && post.citations.length > 0
      ? {
          citation: post.citations.map((c) => ({
            "@type": "CreativeWork",
            name: c.title,
            url: c.url,
          })),
        }
      : {}),
  };

  const REFERENCE_LABELS: Record<string, string> = {
    tr: "Kaynakça", en: "References", de: "Quellen", fr: "Références", es: "Referencias",
    ar: "المراجع", ru: "Источники", pt: "Referências", it: "Riferimenti", ja: "参考文献",
    ko: "참고 문헌", zh: "参考文献", nl: "Bronnen", pl: "Źródła", sv: "Källor", hi: "संदर्भ",
  };
  const referencesLabel = REFERENCE_LABELS[locale] || REFERENCE_LABELS.en;

  const CTA_LABELS: Record<string, { ctaTitle: string; ctaDesc: string }> = {
    tr: { ctaTitle: "Qulo'yu İndir", ctaDesc: "Sorularla tanışmanın yeni yolunu keşfet. Hemen dene, ücretsiz!" },
    en: { ctaTitle: "Download Qulo", ctaDesc: "Discover the new way to meet through questions. Try it now, for free!" },
    de: { ctaTitle: "Qulo herunterladen", ctaDesc: "Entdecken Sie den neuen Weg, sich durch Fragen kennenzulernen." },
    fr: { ctaTitle: "Télécharger Qulo", ctaDesc: "Découvrez la nouvelle façon de se rencontrer par les questions." },
    es: { ctaTitle: "Descargar Qulo", ctaDesc: "Descubre la nueva forma de conocerse a través de preguntas." },
  };

  const cta = CTA_LABELS[locale] || CTA_LABELS.en;

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* BlogPosting JSON-LD — trusted static constants only.
          BreadcrumbList JSON-LD is rendered by the <Breadcrumb /> component below. */}
      <JsonLd data={blogPostingJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[
              { label: "Blog", href: `/${locale}/blog` },
              { label: title },
            ]}
          />

          {/* Back to blog */}
          <nav className="mb-8">
            <Link
              href={`/${locale}/blog`}
              className="text-sm text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              &larr; {labels.backToBlog}
            </Link>
          </nav>

          {/* Article header */}
          <header className="mb-10">
            <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-4">
              <time dateTime={post.publishedAt}>
                {formatDate(post.publishedAt, locale)}
              </time>
              <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
              <span>
                {post.readingTime} {labels.readTime}
              </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-bold leading-tight mb-4">
              {title}
            </h1>
            <p className="text-lg text-qulo-text-secondary leading-relaxed">
              {excerpt}
            </p>
            <div className="mt-4 flex flex-wrap gap-2">
              {post.keywords.map((kw) => (
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
            <BlogContent slug={slug} locale={locale} />
          </article>

          {/* References — rendered from trusted static blog.ts constants only */}
          {post.citations && post.citations.length > 0 && (
            <section className="mt-14 pt-8 border-t border-white/[0.08]">
              <h2 className="text-xl font-bold text-white mb-5">{referencesLabel}</h2>
              <ol className="list-decimal list-inside space-y-3 text-sm text-qulo-text-secondary">
                {post.citations.map((c) => (
                  <li key={c.url}>
                    <a
                      href={c.url}
                      target="_blank"
                      rel="noopener noreferrer nofollow"
                      className="text-qulo-purple hover:underline"
                    >
                      {c.title}
                    </a>
                    <span className="text-qulo-text-secondary/70"> — {c.source}</span>
                  </li>
                ))}
              </ol>
            </section>
          )}

          {/* CTA Section */}
          <section className="mt-16 text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">{cta.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{cta.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>

          {/* Related posts */}
          {otherPosts.length > 0 && (
            <section className="mt-16">
              <h2 className="text-xl font-bold text-white mb-6">{labels.relatedPosts}</h2>
              <div className="space-y-4">
                {otherPosts.map((rp) => (
                  <Link
                    key={rp.slug}
                    href={`/${locale}/blog/${rp.slug}`}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 hover:border-qulo-purple/30 hover:bg-white/[0.05] transition-all duration-200"
                  >
                    <h3 className="text-sm font-semibold text-white mb-1">
                      {rp.titles[locale] || rp.titles.en}
                    </h3>
                    <p className="text-xs text-qulo-text-secondary line-clamp-2">
                      {rp.excerpts[locale] || rp.excerpts.en}
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
