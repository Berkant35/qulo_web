import type { Metadata } from "next";
import { setRequestLocale } from "next-intl/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { Navbar } from "@/components/shared/Navbar";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { FAQ, faqTitle } from "@/components/shared/FAQ";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { LANDING_PAGES } from "@/lib/constants/landings";
import { landingLabels } from "@/lib/constants/landingLabels";
import { SITE_URL, SITE_NAME, OG_LOCALES } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { getFeatureFaqs } from "@/lib/constants/faqs";
import { LANDING_CONTENT } from "../_content";

/* ---------- Static params: 16 locales x 3 slugs = 48 pages ---------- */
export function generateStaticParams() {
  return locales.flatMap((locale) =>
    LANDING_PAGES.map((lp) => ({ locale, slug: lp.slug })),
  );
}

/* ---------- Metadata ---------- */
export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const landing = LANDING_PAGES.find((lp) => lp.slug === slug);
  if (!landing) return {};

  const title = landing.titles[locale] || landing.titles.en;
  const description = landing.descriptions[locale] || landing.descriptions.en;
  const pageUrl = `${SITE_URL}/${locale}/features/${slug}`;
  const ogLocale = OG_LOCALES[locale] || "en_US";

  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/features/${slug}`;
  languages["x-default"] = `${SITE_URL}/tr/features/${slug}`;

  return {
    title,
    description,
    keywords: landing.keywords,
    alternates: { canonical: pageUrl, languages },
    openGraph: {
      title,
      description,
      url: pageUrl,
      siteName: SITE_NAME,
      type: "article",
      locale: ogLocale,
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

/* ---------- Page component ---------- */
export default async function FeatureLandingPage({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  setRequestLocale(locale);

  const landing = LANDING_PAGES.find((lp) => lp.slug === slug);
  if (!landing) notFound();

  /* No English fallback on purpose: every slug carries all 16 locales, and a
     missing one should fail loudly rather than serve English under a canonical
     URL that promises a translation. */
  const content = LANDING_CONTENT[slug]?.[locale];
  if (!content) notFound();

  const labels = landingLabels(locale);
  const pageUrl = `${SITE_URL}/${locale}/features/${slug}`;
  const title = landing.titles[locale] || landing.titles.en;
  const description = landing.descriptions[locale] || landing.descriptions.en;
  const faqs = getFeatureFaqs(slug, locale);

  // The app itself is declared once site-wide by the localized root layout.
  // Repeating it here produced two SoftwareApplication nodes on every one of
  // these pages; the remaining WebPage still describes the app via `about`.
  const jsonLdData = [
    {
      "@context": "https://schema.org",
      "@type": "WebPage",
      name: title,
      description,
      url: pageUrl,
      isPartOf: { "@type": "WebSite", name: SITE_NAME, url: SITE_URL },
      about: {
        "@type": "SoftwareApplication",
        name: SITE_NAME,
        applicationCategory: "SocialNetworkingApplication",
      },
    },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <JsonLd data={jsonLdData} />

      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <div className="max-w-3xl mx-auto">

          <Breadcrumb
            locale={locale}
            items={[
              { label: labels.section, href: `/${locale}/features` },
              { label: title },
            ]}
          />

          {/* Hero Section */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {landing.primaryKeyword}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {content.heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto mb-8">
              {content.heroSub}
            </p>
            <div className="flex justify-center">
              <StoreButtons campaign="web-features" />
            </div>
          </header>

          {/* Problem Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-6">
              {content.problemTitle}
            </h2>
            <article className="space-y-4 text-qulo-text-secondary leading-relaxed text-sm">
              {content.problemParagraphs.map((paragraph, i) => (
                // Static, never-reordered prose: the index is a stable key.
                // eslint-disable-next-line react/no-array-index-key
                <p key={i}>{paragraph}</p>
              ))}
            </article>
          </section>

          {/* Solution Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-green mb-6">
              {content.solutionTitle}
            </h2>
            <ul className="space-y-4">
              {content.solutionBullets.map((bullet, i) => (
                <li
                  key={bullet.title}
                  className="flex items-start gap-4 rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                >
                  <span className="flex-shrink-0 w-8 h-8 rounded-full bg-qulo-green/20 text-qulo-green font-bold text-sm flex items-center justify-center">
                    {i + 1}
                  </span>
                  <div>
                    <p className="text-white font-semibold text-sm">{bullet.title}</p>
                    <p className="text-qulo-text-secondary text-sm mt-1">{bullet.desc}</p>
                  </div>
                </li>
              ))}
            </ul>
          </section>

          {/* How It Works Section */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-6">
              {labels.howItWorks}
            </h2>
            <ol className="space-y-4">
              {content.steps.map((step, i) => (
                <li
                  key={step.title}
                  className="flex items-start gap-4 rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                >
                  <span className="flex-shrink-0 w-8 h-8 rounded-full bg-qulo-purple/20 text-qulo-purple font-bold text-sm flex items-center justify-center">
                    {i + 1}
                  </span>
                  <div>
                    <p className="text-white font-semibold text-sm">{step.title}</p>
                    <p className="text-qulo-text-secondary text-sm mt-1">{step.desc}</p>
                  </div>
                </li>
              ))}
            </ol>
          </section>

          {/* FAQ Section — page-specific, with FAQPage JSON-LD for rich snippets */}
          {faqs.length > 0 ? <FAQ items={faqs} title={faqTitle(locale)} /> : null}

          {/* CTA Section */}
          <section className="text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10 mb-14 mt-16">
            <h2 className="text-2xl font-bold text-white mb-3">{labels.ctaTitle}</h2>
            <p className="text-qulo-text-secondary text-sm mb-6">{labels.ctaDesc}</p>
            <div className="flex justify-center">
              <StoreButtons campaign="web-features" />
            </div>
          </section>

          {/* Internal Links */}
          <nav className="flex flex-wrap justify-center gap-4 text-sm">
            <Link
              href={`/${locale}/about`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {labels.navAbout}
            </Link>
            <Link
              href={`/${locale}/blog`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              Blog
            </Link>
            <Link
              href={`/${locale}/dating`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {labels.navCities}
            </Link>
            <Link
              href={`/${locale}/features`}
              className="text-qulo-text-secondary hover:text-qulo-purple transition-colors"
            >
              {labels.navFeatures}
            </Link>
          </nav>

        </div>
      </div>
    </main>
  );
}
