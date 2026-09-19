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
 * Rule 2 — nothing on this site is sold, so nothing may be marked up as a
 * `Product`.
 *
 * /pricing used to declare `@type: "Product"` with three Offers. Purchases
 * happen inside the app through store billing, so that page sells nothing, and
 * the markup put it in Search Console's **Merchant listings** report, which
 * then asked for `shippingDetails` and `hasMerchantReturnPolicy` (2026-09-19,
 * 8 items each) — fields with no honest answer for an app subscription. It also
 * described the app a second time, disagreeing with the site-wide
 * `SoftwareApplication` about the price. Both are now one entity, shared
 * through `APP_JSON_LD_ID`.
 *
 * Following `verify-links.mjs`: a guard that passes on nothing is worse than no
 * guard, so each rule asserts its floor before scanning.
 */
import { readFileSync, existsSync, readdirSync, statSync } from "node:fs";
import { join } from "node:path";
import { contentLocales, locales } from "./lib/locales.mjs";

const OUT = process.env.VERIFY_OUT ?? "out";
const PAGE = "dating-statistics";
const APP_ID = "https://quloapp.com/#app";

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

// --- Rule 2: no Product markup anywhere; /pricing declares the app instead ---

/** Every JSON-LD node in a page, flattened. */
function nodes(html) {
  return [...html.matchAll(/<script type="application\/ld\+json">(.*?)<\/script>/gs)].flatMap(([, raw]) => {
    try {
      const parsed = JSON.parse(raw);
      return Array.isArray(parsed) ? parsed : [parsed];
    } catch {
      return [];
    }
  });
}

const htmlFiles = (function walk(dir) {
  return readdirSync(dir).flatMap((name) => {
    const path = join(dir, name);
    return statSync(path).isDirectory() ? walk(path) : name.endsWith(".html") ? [path] : [];
  });
})(OUT);

if (htmlFiles.length === 0) failures.push(`${OUT}/ icinde hic HTML yok — derleme yarim`);

const productPages = htmlFiles.filter((f) => nodes(readFileSync(f, "utf8")).some((n) => n?.["@type"] === "Product"));
if (productPages.length > 0) {
  failures.push(
    `Product isaretlemesi ${productPages.length} sayfada (sitede satis yok, Merchant listings'e dusuyor), ornek: ${productPages[0]}`,
  );
}

for (const locale of locales) {
  const file = join(OUT, locale, "pricing", "index.html");
  if (!existsSync(file)) {
    failures.push(`${locale}: pricing sayfasi derlemede yok (${file})`);
    continue;
  }
  // The site-wide node and the plans node share `@id`, so a consumer sees one
  // app with the union of their properties. Check that union, not one node:
  // three tiers exactly, no duplicate Free from declaring offers twice.
  const app = nodes(readFileSync(file, "utf8")).filter(
    (n) => n?.["@type"] === "SoftwareApplication" && n["@id"] === APP_ID,
  );
  if (app.length === 0) {
    failures.push(`${locale}: pricing sayfasinda "@id" ${APP_ID} olan SoftwareApplication yok`);
    continue;
  }
  const offers = app.flatMap((n) => (Array.isArray(n.offers) ? n.offers : n.offers ? [n.offers] : []));
  const names = offers.map((o) => o?.name).sort();
  if (names.join(",") !== "Free,Plus,Premium") {
    failures.push(`${locale}: pricing planlari "Free,Plus,Premium" olmali, bulunan: "${names.join(",")}"`);
  }
  if (app.some((n) => n.aggregateRating)) {
    failures.push(`${locale}: pricing'de aggregateRating var — kendi puanimiz yok, uydurma`);
  }
}

if (failures.length > 0) {
  console.error(`FAIL — ${failures.length} sorun:\n- ${failures.join("\n- ")}`);
  process.exit(1);
}
console.log(
  `PASS — ${contentLocales.length} dilde Dataset lisansi (JSON-LD + sayfa), ` +
    `${locales.length} dilde pricing tek app kimligiyle, ${htmlFiles.length} sayfada Product yok`,
);
