import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { BLOG_POSTS } from "@/lib/constants/blog";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.blog[locale] || PAGE_SEO.blog.en;
  const pageUrl = `${SITE_URL}/${locale}/blog`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/blog`;
  languages["x-default"] = `${SITE_URL}/tr/blog`;

  return {
    title: seo.title,
    description: seo.description,
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

const LABELS: Record<string, { heading: string; readTime: string }> = {
  tr: { heading: "Blog", readTime: "dk okuma" },
  en: { heading: "Blog", readTime: "min read" },
  de: { heading: "Blog", readTime: "Min. Lesezeit" },
  fr: { heading: "Blog", readTime: "min de lecture" },
  es: { heading: "Blog", readTime: "min de lectura" },
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

function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      /* Static server constants only — no user input */
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default async function BlogIndexPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = LABELS[locale] || LABELS.en;
  const sortedPosts = [...BLOG_POSTS].sort(
    (a, b) => new Date(b.publishedAt).getTime() - new Date(a.publishedAt).getTime()
  );

  // CollectionPage JSON-LD
  const collectionJsonLd = {
    "@context": "https://schema.org",
    "@type": "CollectionPage",
    name: labels.heading,
    url: `${SITE_URL}/${locale}/blog`,
    mainEntity: {
      "@type": "ItemList",
      itemListElement: sortedPosts.map((post, i) => ({
        "@type": "ListItem",
        position: i + 1,
        url: `${SITE_URL}/${locale}/blog/${post.slug}`,
        name: post.titles[locale] || post.titles.en,
      })),
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* CollectionPage JSON-LD — trusted static constants only */}
      <JsonLd data={collectionJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: labels.heading }]}
          />

          {/* Header */}
          <header className="mb-12 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              Qulo
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-4">{labels.heading}</h1>
            <p className="text-qulo-text-secondary text-base max-w-xl mx-auto">
              {(PAGE_SEO.blog[locale] || PAGE_SEO.blog.en).description}
            </p>
          </header>

          {/* Blog cards */}
          <div className="space-y-6">
            {sortedPosts.map((post) => {
              const title = post.titles[locale] || post.titles.en;
              const excerpt = post.excerpts[locale] || post.excerpts.en;

              return (
                <article
                  key={post.slug}
                  className="group rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8 transition-all duration-200 hover:border-qulo-purple/30 hover:bg-white/[0.05]"
                >
                  <Link href={`/${locale}/blog/${post.slug}`} className="block">
                    <div className="flex items-center gap-3 text-xs text-qulo-text-secondary mb-3">
                      <time dateTime={post.publishedAt}>
                        {formatDate(post.publishedAt, locale)}
                      </time>
                      <span aria-hidden="true" className="w-1 h-1 rounded-full bg-qulo-purple/50" />
                      <span>
                        {post.readingTime} {labels.readTime}
                      </span>
                    </div>

                    <h2 className="text-lg sm:text-xl font-bold text-white mb-2 group-hover:text-qulo-purple transition-colors">
                      {title}
                    </h2>

                    <p className="text-sm text-qulo-text-secondary leading-relaxed line-clamp-3">
                      {excerpt}
                    </p>

                    <div className="mt-4 flex flex-wrap gap-2">
                      {post.keywords.slice(0, 3).map((kw) => (
                        <span
                          key={kw}
                          className="text-[10px] px-2 py-0.5 rounded-full border border-white/[0.08] text-qulo-text-secondary"
                        >
                          {kw}
                        </span>
                      ))}
                    </div>
                  </Link>
                </article>
              );
            })}
          </div>
        </div>
      </div>

      <Footer />
    </main>
  );
}
