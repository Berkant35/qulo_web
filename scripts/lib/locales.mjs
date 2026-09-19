/**
 * Tek kaynak: src/lib/i18n/config.ts. Script'ler kendi dil listelerini tutmaz;
 * 19. dilde config.ts degisince verify/import/indexnow otomatik takip eder.
 */
import { readFileSync } from "node:fs";

const source = readFileSync(new URL("../../src/lib/i18n/config.ts", import.meta.url), "utf8");

function readList(name) {
  const m = source.match(new RegExp(`export const ${name} = \\[([\\s\\S]*?)\\] as const;`));
  if (!m) throw new Error(`config.ts icinde '${name}' bulunamadi`);
  return [...m[1].matchAll(/"([a-z]{2}(?:-[A-Za-z]+)?)"/g)].map((x) => x[1]);
}

export const locales = readList("locales");
export const contentLocales = readList("contentLocales");

/**
 * Yollarin listesi de tek kaynaktan: bu prefix'lerdeki sayfalar yalnizca
 * `contentLocales`'te uretilir, th/id'de 404'tur. Script'ler kendi listesini
 * tutmasin — config.ts'e 14. prefix eklenince indexnow otomatik takip etsin.
 */
function readPathList(name) {
  const m = source.match(new RegExp(`export const ${name} = \\[([\\s\\S]*?)\\] as const;`));
  if (!m) throw new Error(`config.ts icinde '${name}' bulunamadi`);
  const found = [...m[1].matchAll(/"(\/[a-z0-9-]+)"/g)].map((x) => x[1]);
  if (found.length === 0) throw new Error(`config.ts icinde '${name}' bos gorunuyor`);
  return found;
}

export const contentRoutePrefixes = readPathList("CONTENT_ROUTE_PREFIXES");
const defaultMatch = source.match(/export const defaultLocale: Locale = "([a-z-]+)";/);
if (!defaultMatch) throw new Error("config.ts icinde 'defaultLocale' bulunamadi");
export const defaultLocale = defaultMatch[1];
