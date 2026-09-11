// `npm test` — Node's built-in runner with type stripping; no test dependency.
import { test } from "node:test";
import assert from "node:assert/strict";
import { storeClickFromHref } from "../src/lib/analytics/store-link.ts";

const ORIGIN = "https://quloapp.com";

test("App Store linki: ios + ct kampanyasi", () => {
  const href = "https://apps.apple.com/app/qulo/id1626734572?pt=123&ct=web-hero&mt=8";
  assert.deepEqual(storeClickFromHref(href, ORIGIN), { store: "ios", campaign: "web-hero" });
});

test("App Store linkinde ct yoksa kampanya unknown", () => {
  const href = "https://apps.apple.com/app/qulo/id1626734572";
  assert.deepEqual(storeClickFromHref(href, ORIGIN), { store: "ios", campaign: "unknown" });
});

test("Play linki: android + referrer icindeki utm_campaign", () => {
  const referrer = encodeURIComponent("utm_source=quloapp.com&utm_medium=web&utm_campaign=web-blog");
  const href = `https://play.google.com/store/apps/details?id=com.wordpress.calikusuberkant.qulo&referrer=${referrer}`;
  assert.deepEqual(storeClickFromHref(href, ORIGIN), { store: "android", campaign: "web-blog" });
});

test("/go/app yonlendirmesi: auto + c kampanyasi, sondaki / ile de", () => {
  assert.deepEqual(storeClickFromHref("/go/app?c=web-sticky", ORIGIN), { store: "auto", campaign: "web-sticky" });
  assert.deepEqual(storeClickFromHref("/go/app/?c=web-sticky", ORIGIN), { store: "auto", campaign: "web-sticky" });
});

test("baska sitedeki /go/app magaza sayilmaz", () => {
  assert.equal(storeClickFromHref("https://example.com/go/app?c=x", ORIGIN), null);
});

test("magaza disi dis baglanti ve ic sayfa null", () => {
  assert.equal(storeClickFromHref("https://instagram.com/quloapp", ORIGIN), null);
  assert.equal(storeClickFromHref("/tr/blog/", ORIGIN), null);
});

test("bozuk href cokmez, null doner", () => {
  assert.equal(storeClickFromHref("http://[bozuk", ORIGIN), null);
});
