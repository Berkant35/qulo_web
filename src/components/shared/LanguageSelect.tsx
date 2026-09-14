"use client";

import type { ChangeEvent } from "react";
import { usePathname, useRouter } from "next/navigation";
import { useTranslations } from "next-intl";
import { isLocale, locales, localeFromPathname, switchLocalePath } from "@/lib/i18n/config";

/**
 * Mobile counterpart of LanguageSwitcher. Eighteen inline links do not fit a
 * 375px header next to the logo and the download button, and the legal, help
 * and feature pages have no footer to fall back on — without this, a phone had
 * no way to change language there. A native select is one tap and uses the
 * platform picker.
 */
export function LanguageSelect() {
  const pathname = usePathname();
  const router = useRouter();
  const t = useTranslations("footer");
  const currentLocale = localeFromPathname(pathname);

  function onChange(event: ChangeEvent<HTMLSelectElement>) {
    const target = event.target.value;
    if (isLocale(target) && target !== currentLocale) {
      router.push(switchLocalePath(pathname, target));
    }
  }

  return (
    <select
      aria-label={t("language")}
      value={currentLocale}
      onChange={onChange}
      className="bg-transparent text-xs font-semibold uppercase tracking-wider text-qulo-purple border border-white/10 rounded-md px-2 py-1"
    >
      {locales.map((locale) => (
        <option key={locale} value={locale} lang={locale} className="bg-qulo-bg text-white">
          {locale.toUpperCase()}
        </option>
      ))}
    </select>
  );
}
