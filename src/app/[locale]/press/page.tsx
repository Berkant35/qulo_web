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

const PAGE_SLUG = "press";

/**
 * Brand files offered for download. Every entry is a file that actually exists
 * under `public/` — checked by `scripts/verify-press-assets.mjs`, which fails
 * the build if one goes missing. The page previously advertised a
 * `/press-kit.zip` that was never generated, so both of its download buttons
 * returned 404.
 */
const PRESS_ASSETS = [
  { href: "/brand/qulo-logo-1024.png", label: "Logo 1024", format: "PNG" },
  { href: "/brand/qulo-logo-512.png", label: "Logo 512", format: "PNG" },
  { href: "/brand/qulo-logo-256.png", label: "Logo 256", format: "PNG" },
  { href: "/brand/qulo_splash.svg", label: "Splash", format: "SVG" },
  { href: "/brand/purple_diamond.svg", label: "Purple diamond", format: "SVG" },
  { href: "/brand/green_diamond.svg", label: "Green diamond", format: "SVG" },
] as const;
const PUBLISHED_AT = "2026-04-16";
const MODIFIED_AT = "2026-04-16";

const PRESS_CONTACT_EMAIL = "info@socrepho.com";
const FOUNDER_NAME = "Berkant Çalıkuşu";
const FOUNDER_TITLE = "Founder & CEO";

