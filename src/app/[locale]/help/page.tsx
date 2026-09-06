import Link from "next/link";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Navbar } from "@/components/shared/Navbar";
import { Breadcrumb } from "@/components/shared/Breadcrumb";
import { JsonLd } from "@/components/shared/JsonLd";
import { FaqList, faqPageSchema, type FAQItem } from "@/components/shared/FAQ";
import { locales, rtlLocales } from "@/lib/i18n/config";
import { ANSWER_PAGES, answerQuestion } from "@/lib/constants/answers";
import { ANSWER_LABELS } from "@/lib/constants/answerLabels";

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

/** FAQ categories and the dictionary keys backing each question. */
const CATEGORIES = [
  { key: "account", questions: ["account_reset_password", "account_delete", "account_banned"] },
  { key: "matching", questions: ["matching_how", "matching_questions"] },
  { key: "diamonds", questions: ["diamonds_what", "diamonds_buy"] },
  { key: "security", questions: ["security_block", "security_report", "security_data"] },
  { key: "technical", questions: ["technical_connection", "technical_notification"] },
] as const;

export default async function HelpPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("help");
  const answerLabels = ANSWER_LABELS[locale] || ANSWER_LABELS.en;

  const categories = CATEGORIES.map((category) => ({
    key: category.key,
    label: t(`categories.${category.key}` as Parameters<typeof t>[0]),
    items: category.questions.map(
      (question): FAQItem => ({
        q: t(`faq.${question}_q` as Parameters<typeof t>[0]),
        a: t(`faq.${question}_a` as Parameters<typeof t>[0]),
      }),
    ),
  }));

  const allItems = categories.flatMap((category) => category.items);

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      {/* FAQPage JSON-LD — one combined block for every category (localized dictionary content) */}
      <JsonLd data={faqPageSchema(allItems)} />
      <Navbar />
      <div
        className="pt-24 pb-20 px-6"
        dir={rtlLocales.includes(locale) ? "rtl" : "ltr"}
      >
        <div className="max-w-2xl mx-auto">
          <Breadcrumb locale={locale} items={[{ label: t("title") }]} />

          <h1 className="text-4xl font-bold text-qulo-purple mb-3">{t("title")}</h1>
          <p className="text-qulo-text-muted text-sm mb-10">{t("subtitle")}</p>

          {categories.map((category) => (
            <section key={category.key} className="mb-10">
              <h2 className="text-base font-semibold text-qulo-purple mb-4 uppercase tracking-wider">
                {category.label}
              </h2>
              <FaqList items={category.items} />
            </section>
          ))}

          <section className="mt-4" aria-labelledby="help-answers">
            <h2
              id="help-answers"
              className="text-base font-semibold text-qulo-purple mb-2 uppercase tracking-wider"
            >
              {answerLabels.hubTitle}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-4">
              {answerLabels.hubIntro}
            </p>
            <ul className="space-y-2">
              {ANSWER_PAGES.map((page) => (
                <li key={page.slug}>
                  <Link
                    href={`/${locale}/answers/${page.slug}`}
                    className="text-qulo-text-secondary text-sm hover:text-white hover:underline"
                  >
                    {answerQuestion(page, locale)}
                  </Link>
                </li>
              ))}
            </ul>
          </section>

          <div className="mt-4 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6">
            <h2 className="text-lg font-semibold text-white mb-2">
              {t("still_need_help")}
            </h2>
            <p className="text-qulo-text-secondary text-sm mb-4">
              {t("still_need_help_desc")}
            </p>
            <a
              href={`mailto:${t("contact_email")}`}
              className="inline-flex items-center gap-2 text-qulo-purple text-sm font-medium hover:underline"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none" aria-hidden="true">
                <path
                  d="M1.167 3.5A1.167 1.167 0 0 1 2.333 2.333h9.334A1.167 1.167 0 0 1 12.833 3.5v7a1.167 1.167 0 0 1-1.166 1.167H2.333A1.167 1.167 0 0 1 1.167 10.5v-7Z"
                  stroke="currentColor"
                  strokeWidth="1.2"
                  strokeLinejoin="round"
                />
                <path
                  d="M1.167 3.5 7 7.583 12.833 3.5"
                  stroke="currentColor"
                  strokeWidth="1.2"
                  strokeLinejoin="round"
                />
              </svg>
              {t("contact_email")}
            </a>
          </div>
        </div>
      </div>
    </main>
  );
}
