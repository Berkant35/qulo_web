#!/usr/bin/env node
/**
 * Every locale-keyed label map must cover every content locale.
 *
 * This bug has now been fixed four times. `landingLabels.ts` records the first
 * round (2026-09-04): the /features pages carried `isTr ? … : …` per string, so
 * fourteen locales read English section headings under a translated `<h1>`. On
 * 2026-09-26 six more maps were found in the same state — advice hub, advice
 * article, blog hub, pricing, how-to hub, how-to article — plus three copies of
 * the same CTA, all `tr/en/de/fr/es` and falling back to English. That is 88
 * pages showing "All Guides" and 66 showing "min read" in eleven other
 * languages, on the pages we were simultaneously asking Google to index.
 *
 * Completing a map by hand is not a fix while the next one can ship half-done,
 * so the rule is mechanical: a `Record<string, …>` whose keys are locale codes
 * needs all 16 content locales.
 *
 * Escape hatch, for maps that are deliberately not per-content-locale:
 *   // i18n-partial-ok: <reason>
 * on the line above the declaration. Write the reason; the next reader needs it.
 *
 * Run: `npm run verify:i18n` (no build required)
 */
import { readdirSync, readFileSync, statSync } from "node:fs";
import { join, relative } from "node:path";
import { contentLocales, locales } from "./lib/locales.mjs";

const SRC = "src";
const ALL = new Set(locales);

const files = (function walk(dir) {
  return readdirSync(dir).flatMap((name) => {
    const path = join(dir, name);
    if (statSync(path).isDirectory()) return walk(path);
    return /\.tsx?$/.test(name) ? [path] : [];
  });
})(SRC);

/** Keys declared at depth 1 of the object literal starting at `open`. */
function topLevelKeys(source, open) {
  const keys = [];
  let depth = 0;
  for (let i = open; i < source.length; i++) {
    const c = source[i];
    if (c === "{" || c === "[") depth++;
    else if (c === "}" || c === "]") {
      depth--;
      if (depth === 0) return { keys, end: i };
    } else if (depth === 1) {
      const m = /^\s*(?:"([a-z]{2})"|([a-z]{2}))\s*:/.exec(source.slice(i));
      if (m && ",{\n\t ".includes(source[i - 1])) keys.push(m[1] ?? m[2]);
    }
  }
  return { keys, end: source.length };
}

const failures = [];
let checked = 0;

for (const file of files) {
  const source = readFileSync(file, "utf8");
  const decl = /(?:export\s+)?const\s+(\w+)\s*:\s*Record<\s*string\s*,[\s\S]*?>\s*=\s*\{/g;
  let m;
  while ((m = decl.exec(source)) !== null) {
    const open = m.index + m[0].length - 1;
    const { keys } = topLevelKeys(source, open);
    // Dedupe: the scanner can match the same key at several offsets.
    const unique = [...new Set(keys)];
    const localeKeys = unique.filter((k) => ALL.has(k));
    /*
     * A locale map is one whose keys are ALL locale codes. Counting locale keys
     * instead would skip the worst cases: an earlier version of this guard
     * required three of them and so ignored `FAQ_DATA_PRICING`, which has
     * exactly `tr` and `en` — the very map most in need of the check. Maps
     * keyed by city, slug or plan are excluded because those keys are not
     * locale codes, not because there are few of them.
     */
    if (localeKeys.length < 2 || localeKeys.length !== unique.length) continue;
    // Look back far enough for a multi-line reason; three lines was not.
    const before = source.slice(0, m.index).split("\n").slice(-12).join("\n");
    if (/i18n-partial-ok:/.test(before)) continue;
    checked++;
    const missing = contentLocales.filter((l) => !localeKeys.includes(l));
    if (missing.length > 0) {
      const line = source.slice(0, m.index).split("\n").length;
      failures.push(
        `${relative(".", file)}:${line} ${m[1]} — ${localeKeys.length} dil, eksik: ${missing.join(",")}`,
      );
    }
  }
}

if (checked === 0) {
  console.error("FAIL — hic dil haritasi bulunamadi; bu guard hicbir sey dogrulamiyor.");
  process.exit(1);
}
if (failures.length > 0) {
  console.error(
    `FAIL — ${failures.length} dil haritasi eksik (${contentLocales.length} icerik dili sart):\n` +
      failures.map((f) => `  - ${f}`).join("\n") +
      `\n\nBilerek kismi ise ustune "// i18n-partial-ok: <sebep>" yaz.`,
  );
  process.exit(1);
}
console.log(`PASS — ${checked} dil haritasinin hepsi ${contentLocales.length} icerik dilini kapsiyor`);
