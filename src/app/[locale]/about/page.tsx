import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { StoreButtons } from "@/components/hero/StoreButtons";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { FAQ, faqTitle } from "@/components/shared/FAQ";
import { locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { getAboutFaqs } from "@/lib/constants/faqs";

/** Per-locale breadcrumb label for the About page */
const ABOUT_LABELS: Record<string, string> = {
  tr: "Hakkında", en: "About", de: "Über uns", fr: "À propos", es: "Acerca de",
  ar: "حول", ru: "О нас", pt: "Sobre", it: "Chi siamo", ja: "概要",
  ko: "소개", zh: "关于", nl: "Over ons", pl: "O nas", sv: "Om oss", hi: "के बारे में",
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.about[locale] || PAGE_SEO.about.en;
  const pageUrl = `${SITE_URL}/${locale}/about`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/about`;
  languages["x-default"] = `${SITE_URL}/tr/about`;
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
      images: ogImages(),
    },
  };
}

function HowToJsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default async function AboutPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("about");

  const steps = [
    { name: t("step1"), url: `${SITE_URL}/${locale}/about` },
    { name: t("step2"), url: `${SITE_URL}/${locale}/about` },
    { name: t("step3"), url: `${SITE_URL}/${locale}/about` },
    { name: t("step4"), url: `${SITE_URL}/${locale}/about` },
  ];

  const howToJsonLd = {
    "@context": "https://schema.org",
    "@type": "HowTo",
    name: t("howItWorks"),
    description: t("whatIsQuloDesc"),
    step: steps.map((s, i) => ({
      "@type": "HowToStep",
      position: i + 1,
      name: s.name.split(" — ")[0],
      text: s.name,
      url: s.url,
    })),
  };

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />

      {/* HowTo JSON-LD — trusted i18n content only */}
      <HowToJsonLd data={howToJsonLd} />

      <div className="pt-24 pb-20 px-6">
        <div className="max-w-3xl mx-auto">

          <Breadcrumb
            locale={locale}
            items={[{ label: ABOUT_LABELS[locale] || ABOUT_LABELS.en }]}
          />

          {/* Hero Section */}
          <header className="mb-16 text-center">
            <p className="text-qulo-purple text-xs font-semibold uppercase tracking-[0.2em] mb-4">
              {t("subtitle")}
            </p>
            <h1 className="text-4xl sm:text-5xl font-bold mb-6 leading-tight">
              {t("title")}
            </h1>
            <p className="text-lg text-qulo-text-secondary max-w-xl mx-auto">
              {t("hero")}
            </p>
          </header>

          {/* What is Qulo */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-4">
              {t("whatIsQulo")}
            </h2>
            <article className="text-qulo-text-secondary leading-relaxed text-sm">
              <p>{t("whatIsQuloDesc")}</p>
            </article>
          </section>

          {/* Why Different — Swipe Fatigue */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-4">
              {t("whyDifferent")}
            </h2>
            <article className="text-qulo-text-secondary leading-relaxed text-sm">
              <p>{t("whyDifferentDesc")}</p>
            </article>
          </section>

          {/* Swipe Fatigue Deep Dive */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-green mb-4">
              {t("swipeFatigue")}
            </h2>
            <article className="text-qulo-text-secondary leading-relaxed text-sm">
              <p>{t("swipeFatigueDesc")}</p>
            </article>
          </section>

          {/* How It Works — 4 Steps */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-6">
              {t("howItWorks")}
            </h2>
            <ol className="space-y-4">
              {[t("step1"), t("step2"), t("step3"), t("step4")].map(
                (step, i) => {
                  const [title, desc] = step.split(" — ");
                  return (
                    <li
                      key={i}
                      className="flex items-start gap-4 rounded-xl border border-white/[0.08] bg-white/[0.03] p-5"
                    >
                      <span className="flex-shrink-0 w-8 h-8 rounded-full bg-qulo-purple/20 text-qulo-purple font-bold text-sm flex items-center justify-center">
                        {i + 1}
                      </span>
                      <div>
                        <p className="text-white font-semibold text-sm">
                          {title}
                        </p>
                        {desc && (
                          <p className="text-qulo-text-secondary text-sm mt-1">
                            {desc}
                          </p>
                        )}
                      </div>
                    </li>
                  );
                }
              )}
            </ol>
          </section>

          {/* AI Powered */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-purple mb-4">
              {t("aiPowered")}
            </h2>
            <article className="text-qulo-text-secondary leading-relaxed text-sm">
              <p>{t("aiPoweredDesc")}</p>
            </article>
          </section>

          {/* Global Community */}
          <section className="mb-14">
            <h2 className="text-2xl font-bold text-qulo-green mb-4">
              {t("globalCommunity")}
            </h2>
            <article className="text-qulo-text-secondary leading-relaxed text-sm">
              <p>{t("globalCommunityDesc")}</p>
            </article>
          </section>

          {/* FAQ Section — FAQPage JSON-LD for Google rich snippets */}
          <FAQ items={getAboutFaqs(locale)} title={faqTitle(locale)} />

          {/* Download CTA */}
          <section className="text-center rounded-2xl border border-white/[0.08] bg-white/[0.03] p-10 mt-16">
            <h2 className="text-2xl font-bold text-white mb-3">
              {t("downloadCta")}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-6">
              {t("downloadCtaDesc")}
            </p>
            <div className="flex justify-center">
              <StoreButtons />
            </div>
          </section>

        </div>
      </div>
    </main>
  );
}
