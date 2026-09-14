/**
 * netlify.toml dil algilama bloklari (/, /q, /q/, /q/*, /invite/*) her locale icin elle
 * yaziliyor. th/id eklenirken 10 blok elle eklendi; 19. dilde unutulursa o dilin tarayicisi
 * ana sayfada Ingilizce'ye duser. Varsayilan locale kosulsuz fallback hedefi oldugu icin
 * yalniz kok ("/") blogunu tasir.
 */
import { readFileSync } from "node:fs";
import { locales, defaultLocale } from "./lib/locales.mjs";

const toml = readFileSync("netlify.toml", "utf8");
const counts = {};
for (const m of toml.matchAll(/conditions = \{Language = \["([a-z-]+)"\]\}/g)) counts[m[1]] = (counts[m[1]] ?? 0) + 1;

const errors = [];
for (const l of locales) {
  const expected = l === defaultLocale ? 1 : 5;
  if ((counts[l] ?? 0) !== expected) errors.push(`${l}: ${counts[l] ?? 0} blok, beklenen ${expected}`);
}
for (const l of Object.keys(counts)) if (!locales.includes(l)) errors.push(`${l}: config.ts'te olmayan dil icin blok var`);

if (errors.length) {
  console.error(`FAIL — netlify.toml dil bloklari config.ts ile uyusmuyor (${errors.length}):`);
  for (const e of errors) console.error(`  - ${e}`);
  process.exit(1);
}
console.log(`PASS — netlify.toml: ${locales.length} dil, ${Object.values(counts).reduce((a, b) => a + b, 0)} dil-kosullu blok`);
