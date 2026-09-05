import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { rtlLocales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";
import { ogImages } from "@/lib/seo/openGraph";
import { alternateLanguages } from "@/lib/seo/alternates";

/** Per-locale breadcrumb label for the Safety Tips page */
const SAFETY_LABELS: Record<string, string> = {
  tr: "Güvenlik", en: "Safety", de: "Sicherheit", fr: "Sécurité", es: "Seguridad",
  ar: "السلامة", ru: "Безопасность", pt: "Segurança", it: "Sicurezza", ja: "安全",
  ko: "안전", zh: "安全", nl: "Veiligheid", pl: "Bezpieczeństwo", sv: "Säkerhet",
  hi: "सुरक्षा",
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.safetyTips[locale] || PAGE_SEO.safetyTips.en;
  const pageUrl = `${SITE_URL}/${locale}/safety-tips`;
  const languages = alternateLanguages("/safety-tips");
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website", images: ogImages() },
  };
}

const sections = [
  { title: "onlineTitle", body: "online" },
  { title: "scamsTitle", body: "scams" },
  { title: "meetingTitle", body: "meeting" },
  { title: "privacyTitle", body: "privacy" },
  { title: "toolsTitle", body: "tools" },
  { title: "emergencyTitle", body: "emergency" },
] as const;

export default async function SafetyTipsPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("safetyTips");

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6" dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}>
        <div className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: SAFETY_LABELS[locale] || SAFETY_LABELS.en }]}
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
