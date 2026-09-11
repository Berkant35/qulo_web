#!/usr/bin/env node
/**
 * Guard for the Google Analytics setup (`npm run verify:analytics`).
 *
 * What it protects:
 * 1. CSP still allows GA4's hosts — otherwise the browser silently blocks
 *    gtag.js and the dashboard just shows zero, with no error anywhere.
 * 2. Every locale has the consent banner strings and says so in its privacy
 *    policy — the banner must never render a raw key, and the policy must
 *    disclose Google Analytics in all 16 languages, not only in tr/en.
 * 3. The built HTML does not reference gtag.js — it may only be injected at
 *    runtime after consent. A <script src> in the HTML would load it for
 *    everyone, consent or not.
 */
import { readFileSync, existsSync, readdirSync, statSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const failures = [];

// 1. CSP
const toml = readFileSync(join(root, "netlify.toml"), "utf8");
const csp = toml.match(/Content-Security-Policy = "([^"]+)"/)?.[1] ?? "";
const directive = (name) => csp.split(";").map((d) => d.trim()).find((d) => d.startsWith(`${name} `)) ?? "";
const required = {
  "script-src": ["https://*.googletagmanager.com"],
  "img-src": ["https://*.google-analytics.com", "https://*.googletagmanager.com"],
  "connect-src": ["https://*.google-analytics.com", "https://*.analytics.google.com", "https://*.googletagmanager.com"],
};
for (const [name, hosts] of Object.entries(required)) {
  for (const host of hosts) {
    if (!directive(name).split(/\s+/).includes(host)) failures.push(`CSP ${name} izin vermiyor: ${host}`);
  }
}

// 2. Dictionaries
const dictDir = join(root, "src/lib/i18n/dictionaries");
const consentKeys = ["title", "body", "accept", "reject", "policy"];
for (const file of readdirSync(dictDir).filter((f) => f.endsWith(".json"))) {
  const dict = JSON.parse(readFileSync(join(dictDir, file), "utf8"));
  for (const key of consentKeys) {
    if (!dict.consent?.[key]?.trim()) failures.push(`${file}: consent.${key} eksik`);
  }
  if (!dict.footer?.cookieSettings?.trim()) failures.push(`${file}: footer.cookieSettings eksik`);
  if (!dict.privacyPolicy?.cookies?.includes("Google Analytics")) {
    failures.push(`${file}: privacyPolicy.cookies Google Analytics'i acıklamıyor`);
  }
  // The banner and the policy tell people where to withdraw consent — by name.
  // If the footer label changes, both texts must change with it.
  const label = dict.footer?.cookieSettings?.trim();
  for (const [key, text] of [["consent.body", dict.consent?.body], ["privacyPolicy.cookies", dict.privacyPolicy?.cookies]]) {
    if (label && !text?.includes(label)) failures.push(`${file}: ${key} footer etiketini ("${label}") birebir anmiyor`);
  }
}

// 3. Built output (only when a build exists)
const out = join(root, "out");
if (existsSync(out)) {
  const walk = (dir) =>
    readdirSync(dir).flatMap((name) => {
      const path = join(dir, name);
      return statSync(path).isDirectory() ? walk(path) : path.endsWith(".html") ? [path] : [];
    });
  const offenders = walk(out).filter((file) => readFileSync(file, "utf8").includes("googletagmanager.com/gtag/js"));
  if (offenders.length > 0) {
    failures.push(`gtag.js onaydan once HTML'de yukleniyor (${offenders.length} sayfa), ornek: ${offenders[0]}`);
  }
}

if (failures.length > 0) {
  console.error(`verify:analytics — ${failures.length} sorun:\n- ${failures.join("\n- ")}`);
  process.exit(1);
}
console.log("verify:analytics — CSP, 16 dil sozlugu ve derleme ciktisi temiz");
