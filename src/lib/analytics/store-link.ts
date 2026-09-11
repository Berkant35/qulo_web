/**
 * Maps a clicked link to an app-store destination for the `store_click` event.
 *
 * Kept free of DOM and framework imports so plain Node can unit test it
 * (`npm test`). Recognises the three ways the site sends people to a store:
 * direct App Store / Google Play links built by `storeLinks()`, and the edge
 * redirect `/go/app?c=<campaign>` that picks the store from the User-Agent.
 */
export type StoreTarget = "ios" | "android" | "auto";

export interface StoreClick {
  store: StoreTarget;
  /** Site area that rendered the button (its attribution campaign), or "unknown". */
  campaign: string;
}

export function storeClickFromHref(href: string, origin: string): StoreClick | null {
  let url: URL;
  try {
    url = new URL(href, origin);
  } catch {
    return null;
  }

  if (url.hostname === "apps.apple.com") {
    // `ct` is only present once the App Store provider token is configured.
    return { store: "ios", campaign: url.searchParams.get("ct") || "unknown" };
  }
  if (url.hostname === "play.google.com") {
    const referrer = new URLSearchParams(url.searchParams.get("referrer") ?? "");
    return { store: "android", campaign: referrer.get("utm_campaign") || "unknown" };
  }
  const sameOrigin = url.origin === new URL(origin).origin;
  if (sameOrigin && url.pathname.replace(/\/$/, "") === "/go/app") {
    return { store: "auto", campaign: url.searchParams.get("c") || "unknown" };
  }
  return null;
}
