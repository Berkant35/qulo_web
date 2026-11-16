import { test } from "node:test";
import assert from "node:assert/strict";
import { ROOT_METADATA } from "../src/lib/constants/rootMetadata.ts";
import { APP_STORE_URL } from "../src/lib/constants/links.ts";

// iOS Smart App Banner: both root layouts spread ROOT_METADATA, so this is the
// single place the <meta name="apple-itunes-app"> tag comes from.
test("ROOT_METADATA exposes the Smart App Banner with the real App Store id", () => {
  const appId = ROOT_METADATA.itunes?.appId;
  assert.match(String(appId), /^\d+$/);
  assert.ok(APP_STORE_URL.endsWith(`/id${appId}`), "banner id must match APP_STORE_URL");
});

test("Smart App Banner has no app-argument (deep link mapping unverified)", () => {
  assert.equal(ROOT_METADATA.itunes?.appArgument, undefined);
});
