/**
 * Internal link checker for the exported site.
 *
 * Runs over `out/` after a build and asserts that every site-internal href
 * resolves to a page or a file that actually shipped. This exists because a
 * dead link was found by reading one page by hand — `/press-kit.zip`, sitting
 * behind two call-to-action buttons and returning 404 in production — and
 * because 268 of the internal links on this site are now generated at render
 * time rather than typed, so a mistake in the generator would multiply across
 * sixteen locales before anyone noticed.
 *
 * Run: `npm run verify:links` (requires a build first)
 */
import { readdirSync, readFileSync, statSync, existsSync } from "node:fs";
import { join } from "node:path";

const OUT = "out";

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
console.log(`PASS — every internal link on ${pages.length} pages resolves`);
