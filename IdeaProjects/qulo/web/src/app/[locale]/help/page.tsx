"use client";

import { useTranslations } from "next-intl";
import { useState } from "react";
import { Navbar } from "@/components/shared/Navbar";

type FaqItem = {
  q: string;
  a: string;
};

type Category = {
  key: string;
  label: string;
  items: FaqItem[];
};

function AccordionItem({ q, a }: FaqItem) {
  const [open, setOpen] = useState(false);

  return (
    <div className="border border-white/[0.08] rounded-xl overflow-hidden">
      <button
        onClick={() => setOpen((prev) => !prev)}
        className="w-full flex items-center justify-between px-5 py-4 text-left hover:bg-white/[0.04] transition-colors"
        aria-expanded={open}
      >
        <span className="text-white font-medium text-sm leading-snug pr-4">{q}</span>
        <span
          className="flex-shrink-0 w-5 h-5 rounded-full border border-white/20 flex items-center justify-center transition-transform duration-200"
          style={{ transform: open ? "rotate(45deg)" : "rotate(0deg)" }}
        >
          <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
            <path d="M5 1v8M1 5h8" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
          </svg>
        </span>
      </button>
      {open && (
        <div className="px-5 pb-4 text-qulo-text-secondary text-sm leading-relaxed border-t border-white/[0.06]">
          <p className="pt-3">{a}</p>
        </div>
      )}
    </div>
  );
}

function CategorySection({ label, items }: { label: string; items: FaqItem[] }) {
  return (
    <section className="mb-10">
      <h2 className="text-base font-semibold text-qulo-purple mb-4 uppercase tracking-wider">
        {label}
      </h2>
      <div className="flex flex-col gap-2">
        {items.map((item, i) => (
          <AccordionItem key={i} q={item.q} a={item.a} />
        ))}
      </div>
    </section>
  );
}

export default function HelpPage() {
  const t = useTranslations("help");

  const categories: Category[] = [
    {
      key: "account",
      label: t("categories.account"),
      items: [
        { q: t("faq.account_reset_password_q"), a: t("faq.account_reset_password_a") },
        { q: t("faq.account_delete_q"), a: t("faq.account_delete_a") },
        { q: t("faq.account_banned_q"), a: t("faq.account_banned_a") },
      ],
    },
    {
      key: "matching",
      label: t("categories.matching"),
      items: [
        { q: t("faq.matching_how_q"), a: t("faq.matching_how_a") },
        { q: t("faq.matching_questions_q"), a: t("faq.matching_questions_a") },
      ],
    },
    {
      key: "diamonds",
      label: t("categories.diamonds"),
      items: [
        { q: t("faq.diamonds_what_q"), a: t("faq.diamonds_what_a") },
        { q: t("faq.diamonds_buy_q"), a: t("faq.diamonds_buy_a") },
      ],
    },
    {
      key: "security",
      label: t("categories.security"),
      items: [
        { q: t("faq.security_block_q"), a: t("faq.security_block_a") },
        { q: t("faq.security_report_q"), a: t("faq.security_report_a") },
        { q: t("faq.security_data_q"), a: t("faq.security_data_a") },
      ],
    },
    {
      key: "technical",
      label: t("categories.technical"),
      items: [
        { q: t("faq.technical_connection_q"), a: t("faq.technical_connection_a") },
        { q: t("faq.technical_notification_q"), a: t("faq.technical_notification_a") },
      ],
    },
  ];

  return (
    <main className="min-h-screen bg-qulo-bg text-white">
      <Navbar />
      <div className="pt-24 pb-20 px-6">
        <div className="max-w-2xl mx-auto">
          {/* Header */}
          <h1 className="text-4xl font-bold text-qulo-purple mb-3">{t("title")}</h1>
          <p className="text-qulo-text-muted text-sm mb-10">{t("subtitle")}</p>

          {/* FAQ Categories */}
          {categories.map((cat) => (
            <CategorySection key={cat.key} label={cat.label} items={cat.items} />
          ))}

          {/* Still need help? */}
          <div className="mt-4 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-6">
            <h2 className="text-lg font-semibold text-white mb-2">{t("still_need_help")}</h2>
            <p className="text-qulo-text-secondary text-sm mb-4">{t("still_need_help_desc")}</p>
            <a
              href={`mailto:${t("contact_email")}`}
              className="inline-flex items-center gap-2 text-qulo-purple text-sm font-medium hover:underline"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
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
