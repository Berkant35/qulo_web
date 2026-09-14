/**
 * Sitenin arayuz + yasal sayfa dilleri (sozluk JSON'lari): 18.
 * `contentLocales`: blog, sozluk (glossary), advice, answers, how-to gibi yapili icerik
 * yalnizca bu 16 dilde yazildi; th/id icin o sayfalar uretilmez (404 ve bozuk hreflang
 * yerine dil secici ana sayfaya goturur). Icerik cevrildikce buraya ekle.
 */
export const locales = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
  "th", "id",
] as const;
export type Locale = (typeof locales)[number];
export const defaultLocale: Locale = "tr";
export const rtlLocales: readonly string[] = ["ar"];

export const contentLocales = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
] as const;
export type ContentLocale = (typeof contentLocales)[number];
export const isContentLocale = (locale: string): locale is ContentLocale =>
  (contentLocales as readonly string[]).includes(locale);

/** Routes whose pages exist only in `contentLocales`. */
export const CONTENT_ROUTE_PREFIXES = [
  "/blog", "/glossary", "/advice", "/answers", "/features", "/how-to", "/questions",
  "/dating", "/country", "/dating-statistics", "/trends", "/press", "/sitemap-html",
] as const;

export function isContentRoute(pathAfterLocale: string): boolean {
  return CONTENT_ROUTE_PREFIXES.some(
    (p) => pathAfterLocale === p || pathAfterLocale.startsWith(`${p}/`),
  );
}

/**
 * Build a localized href. Structured content (blog, glossary, …) exists only in
 * `contentLocales`; from th/id (or any future UI-only locale) those links point at
 * the English version — the page `x-default` names — instead of a 404. Every
 * other path keeps the visitor's locale.
 */
export function contentPath(locale: string, pathAfterLocale: string): string {
  const target = isContentRoute(pathAfterLocale) && !isContentLocale(locale) ? "en" : locale;
  return `/${target}${pathAfterLocale}`;
}
