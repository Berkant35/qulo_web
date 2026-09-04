import type { Metadata } from "next";
import Link from "next/link";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { locales } from "@/lib/i18n/config";
import {
  PAGE_SEO,
  SITE_URL,
  SITE_NAME,
  OG_LOCALES,
} from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { BLOG_POSTS } from "@/lib/constants/blog";
import { ADVICE_GUIDES } from "@/lib/constants/advice";
import { HOW_TO_GUIDES } from "@/lib/constants/howto";
import { LANDING_PAGES } from "@/lib/constants/landings";
import { CITIES } from "@/lib/constants/cities";
import { COUNTRIES } from "@/lib/constants/countries";
import { ANSWER_PAGES, answerQuestion } from "@/lib/constants/answers";
import { SORTED_GLOSSARY_TERMS } from "@/lib/constants/glossary";
import { GLOSSARY_CONTENT } from "../glossary/_content";

const PAGE_SLUG = "sitemap-html";

/** Per-locale breadcrumb label */
const SITEMAP_LABELS: Record<string, string> = {
  tr: "Site Haritası", en: "Sitemap", de: "Sitemap", fr: "Plan du site",
  es: "Mapa del sitio", ar: "خريطة الموقع", ru: "Карта сайта", pt: "Mapa do site",
  it: "Mappa del sito", ja: "サイトマップ", ko: "사이트맵", zh: "网站地图",
  nl: "Sitemap", pl: "Mapa strony", sv: "Webbplatskarta", hi: "साइटमैप",
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
  const seo = PAGE_SEO.sitemap[locale] || PAGE_SEO.sitemap.en;
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/${PAGE_SLUG}`;
  languages["x-default"] = `${SITE_URL}/tr/${PAGE_SLUG}`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    // noindex the sitemap page itself but its links remain crawlable
    robots: {
      index: false,
      follow: true,
    },
    openGraph: {
      title: seo.title,
      description: seo.description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "website",
      locale: OG_LOCALES[locale] || "en_US",
      images: ogImages(),
    },
  };
}

/**
 * Section headings and page labels come from the dictionaries, which carry all
 * 16 locales for the footer and nav.
 *
 * They used to come from a `locale === "tr" ? … : …` table right here, so every
 * language except Turkish read this page in English while its `hreflang` and
 * canonical promised a translation. Reusing the footer keys fixes that without
 * inventing a second set of translations for words the site already has — and
 * it keeps the sitemap's wording in step with the navigation it describes.
 */

interface SitemapLink {
  href: string;
  label: string;
}

function SitemapSection({
  id,
  title,
  links,
  accent,
}: {
  id: string;
  title: string;
  links: SitemapLink[];
  accent: "purple" | "green";
}) {
  const headingColor = accent === "purple" ? "text-qulo-purple" : "text-qulo-green";
  return (
    <nav aria-labelledby={id} className="mb-10">
      <h2
        id={id}
        className={`text-xl sm:text-2xl font-bold mb-4 ${headingColor}`}
      >
        {title}
      </h2>
      <ul className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2">
        {links.map((link) => (
          <li key={link.href}>
            <Link
              href={link.href}
              className="block rounded-lg border border-white/[0.06] bg-white/[0.02] px-3 py-2 text-sm text-qulo-text-secondary hover:text-white hover:border-qulo-purple/40 transition-colors"
            >
              {link.label}
            </Link>
          </li>
        ))}
      </ul>
    </nav>
  );
}

function getBlogTitle(
  post: (typeof BLOG_POSTS)[number],
  locale: string,
): string {
  return post.titles[locale] || post.titles.en;
}

function getAdviceTitle(
  guide: (typeof ADVICE_GUIDES)[number],
  locale: string,
): string {
  return guide.titles[locale] || guide.titles.en;
}

function getHowToTitle(
  guide: (typeof HOW_TO_GUIDES)[number],
  locale: string,
): string {
  return guide.titles[locale] || guide.titles.en;
}

function getLandingTitle(
  landing: (typeof LANDING_PAGES)[number],
  locale: string,
): string {
  return landing.titles[locale] || landing.titles.en;
}

function getCityName(
  city: (typeof CITIES)[number],
  locale: string,
): string {
  return city.names[locale] || city.names.en || city.slug;
}

function getCountryName(
  country: (typeof COUNTRIES)[number],
  locale: string,
): string {
  return country.names[locale] || country.names.en || country.slug;
}

export default async function SitemapHtmlPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const nav = await getTranslations("nav");
  const t = await getTranslations("footer");

  // The homepage is labelled with the site name — a sitemap's root entry reads
  // naturally that way and it needs no thirty-second translation of "Home".
  const mainPages: SitemapLink[] = [
    { href: `/${locale}`, label: SITE_NAME },
    { href: `/${locale}/about`, label: t("about") },
    { href: `/${locale}/press`, label: t("press") },
    { href: `/${locale}/features`, label: nav("features") },
    { href: `/${locale}/advice`, label: t("advice") },
    { href: `/${locale}/how-to`, label: t("howto") },
    { href: `/${locale}/blog`, label: t("blog") },
    { href: `/${locale}/answers`, label: t("answers") },
    { href: `/${locale}/glossary`, label: t("glossary") },
    { href: `/${locale}/pricing`, label: t("pricing") },
    { href: `/${locale}/dating-statistics`, label: t("statistics") },
    { href: `/${locale}/trends/2026`, label: t("trends") },
  ];

  // Every glossary term, so the 432 term pages are reachable from a crawlable
  // page and not only from the XML sitemap.
  const glossaryPages: SitemapLink[] = SORTED_GLOSSARY_TERMS.flatMap((term) => {
    const entry = GLOSSARY_CONTENT[term.slug]?.[locale];
    return entry
      ? [{ href: `/${locale}/glossary/${term.slug}`, label: entry.term }]
      : [];
  }).sort((a, b) => a.label.localeCompare(b.label, locale));

  const answerPages: SitemapLink[] = ANSWER_PAGES.map((page) => ({
    href: `/${locale}/answers/${page.slug}`,
    label: answerQuestion(page, locale),
  }));

  const featurePages: SitemapLink[] = LANDING_PAGES.map((landing) => ({
    href: `/${locale}/features/${landing.slug}`,
    label: getLandingTitle(landing, locale),
  }));

  const advicePages: SitemapLink[] = ADVICE_GUIDES.map((guide) => ({
    href: `/${locale}/advice/${guide.slug}`,
    label: getAdviceTitle(guide, locale),
  }));

  const howtoPages: SitemapLink[] = HOW_TO_GUIDES.map((guide) => ({
    href: `/${locale}/how-to/${guide.slug}`,
    label: getHowToTitle(guide, locale),
  }));

  const blogPages: SitemapLink[] = BLOG_POSTS.map((post) => ({
    href: `/${locale}/blog/${post.slug}`,
    label: getBlogTitle(post, locale),
  }));

  const cityPages: SitemapLink[] = CITIES.map((city) => ({
    href: `/${locale}/dating/${city.slug}`,
    label: getCityName(city, locale),
  }));

  const countryPages: SitemapLink[] = COUNTRIES.map((country) => ({
    href: `/${locale}/country/${country.slug}`,
    label: getCountryName(country, locale),
  }));

  const legalPages: SitemapLink[] = [
    { href: `/${locale}/privacy-policy`, label: t("privacy") },
    { href: `/${locale}/terms`, label: t("terms") },
    { href: `/${locale}/community-guidelines`, label: t("guidelines") },
    { href: `/${locale}/safety-tips`, label: t("safety") },
    { href: `/${locale}/csae-policy`, label: t("childSafety") },
    { href: `/${locale}/help`, label: t("help") },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-5xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: SITEMAP_LABELS[locale] || SITEMAP_LABELS.en }]}
          />

          {/* Hero */}
          <header className="mb-12 text-center">
            <h1 className="text-4xl sm:text-5xl font-bold">{t("sitemap")}</h1>
          </header>

          <SitemapSection
            id="main-pages-heading"
            title={t("company")}
            links={mainPages}
            accent="purple"
          />

          <SitemapSection
            id="features-heading"
            title={nav("features")}
            links={featurePages}
            accent="green"
          />

          <SitemapSection
            id="advice-heading"
            title={t("advice")}
            links={advicePages}
            accent="purple"
          />

          <SitemapSection
            id="howto-heading"
            title={t("howto")}
            links={howtoPages}
            accent="green"
          />

          <SitemapSection
            id="blog-heading"
            title={t("blog")}
            links={blogPages}
            accent="purple"
          />

          <SitemapSection
            id="answers-heading"
            title={t("answers")}
            links={answerPages}
            accent="green"
          />

          <SitemapSection
            id="glossary-heading"
            title={t("glossary")}
            links={glossaryPages}
            accent="purple"
          />

          <SitemapSection
            id="cities-heading"
            title={t("cities")}
            links={cityPages}
            accent="green"
          />

          <SitemapSection
            id="countries-heading"
            title={t("countries")}
            links={countryPages}
            accent="purple"
          />

          <SitemapSection
            id="legal-heading"
            title={t("legal")}
            links={legalPages}
            accent="green"
          />
        </div>
      </div>

      <Footer />
    </main>
  );
}
