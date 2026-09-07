/**
 * IndexNow submitter.
 *
 * WHY THIS EXISTS: ChatGPT Search and Microsoft Copilot retrieve through Bing's
 * index, so a page Bing has not re-crawled is a page those engines answer from
 * a stale copy of. That is not hypothetical here — an audit on 2026-09-06 found
 * AI answers still repeating claims that were removed from this site days
 * earlier ("2-10 questions", "world's first quiz-based dating app"), because
 * the index still held the pre-2026-09-04 document. IndexNow is the documented
 * way to push a changed URL to Bing in seconds instead of waiting for a crawl.
 *
 * WHAT IT DOES NOT DO: it does not make a page rank, get cited, or get answered
 * from. It only closes the discovery gap — one stage of a long chain. Submitting
 * more URLs does not buy more of anything, so this script deliberately submits
 * only what actually changed.
 *
 * Usage:
 *   node scripts/indexnow.mjs --urls <file>    # one absolute URL per line
 *   node scripts/indexnow.mjs --paths /en/about/,/tr/about/
 *   node scripts/indexnow.mjs --since <git-ref> # URLs whose content changed
 *   node scripts/indexnow.mjs ... --dry-run
 *
 * The key lives in `public/<key>.txt` and must be reachable at
 * https://quloapp.com/<key>.txt before a submission is accepted.
 */
import { readFileSync, readdirSync } from "node:fs";
import { execFileSync } from "node:child_process";

const HOST = "quloapp.com";
const ORIGIN = `https://${HOST}`;
const ENDPOINT = "https://api.indexnow.org/IndexNow";
/** IndexNow accepts at most 10,000 URLs per request; stay well under. */
const MAX_URLS = 5000;

function findKey() {
  const files = readdirSync("public").filter((f) => /^[0-9a-f]{8,128}\.txt$/.test(f));
  if (files.length !== 1) {
    throw new Error(
      files.length === 0
        ? "public/<key>.txt not found — generate one before submitting"
        : `expected exactly one IndexNow key file, found ${files.length}`,
    );
  }
  const key = files[0].replace(/\.txt$/, "");
  const body = readFileSync(`public/${files[0]}`, "utf8").trim();
  if (body !== key) throw new Error(`public/${files[0]} must contain exactly "${key}"`);
  return key;
}

/** Map a changed content file to the URLs it renders as, across all locales. */
function urlsForChangedFiles(ref) {
  // execFileSync, not a shell string: `ref` comes from the command line and a
  // shell would happily interpret metacharacters in it.
  const out = execFileSync("git", ["diff", "--name-only", ref, "HEAD"], { encoding: "utf8" });
  const files = out.split("\n").filter(Boolean);
  const locales = ["en","tr","de","fr","es","ar","ru","pt","it","ja","ko","zh","nl","pl","sv","hi"];
  const paths = new Set();
  for (const f of files) {
    let m;
    if ((m = f.match(/glossary\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/glossary/${m[1]}/`);
    else if ((m = f.match(/answers\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/answers/${m[1]}/`);
    else if ((m = f.match(/blog\/\[slug\]\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/blog/${m[1]}/`);
    else if ((m = f.match(/advice\/\[slug\]\/_content\/([a-z0-9-]+)\.ts$/))) paths.add(`/advice/${m[1]}/`);
    else if ((m = f.match(/\[locale\]\/([a-z0-9-]+)\/page\.tsx$/))) paths.add(`/${m[1]}/`);
  }
  return [...paths].flatMap((p) => locales.map((l) => `${ORIGIN}/${l}${p}`));
}

const args = process.argv.slice(2);
const argValue = (name) => {
  const i = args.indexOf(name);
  return i >= 0 ? args[i + 1] : undefined;
};
const dryRun = args.includes("--dry-run");

let urls = [];
const urlsFile = argValue("--urls");
const pathsArg = argValue("--paths");
const since = argValue("--since");
if (urlsFile) urls = readFileSync(urlsFile, "utf8").split("\n").map((s) => s.trim()).filter(Boolean);
else if (pathsArg) urls = pathsArg.split(",").map((p) => `${ORIGIN}${p.trim()}`);
else if (since) urls = urlsForChangedFiles(since);
else {
  console.error("nothing to submit — pass --urls, --paths or --since");
  process.exit(1);
}

urls = [...new Set(urls)].filter((u) => u.startsWith(ORIGIN));
if (urls.length === 0) {
  console.log("no URLs matched — nothing submitted");
  process.exit(0);
}
if (urls.length > MAX_URLS) {
  console.error(`${urls.length} URLs exceeds the ${MAX_URLS} cap — narrow the selection`);
  process.exit(1);
}

const key = findKey();
console.log(`host      ${HOST}`);
console.log(`keyfile   ${ORIGIN}/${key}.txt`);
console.log(`urls      ${urls.length}`);
for (const u of urls.slice(0, 8)) console.log(`          ${u}`);
if (urls.length > 8) console.log(`          … and ${urls.length - 8} more`);

if (dryRun) {
  console.log("\n--dry-run — nothing submitted");
  process.exit(0);
}

// The key file has to be live, or the endpoint accepts the request and then
// silently discards it. Check before claiming a submission happened.
const probe = await fetch(`${ORIGIN}/${key}.txt`);
const probeBody = probe.ok ? (await probe.text()).trim() : "";
if (probeBody !== key) {
  console.error(`\nFAIL — ${ORIGIN}/${key}.txt is not serving the key (HTTP ${probe.status}).`);
  console.error("Deploy the key file first; a submission without it is discarded.");
  process.exit(1);
}
console.log("keyfile verified live");

const res = await fetch(ENDPOINT, {
  method: "POST",
  headers: { "Content-Type": "application/json; charset=utf-8" },
  body: JSON.stringify({ host: HOST, key, keyLocation: `${ORIGIN}/${key}.txt`, urlList: urls }),
});
const text = await res.text();
// 200 = accepted, 202 = accepted, key validation pending. Both are successes.
if (res.status === 200 || res.status === 202) {
  console.log(`\nOK — HTTP ${res.status}, ${urls.length} URLs submitted`);
} else {
  console.error(`\nFAIL — HTTP ${res.status} ${text.slice(0, 300)}`);
  process.exit(1);
}
