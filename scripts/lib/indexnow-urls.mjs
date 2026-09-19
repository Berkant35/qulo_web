/**
 * Changed files → the URLs they actually render as.
 *
 * Pulled out of `indexnow.mjs` so it can be tested: the script itself parses
 * argv and talks to the network on import, and this mapping is where the
 * mistakes live. Two of them have already happened —
 *
 *  1. `_content/index.ts` is a barrel file, not a page; it used to map to
 *     `/glossary/index/`, which 301s.
 *  2. Structured content exists only in `contentLocales`; mapping it across all
 *     18 locales submitted `/th/dating-statistics/` and `/id/dating-statistics/`,
 *     both 404 (found 2026-09-19).
 *
 * — and both share one shape: telling Bing a URL changed when the URL does not
 * exist. While the site is fighting a discovery problem that is not a harmless
 * extra; it is noise in the one channel we are trying to use.
 */
import { locales, contentLocales, contentRoutePrefixes } from "./locales.mjs";

/** Mirrors `isContentRoute` in src/lib/i18n/config.ts. */
export function isContentRoute(pathAfterLocale) {
  return contentRoutePrefixes.some(
    (p) => pathAfterLocale === p || pathAfterLocale === `${p}/` || pathAfterLocale.startsWith(`${p}/`),
  );
}

/** Repo-relative changed files → distinct locale-less page paths. */
export function pathsForChangedFiles(files) {
  const paths = new Set();
  for (const f of files) {
    if (f.endsWith("/index.ts")) continue; // barrel file, not a page
    let m;
    if ((m = f.match(/glossary\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/glossary/${m[1]}/`);
    else if ((m = f.match(/answers\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/answers/${m[1]}/`);
    else if ((m = f.match(/blog\/\[slug\]\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/blog/${m[1]}/`);
    else if ((m = f.match(/advice\/\[slug\]\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/advice/${m[1]}/`);
    else if ((m = f.match(/\[locale\]\/([a-z0-9-]+)\/page\.tsx$/))) paths.add(`/${m[1]}/`);
  }
  return [...paths];
}

/** Page paths → absolute URLs, in the locales each path is actually built for. */
export function urlsForPaths(paths, origin) {
  return paths.flatMap((p) =>
    (isContentRoute(p) ? contentLocales : locales).map((l) => `${origin}/${l}${p}`),
  );
}
