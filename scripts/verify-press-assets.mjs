/**
 * Guard: every file the press page offers for download must exist.
 *
 * The page used to advertise `/press-kit.zip` behind two call-to-action
 * buttons, listing screenshots, a fact-sheet PDF and a founder photo as its
 * contents. The ZIP was never generated — the link returned 404 in production —
 * and three of the four promised items did not exist anywhere in the repo. A
 * press page is the one page whose broken link is guaranteed to be found by
 * someone deciding whether to write about you.
 *
 * Run: `npm run verify:press`
 */
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

const PAGE = "src/app/[locale]/press/page.tsx";
const PUBLIC_DIR = "public";

const src = readFileSync(PAGE, "utf8");

/**
 * Local asset paths referenced by the page, whatever section or key they sit
 * in — the download list uses `href`, the logo gallery uses `src`, and the
 * Organization JSON-LD uses an absolute `logo` URL.
 */
const referenced = [
  ...src.matchAll(/(?:href|src):\s*"(\/[^"]+\.[a-z0-9]{2,4})"/g),
  ...src.matchAll(/(?:href|src)="(\/[^"]+\.[a-z0-9]{2,4})"/g),
  ...src.matchAll(/\$\{SITE_URL\}(\/[^"`]+\.[a-z0-9]{2,4})/g),
].map((match) => match[1]);

const unique = [...new Set(referenced)];
const missing = unique.filter((href) => !existsSync(join(PUBLIC_DIR, href)));

if (missing.length) {
  console.error(`FAIL — the press page links ${missing.length} file(s) that do not exist:`);
  for (const href of missing) console.error(`  - ${href} (expected at ${join(PUBLIC_DIR, href)})`);
  console.error("\nShip the file or stop advertising it.");
  process.exit(1);
}
console.log(`PASS — all ${unique.length} press downloads exist in ${PUBLIC_DIR}/`);
