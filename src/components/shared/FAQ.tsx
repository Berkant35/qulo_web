import { JsonLd } from "@/components/shared/JsonLd";

export interface FAQItem {
  q: string;
  a: string;
}

interface FAQProps {
  items: FAQItem[];
  /** Section title — defaults to "Frequently Asked Questions" */
  title?: string;
}

/** Build FAQPage structured data from a flat question list. */
export function faqPageSchema(items: FAQItem[]) {
  return {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: items.map((item) => ({
      "@type": "Question",
      name: item.q,
      acceptedAnswer: {
        "@type": "Answer",
        text: item.a,
      },
    })),
  };
}

/**
 * Question list rendered as semantic `<details>/<summary>` — no JS needed for
 * accordion behavior, so answers are present in the static HTML and readable by
 * search crawlers and LLM fetchers.
 *
 * Emits no structured data of its own: pages showing several lists must emit a
 * single combined FAQPage (see `faqPageSchema`), not one per section.
 */
export function FaqList({ items }: { items: FAQItem[] }) {
  return (
    <div className="space-y-3">
      {items.map((item, idx) => (
        <details
          key={idx}
          className="group rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 open:bg-white/[0.05]"
        >
          <summary className="cursor-pointer list-none flex items-start justify-between gap-4">
            <h3 className="text-base font-semibold text-white">{item.q}</h3>
            <span
              className="text-qulo-purple transition-transform group-open:rotate-45 shrink-0"
              aria-hidden="true"
            >
              +
            </span>
          </summary>
          <p className="mt-4 text-sm text-qulo-text-secondary leading-relaxed">
            {item.a}
          </p>
        </details>
      ))}
    </div>
  );
}

/**
 * FAQ section with FAQPage JSON-LD schema.
 *
 * SECURITY: `items` MUST originate from trusted server-side constants (page i18n
 * data). Never pass user-controlled input — see the note on `JsonLd`.
 */
export function FAQ({ items, title = "Frequently Asked Questions" }: FAQProps) {
  return (
    <section className="mt-16" aria-labelledby="faq-title">
      {/* FAQPage JSON-LD — server-side static content only (see SECURITY note) */}
      <JsonLd data={faqPageSchema(items)} />
      <h2 id="faq-title" className="text-2xl font-bold text-qulo-purple mb-6">
        {title}
      </h2>
      <FaqList items={items} />
    </section>
  );
}

/**
 * Per-locale FAQ section title used across all FAQ-enabled pages.
 * EN fallback for unsupported locales.
 */
export const FAQ_TITLES: Record<string, string> = {
  tr: "Sık Sorulan Sorular",
  en: "Frequently Asked Questions",
  de: "Häufig gestellte Fragen",
  fr: "Questions Fréquemment Posées",
  es: "Preguntas Frecuentes",
  ar: "الأسئلة الشائعة",
  ru: "Часто задаваемые вопросы",
  pt: "Perguntas Frequentes",
  it: "Domande Frequenti",
  ja: "よくある質問",
  ko: "자주 묻는 질문",
  zh: "常见问题",
  nl: "Veelgestelde Vragen",
  pl: "Często Zadawane Pytania",
  sv: "Vanliga Frågor",
  hi: "अक्सर पूछे जाने वाले सवाल",
};

/** Resolve FAQ title for a locale with safe EN fallback. */
export function faqTitle(locale: string): string {
  return FAQ_TITLES[locale] || FAQ_TITLES.en;
}
