/**
 * Structural parity guard for the structured articles in
 * `src/app/[locale]/blog/[slug]/_content/` and
 * `src/app/[locale]/advice/[slug]/_content/`.
 *
 * Each article must exist in all 16 locales, and every locale must mirror `en`
 * exactly in block-type sequence, `accent: "green"` indices and `ul` item
 * counts — that is what keeps a translation from silently dropping a section
 * while `hreflang` still promises the language. Also asserts balanced `**`
 * emphasis and that no HTML entity (`&quot;`, `&apos;`, `&#39;`, …) leaked into
 * what are plain TypeScript strings.
 *
 * Run: `npm run verify:content`
 */
import { readdirSync, readFileSync } from "node:fs";
import { join } from "node:path";

const LOCALES = ["tr","en","de","fr","es","ar","ru","pt","it","ja","ko","zh","nl","pl","sv","hi"];
const DIRS = [
  "src/app/[locale]/blog/[slug]/_content",
  "src/app/[locale]/advice/[slug]/_content",
  "src/app/[locale]/questions/_content",
];

/** Evaluate the exported object literal without importing TypeScript. */
function loadArticle(file) {
  const src = readFileSync(file, "utf8");
  const start = src.indexOf(": LocalizedArticle = ");
  if (start < 0) throw new Error(`${file}: no LocalizedArticle export found`);
  const literal = src.slice(src.indexOf("{", start)).replace(/;\s*$/, "");
  return new Function(`return ${literal}`)();
}

const shape = (blocks) => ({
  types: blocks.map((b) => b.type).join(","),
  green: blocks.flatMap((b, i) => (b.accent === "green" ? [i] : [])).join(","),
  uls: blocks.filter((b) => b.type === "ul").map((b) => b.items.length).join(","),
});

const errors = [];
const files = DIRS.flatMap((dir) =>
  readdirSync(dir)
    .filter((f) => f.endsWith(".ts"))
    .sort()
    .map((f) => join(dir, f)),
);

for (const file of files) {
  const article = loadArticle(file);
  const present = Object.keys(article);

  for (const l of LOCALES) if (!present.includes(l)) errors.push(`${file} — missing locale: ${l}`);
  for (const l of present) if (!LOCALES.includes(l)) errors.push(`${file} — unexpected locale: ${l}`);

  const ref = shape(article.en);
  for (const l of present) {
    const s = shape(article[l]);
    if (s.types !== ref.types) errors.push(`${file} [${l}] — block-type sequence differs from en`);
    if (s.green !== ref.green) errors.push(`${file} [${l}] — green indices "${s.green}" != en "${ref.green}"`);
    if (s.uls !== ref.uls) errors.push(`${file} [${l}] — ul item counts "${s.uls}" != en "${ref.uls}"`);

    article[l]
      .flatMap((b) => (b.type === "ul" ? b.items : [b.text]))
      .forEach((t, i) => {
        if ((t.match(/\*\*/g) || []).length % 2 !== 0) errors.push(`${file} [${l}] — unbalanced ** in text #${i}`);
        // A lone `*` renders as a literal asterisk: `renderInline` splits only
        // on `**bold**`. This slipped past the check above because a stray pair
        // of single asterisks leaves the `**` count even — journal names were
        // written as *Italics* and would have shipped with the marks visible.
        const stray = t.replace(/\*\*[^*]+\*\*/g, "").match(/\*/g);
        if (stray) errors.push(`${file} [${l}] — ${stray.length} single "*" in text #${i}; only **bold** renders`);
        const entity = t.match(/&(?:quot|apos|amp|lt|gt|nbsp|#\d+);/);
        if (entity) errors.push(`${file} [${l}] — HTML entity ${entity[0]} in text #${i}`);
      });
  }

  console.log(
    `${present.length === 16 ? "OK  " : "??  "} ${file.split("/").pop().padEnd(42)} ` +
      `${present.length} locales · ${article.en.length} blocks · green [${ref.green}] · ul [${ref.uls}]`,
  );
}

if (errors.length) {
  console.error(`\nFAIL (${errors.length})`);
  for (const e of errors) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(
  `\nPASS — ${files.length} articles across ${DIRS.length} trees, all 16 locales structurally identical to en`,
);
