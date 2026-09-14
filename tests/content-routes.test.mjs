import { test } from "node:test";
import assert from "node:assert/strict";
import { readdirSync, readFileSync, existsSync } from "node:fs";
import { join } from "node:path";

/**
 * `CONTENT_ROUTE_PREFIXES` (config.ts) elle tutulan bir liste: icerik rotalari
 * (generateStaticParams'i contentLocales kullanan sayfalar) ile birebir olmali.
 * Ayrisirsa th/id menusu uretilmeyen bir sayfaya link verir (404) ya da var olan
 * bir sayfayi gereksiz yere Ingilizce'ye yollar. verify:links bunu ancak build
 * sonrasi yakalar; bu test kaynakta yakalar.
 */
const APP = "src/app/[locale]";
const cfg = readFileSync("src/lib/i18n/config.ts", "utf8");
const prefixes = [...cfg.match(/CONTENT_ROUTE_PREFIXES = \[([\s\S]*?)\] as const/)[1].matchAll(/"(\/[^"]+)"/g)].map((m) => m[1]).sort();

function usesContentLocales(dir) {
  // Dizin kokundeki page.tsx ya da alt dinamik segment ([slug], [city], 2026) sayfasi
  const candidates = [join(dir, "page.tsx"), ...readdirSync(dir, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => join(dir, d.name, "page.tsx"))];
  return candidates.some((f) => existsSync(f) && /contentLocales\.map\(/.test(readFileSync(f, "utf8")));
}

test("CONTENT_ROUTE_PREFIXES == contentLocales kullanan rota dizinleri", () => {
  const dirs = readdirSync(APP, { withFileTypes: true }).filter((d) => d.isDirectory() && !d.name.startsWith("_"));
  const contentDirs = dirs.filter((d) => usesContentLocales(join(APP, d.name))).map((d) => `/${d.name}`).sort();
  assert.deepEqual(prefixes, contentDirs);
});

test("icerik olmayan rotalar (yasal, yardim, ana sayfa) contentLocales kullanmaz", () => {
  for (const name of ["privacy-policy", "terms", "help", "about", "community-guidelines", "safety-tips", "pricing"]) {
    const f = join(APP, name, "page.tsx");
    if (!existsSync(f)) continue;
    assert.ok(!/contentLocales/.test(readFileSync(f, "utf8")), `${name} 18 dilde uretilmeli`);
  }
});
