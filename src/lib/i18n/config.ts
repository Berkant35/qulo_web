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

export const isLocale = (value: string): value is Locale =>
  (locales as readonly string[]).includes(value);

/** Leading locale segment, matched exactly: `/th/about` → th; `/thai/…` is not Thai. */
const LOCALE_PREFIX = new RegExp(`^/(${locales.join("|")})(?=/|$)`);

export function localeFromPathname(pathname: string): Locale {
  const code = LOCALE_PREFIX.exec(pathname)?.[1];
  return code !== undefined && isLocale(code) ? code : defaultLocale;
}

/**
 * The same page in another locale (language switcher). Structured content is
 * not translated into every UI language; from those pages a UI-only locale goes
 * to its home instead of a URL that was never generated. The home form carries
 * the trailing slash the site is exported with.
 */
export function switchLocalePath(pathname: string, target: Locale): string {
  const pathAfterLocale = pathname.replace(LOCALE_PREFIX, "") || "/";
  if (isContentRoute(pathAfterLocale) && !isContentLocale(target)) return `/${target}/`;
  return `/${target}${pathAfterLocale}`;
}
