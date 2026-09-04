/**
 * Brand guard: Qulo is the only dating app that may be named on this site.
 *
 * This exists because the rule was broken once at scale — competitor research
 * was cited by name across seven files and sixteen locales before anyone
 * noticed. The rule holds even in neutral or positive context, and even when
 * citing a competitor's own published research: describe them generically as
 * "dating apps" or "swipe-based apps" instead.
 *
 * See the note on BANNED below for the three patterns that are deliberately
 * narrower than the plain name, and why.
 *
 * Run: `npm run verify:brand`
 */
import { readdirSync, readFileSync, statSync } from "node:fs";
import { join, extname } from "node:path";

const ROOTS = ["src", "public"];
const EXTENSIONS = new Set([".ts", ".tsx", ".json", ".md", ".txt", ".xml"]);
const SKIP_FILES = new Set(["verify-brand.mjs"]);

/**
 * Whole-word patterns. Three deliberate narrowings, each because the plain
 * pattern collides with ordinary language:
 *
 *  - `Match` alone is an ordinary noun here (there is a glossary term for it),
 *    so only the domain form is banned.
 *  - "Azar" and "Raya" are ordinary Spanish words ("al azar" = at random,
 *    "a raya" = in check) and appear legitimately in translated copy, so they
 *    are not listed at all.
 *  - `Hinge` is matched case-SENSITIVELY. Lowercase "hinge" is an everyday
 *    English word (a door hinge, an argument hinges on something) and the term
 *    files use it in prose; an app name in shipped copy is always capitalised,
 *    so the capitalised form is what needs catching. Every other pattern stays
 *    case-insensitive.
 */
const BANNED = [
  /\bTinder\b/i,
  /\bBumble\b/i,
  /\bHinge\b/,
  /\bOkCupid\b/i,
  /\bGrindr\b/i,
  /\bBadoo\b/i,
  /\bHappn\b/i,
  /\beHarmony\b/i,
  /\bMatch\.com\b/i,
  /\bCoffee Meets Bagel\b/i,
  /\bPlenty of Fish\b/i,
  /\bTantan\b/i,
  /\bFeeld\b/i,
];

const hits = [];

function walk(dir) {
  for (const name of readdirSync(dir)) {
    const path = join(dir, name);
    if (statSync(path).isDirectory()) {
      if (name === "node_modules" || name === ".next") continue;
      walk(path);
      continue;
    }
    if (!EXTENSIONS.has(extname(name)) || SKIP_FILES.has(name)) continue;
    const lines = readFileSync(path, "utf8").split("\n");
    lines.forEach((line, i) => {
      for (const pattern of BANNED) {
        const match = line.match(pattern);
        if (match) hits.push(`${path}:${i + 1} — "${match[0]}"`);
      }
    });
  }
}

for (const root of ROOTS) walk(root);

if (hits.length) {
  console.error(`FAIL — ${hits.length} competitor app name(s) found:`);
  for (const hit of hits) console.error(`  - ${hit}`);
  process.exit(1);
}
console.log("PASS — no competitor app names in src/ or public/");
