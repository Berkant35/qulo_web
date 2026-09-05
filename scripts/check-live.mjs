/**
 * Live crawlability check for quloapp.com.
 *
 * This does NOT measure traffic — nothing on the site measures traffic today
 * (no analytics script, no Search Console verification, and the site is no
 * longer behind Cloudflare). It measures the things that have to be true
 * *before* traffic can arrive, so a regression in them is caught in hours
 * rather than at the next manual look:
 *
 *   - the sitemap is reachable and its URL count has not silently collapsed
 *   - robots.txt still allows the crawlers we want
 *   - a sample across every page type returns 200
 *   - pages that must be indexable say so, and the noindexed location pages
 *     stay noindexed
 *   - each sampled page serves its own language, not an English fallback
 *   - the apex redirects to the visitor's language and does not answer 200
 *
 * The apex check exists because that URL answered 200 with a Next error page
 * from the site's first deploy until 2026-09-05 and nobody noticed: two bugs
 * hid each other, and no check looked at the front door.
 *
 * Run: `npm run check:live`
 */
const SITE = "https://quloapp.com";

/** One sample per page type, deliberately in different locales. */
const SAMPLES = [
  { path: "/tr/", indexable: true, lang: "tr" },
  { path: "/en/blog/is-cuffing-season-real/", indexable: true, lang: "en" },
  { path: "/ja/blog/the-question-deficit/", indexable: true, lang: "ja" },
  { path: "/ko/glossary/ghosting/", indexable: true, lang: "ko" },
  { path: "/ar/glossary/", indexable: true, lang: "ar" },
  { path: "/pl/questions/", indexable: true, lang: "pl" },
  { path: "/ru/press/", indexable: true, lang: "ru" },
  { path: "/de/advice/first-date-tips/", indexable: true, lang: "de" },
  { path: "/es/how-to/write-great-questions/", indexable: true, lang: "es" },
  { path: "/en/answers/is-qulo-free/", indexable: true, lang: "en" },
  // Template location pages: live, crawlable, deliberately out of the index.
  { path: "/en/dating/istanbul/", indexable: false, lang: "en" },
  { path: "/en/country/turkey/", indexable: false, lang: "en" },
];

const problems = [];
const note = (message) => problems.push(message);

async function get(path) {
  const response = await fetch(`${SITE}${path}`, { redirect: "follow" });
  return { status: response.status, body: await response.text() };
}

const sitemap = await get("/sitemap-0.xml");
const urlCount = (sitemap.body.match(/<loc>/g) || []).length;
if (sitemap.status !== 200) note(`sitemap-0.xml returned ${sitemap.status}`);
// The count is expected to move as content ships; a collapse is the signal.
if (urlCount < 1000) note(`sitemap lists only ${urlCount} URLs — expected ~1200`);

/**
 * The apex must redirect, never render. A 200 here means a static index.html
 * has reappeared and is shadowing the redirect rules again.
 */
for (const [language, expected] of [
  ["en-US,en;q=0.9", "/en/"],
  ["tr-TR,tr;q=0.9", "/tr/"],
  ["de-DE,de;q=0.9", "/de/"],
  ["fi-FI,fi;q=0.9", "/en/"], // unsupported language falls back to English
]) {
  const response = await fetch(SITE, {
    redirect: "manual",
    headers: { "accept-language": language },
  });
  const location = response.headers.get("location") || "";
  if (response.status !== 302) {
    note(`apex answered ${response.status} for ${language} — expected a 302`);
  } else if (!location.endsWith(expected)) {
    note(`apex sent ${language} to ${location || "nowhere"}, expected ${expected}`);
  }
}

const robots = await get("/robots.txt");
if (robots.status !== 200) note(`robots.txt returned ${robots.status}`);
for (const agent of ["Googlebot", "GPTBot", "ClaudeBot", "PerplexityBot"]) {
  if (!robots.body.includes(agent)) note(`robots.txt no longer names ${agent}`);
}
if (/Disallow:\s*\/\s*$/m.test(robots.body)) note("robots.txt contains a blanket Disallow: /");

const rows = [];
for (const sample of SAMPLES) {
  const page = await get(sample.path);
  const noindex = /<meta name="robots" content="[^"]*noindex/.test(page.body);
  const lang = (page.body.match(/<html lang="([a-z-]+)"/) || [])[1];
  const title = (page.body.match(/<title>([^<]*)<\/title>/) || [])[1] || "";

  if (page.status !== 200) note(`${sample.path} returned ${page.status}`);
  if (sample.indexable && noindex) note(`${sample.path} is noindex but should be indexable`);
  if (!sample.indexable && !noindex) note(`${sample.path} lost its noindex`);
  if (lang !== sample.lang) note(`${sample.path} serves lang="${lang}", expected "${sample.lang}"`);

  rows.push(
    `  ${page.status}  ${noindex ? "noindex" : "index  "}  ${String(lang).padEnd(3)}  ${sample.path.padEnd(42)} ${title.slice(0, 44)}`,
  );
}

console.log(`sitemap: ${urlCount} URLs · apex redirects by language\n`);
console.log("  code  robots   lang  path                                       title");
console.log(rows.join("\n"));

if (problems.length) {
  console.error(`\nFAIL — ${problems.length} problem(s):`);
  for (const problem of problems) console.error(`  - ${problem}`);
  process.exit(1);
}
console.log(`\nPASS — sitemap reachable, robots intact, ${SAMPLES.length} sampled pages correct`);
