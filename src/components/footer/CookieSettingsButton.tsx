"use client";

import { useTranslations } from "next-intl";
import { cn } from "@/lib/utils/cn";
import { GA_MEASUREMENT_ID, OPEN_CONSENT_EVENT } from "@/lib/analytics/ga";

interface CookieSettingsButtonProps {
  className?: string;
}

/**
 * Reopens the analytics consent banner. Withdrawing consent has to be as easy
 * as giving it, so this sits in the footer and in the privacy policy's cookie
 * section. Renders nothing until analytics is configured.
 */
export function CookieSettingsButton({ className }: CookieSettingsButtonProps) {
  const t = useTranslations("footer");
  if (!GA_MEASUREMENT_ID) return null;

  return (
    <button
      type="button"
      onClick={() => window.dispatchEvent(new Event(OPEN_CONSENT_EVENT))}
      className={cn("text-xs text-qulo-text-secondary hover:text-white transition-colors", className)}
    >
      {t("cookieSettings")}
    </button>
  );
}
