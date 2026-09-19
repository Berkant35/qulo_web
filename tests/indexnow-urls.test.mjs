import { test } from "node:test";
import assert from "node:assert/strict";
import {
  isContentRoute,
  pathsForChangedFiles,
  urlsForPaths,
} from "../scripts/lib/indexnow-urls.mjs";
import { locales, contentLocales } from "../scripts/lib/locales.mjs";

const ORIGIN = "https://quloapp.com";
const localesOf = (urls) => urls.map((u) => u.replace(`${ORIGIN}/`, "").split("/")[0]);

/**
 * IndexNow'a var olmayan bir URL bildirmek zararsiz bir fazlalik degil: sitenin
 * asil sorunu kesfedilme ve bu, kullandigimiz tek kanala gurultu koyuyor.
 * 19.09.2026'da `/th/dating-statistics/` ve `/id/dating-statistics/` (ikisi de
 * 404) gonderilmek uzereydi — yapili icerik yalniz 16 dilde uretiliyor.
 */
test("icerik rotasi yalniz contentLocales'e genisler — th/id yok", () => {
  const urls = urlsForPaths(["/dating-statistics/"], ORIGIN);
  assert.equal(urls.length, contentLocales.length);
  assert.ok(!urls.includes(`${ORIGIN}/th/dating-statistics/`));
  assert.ok(!urls.includes(`${ORIGIN}/id/dating-statistics/`));
  assert.ok(urls.includes(`${ORIGIN}/tr/dating-statistics/`));
});

test("icerik olmayan rota 18 dile genisler — th/id dahil", () => {
  const urls = urlsForPaths(["/about/"], ORIGIN);
  assert.equal(urls.length, locales.length);
  assert.ok(urls.includes(`${ORIGIN}/th/about/`));
  assert.ok(urls.includes(`${ORIGIN}/id/about/`));
});

test("iki kume gercekten farkli — test kendini kandirmasin", () => {
  assert.notEqual(locales.length, contentLocales.length);
  const uiOnly = locales.filter((l) => !contentLocales.includes(l));
  assert.deepEqual(localesOf(urlsForPaths(["/glossary/ick/"], ORIGIN)).filter((l) => uiOnly.includes(l)), []);
});

test("isContentRoute: segment tam eslesir, yarim prefix saymaz", () => {
  assert.equal(isContentRoute("/dating-statistics/"), true);
  assert.equal(isContentRoute("/blog/what-is-swipe-fatigue/"), true);
  assert.equal(isContentRoute("/press"), true);
  // `/press` bir prefix ama `/pressroom` ondan turemis bir sayfa degil.
  assert.equal(isContentRoute("/pressroom/"), false);
  assert.equal(isContentRoute("/about/"), false);
  assert.equal(isContentRoute("/pricing/"), false);
});

test("pathsForChangedFiles: icerik dosyalarini sayfa yoluna cevirir", () => {
  const paths = pathsForChangedFiles([
    "web/src/app/[locale]/glossary/_content/ghosting.ts",
    "web/src/app/[locale]/answers/_content/is-qulo-free.ts",
    "web/src/app/[locale]/blog/[slug]/_content/the-question-deficit.ts",
    "web/src/app/[locale]/advice/[slug]/_content/first-date-tips.ts",
    "web/src/app/[locale]/dating-statistics/page.tsx",
  ]);
  assert.deepEqual(paths.sort(), [
    "/advice/first-date-tips/",
    "/answers/is-qulo-free/",
    "/blog/the-question-deficit/",
    "/dating-statistics/",
    "/glossary/ghosting/",
  ]);
});

test("pathsForChangedFiles: barrel dosyasi ve alakasiz dosya yol uretmez", () => {
  assert.deepEqual(
    pathsForChangedFiles([
      "web/src/app/[locale]/glossary/_content/index.ts",
      "web/src/lib/analytics/ga.ts",
      "web/package.json",
    ]),
    [],
  );
});

test("ayni dosya iki kez degisse URL bir kez gonderilir", () => {
  const paths = pathsForChangedFiles([
    "web/src/app/[locale]/glossary/_content/ick.ts",
    "web/src/app/[locale]/glossary/_content/ick.ts",
  ]);
  assert.deepEqual(paths, ["/glossary/ick/"]);
});
