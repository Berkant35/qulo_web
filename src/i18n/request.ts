import { getRequestConfig } from "next-intl/server";
import { notFound } from "next/navigation";
import { locales, type Locale } from "@/lib/i18n/config";

export default getRequestConfig(async ({ requestLocale }) => {
  const locale = await requestLocale;
  if (!locale || !locales.includes(locale as Locale)) notFound();

  const enMessages = (await import("@/lib/i18n/dictionaries/en.json")).default;
  const localeMessages = locale === "en"
    ? enMessages
    : (await import(`@/lib/i18n/dictionaries/${locale}.json`)).default;

  return {
    locale,
    messages: locale === "en" ? enMessages : { ...enMessages, ...localeMessages },
  };
});
