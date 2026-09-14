"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import { useTranslations } from "next-intl";
import { locales, localeFromPathname, switchLocalePath } from "@/lib/i18n/config";

interface LanguageSwitcherProps {
  /**
   * The header owns the one `<nav aria-label="Language">` landmark. The footer
   * copy passes `false` and renders a labelled group instead — two landmarks
   * with the same name are announced twice by screen readers.
   */
  landmark?: boolean;
}

export function LanguageSwitcher({ landmark = true }: LanguageSwitcherProps) {
  const pathname = usePathname();
  const t = useTranslations("footer");
  const currentLocale = localeFromPathname(pathname);
  const Wrapper = landmark ? "nav" : "div";

  return (
    <Wrapper
      aria-label={t("language")}
      role={landmark ? undefined : "group"}
      className="flex flex-wrap items-center gap-1"
    >
      {locales.map((locale, i) => (
        <span key={locale} className="flex items-center gap-1">
          {i > 0 && (
            <span aria-hidden="true" className="text-white/20 text-xs select-none">|</span>
          )}
          <Link
            href={switchLocalePath(pathname, locale)}
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
    </Wrapper>
  );
}
