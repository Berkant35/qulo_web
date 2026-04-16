export interface FAQItem {
  q: string;
  a: string;
}

interface FAQProps {
  items: FAQItem[];
  /** Section title — defaults to "Frequently Asked Questions" */
  title?: string;
}

/**
 * FAQ section with FAQPage JSON-LD schema.
 *
 * - Renders semantic HTML (`<section>` + `<details>/<summary>`) — no JS needed
 *   for accordion behavior.
 * - Emits FAQPage structured data for Google rich snippets.
 *
 * SECURITY: This component is server-rendered and `items` MUST originate from
 * trusted server-side constants (page i18n data). Never pass user-controlled
 * input here — the JSON-LD payload is injected via `dangerouslySetInnerHTML`,
 * matching the existing JsonLd pattern used in features/[slug] and compare/[slug].
 */
export function FAQ({ items, title = "Frequently Asked Questions" }: FAQProps) {
  // Static, trusted server-side content only — see SECURITY note above.
  const jsonLd = JSON.stringify({
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
  });

  return (
    <section className="mt-16" aria-labelledby="faq-title">
      {/* FAQPage JSON-LD — server-side static content only (see SECURITY note) */}
      <script
        type="application/ld+json"
        // eslint-disable-next-line react/no-danger
        dangerouslySetInnerHTML={{ __html: jsonLd }}
      />
      <h2
        id="faq-title"
        className="text-2xl font-bold text-qulo-purple mb-6"
      >
        {title}
      </h2>
      <div className="space-y-3">
        {items.map((item, idx) => (
          <details
            key={idx}
            className="group rounded-xl border border-white/[0.08] bg-white/[0.03] p-5 open:bg-white/[0.05]"
          >
            <summary className="cursor-pointer list-none flex items-start justify-between gap-4">
              <h3 className="text-base font-semibold text-white">
                {item.q}
              </h3>
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
};

/** Resolve FAQ title for a locale with safe EN fallback. */
export function faqTitle(locale: string): string {
  return FAQ_TITLES[locale] || FAQ_TITLES.en;
}
