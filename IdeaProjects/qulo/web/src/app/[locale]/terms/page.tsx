import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { rtlLocales } from "@/lib/i18n/config";

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
