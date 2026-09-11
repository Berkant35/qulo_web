"use client";

import { useEffect, useRef } from "react";
import Link from "next/link";
import { useLocale, useTranslations } from "next-intl";

interface ConsentBannerProps {
  /** Move focus in — only when the visitor opened the banner on purpose. */
  autoFocus: boolean;
  onAccept: () => void;
  onDecline: () => void;
}

/**
 * Analytics consent. Both choices carry the same visual weight on purpose: a
 * dominant or pre-selected "Allow" is exactly what KVKK and GDPR guidance call
 * a dark pattern, and consent obtained that way is not valid consent.
 *
 * `sticky`, not `fixed`: as the last element of <body> it stays pinned to the
 * viewport while the page scrolls, yet at the very end of the page it settles
 * below the footer instead of covering its last links (WCAG 2.4.11). A named
 * <section> is a landmark screen readers can jump to; `role="dialog"` would
 * promise modal behaviour the banner deliberately does not have.
 */
export function ConsentBanner({ autoFocus, onAccept, onDecline }: ConsentBannerProps) {
  const t = useTranslations("consent");
  const locale = useLocale();
  const firstButton = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (autoFocus) firstButton.current?.focus();
  }, [autoFocus]);

  const buttonClass =
    "flex-1 rounded-lg border border-white/20 px-4 py-2 text-sm font-semibold text-white transition-colors hover:bg-white/10 sm:flex-none";

  return (
    <section
      aria-labelledby="consent-title"
      className="sticky bottom-0 z-50 border-t border-white/10 bg-qulo-bg/95 px-4 py-4 backdrop-blur"
    >
      <div className="mx-auto flex max-w-4xl flex-col gap-3 sm:flex-row sm:items-center">
        <div className="flex-1">
          <p id="consent-title" className="text-sm font-semibold text-white">
            {t("title")}
          </p>
          <p className="mt-1 text-xs leading-relaxed text-qulo-text-secondary">
            {t("body")}{" "}
            <Link href={`/${locale}/privacy-policy`} className="underline hover:text-white">
              {t("policy")}
            </Link>
          </p>
        </div>
        <div className="flex gap-2">
          <button ref={firstButton} type="button" onClick={onDecline} className={buttonClass}>
            {t("reject")}
          </button>
          <button type="button" onClick={onAccept} className={buttonClass}>
            {t("accept")}
          </button>
        </div>
      </div>
    </section>
  );
}