/** Per-locale breadcrumb label for the Press Kit page */
const PRESS_LABELS: Record<string, string> = {
  tr: "Basın Kiti", en: "Press Kit", de: "Pressekit", fr: "Kit Presse", es: "Kit de Prensa",
  ar: "ملف الصحافة", ru: "Пресс-кит", pt: "Kit de Imprensa", it: "Kit Stampa", ja: "プレスキット",
  ko: "프레스 키트", zh: "媒体资料", nl: "Perskit", pl: "Materiały Prasowe", sv: "Presskit", hi: "प्रेस किट",
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
  const seo = PAGE_SEO.press[locale] || PAGE_SEO.press.en;
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

/**
 * JSON-LD renderer — only static trusted content (no user input).
 * Uses dangerouslySetInnerHTML because Next.js requires it for
 * application/ld+json scripts. All content originates from server-side
 * static constants (PAGE_SEO, SITE_URL, locale slug). No user input.
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

/** Per-locale UI strings — TR + EN full, others fall back to EN */
type UiCopy = {
  eyebrow: string;
  heroTitle: string;
  heroSubtitle: string;
  quickFactsHeading: string;
  quickFacts: { dt: string; dd: string }[];
  aboutHeading: string;
  aboutParagraph: string;
  logosHeading: string;
  logosSubtitle: string;
  logoVariations: { label: string; src: string; alt: string; bg: string }[];
  colorsHeading: string;
  colorsSubtitle: string;
  colorHexLabel: string;
  colorRgbLabel: string;
  founderHeading: string;
  founderBio: string;
  mediaCoverageHeading: string;
  mediaCoverageMessage: string;
  pressContactHeading: string;
  pressContactEmailLabel: string;
  pressContactResponseLabel: string;
  pressContactResponseValue: string;
  pressContactTopicsLabel: string;
  pressContactTopics: string[];
  fullPressKitHeading: string;
  fullPressKitDescription: string;
  internalLinksHeading: string;
  internalLinks: { label: string; href: string }[];
  ctaHeading: string;
  ctaText: string;
};

function getCopy(locale: string): UiCopy {
  const isTr = locale === "tr";
  return {
    eyebrow: isTr ? "Basın Merkezi" : "Press Center",
    heroTitle: isTr ? "Basın Kiti" : "Press Kit",
    heroSubtitle: isTr
      ? "Qulo hakkında haber yapmak veya medyada bahsetmek için tüm kaynaklar"
      : "All resources you need to write about or feature Qulo in the media",

    quickFactsHeading: isTr ? "Hızlı Bilgiler" : "Quick Facts",
    quickFacts: [
      { dt: isTr ? "Şirket" : "Company", dd: "Qulo" },
      { dt: isTr ? "Kuruluş" : "Founded", dd: "2026" },
      { dt: isTr ? "Kategori" : "Category", dd: "Quiz Dating App" },
      { dt: "Platform", dd: "iOS, Android" },
      { dt: isTr ? "Diller" : "Languages", dd: "16" },
      { dt: isTr ? "Merkez" : "Headquarters", dd: "Istanbul, Turkey" },
      { dt: isTr ? "Slogan" : "Tag line", dd: isTr ? "Sorularla Tanış" : "Meet Through Questions" },
      { dt: isTr ? "Web Sitesi" : "Website", dd: "quloapp.com" },
    ],

    aboutHeading: isTr ? "Qulo Hakkında" : "About Qulo",
    aboutParagraph: isTr
      ? "Qulo, geleneksel dating uygulamalarının swipe yorgunluğuna alternatif olarak doğmuş, soru-cevap tabanlı bir tanışma platformudur. Kullanıcılar kendileri hakkında 2 ila 4 soru hazırlar, ücretli planlarda 10'a kadar; diğer kullanıcılar bu soruları çözer ve tüm cevapları doğru veren kişiyle eşleşme gerçekleşir. Qulo, 16 dilde hizmet vererek bekarların daha derin ve anlamlı bağlantılar kurmasını hedefler."
      : "Qulo is a question-and-answer based dating platform born as an alternative to the swipe fatigue of traditional dating apps. Users write 2 to 4 questions about themselves, or up to 10 on a paid plan; others answer those questions, and matching occurs with the person who gets them all correct. With service in 16 languages, Qulo aims to help singles build deeper and more meaningful connections.",

    logosHeading: isTr ? "Logo İndirme" : "Logo Downloads",
    logosSubtitle: isTr
      ? "Qulo logo varyasyonları. Tıklayarak yeni sekmede aç ve indir."
      : "Qulo logo variations. Click to open in a new tab and download.",
    logoVariations: [
      {
        label: isTr ? "Mor Logo" : "Purple Logo",
        src: "/brand/purple_diamond.svg",
        alt: isTr ? "Qulo mor elmas logosu" : "Qulo purple diamond logo",
        bg: "bg-qulo-bg",
      },
      {
        label: isTr ? "Yeşil Logo" : "Green Logo",
        src: "/brand/green_diamond.svg",
        alt: isTr ? "Qulo yeşil elmas logosu" : "Qulo green diamond logo",
        bg: "bg-qulo-bg",
      },
      {
        label: isTr ? "Splash Logo" : "Splash Logo",
        src: "/brand/qulo_splash.svg",
        alt: isTr ? "Qulo splash logosu" : "Qulo splash logo",
        bg: "bg-qulo-bg",
      },
    ],

    colorsHeading: isTr ? "Marka Renkleri" : "Brand Colors",
    colorsSubtitle: isTr
      ? "Qulo marka kimliğinin temel renkleri. HEX ve RGB değerleri ile."
      : "Core colors of the Qulo brand identity, with HEX and RGB values.",
    colorHexLabel: "HEX",
    colorRgbLabel: "RGB",

    founderHeading: isTr ? "Kurucu" : "Founder",
    founderBio: isTr
      ? "Berkant Çalıkuşu, İstanbul'da yaşayan bağımsız bir geliştirici. Qulo'yu 2026'da kurdu; uygulamayı kendisi geliştiriyor ve yürütüyor. Gizlilik politikasında adı geçen veri sorumlusu da kendisi."
      : "Berkant Çalıkuşu is an independent developer based in Istanbul, Turkey. He founded Qulo in 2026 and builds and runs the app himself. He is also the data controller named in the privacy policy.",

    mediaCoverageHeading: isTr ? "Medyada Qulo" : "Qulo in the Media",
    mediaCoverageMessage: isTr
      ? "Henüz yayımlanmış bir haber yok. Basın talepleri için bize yazabilirsiniz."
      : "No press coverage yet. Get in touch with press enquiries.",

    pressContactHeading: isTr ? "Basın İletişim" : "Press Contact",
    pressContactEmailLabel: "Email",
    pressContactResponseLabel: isTr ? "Yanıt Süresi" : "Response Time",
    pressContactResponseValue: isTr ? "24 saat içinde" : "Within 24 hours",
    pressContactTopicsLabel: isTr ? "Önerilen Konular" : "Suggested Topics",
    pressContactTopics: isTr
      ? ["İnceleme talebi", "Röportaj", "Özellik haberi", "Founder söyleşisi"]
      : ["Review request", "Interview", "Feature story", "Founder Q&A"],

    fullPressKitHeading: isTr ? "Tam Press Kit" : "Full Press Kit",
    fullPressKitDescription: isTr
      ? "Marka dosyaları, doğrudan indirilebilir:"
      : "Brand files, ready to download:",

    internalLinksHeading: isTr ? "Daha Fazla" : "More",
    internalLinks: [
      { label: isTr ? "Hakkımızda" : "About", href: `/${locale}/about` },
      { label: isTr ? "İstatistikler" : "Statistics", href: `/${locale}/dating-statistics` },
      { label: "Blog", href: `/${locale}/blog` },
      { label: isTr ? "İletişim" : "Contact", href: `/${locale}/help` },
    ],

    ctaHeading: isTr ? "Qulo'yu Deneyin" : "Try Qulo",
    ctaText: isTr
      ? "Sorularla tanışın, gerçek bağlantılar kurun."
      : "Meet through questions, build real connections.",
  };
}

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

export default async function PressPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);

  const copy = getCopy(locale);
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
    name: SITE_NAME,
    url: SITE_URL,
    logo: `${SITE_URL}/brand/purple_diamond.svg`,
    description:
      "Qulo is a question-and-answer based dating platform that matches users through quiz mechanics instead of swiping.",
    foundingDate: "2026",
    founder: {
      "@type": "Person",
      name: FOUNDER_NAME,
      jobTitle: FOUNDER_TITLE,
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
    jobTitle: FOUNDER_TITLE,
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
          <Breadcrumb
            locale={locale}
            items={[{ label: PRESS_LABELS[locale] || PRESS_LABELS.en }]}
          />

          {/* Hero */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {copy.eyebrow}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {copy.heroTitle}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-2xl mx-auto">
              {copy.heroSubtitle}
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
              {copy.quickFactsHeading}
            </h2>
            <dl className="grid grid-cols-1 sm:grid-cols-2 gap-x-8 gap-y-4">
              {copy.quickFacts.map((fact) => (
                <div key={fact.dt}>
                  <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-1">
                    {fact.dt}
                  </dt>
                  <dd className="text-white text-base mb-3">{fact.dd}</dd>
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
              {copy.aboutHeading}
            </h2>
            <p className="text-base text-qulo-text-secondary leading-relaxed">
              {copy.aboutParagraph}
            </p>
          </section>

          {/* Logo Downloads */}
          <section
            aria-labelledby="logos"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2 id="logos" className="text-2xl font-bold text-qulo-purple mb-3">
              {copy.logosHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-6">
              {copy.logosSubtitle}
            </p>
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
              {copy.logoVariations.map((logo) => (
                <a
                  key={logo.src}
                  href={logo.src}
                  target="_blank"
                  rel="noopener noreferrer"
                  className={`group flex flex-col items-center justify-center rounded-xl border border-white/[0.08] ${logo.bg} p-6 hover:border-qulo-purple/40 transition-colors`}
                >
                  <div className="flex items-center justify-center h-24 mb-4">
                    {/* eslint-disable-next-line @next/next/no-img-element */}
                    <img
                      src={logo.src}
                      alt={logo.alt}
                      className="max-h-20 w-auto"
                    />
                  </div>
                  <p className="text-sm font-semibold text-white text-center">
                    {logo.label}
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
              {copy.colorsHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-6">
              {copy.colorsSubtitle}
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
                  <div className="bg-white/[0.02] p-4 grid grid-cols-2 gap-3">
                    <div>
                      <p className="text-[10px] uppercase tracking-wider text-qulo-text-secondary mb-1">
                        {copy.colorHexLabel}
                      </p>
                      <code className="text-xs text-white">{color.hex}</code>
                    </div>
                    <div>
                      <p className="text-[10px] uppercase tracking-wider text-qulo-text-secondary mb-1">
                        {copy.colorRgbLabel}
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
              {copy.founderHeading}
            </h2>
            <div className="flex flex-col sm:flex-row gap-6 items-start">
              <div className="flex-shrink-0 w-24 h-24 rounded-full bg-gradient-to-br from-qulo-purple to-qulo-green flex items-center justify-center text-white text-3xl font-bold">
                BÇ
              </div>
              <div>
                <h3 className="text-xl font-semibold text-white mb-1">
                  {FOUNDER_NAME}
                </h3>
                <p className="text-sm text-qulo-green mb-4">{FOUNDER_TITLE}</p>
                <p className="text-sm text-qulo-text-secondary leading-relaxed">
                  {copy.founderBio}
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
              {copy.mediaCoverageHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary">
              {copy.mediaCoverageMessage}
            </p>
          </section>

          {/* Press Contact */}
          <section
            aria-labelledby="press-contact"
            className="mb-12 rounded-2xl border border-qulo-green/20 bg-qulo-green/5 p-6 sm:p-8"
          >
            <h2
              id="press-contact"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {copy.pressContactHeading}
            </h2>
            <dl className="space-y-4">
              <div>
                <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-1">
                  {copy.pressContactEmailLabel}
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
                <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-1">
                  {copy.pressContactResponseLabel}
                </dt>
                <dd className="text-white text-base">
                  {copy.pressContactResponseValue}
                </dd>
              </div>
              <div>
                <dt className="text-qulo-text-secondary uppercase tracking-wide text-xs mb-2">
                  {copy.pressContactTopicsLabel}
                </dt>
                <dd>
                  <ul className="flex flex-wrap gap-2">
                    {copy.pressContactTopics.map((topic) => (
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

          {/* Full Press Kit */}
          <section
            aria-labelledby="full-press-kit"
            className="mb-12 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6 sm:p-8"
          >
            <h2
              id="full-press-kit"
              className="text-2xl font-bold text-qulo-purple mb-3"
            >
              {copy.fullPressKitHeading}
            </h2>
            <p className="text-sm text-qulo-text-secondary mb-4">
              {copy.fullPressKitDescription}
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
                    {asset.label}
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
          <section aria-labelledby="more-links">
            <h2
              id="more-links"
              className="text-2xl font-bold text-qulo-purple mb-6"
            >
              {copy.internalLinksHeading}
            </h2>
            <ul className="grid grid-cols-2 sm:grid-cols-4 gap-3">
              {copy.internalLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="block rounded-xl border border-white/[0.08] bg-white/[0.03] p-4 text-center hover:border-qulo-purple/40 transition-colors"
                  >
                    <p className="text-sm font-semibold text-white">
                      {link.label}
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
