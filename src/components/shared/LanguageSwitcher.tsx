"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import { isContentLocale, isContentRoute, locales } from "@/lib/i18n/config";

export function LanguageSwitcher() {
  const pathname = usePathname();

  // Extract current locale from pathname
  const currentLocale = locales.find((loc) => pathname.startsWith(`/${loc}`)) ?? "tr";

  function buildLocalePath(locale: string) {
    // Replace the leading locale segment
    const withoutLocale = pathname.replace(/^\/[a-z]{2}/, "") || "/";
    // Structured content is not translated into every UI language; send those
    // locales to their home page instead of a URL that was never generated.
    if (isContentRoute(withoutLocale) && !isContentLocale(locale)) return `/${locale}/`;
    return `/${locale}${withoutLocale}`;
  }

  return (
    <div className="flex items-center gap-1">
      {locales.map((locale, i) => (
        <span key={locale} className="flex items-center gap-1">
          {i > 0 && (
            <span className="text-white/20 text-xs select-none">|</span>
          )}
          <Link
            href={buildLocalePath(locale)}
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
    </div>
  );
}
