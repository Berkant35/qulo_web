import { locales } from "@/lib/i18n/config";
import { SITE_URL } from "@/lib/constants/metadata";

/**
 * The locale Google should show a visitor whose language matches none of the
 * sixteen we publish.
 *
 * English, matching the apex redirect: a browser that asked for none of our
 * languages is by definition not asking for Turkish either, and English is the
 * one most likely to be readable. These two have to agree — a `x-default`
 * pointing at Turkish while the apex sends the same visitor to English is a
 * contradiction in the signals we hand search engines.
 */
export const X_DEFAULT_LOCALE = "en";

/**
 * hreflang map for a page that exists in every locale.
 *
 * `pathAfterLocale` is everything after the locale segment, starting with a
 * slash, or an empty string for a locale home page:
 *
 *   alternateLanguages("/glossary/ghosting")  → /tr/glossary/ghosting, …
 *   alternateLanguages("")                    → /tr, /en, …
 *
 * This was copied by hand into thirty page modules before it lived here, which
 * is how the `x-default` in each of them came to disagree with the redirect at
 * the apex.
 */
export function alternateLanguages(pathAfterLocale: string): Record<string, string> {
  const languages: Record<string, string> = {};
  for (const locale of locales) {
    languages[locale] = `${SITE_URL}/${locale}${pathAfterLocale}`;
  }
  languages["x-default"] = `${SITE_URL}/${X_DEFAULT_LOCALE}${pathAfterLocale}`;
  return languages;
}
