import { test } from "node:test";
import assert from "node:assert/strict";
import {
  defaultLocale,
  isLocale,
  localeFromPathname,
  switchLocalePath,
} from "../src/lib/i18n/config.ts";

/**
 * Dil secici (baslik + altbilgi) ve Navbar ayni iki yardimciyi kullanir. Eski
 * `pathname.startsWith("/th")` bicimi "/thai/..." gibi bir yolu Tayca sanirdi;
 * `split("/")[1]` ise bilinmeyen segmenti dil diye tasirdi.
 */
test("localeFromPathname: bastaki dil segmentini tam eslesme ile okur", () => {
  assert.equal(localeFromPathname("/th/about"), "th");
  assert.equal(localeFromPathname("/th"), "th");
  assert.equal(localeFromPathname("/id/"), "id");
});

test("localeFromPathname: dil olmayan ya da yarim eslesen segmentte varsayilana duser", () => {
  assert.equal(localeFromPathname("/thai/about"), defaultLocale);
  assert.equal(localeFromPathname("/"), defaultLocale);
  assert.equal(localeFromPathname("/about"), defaultLocale);
});

test("isLocale: yalniz config'teki 18 kodu kabul eder", () => {
  assert.equal(isLocale("id"), true);
  assert.equal(isLocale("tr"), true);
  assert.equal(isLocale("xx"), false);
  assert.equal(isLocale(""), false);
  assert.equal(isLocale("TH"), false);
});

test("switchLocalePath: ayni sayfayi hedef dilde verir", () => {
  assert.equal(switchLocalePath("/th/about", "en"), "/en/about");
  assert.equal(switchLocalePath("/en/blog/some-post", "de"), "/de/blog/some-post");
});

test("switchLocalePath: icerik rotasi, icerigi olmayan dilde ana sayfaya gider", () => {
  assert.equal(switchLocalePath("/en/blog/some-post", "th"), "/th/");
  assert.equal(switchLocalePath("/de/glossary", "id"), "/id/");
});

test("switchLocalePath: ana sayfa her bicimde trailingSlash'li ana sayfaya gider", () => {
  assert.equal(switchLocalePath("/en", "id"), "/id/");
  assert.equal(switchLocalePath("/tr/", "th"), "/th/");
  assert.equal(switchLocalePath("/", "th"), "/th/");
});
