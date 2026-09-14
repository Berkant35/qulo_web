"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import { useTranslations } from "next-intl";
import { isContentLocale, isContentRoute, locales } from "@/lib/i18n/config";

/** Strips the leading locale segment exactly; a 2-letter regex would mis-cut a future `pt-BR`. */
const LOCALE_PREFIX = new RegExp(`^/(?:${locales.join("|")})(?=/|$)`);

export function LanguageSwitcher() {
  const pathname = usePathname();
  const t = useTranslations("footer");

  // Extract current locale from pathname
  const currentLocale = locales.find((loc) => pathname.startsWith(`/${loc}`)) ?? "tr";

  function buildLocalePath(locale: string) {
    // Replace the leading locale segment
    const withoutLocale = pathname.replace(LOCALE_PREFIX, "") || "/";
    // Structured content is not translated into every UI language; send those
    // locales to their home page instead of a URL that was never generated.
    if (isContentRoute(withoutLocale) && !isContentLocale(locale)) return `/${locale}/`;
    return `/${locale}${withoutLocale}`;
  }

  return (
    <nav aria-label={t("language")} className="flex flex-wrap items-center gap-1">
      {locales.map((locale, i) => (
        <span key={locale} className="flex items-center gap-1">
          {i > 0 && (
            <span aria-hidden="true" className="text-white/20 text-xs select-none">|</span>
          )}
          <Link
            href={buildLocalePath(locale)}
            lang={locale}
            hrefLang={locale}
            aria-current={locale === currentLocale ? "true" : undefined}
            className={
              locale === currentLocale
                ? "text-xs font-semibold text-qulo-purple uppercase tracking-wider"
                : "text-xs font-medium text-qulo-text-secondary uppercase tracking-wider hover:text-white transition-colors"
            }
          >
            {locale.toUpperCase()}
          </Link>
        </span>
      ))}
    </nav>
  );
}
