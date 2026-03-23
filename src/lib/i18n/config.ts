export const locales = [
  "en", "tr", "de", "fr", "es", "ar", "ru", "pt",
  "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = "en";
export const rtlLocales: readonly string[] = ["ar"];
