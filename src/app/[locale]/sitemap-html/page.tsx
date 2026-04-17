import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
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
import { BLOG_POSTS } from "@/lib/constants/blog";
import { ADVICE_GUIDES } from "@/lib/constants/advice";
import { HOW_TO_GUIDES } from "@/lib/constants/howto";
import { LANDING_PAGES } from "@/lib/constants/landings";
import { CITIES } from "@/lib/constants/cities";
import { COUNTRIES } from "@/lib/constants/countries";

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
    },
  };
}

interface SitemapCopy {
  heroTitle: string;
  heroSubtitle: string;
  mainPages: string;
  featuresSection: string;
  adviceSection: string;
  howtoSection: string;
  blogSection: string;
  citiesSection: string;
  countriesSection: string;
  legalSection: string;
  // Main page labels
  home: string;
  about: string;
  press: string;
  features: string;
  advice: string;
  howto: string;
  blog: string;
  glossary: string;
  statistics: string;
  trends: string;
  privacy: string;
  terms: string;
  help: string;
}

function getCopy(locale: string): SitemapCopy {
  const isTr = locale === "tr";
  return {
    heroTitle: isTr ? "Site Haritası" : "Sitemap",
    heroSubtitle: isTr
      ? "Qulo web sitesindeki tüm sayfaların organize listesi."
      : "An organized list of all pages on the Qulo website.",
    mainPages: isTr ? "Ana Sayfalar" : "Main Pages",
    featuresSection: isTr ? "Özellikler" : "Features",
    adviceSection: isTr ? "Tavsiye Rehberleri" : "Advice Guides",
    howtoSection: isTr ? "Nasıl Kullanılır Rehberleri" : "How-to Guides",
    blogSection: isTr ? "Blog Yazıları" : "Blog Articles",
    citiesSection: isTr ? "Şehirler" : "Cities",
    countriesSection: isTr ? "Ülkeler" : "Countries",
    legalSection: isTr ? "Yasal" : "Legal",
    home: isTr ? "Ana Sayfa" : "Home",
    about: isTr ? "Hakkında" : "About",
    press: isTr ? "Basın" : "Press",
    features: isTr ? "Özellikler" : "Features",
    advice: isTr ? "Tavsiyeler" : "Advice",
    howto: isTr ? "Nasıl Kullanılır" : "How-to",
    blog: "Blog",
    glossary: isTr ? "Sözlük" : "Glossary",
    statistics: isTr ? "İstatistikler" : "Statistics",
    trends: isTr ? "Dating Trendleri 2026" : "Dating Trends 2026",
    privacy: isTr ? "Gizlilik Politikası" : "Privacy Policy",
    terms: isTr ? "Kullanım Koşulları" : "Terms of Service",
    help: isTr ? "Yardım" : "Help",
  };
}

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

  const copy = getCopy(locale);

  const mainPages: SitemapLink[] = [
    { href: `/${locale}`, label: copy.home },
    { href: `/${locale}/about`, label: copy.about },
    { href: `/${locale}/press`, label: copy.press },
    { href: `/${locale}/features`, label: copy.features },
    { href: `/${locale}/advice`, label: copy.advice },
    { href: `/${locale}/how-to`, label: copy.howto },
    { href: `/${locale}/blog`, label: copy.blog },
    { href: `/${locale}/glossary`, label: copy.glossary },
    { href: `/${locale}/dating-statistics`, label: copy.statistics },
    { href: `/${locale}/trends/2026`, label: copy.trends },
  ];

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
    { href: `/${locale}/privacy-policy`, label: copy.privacy },
    { href: `/${locale}/terms`, label: copy.terms },
    { href: `/${locale}/help`, label: copy.help },
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
            <h1 className="text-4xl sm:text-5xl font-bold mb-4">
              {copy.heroTitle}
            </h1>
            <p className="text-base text-qulo-text-secondary max-w-2xl mx-auto">
              {copy.heroSubtitle}
            </p>
          </header>

          <SitemapSection
            id="main-pages-heading"
            title={copy.mainPages}
            links={mainPages}
            accent="purple"
          />

          <SitemapSection
            id="features-heading"
            title={copy.featuresSection}
            links={featurePages}
            accent="green"
          />

          <SitemapSection
            id="advice-heading"
            title={copy.adviceSection}
            links={advicePages}
            accent="purple"
          />

          <SitemapSection
            id="howto-heading"
            title={copy.howtoSection}
            links={howtoPages}
            accent="green"
          />

          <SitemapSection
            id="blog-heading"
            title={copy.blogSection}
            links={blogPages}
            accent="purple"
          />

          <SitemapSection
            id="cities-heading"
            title={copy.citiesSection}
            links={cityPages}
            accent="green"
          />

          <SitemapSection
            id="countries-heading"
            title={copy.countriesSection}
            links={countryPages}
            accent="purple"
          />

          <SitemapSection
            id="legal-heading"
            title={copy.legalSection}
            links={legalPages}
            accent="green"
          />
        </div>
      </div>

      <Footer />
    </main>
  );
}
