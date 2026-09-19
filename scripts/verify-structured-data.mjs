#!/usr/bin/env node
/**
 * Structured-data guard for the exported site (`npm run verify:structured-data`).
 *
 * Rule 1 — the Dataset licence is stated twice, and the two must agree.
 *
 * Search Console reported `license` missing from the Dating Statistics page's
 * Dataset markup on 2026-09-18. The fix declares it in the JSON-LD *and* says
 * the same thing in prose next to the citation formats, because structured data
 * must not promise a licence the reader cannot see. That leaves two copies of
 * one fact in one file — exactly the shape that drifts: someone rewords the
 * paragraph, or swaps the constant, and the markup starts granting a licence
 * the page never mentions (or the reverse). So this asserts the pair: every
 * content locale's page carries a Dataset with a `license`, and the rendered
 * HTML links that same URL with `rel="license"`.
 *
 * Following `verify-links.mjs`: a guard that passes on nothing is worse than no
 * guard, so the floor is asserted first — every content locale's page shipped.
 */
import { readFileSync, existsSync } from "node:fs";
import { join } from "node:path";
import { contentLocales } from "./lib/locales.mjs";

const OUT = process.env.VERIFY_OUT ?? "out";
const PAGE = "dating-statistics";

if (!existsSync(OUT)) {
  console.error(`FAIL — ${OUT}/ yok. Once \`npm run build\`.`);
  process.exit(1);
}

const failures = [];

for (const locale of contentLocales) {
  const file = join(OUT, locale, PAGE, "index.html");
  if (!existsSync(file)) {
    failures.push(`${locale}: ${PAGE} sayfasi derlemede yok (${file})`);
    continue;
  }
  const html = readFileSync(file, "utf8");

  const datasets = [...html.matchAll(/<script type="application\/ld\+json">(.*?)<\/script>/gs)]
    .flatMap(([, raw]) => {
      let parsed;
      try {
        parsed = JSON.parse(raw);
      } catch {
        failures.push(`${locale}: JSON-LD blogu ayristirilamadi`);
        return [];
      }
      return (Array.isArray(parsed) ? parsed : [parsed]).filter((n) => n?.["@type"] === "Dataset");
    });

  if (datasets.length !== 1) {
    failures.push(`${locale}: tam olarak 1 Dataset beklenir, ${datasets.length} bulundu`);
    continue;
  }

  const license = datasets[0].license;
  if (typeof license !== "string" || !license.startsWith("https://")) {
    failures.push(`${locale}: Dataset.license eksik veya URL degil (${JSON.stringify(license)})`);
    continue;
  }
  // The other half of the pair: the reader has to be able to see it.
  const linked = new RegExp(`<a[^>]+href="${license.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}"[^>]*rel="license[^"]*"`).test(html);
  if (!linked) {
    failures.push(`${locale}: Dataset.license (${license}) sayfada rel="license" baglantisiyla gorunmuyor`);
  }
}

if (failures.length > 0) {
  console.error(`FAIL — ${failures.length} sorun:\n- ${failures.join("\n- ")}`);
  process.exit(1);
}
console.log(`PASS — ${contentLocales.length} dilde Dataset lisansi hem JSON-LD'de hem sayfada`);
