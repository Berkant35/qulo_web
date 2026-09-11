"use client";

import { useEffect, useRef, useState } from "react";
import { usePathname } from "next/navigation";
import {
  CONSENT_STORAGE_KEY,
  GA_MEASUREMENT_ID,
  OPEN_CONSENT_EVENT,
  enableGoogleAnalytics,
  pauseGoogleAnalytics,
  readConsent,
  revokeGoogleAnalytics,
  saveConsent,
  trackStoreClick,
  type ConsentChoice,
} from "@/lib/analytics/ga";
import { isSensitivePath } from "@/lib/analytics/sensitive-paths";
import { ConsentBanner } from "./ConsentBanner";

type BannerState = "closed" | "first-visit" | "reopened";

/**
 * Consent gate for Google Analytics. Nothing is loaded before the visitor
 * chooses, and nothing renders at all until a measurement ID is configured.
 */
export function Analytics() {
  const pathname = usePathname();
  const [choice, setChoice] = useState<ConsentChoice | null>(null);
  const [banner, setBanner] = useState<BannerState>("closed");
  const returnFocusTo = useRef<HTMLElement | null>(null);

  useEffect(() => {
    if (!GA_MEASUREMENT_ID) return;
    const stored = readConsent();
    setChoice(stored);
    if (stored === null) setBanner("first-visit");

    // Reopened on purpose from "Cookie settings": focus moves into the banner and
    // goes back to the button afterwards. A first-visit banner never steals focus.
    const reopen = () => {
      returnFocusTo.current = document.activeElement instanceof HTMLElement ? document.activeElement : null;
      setBanner("reopened");
    };
    // A withdrawal in another tab has to stop this tab too, not only the next page load.
    const onStorage = (event: StorageEvent) => {
      if (event.key !== CONSENT_STORAGE_KEY) return;
      const next = readConsent();
      setChoice(next);
      if (next !== "granted") revokeGoogleAnalytics(GA_MEASUREMENT_ID);
    };
    window.addEventListener(OPEN_CONSENT_EVENT, reopen);
    window.addEventListener("storage", onStorage);
    return () => {
      window.removeEventListener(OPEN_CONSENT_EVENT, reopen);
      window.removeEventListener("storage", onStorage);
    };
  }, []);

  useEffect(() => {
    if (!GA_MEASUREMENT_ID || choice !== "granted") return;
    // Pages whose URL carries a reset token or an invite code never reach GA —
    // not even when consent is given on that very page.
    if (isSensitivePath(pathname)) pauseGoogleAnalytics(GA_MEASUREMENT_ID);
    else enableGoogleAnalytics(GA_MEASUREMENT_ID);
  }, [choice, pathname]);

  useEffect(() => {
    if (choice !== "granted") return;
    // One delegated listener instead of touching the nine components that render
    // store buttons. Capture phase: it runs before the browser navigates away.
    const onClick = (event: MouseEvent) => {
      if (!(event.target instanceof Element)) return;
      const anchor = event.target.closest("a[href]");
      if (anchor) trackStoreClick(anchor.getAttribute("href") ?? "");
    };
    document.addEventListener("click", onClick, true);
    return () => document.removeEventListener("click", onClick, true);
  }, [choice]);

  function decide(next: ConsentChoice) {
    saveConsent(next);
    setChoice(next);
    setBanner("closed");
    if (next === "denied") revokeGoogleAnalytics(GA_MEASUREMENT_ID);
    returnFocusTo.current?.focus();
    returnFocusTo.current = null;
  }

  if (!GA_MEASUREMENT_ID || banner === "closed") return null;

  return (
    <ConsentBanner
      autoFocus={banner === "reopened"}
      onAccept={() => decide("granted")}
      onDecline={() => decide("denied")}
    />
  );
}
