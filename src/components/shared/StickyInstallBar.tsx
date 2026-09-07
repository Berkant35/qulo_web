"use client";

import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";
import { STORE_REDIRECT } from "@/lib/constants/links";

const DISMISS_KEY = "qulo_sticky_dismissed_at";
const DISMISS_DAYS = 7;
const SHOW_AFTER_PX = 400;
/** Pages that already are a single install/share call to action. */
const EXCLUDED = /^\/[a-z]{2}\/(q|invite|reset-password)(\/|$)/;

/**
 * Mobile-only install bar for content pages. The glossary/blog/answers pages are the
 * bulk of the site's search traffic and their store buttons sit at the bottom of long
 * articles; this keeps one install action within thumb reach once the visitor has
 * scrolled far enough to be reading. Dismissal is remembered for a week per browser.
 */
export function StickyInstallBar() {
  const t = useTranslations("stickyBar");
  const pathname = usePathname();
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (EXCLUDED.test(pathname)) return;
    try {
      const at = Number(localStorage.getItem(DISMISS_KEY) ?? 0);
      if (at && Date.now() - at < DISMISS_DAYS * 86_400_000) return;
    } catch {
      // storage blocked — just show it
    }
    const onScroll = () => setVisible(window.scrollY > SHOW_AFTER_PX);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, [pathname]);

  function dismiss() {
    setVisible(false);
    try {
      localStorage.setItem(DISMISS_KEY, String(Date.now()));
    } catch {
      // ignore
    }
  }

  if (!visible) return null;

  return (
    <div className="fixed inset-x-0 bottom-0 z-40 md:hidden border-t border-white/10 bg-qulo-bg/95 px-4 py-3 backdrop-blur">
      <div className="flex items-center gap-3">
        <p className="flex-1 text-sm font-medium text-white">{t("title")}</p>
        <a
          href={STORE_REDIRECT("web-sticky")}
          className="rounded-lg bg-gradient-to-r from-qulo-purple to-qulo-purple-dark px-4 py-2 text-sm font-semibold text-white"
        >
          {t("cta")}
        </a>
        <button type="button" onClick={dismiss} aria-label={t("close")} className="p-1 text-qulo-text-muted">
          ✕
        </button>
      </div>
    </div>
  );
}
