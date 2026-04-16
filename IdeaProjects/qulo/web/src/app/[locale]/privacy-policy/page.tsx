import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { rtlLocales, locales } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";

/** Per-locale breadcrumb label for the Privacy Policy page */
const PRIVACY_LABELS: Record<string, string> = {
  tr: "Gizlilik", en: "Privacy", de: "Datenschutz", fr: "Confidentialité", es: "Privacidad",
  ar: "الخصوصية", ru: "Конфиденциальность", pt: "Privacidade", it: "Privacy", ja: "プライバシー",
  ko: "개인정보", zh: "隐私", nl: "Privacy", pl: "Prywatność", sv: "Integritet", hi: "गोपनीयता",
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.privacy[locale] || PAGE_SEO.privacy.en;
  const pageUrl = `${SITE_URL}/${locale}/privacy-policy`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/privacy-policy`;
  languages["x-default"] = `${SITE_URL}/tr/privacy-policy`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website" },
  };
}

const sections = [
  { title: "introTitle", body: "intro" },
  { title: "dataCollectionTitle", body: "dataCollection" },
  { title: "dataNotCollectedTitle", body: "dataNotCollected" },
  { title: "usageTitle", body: "usage" },
  { title: "sharingTitle", body: "sharing" },
  { title: "retentionTitle", body: "retention" },
  { title: "securityTitle", body: "security" },
  { title: "rightsTitle", body: "rights" },
  { title: "deletionTitle", body: "deletion" },
  { title: "childrenTitle", body: "children" },
  { title: "locationTitle", body: "location" },
  { title: "cookiesTitle", body: "cookies" },
  { title: "changesTitle", body: "changes" },
  { title: "kvkkTitle", body: "kvkk" },
  { title: "kvkkRightsTitle", body: "kvkkRights" },
  { title: "contactTitle", body: "contact" },
] as const;

export default async function PrivacyPolicyPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("privacyPolicy");

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6" dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}>
        <div className="max-w-2xl mx-auto">
          <Breadcrumb
            locale={locale}
            items={[{ label: PRIVACY_LABELS[locale] || PRIVACY_LABELS.en }]}
          />

          <h1 className="text-4xl font-bold text-qulo-purple mb-3">
            {t("title")}
          </h1>
          <p className="text-qulo-text-muted text-sm mb-10">
            {t("lastUpdated")}
          </p>
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
