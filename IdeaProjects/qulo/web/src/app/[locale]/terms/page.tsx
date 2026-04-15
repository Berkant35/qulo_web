import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { rtlLocales, locales, type Locale } from "@/lib/i18n/config";
import { PAGE_SEO, SITE_URL, SITE_NAME } from "@/lib/constants/metadata";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const seo = PAGE_SEO.terms[locale] || PAGE_SEO.terms.en;
  const pageUrl = `${SITE_URL}/${locale}/terms`;
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = `${SITE_URL}/${l}/terms`;
  languages["x-default"] = `${SITE_URL}/tr/terms`;
  return {
    title: seo.title,
    description: seo.description,
    alternates: { canonical: pageUrl, languages },
    openGraph: { title: seo.title, description: seo.description, url: pageUrl, siteName: SITE_NAME, type: "website" },
  };
}

const sections = [
  { title: "acceptanceTitle", body: "acceptance" },
  { title: "eligibilityTitle", body: "eligibility" },
  { title: "accountTitle", body: "account" },
  { title: "contentTitle", body: "content" },
  { title: "diamondsTitle", body: "diamonds" },
  { title: "powersTitle", body: "powers" },
  { title: "conductTitle", body: "conduct" },
  { title: "subscriptionTitle", body: "subscription" },
  { title: "terminationTitle", body: "termination" },
  { title: "disclaimerTitle", body: "disclaimer" },
  { title: "liabilityTitle", body: "liability" },
  { title: "governingTitle", body: "governing" },
  { title: "kvkkTitle", body: "kvkk" },
  { title: "dataProtectionTitle", body: "dataProtection" },
  { title: "contactTitle", body: "contactInfo" },
] as const;

export default async function TermsPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("termsOfService");

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6" dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}>
        <div className="max-w-2xl mx-auto">
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
