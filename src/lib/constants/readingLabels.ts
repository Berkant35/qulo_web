/**
 * "N min read" — the one string every article template shows.
 *
 * It was declared four times: in the blog hub, the blog article template, the
 * advice hub and the advice article template. The blog article copy had all 16
 * content locales; the other three had `tr/en/de/fr/es` and fell back to
 * English, so a Japanese reader got "8 min read" under a Japanese headline.
 * Four copies of one string is how that happens, and completing four copies is
 * how it happens again — so there is one copy now.
 *
 * The values are the reviewed ones from the blog article template, unchanged.
 * `readTime` is a unit label, not a sentence: it follows the number, and some
 * locales fold the verb into it (ja "分で読めます", ko "분 분량").
 */
export const READ_TIME_LABELS: Record<string, string> = {
  tr: "dk okuma",
  en: "min read",
  de: "Min. Lesezeit",
  fr: "min de lecture",
  es: "min de lectura",
  ar: "دقيقة قراءة",
  ru: "мин чтения",
  pt: "min de leitura",
  it: "min di lettura",
  ja: "分で読めます",
  ko: "분 분량",
  zh: "分钟阅读",
  nl: "min leestijd",
  pl: "min czytania",
  sv: "min läsning",
  hi: "मिनट पढ़ें",
};

/** Resolve the read-time label for a locale, falling back to English. */
export function readTimeLabel(locale: string): string {
  return READ_TIME_LABELS[locale] || READ_TIME_LABELS.en;
}
