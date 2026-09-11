import { storeClickFromHref } from "./store-link";

/**
 * Google Analytics 4 for quloapp.com — loaded ONLY after the visitor consents.
 *
 * Why no script until consent: Turkey's KVKK cookie guidance and the GDPR both
 * require prior consent for analytics cookies. The simplest compliant setup is
 * "basic" consent mode: gtag.js is not even requested until the visitor clicks
 * Allow, so declining leaves no Google request and no cookie behind.
 *
 * Advertising signals stay denied even after consent — the site runs no ads and
 * the banner only asks for analytics.
 */

/**
 * Public by design: the measurement ID is visible in every GA-enabled page.
 * Empty means analytics is off — no banner, no script (previews, forks).
 */
export const GA_MEASUREMENT_ID = process.env.NEXT_PUBLIC_GA_MEASUREMENT_ID ?? "";

/** localStorage key holding the visitor's choice — also watched across tabs. */
export const CONSENT_STORAGE_KEY = "qulo_analytics_consent";

/** Window event the "Cookie settings" buttons dispatch to reopen the banner. */
export const OPEN_CONSENT_EVENT = "qulo:open-consent";

export type ConsentChoice = "granted" | "denied";

type Gtag = (...args: unknown[]) => void;

declare global {
  interface Window {
    dataLayer?: unknown[];
    gtag?: Gtag;
    /** gtag's per-property kill switch, checked before every single hit. */
    [flag: `ga-disable-${string}`]: boolean | undefined;
  }
}

export function readConsent(): ConsentChoice | null {
  try {
    const value = localStorage.getItem(CONSENT_STORAGE_KEY);
    return value === "granted" || value === "denied" ? value : null;
  } catch {
    return null; // storage blocked — the banner simply asks again next visit
  }
}

export function saveConsent(choice: ConsentChoice): void {
  try {
    localStorage.setItem(CONSENT_STORAGE_KEY, choice);
  } catch {
    // storage blocked — the choice still applies to this page view
  }
}

let loaded = false;
/** Mirrors the `ga-disable-<id>` flag. */
let paused = false;

function setPaused(id: string, value: boolean): void {
  paused = value;
  window[`ga-disable-${id}`] = value;
}

/** Loads gtag.js on the first call; later calls resume a paused or revoked tracker. */
export function enableGoogleAnalytics(id: string): void {
  if (!id || (loaded && !paused)) return;
  setPaused(id, false);
  if (loaded) {
    window.gtag?.("consent", "update", { analytics_storage: "granted" });
    return;
  }
  loaded = true;

  window.dataLayer = window.dataLayer || [];
  // gtag.js reads `arguments` objects from dataLayer, not arrays — keep the
  // official snippet's shape.
  window.gtag = function gtag() {
    // eslint-disable-next-line prefer-rest-params
    window.dataLayer?.push(arguments);
  };
  window.gtag("consent", "default", {
    analytics_storage: "granted",
    ad_storage: "denied",
    ad_user_data: "denied",
    ad_personalization: "denied",
  });
  window.gtag("js", new Date());
  window.gtag("config", id, {
    allow_google_signals: false,
    allow_ad_personalization_signals: false,
  });

  const script = document.createElement("script");
  script.async = true;
  script.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(id)}`;
  document.head.appendChild(script);
}

/**
 * Stops sending without touching consent — for pages whose URL carries a secret
 * (see sensitive-paths.ts). The flag is checked per hit, so it also drops the
 * page_view GA sends on its own after a client-side navigation.
 */
export function pauseGoogleAnalytics(id: string): void {
  if (id && loaded && !paused) setPaused(id, true);
}

/**
 * Withdrawal must be as effective as consent: stop sending from this page and
 * remove the cookies GA already set. The next page view no longer loads gtag.js.
 */
export function revokeGoogleAnalytics(id: string): void {
  if (!id) return;
  setPaused(id, true);
  window.gtag?.("consent", "update", { analytics_storage: "denied" });

  const names = document.cookie.split(";").map((cookie) => cookie.split("=")[0].trim());
  const domain = location.hostname.replace(/^www\./, "");
  for (const name of names) {
    if (!name.startsWith("_ga")) continue;
    // GA writes on the registrable domain (.quloapp.com); clear both forms.
    document.cookie = `${name}=; Max-Age=0; path=/`;
    document.cookie = `${name}=; Max-Age=0; path=/; domain=.${domain}`;
  }
}

/** `store_click` — the site's real conversion: which page sends people to a store. */
export function trackStoreClick(href: string): void {
  if (!window.gtag) return;
  const click = storeClickFromHref(href, location.origin);
  if (click) window.gtag("event", "store_click", click);
}
