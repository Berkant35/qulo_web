/**
 * `/go/app` — sends a visitor to the right app store, server side.
 *
 * WHY THIS EXISTS: the download button in the header is the only store link
 * above the fold, and picking the store in the browser left it pointing at the
 * App Store for Android users until hydration finished — measured at several
 * seconds on an emulated mobile connection. Anyone who tapped in that window
 * landed on a page they could not install from. Reading the User-Agent here
 * removes the race entirely, and also works with JavaScript disabled.
 *
 * Attribution rides along: `?c=<campaign>` becomes the Play `referrer`, so
 * installs stay separable per section of the site in Play Console.
 *
 * FAIL-SAFE: any unexpected input falls through to the App Store URL, which is
 * exactly what the button did before this function existed. A bad campaign
 * string can never produce a broken destination — it is validated, not trusted.
 */
const APP_STORE = "https://apps.apple.com/app/qulo/id1626734572";
const PLAY_STORE =
  "https://play.google.com/store/apps/details?id=com.wordpress.calikusuberkant.qulo";

/** Campaign labels are ours, but the query string is not — validate, don't trust. */
const CAMPAIGN = /^[a-z0-9-]{1,40}$/;

export default (request: Request): Response => {
  const url = new URL(request.url);
  const raw = url.searchParams.get("c") || "";
  const campaign = CAMPAIGN.test(raw) ? raw : "web-unknown";

  const ua = request.headers.get("user-agent") || "";
  const isAndroid = /android/i.test(ua) && !/windows phone/i.test(ua);

  let target = APP_STORE;
  if (isAndroid) {
    const referrer = new URLSearchParams({
      utm_source: "quloapp.com",
      utm_medium: "web",
      utm_campaign: campaign,
    });
    target = `${PLAY_STORE}&referrer=${encodeURIComponent(referrer.toString())}`;
  }

  return Response.redirect(target, 302);
};

export const config = { path: "/go/app" };
