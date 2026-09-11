// `npm test` — GA'nin hic gormemesi gereken sayfalar (sifre sifirlama token'i, davet kodu).
import { test } from "node:test";
import assert from "node:assert/strict";
import { isSensitivePath } from "../src/lib/analytics/sensitive-paths.ts";

test("sifre sifirlama: dil onekli ve oneksiz (Netlify eski yol)", () => {
  assert.equal(isSensitivePath("/tr/reset-password/"), true);
  assert.equal(isSensitivePath("/en/reset-password"), true);
  assert.equal(isSensitivePath("/reset-password/"), true);
});

test("davet kodu yolu ve e-posta dogrulama", () => {
  assert.equal(isSensitivePath("/tr/invite/AB12CD34/"), true);
  assert.equal(isSensitivePath("/invite/AB12CD34"), true);
  assert.equal(isSensitivePath("/de/email-verified/"), true);
});

test("normal sayfalar olculur", () => {
  for (const path of ["/tr/", "/en/blog/some-post/", "/tr/privacy-policy/", "/tr/q/abc/", "/"]) {
    assert.equal(isSensitivePath(path), false, path);
  }
});

test("benzer adli sayfa yanlislikla dislanmaz", () => {
  assert.equal(isSensitivePath("/tr/invitees/"), false);
  assert.equal(isSensitivePath("/tr/blog/reset-password-tips/"), false);
});
