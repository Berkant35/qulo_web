/**
 * Reads Netlify Analytics for quloapp.com.
 *
 * TOKEN: never passed on the command line. Read from `NETLIFY_AUTH_TOKEN`, or
 * from a file whose path is in `NETLIFY_TOKEN_FILE`, or from ~/.netlify-token.
 * Nothing here prints or logs the token.
 *
 * CAVEAT, stated up front: Netlify Analytics has no documented public API. The
 * site list below uses the official `api.netlify.com` endpoint, but the traffic
 * figures come from `analytics.services.netlify.com`, which is what the Netlify
 * dashboard itself calls and which Netlify does not support publicly. It may
 * change or disappear without notice. This script therefore reports exactly
 * what happened — an auth failure, an add-on that is not enabled, and a shape
 * it did not recognise are three different messages, never one silent zero.
 *
 * Run: `npm run traffic` · `npm run traffic -- 30` for a 30-day window
 */
import { readFileSync, existsSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

const DAYS = Number(process.argv[2] || 7);
const SITE_NAME_HINT = "quloapp";

function readToken() {
  if (process.env.NETLIFY_AUTH_TOKEN) return process.env.NETLIFY_AUTH_TOKEN.trim();
  const candidates = [
    process.env.NETLIFY_TOKEN_FILE,
    join(homedir(), ".netlify-token"),
  ].filter(Boolean);
  for (const path of candidates) {
    if (existsSync(path)) return readFileSync(path, "utf8").trim();
  }
  return null;
}

const token = readToken();
if (!token) {
  console.error(
    "No token found.\n" +
      "  Create one at Netlify → User settings → Applications → Personal access tokens,\n" +
      "  then save it to ~/.netlify-token (chmod 600) or export NETLIFY_AUTH_TOKEN.\n" +
      "  Do not paste it into a command line or a chat message.",
  );
  process.exit(1);
}

const auth = { Authorization: `Bearer ${token}` };

async function json(url) {
  const response = await fetch(url, { headers: auth });
  const text = await response.text();
  let body = null;
  try {
    body = JSON.parse(text);
  } catch {
    /* left null on purpose — the caller reports the status instead */
  }
  return { status: response.status, body, text };
}

/* 1. Find the site — official API. */
const sites = await json("https://api.netlify.com/api/v1/sites?per_page=100");
if (sites.status === 401) {
  console.error("Netlify rejected the token (401). It may be revoked or wrong.");
  process.exit(1);
}
if (sites.status !== 200 || !Array.isArray(sites.body)) {
  console.error(`Unexpected response listing sites: HTTP ${sites.status}`);
  process.exit(1);
}

const site = sites.body.find(
  (candidate) =>
    (candidate.name || "").includes(SITE_NAME_HINT) ||
    (candidate.custom_domain || "").includes(SITE_NAME_HINT),
);
if (!site) {
  console.error(
    `No site matching "${SITE_NAME_HINT}" on this account. Sites visible: ` +
      sites.body.map((s) => s.name).join(", "),
  );
  process.exit(1);
}

console.log(`site: ${site.name} (${site.custom_domain || site.url})`);
console.log(`window: last ${DAYS} days\n`);

/* 2. Traffic — undocumented dashboard endpoint. */
const to = Date.now();
const from = to - DAYS * 24 * 60 * 60 * 1000;
const base = `https://analytics.services.netlify.com/v2/${site.id}`;
const query = `from=${from}&to=${to}&timezone=%2B0000`;

const pages = await json(`${base}/ranking/pages?${query}&limit=15`);

if (pages.status === 402 || pages.status === 403) {
  console.error(
    `Netlify Analytics is not enabled for this site (HTTP ${pages.status}).\n` +
      "  It is a paid add-on, enabled per site in the Netlify dashboard under Analytics.",
  );
  process.exit(1);
}
if (pages.status !== 200) {
  console.error(
    `Analytics endpoint returned HTTP ${pages.status}. Netlify does not document\n` +
      "  this endpoint, so it may have changed. Raw response:\n  " +
      pages.text.slice(0, 300),
  );
  process.exit(1);
}

const rows = pages.body?.data;
if (!Array.isArray(rows)) {
  console.error(
    "Analytics responded 200 but not in the expected shape — reporting rather than\n" +
      "  guessing. Keys received: " +
      Object.keys(pages.body || {}).join(", "),
  );
  process.exit(1);
}

const total = rows.reduce((sum, row) => sum + (row.count || 0), 0);
console.log(`top pages by views (${total} across the rows below)\n`);
for (const row of rows) {
  console.log(`  ${String(row.count).padStart(7)}  ${row.resource}`);
}
