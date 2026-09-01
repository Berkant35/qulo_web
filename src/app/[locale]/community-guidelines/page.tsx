import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { rtlLocales, locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";

/** Per-locale breadcrumb label for the Community Guidelines page */
const GUIDELINES_LABELS: Record<string, string> = {
  tr: "Topluluk Kuralları", en: "Guidelines", de: "Richtlinien", fr: "Règles", es: "Normas",
  ar: "إرشادات المجتمع", ru: "Правила", pt: "Regras", it: "Linee Guida", ja: "ガイドライン",
  ko: "가이드라인", zh: "社区准则", nl: "Richtlijnen", pl: "Zasady", sv: "Regler",
  hi: "दिशानिर्देश",
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.communityGuidelines[locale] || PAGE_SEO.communityGuidelines.en;
  const pageUrl = `${SITE_URL}/${locale}/community-guidelines`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/community-guidelines`;
  languages["x-default"] = `${SITE_URL}/tr/community-guidelines`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", images: ogImages() },
  };
}

const sections = [
  { title: "respectTitle", body: "respect" },
  { title: "authenticityTitle", body: "authenticity" },
  { title: "contentTitle", body: "content" },
  { title: "questionsTitle", body: "questions" },
  { title: "reportingTitle", body: "reporting" },
  { title: "enforcementTitle", body: "enforcement" },
  { title: "contactTitle", body: "contact" },
] as const;

export default async function CommunityGuidelinesPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("communityGuidelines");

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6" dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}>
        <div className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: GUIDELINES_LABELS[locale] || GUIDELINES_LABELS.en }]}
          />

          <h1 className="text-4xl font-bold text-qulo-purple mb-3">
            {t("title")}
          </h1>
          <p className="text-qulo-text-muted text-sm mb-6">
            {t("lastUpdated")}
          </p>
          <div className="text-qulo-text-secondary leading-relaxed text-base whitespace-pre-line mb-10">
            {t("intro")}
          </div>
          {sections.map(({ title, body }) => (
            <section key={title} className="mb-8">
              <h2 className="text-xl font-semibold text-white mb-3">
                {t(title)}
              </h2>
              <div className="text-qulo-text-secondary leading-relaxed text-base whitespace-pre-line">
                {t(body)}
              </div>
            </section>
          ))}
        </div>
      </div>
    </main>
  );
}
