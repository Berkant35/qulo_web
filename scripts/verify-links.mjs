/**
 * Internal link checker for the exported site.
 *
 * Runs over `out/` after a build and asserts that every site-internal href
 * resolves to a page or a file that actually shipped. This exists because a
 * dead link was found by reading one page by hand — `/press-kit.zip`, sitting
 * behind two call-to-action buttons and returning 404 in production — and
 * because 268 of the internal links on this site are now generated at render
 * time rather than typed, so a mistake in the generator would multiply across
 * eighteen locales before anyone noticed.
 *
 * A guard that passes on nothing is worse than no guard: a build once died
 * while replacing `out/` (ENOTEMPTY), left it half-empty, and this script
 * printed "every internal link on 0 pages resolves". So before scanning it
 * asserts the floor — every locale's home page shipped.
 *
 * Run: `npm run verify:links` (requires a build first)
 */
import { readdirSync, readFileSync, statSync, existsSync } from "node:fs";
import { join } from "node:path";
import { locales } from "./lib/locales.mjs";

const OUT = process.env.VERIFY_LINKS_OUT ?? "out";

if (!existsSync(OUT)) {
  console.error(`FAIL — ${OUT}/ does not exist. Run \`npm run build\` first.`);
  process.exit(1);
}

/** Every path the export can actually serve. */
const served = new Set();
/** Every HTML page, so we know what to scan. */
const pages = [];

function collect(dir, prefix) {
  for (const name of readdirSync(dir)) {
    const path = join(dir, name);
    const urlPath = `${prefix}/${name}`;
    if (statSync(path).isDirectory()) {
      collect(path, urlPath);
      continue;
    }
    served.add(urlPath);
    if (name === "index.html") {
      // `trailingSlash: true`, so a directory is served with and without it.
      served.add(prefix === "" ? "/" : `${prefix}/`);
      served.add(prefix === "" ? "/" : prefix);
      pages.push({ file: path, url: prefix === "" ? "/" : `${prefix}/` });
    }
  }
}

collect(OUT, "");

const missingHomes = locales.filter((locale) => !pages.some((page) => page.url === `/${locale}/`));
if (missingHomes.length) {
  console.error(
    `FAIL — ${OUT}/ is not a complete export: no home page for ${missingHomes.join(", ")} ` +
      `(${pages.length} pages found). Run \`npm run build\` again.`,
  );
  process.exit(1);
}

/**
 * Paths served by Netlify rather than by a file in `out/` — edge functions and
 * redirect rules. Read from netlify.toml so this list cannot drift from the
 * config: a route that stops being declared there starts failing here, which
 * is the behaviour we want.
 */
const netlifyConfig = existsSync("netlify.toml") ? readFileSync("netlify.toml", "utf8") : "";
for (const match of netlifyConfig.matchAll(/^\s*(?:path|from)\s*=\s*"([^"]+)"/gm)) {
  const route = match[1];
  if (!route.includes("*") && !route.includes(":")) served.add(route);
}

/** Site-internal targets only: no protocol, no protocol-relative, no fragment. */
function internalTargets(html) {
  return [...html.matchAll(/(?:href|src)="(\/[^"#]*)"/g)]
    .map((match) => match[1])
    .filter((href) => !href.startsWith("//") && !href.startsWith("/_next/"));
}

const broken = new Map();

for (const page of pages) {
  const html = readFileSync(page.file, "utf8");
  for (const target of new Set(internalTargets(html))) {
    const [path] = target.split("?");
    if (served.has(path) || served.has(path.replace(/\/$/, ""))) continue;
    if (!broken.has(path)) broken.set(path, new Set());
    broken.get(path).add(page.url);
  }
}

/**
 * A sitemap URL may not be noindexed.
 *
 * The sitemap asks Google to index a URL; `robots: noindex` on the page tells
 * it not to. Google spends discovery on the URL and then drops it, and on
 * 2026-09-25 this site had 1,224 URLs in "Discovered - currently not indexed"
 * against 229 indexed — discovery budget is the scarce resource, so a URL that
 * contradicts itself is not a harmless inconsistency. 34 such URLs
 * (`/sitemap-html`, `/q/play`) were in the sitemap until that day; the
 * exclusion lives in `next-sitemap.config.js` and this keeps it there.
 */
const sitemapFiles = readdirSync(OUT).filter((f) => /^sitemap-\d+\.xml$/.test(f));
if (sitemapFiles.length === 0) {
  console.error(`FAIL — ${OUT}/ icinde sitemap-N.xml yok; derleme yarim.`);
  process.exit(1);
}
const sitemapPaths = sitemapFiles.flatMap((f) =>
  [...readFileSync(join(OUT, f), "utf8").matchAll(/<loc>([^<]+)<\/loc>/g)].map(([, loc]) =>
    loc.replace(/^https?:\/\/[^/]+/, ""),
  ),
);
if (sitemapPaths.length === 0) {
  console.error("FAIL — site haritasinda hic URL yok; bu guard hicbir sey dogrulamaz.");
  process.exit(1);
}
const noindexed = sitemapPaths.filter((path) => {
  const file = join(OUT, path.replace(/^\//, ""), "index.html");
  return existsSync(file) && /<meta name="robots"[^>]*content="[^"]*noindex/.test(readFileSync(file, "utf8"));
});
if (noindexed.length > 0) {
  console.error(
    `FAIL — ${noindexed.length} site haritasi URL'si noindex (sitemap "dizine ekle" derken sayfa "ekleme" diyor):\n` +
      noindexed.slice(0, 5).map((p) => `  - ${p}`).join("\n"),
  );
  process.exit(1);
}

if (broken.size) {
  console.error(`FAIL — ${broken.size} internal target(s) do not exist in ${OUT}/:`);
  for (const [target, sources] of [...broken].sort()) {
    const list = [...sources];
    const shown = list.slice(0, 3).join(", ");
    const more = list.length > 3 ? ` (+${list.length - 3} more pages)` : "";
    console.error(`  - ${target}\n      linked from: ${shown}${more}`);
  }
  process.exit(1);
}
console.log(
  `PASS — every internal link on ${pages.length} pages resolves, ` +
    `${sitemapPaths.length} site haritasi URL'sinin hicbiri noindex degil`,
);
