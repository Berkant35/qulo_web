export const locales = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = "tr";
export const rtlLocales: readonly string[] = ["ar"];
