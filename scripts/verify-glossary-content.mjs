/**
 * Structural parity guard for `src/app/[locale]/glossary/_content/`.
 *
 * Same contract as the blog guard, plus two checks that matter more here:
 *
 *  - Every term must exist in all 16 locales. The legacy glossary stored 5 and
 *    rendered `definitions[locale] || definitions.en`, so 11 languages were
 *    served English under a `hreflang` and a JSON-LD `inLanguage` that both
 *    claimed a translation.
 *  - No non-`en` locale may reuse the English `summary` verbatim. A missing
 *    translation that falls back silently is exactly the defect being closed,
 *    and a copy-paste would slip past a locale-count check.
 *
 * Run: `npm run verify:glossary`
 */
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const LOCALES = ["tr","en","de","fr","es","ar","ru","pt","it","ja","ko","zh","nl","pl","sv","hi"];
const DIR = "src/app/[locale]/glossary/_content";

/** Evaluate the exported object literal without importing TypeScript. */
function loadTerm(file) {
  const src = readFileSync(join(DIR, file), "utf8");
  const start = src.indexOf(": LocalizedGlossaryEntry = ");
  if (start < 0) throw new Error(`${file}: no LocalizedGlossaryEntry export found`);
  const literal = src.slice(src.indexOf("{", start)).replace(/;\s*$/, "");
  return new Function(`return ${literal}`)();
}

const shape = (blocks) => ({
  types: blocks.map((b) => b.type).join(","),
  green: blocks.flatMap((b, i) => (b.accent === "green" ? [i] : [])).join(","),
  uls: blocks.filter((b) => b.type === "ul").map((b) => b.items.length).join(","),
});

const errors = [];
const files = readdirSync(DIR)
  .filter((f) => f.endsWith(".ts") && f !== "index.ts")
  .sort();

// Every slug in the registry needs a content file, and vice versa.
const registry = readFileSync("src/lib/constants/glossary.ts", "utf8");
const slugs = [...registry.matchAll(/^    slug: "([a-z-]+)",$/gm)].map((m) => m[1]).sort();
const fileSlugs = files.map((f) => f.replace(/\.ts$/, ""));
for (const slug of slugs) {
  if (!fileSlugs.includes(slug)) errors.push(`registry slug "${slug}" has no content file`);
}
for (const slug of fileSlugs) {
  if (!slugs.includes(slug)) errors.push(`content file "${slug}.ts" is not in the registry`);
}

for (const file of files) {
  const term = loadTerm(file);
  const present = Object.keys(term);

  for (const l of LOCALES) if (!present.includes(l)) errors.push(`${file} — missing locale: ${l}`);
  for (const l of present) if (!LOCALES.includes(l)) errors.push(`${file} — unexpected locale: ${l}`);
  if (!term.en) {
    errors.push(`${file} — no en entry to compare against`);
    continue;
  }

  const ref = shape(term.en.blocks);
  for (const l of present) {
    const entry = term[l];
    if (!entry.term || !entry.summary || !Array.isArray(entry.blocks)) {
      errors.push(`${file} [${l}] — entry needs term, summary and blocks`);
      continue;
    }
    if (l !== "en" && entry.summary === term.en.summary) {
      errors.push(`${file} [${l}] — summary is the English one verbatim`);
    }
    if (entry.summary.length > 300) {
      errors.push(`${file} [${l}] — summary is ${entry.summary.length} chars, too long for a meta description`);
    }

    const s = shape(entry.blocks);
    if (s.types !== ref.types) errors.push(`${file} [${l}] — block-type sequence differs from en`);
    if (s.green !== ref.green) errors.push(`${file} [${l}] — green indices "${s.green}" != en "${ref.green}"`);
    if (s.uls !== ref.uls) errors.push(`${file} [${l}] — ul item counts "${s.uls}" != en "${ref.uls}"`);

    [entry.summary, ...entry.blocks.flatMap((b) => (b.type === "ul" ? b.items : [b.text]))]
      .forEach((t, i) => {
        if ((t.match(/\*\*/g) || []).length % 2 !== 0) errors.push(`${file} [${l}] — unbalanced ** in text #${i}`);
        const entity = t.match(/&(?:quot|apos|amp|lt|gt|nbsp|#\d+);/);
        if (entity) errors.push(`${file} [${l}] — HTML entity ${entity[0]} in text #${i}`);
      });
  }

  console.log(
    `${present.length === 16 ? "OK  " : "??  "} ${file.padEnd(24)} ` +
      `${present.length} locales · ${term.en.blocks.length} blocks · green [${ref.green}] · ul [${ref.uls}]`,
  );
}

if (errors.length) {
  console.error(`\nFAIL (${errors.length})`);
  for (const e of errors) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(`\nPASS — ${files.length} terms, all 16 locales structurally identical to en`);
