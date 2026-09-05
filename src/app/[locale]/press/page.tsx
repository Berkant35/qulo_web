import type { Metadata } from "next";
import Link from "next/link";
import { setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Footer } from "@/components/footer/Footer";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { locales } from "@/lib/i18n/config";
import {
  PAGE_SEO,
  SITE_URL,
  SITE_NAME,
  OG_LOCALES,
} from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";
import {
  pressLabelsFor,
  type PressFactKey,
  type PressLinkKey,
  type PressLogoKey,
} from "@/lib/constants/pressLabels";

const PAGE_SLUG = "press";

/**
 * Brand files offered for download. Every entry is a file that actually exists
 * under `public/` — checked by `scripts/verify-press-assets.mjs`, which fails
 * the build if one goes missing. The page previously advertised a
 * `/press-kit.zip` that was never generated, so both of its download buttons
 * returned 404.
 */
const PRESS_ASSETS = [
  // Size-plus-format rows: the same token in every language, so no key.
  { href: "/brand/qulo-logo-1024.png", label: "Logo 1024", format: "PNG" },
  { href: "/brand/qulo-logo-512.png", label: "Logo 512", format: "PNG" },
  { href: "/brand/qulo-logo-256.png", label: "Logo 256", format: "PNG" },
  // The three named marks reuse the gallery's localized names rather than
  // printing "Purple diamond" in fourteen languages that do not read English.
  { href: "/brand/qulo_splash.svg", logoKey: "splash", format: "SVG" },
  { href: "/brand/purple_diamond.svg", logoKey: "purple", format: "SVG" },
  { href: "/brand/green_diamond.svg", logoKey: "green", format: "SVG" },
] as const;

/**
 * The logo gallery. Paths stay here rather than in the label module so
 * `verify:press` — which only reads this file — keeps checking that they exist.
 * Names and alt text come from `PRESS_LABELS[locale].logos`, keyed by `key`.
 */
const LOGO_ASSETS: { key: PressLogoKey; src: string }[] = [
  { key: "purple", src: "/brand/purple_diamond.svg" },
  { key: "green", src: "/brand/green_diamond.svg" },
  { key: "splash", src: "/brand/qulo_splash.svg" },
];

/** Quick-facts rows, in print order. Labels and values are per locale. */
const FACT_ORDER: PressFactKey[] = [
  "name",
  "founded",
  "category",
  "platforms",
  "price",
  "languages",
  "basedIn",
  "tagline",
  "website",
];

/** Internal links at the foot of the page, in print order. */
const MORE_LINKS: { key: PressLinkKey; path: string }[] = [
  { key: "about", path: "about" },
  { key: "statistics", path: "dating-statistics" },
  { key: "blog", path: "blog" },
  { key: "contact", path: "help" },
];

const PUBLISHED_AT = "2026-04-16";
const MODIFIED_AT = "2026-09-04";

const PRESS_CONTACT_EMAIL = "info@socrepho.com";
const FOUNDER_NAME = "Berkant Çalıkuşu";
/** Avatar monogram. Derived so it cannot drift from the name beside it. */
const FOUNDER_INITIALS = FOUNDER_NAME.split(" ")
  .map((part) => part[0])
  .join("");

/** Brand color palette — static, used for both UI and content. */
const BRAND_COLORS: {
  name: string;
  hex: string;
  rgb: string;
  preview: string;
  textOnDark?: boolean;
}[] = [
  { name: "Qulo Purple", hex: "#BB86FC", rgb: "187, 134, 252", preview: "#BB86FC" },
  { name: "Qulo Green", hex: "#69F0AE", rgb: "105, 240, 174", preview: "#69F0AE" },
  { name: "Qulo Dark Background", hex: "#050508", rgb: "5, 5, 8", preview: "#050508", textOnDark: true },
  { name: "Qulo Light Text", hex: "#FFFFFF", rgb: "255, 255, 255", preview: "#FFFFFF" },
];

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.press[locale] || PAGE_SEO.press.en;
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const languages = alternateLanguages(`/${PAGE_SLUG}`);
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
      locale: OG_LOCALES[locale] || "en_US",
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

