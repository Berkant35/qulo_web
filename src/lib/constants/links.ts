export const APP_STORE_URL = "https://apps.apple.com/app/qulo/id1626734572";
export const PLAY_STORE_URL = "https://play.google.com/store/apps/details?id=com.wordpress.calikusuberkant.qulo";

/**
 * App Store Connect provider ID, needed for install attribution.
 *
 * Apple does NOT attribute a campaign token (`ct`) unless the provider token
 * (`pt`) is present too — a `ct`-only link is simply ignored, so the campaign
 * never appears under App Analytics → Sources → Campaigns. The ID lives in
 * App Store Connect under Users and Access.
 *
 * Until it is filled in, iOS installs from the site stay unattributable while
 * Android ones are already tracked. Set it and iOS starts reporting with no
 * other change.
 */
const APPLE_PROVIDER_TOKEN = process.env.NEXT_PUBLIC_APPLE_PROVIDER_TOKEN || "";

/**
 * Store links carrying install attribution for one part of the site.
 *
 * WHY: the store links were bare, so nothing distinguished an install that came
 * from quloapp.com from any other install — which made "does the site convert
 * to downloads?" unanswerable in both consoles. Google Play reads the
 * `referrer` parameter and reports it under Acquisition; Apple reads `pt`/`ct`
 * and reports it under App Analytics.
 *
 * `campaign` should stay under 40 characters (Apple's limit) and describe the
 * part of the site, not the page — per-page campaigns would fragment the
 * report into noise.
 */
export function storeLinks(
  campaign: string,
  content?: string,
): { ios: string; android: string } {
  const params: Record<string, string> = {
    utm_source: "quloapp.com",
    utm_medium: "web",
    utm_campaign: campaign,
  };
  // `content` rides in `utm_content` — used by the invite landing to carry the
  // referral code into the Play referrer, where the app can read it back via
  // the Install Referrer API and Play Console breaks installs down by it.
  if (content) params.utm_content = content;
  const referrer = new URLSearchParams(params).toString();

  const apple = new URL(APP_STORE_URL);
  if (APPLE_PROVIDER_TOKEN) {
    apple.searchParams.set("pt", APPLE_PROVIDER_TOKEN);
    apple.searchParams.set("ct", campaign.slice(0, 40));
    apple.searchParams.set("mt", "8");
  }

  return {
    ios: apple.toString(),
    android: `${PLAY_STORE_URL}&referrer=${encodeURIComponent(referrer)}`,
  };
}

export const SOCIAL = {
  instagram: "https://instagram.com/quloapp",
  tiktok: "https://tiktok.com/@quloapp",
} as const;

/**
 * Edge-resolved store link: `/go/app?c=<campaign>` reads the visitor's
 * User-Agent server side and redirects to the right store, carrying the
 * campaign into the Play referrer.
 *
 * Prefer this wherever a single button must be correct on first paint. Where
 * both stores are shown side by side, `storeLinks()` is still right — there is
 * nothing to guess.
 */
export function STORE_REDIRECT(campaign: string, code?: string): string {
  const qs = new URLSearchParams({ c: campaign });
  if (code) qs.set("code", code);
  return `/go/app?${qs.toString()}`;
}
