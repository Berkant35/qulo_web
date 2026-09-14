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
export const defaultLocale = source.match(/export const defaultLocale: Locale = "([a-z-]+)";/)?.[1] ?? "tr";