export default async function PressPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const labels = pressLabelsFor(locale);
  const pageUrl = `${SITE_URL}/${locale}/${PAGE_SLUG}`;
  const seo = PAGE_SEO.press[locale] || PAGE_SEO.press.en;

  // JSON-LD: AboutPage schema
  const aboutPageJsonLd = {
    "@context": "https://schema.org",
    "@type": "AboutPage",
    name: seo.title,
    description: seo.description,
    url: pageUrl,
    inLanguage: locale,
    datePublished: PUBLISHED_AT,
    dateModified: MODIFIED_AT,
    isPartOf: {
      "@type": "WebSite",
      name: SITE_NAME,
      url: SITE_URL,
    },
  };

  // JSON-LD: Organization schema (extended with contact info)
  const organizationJsonLd = {
    "@context": "https://schema.org",
    "@type": "Organization",
    // Same `@id` as the site-wide Organization in the root layout, so this
    // richer declaration merges into that entity rather than competing with it.
    // For the same reason there is no `description` here: the layout already
    // carries one in the page's own language, and a hard-coded English second
    // copy would give one entity two descriptions, one of them in the wrong
    // language.
    "@id": `${SITE_URL}/#organization`,
    name: SITE_NAME,
    url: SITE_URL,
    logo: `${SITE_URL}/brand/purple_diamond.svg`,
    foundingDate: "2026",
    founder: {
      "@type": "Person",
      name: FOUNDER_NAME,
      jobTitle: labels.founderRole,
    },
    address: {
      "@type": "PostalAddress",
      addressLocality: "Istanbul",
      addressCountry: "TR",
    },
    contactPoint: [
      {
        "@type": "ContactPoint",
        contactType: "press",
        email: PRESS_CONTACT_EMAIL,
        availableLanguage: ["en", "tr"],
      },
    ],
    sameAs: [
      "https://www.instagram.com/quloapp",
      "https://www.tiktok.com/@quloapp",
    ],
  };

  // JSON-LD: Person schema for founder
  const personJsonLd = {
    "@context": "https://schema.org",
    "@type": "Person",
    name: FOUNDER_NAME,
    jobTitle: labels.founderRole,
    description: labels.founderBio,
    worksFor: {
      "@type": "Organization",
      name: SITE_NAME,
      url: SITE_URL,
    },
    nationality: "TR",
    address: {
      "@type": "PostalAddress",
      addressLocality: "Istanbul",
      addressCountry: "TR",
    },
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* JSON-LD scripts use trusted static constants only (no user input). */}
      <JsonLd data={aboutPageJsonLd} />
      <JsonLd data={organizationJsonLd} />
      <JsonLd data={personJsonLd} />

      <article className="pt-24 pb-20 px-6">
        <div className="max-w-4xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: labels.breadcrumb }]} />

          {/* Hero */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {labels.eyebrow}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {labels.heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-2xl mx-auto">
              {labels.heroSubtitle}
            </p>
          </header>

          {/* Quick Facts */}
          <section
            aria-labelledby="quick-facts"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="quick-facts"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {labels.quickFactsHeading}
            </h2>
            <dl className="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-4">
              {FACT_ORDER.map((key) => (
                <div key={key}>
                  <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-1">
                    {labels.facts[key].term}
                  </dt>
                  <dd className="text-white text-base mb-3">
                    {labels.facts[key].value}
                  </dd>
                </div>
              ))}
            </dl>
          </section>

          {/* About Qulo */}
          <section
            aria-labelledby="about-qulo"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="about-qulo"
              className="text-2xl font-bold text-qulo-purple mb-4"
            >
              {labels.aboutHeading}
            </h2>
            <div className="space-y-4">
              {labels.aboutParagraphs.map((paragraph) => (
                <p
                  key={paragraph}
                  className="text-base text-qulo-text-secondary leading-relaxed"
                >
                  {paragraph}
                </p>
              ))}
            </div>
          </section>

          {/* Logo Downloads */}
          <section
            aria-labelledby="logos"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2 id="logos" className="text-2xl font-bold text-qulo-purple mb-3">
              {labels.logosHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-6">
              {labels.logosSubtitle}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              {LOGO_ASSETS.map((logo) => (
                <a
                  key={logo.key}
                  href={logo.src}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="group flex flex-col items-center justify-center rounded-xl border border-white/[0.08] bg-qulo-bg p-6 hover:border-qulo-purple/40 transition-colors"
                >
                  <div className="flex items-center justify-center h-24 mb-4">
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={logo.src}
                      alt={labels.logos[logo.key].alt}
                      className="max-h-20 w-auto"
                    />
                  </div>
                  <p className="text-sm font-semibold text-white text-center">
                    {labels.logos[logo.key].label}
                  </p>
                  <p className="text-[10px] text-qulo-text-secondary uppercase tracking-wider mt-1 group-hover:text-qulo-green transition-colors">
                    SVG
                  </p>
                </a>
              ))}
            </div>
          </section>

          {/* Brand Colors */}
          <section
            aria-labelledby="colors"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="colors"
              className="text-2xl font-bold text-qulo-purple mb-3"
            >
              {labels.colorsHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-6">
              {labels.colorsSubtitle}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {BRAND_COLORS.map((color) => (
                <div
                  key={color.hex}
                  className="rounded-xl border border-white/[0.08] overflow-hidden"
                >
                  <div
                    className="w-full h-24 flex items-end p-3"
                    style={{ backgroundColor: color.preview }}
                  >
                    <p
                      className={`text-sm font-semibold ${
                        color.textOnDark ? "text-white" : "text-black/70"
                      }`}
                    >
                      {color.name}
                    </p>
                  </div>
                  {/* HEX and RGB are the same token in every language. */}
                  <div className="bg-white/[0.02] p-4 grid grid-cols-2 gap-3">
                    <div>
                      <p className="text-[10px] uppercase tracking-wider text-qulo-text-secondary mb-1">
                        HEX
                      </p>
                      <code className="text-xs text-white">{color.hex}</code>
                    </div>
                    <div>
                      <p className="text-[10px] uppercase tracking-wider text-qulo-text-secondary mb-1">
                        RGB
                      </p>
                      <code className="text-xs text-white">{color.rgb}</code>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </section>

          {/* Founder */}
          <section
            aria-labelledby="founder"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="founder"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {labels.founderHeading}
            </h2>
            <div className="flex flex-col sm:flex-row gap-6 items-start">
              <div
                aria-hidden="true"
                className="flex-shrink-0 w-24 h-24 rounded-full bg-gradient-to-br from-qulo-purple to-qulo-green flex items-center justify-center text-white text-3xl font-bold"
              >
                {FOUNDER_INITIALS}
              </div>
              <div>
                <h3 className="text-xl font-semibold text-white mb-1">
                  {FOUNDER_NAME}
                </h3>
                <p className="text-sm text-qulo-green mb-4">
                  {labels.founderRole}
                </p>
                <p className="text-sm text-qulo-text-secondary leading-relaxed">
                  {labels.founderBio}
                </p>
              </div>
            </div>
          </section>

          {/* Media Coverage */}
          <section
            aria-labelledby="media-coverage"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="media-coverage"
              className="text-2xl font-bold text-qulo-purple mb-3"
            >
              {labels.coverageHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary">
              {labels.coverageMessage}
            </p>
          </section>

          {/* Press Contact — an address and what it is good for. No response-time
              promise: the page used to guarantee a reply within 24 hours from a
              one-person operation. */}
          <section
            aria-labelledby="press-contact"
            className="mb-12 rounded-2xl border border-qulo-green/20 bg-qulo-green/5 p-6 sm:p-8"
          >
            <h2
              id="press-contact"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {labels.contactHeading}
            </h2>
            <dl className="space-y-4">
              <div>
                <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-1">
                  {labels.contactEmailLabel}
                </dt>
                <dd>
                  <a
                    href={`mailto:${PRESS_CONTACT_EMAIL}`}
                    className="text-qulo-green text-base font-semibold hover:underline"
                  >
                    {PRESS_CONTACT_EMAIL}
                  </a>
                </dd>
              </div>
              <div>
                <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-2">
                  {labels.contactTopicsLabel}
                </dt>
                <dd>
                  <ul className="flex flex-wrap gap-2">
                    {labels.contactTopics.map((topic) => (
                      <li
                        key={topic}
                        className="text-xs text-white rounded-full border border-white/[0.1] bg-white/[0.04] px-3 py-1"
                      >
                        {topic}
                      </li>
                    ))}
                  </ul>
                </dd>
              </div>
            </dl>
          </section>

          {/* Brand files */}
          <section
            aria-labelledby="brand-files"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="brand-files"
              className="text-2xl font-bold text-qulo-purple mb-3"
            >
              {labels.filesHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-4">
              {labels.filesUsageNote}
            </p>
            {/* Direct links to files that exist. This section used to promise a
                /press-kit.zip containing screenshots, a fact-sheet PDF and a
                founder photo; none of the three existed and the ZIP itself was
                a live 404 behind two call-to-action buttons. */}
            <ul className="grid grid-cols-2 sm:grid-cols-3 gap-3">
              {PRESS_ASSETS.map((asset) => (
                <li key={asset.href}>
                  <a
                    href={asset.href}
                    download
                    className="block rounded-lg border border-white/[0.08] bg-white/[0.02] px-3 py-3 text-center text-sm text-qulo-text-secondary hover:text-white hover:border-qulo-purple/40 transition-colors"
                  >
                    {"logoKey" in asset ? labels.logos[asset.logoKey].label : asset.label}
                    <span className="block text-[10px] uppercase tracking-wider mt-1">
                      {asset.format}
                    </span>
                  </a>
                </li>
              ))}
            </ul>
          </section>

          {/* CTA */}
          <section className="mb-12 text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10">
            <h2 className="text-2xl font-bold text-white mb-3">
              {labels.ctaHeading}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-6 max-w-xl mx-auto">
              {labels.ctaText}
            </p>
            <div className="flex justify-center">
              <StoreButtons campaign="web-press" />
            </div>
          </section>

          {/* Internal Links */}
          <section aria-labelledby="more-links">
            <h2
              id="more-links"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {labels.moreHeading}
            </h2>
            <ul className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              {MORE_LINKS.map((link) => (
                <li key={link.key}>
                  <Link
                    href={`/${locale}/${link.path}`}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 text-center hover:border-qulo-purple/40 transition-colors"
                  >
                    <p className="text-sm font-semibold text-white">
                      {labels.moreLinks[link.key]}
                    </p>
                  </Link>
                </li>
              ))}
            </ul>
          </section>
        </div>
      </article>

      <Footer />
    </main>
  );
}
