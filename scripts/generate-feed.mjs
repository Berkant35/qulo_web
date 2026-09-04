/**
 * Regenerates `public/feed.xml` from `BLOG_POSTS`.
 *
 * The feed used to be maintained by hand and had drifted badly: it listed 7 of
 * the 10 posts, every pubDate was a build date from April rather than the
 * post's own, and one title still named a competitor app — which the brand rule
 * forbids anywhere on this site. Generating it removes the whole class of
 * problem; the feed cannot go stale or off-message again without the blog
 * constants going stale first.
 *
 * English only, on purpose: a feed is consumed by aggregators, and 16 parallel
 * feeds would fragment subscribers for no gain. `<link>` points at the English
 * post, whose page carries `hreflang` to the other 15.
 *
 * Runs automatically via `prebuild`.
 */
import { readFileSync, writeFileSync } from "node:fs";

const SITE_URL = "https://quloapp.com";

/** Pull the BLOG_POSTS array literal out of the TypeScript source. */
function loadPosts() {
  const src = readFileSync("src/lib/constants/blog.ts", "utf8");
  const start = src.indexOf("export const BLOG_POSTS");
  if (start < 0) throw new Error("BLOG_POSTS not found");
  // Seek past the type annotation: `BlogPost[]` carries a bracket of its own,
  // so anchor on the `=` and take the first `[` after it.
  const open = src.indexOf("[", src.indexOf("=", start));
  let depth = 0;
  let end = open;
  for (let i = open; i < src.length; i++) {
    if (src[i] === "[") depth++;
    else if (src[i] === "]") {
      depth--;
      if (depth === 0) {
        end = i + 1;
        break;
      }
    }
  }
  return new Function(`return ${src.slice(open, end)}`)();
}

/** XML text nodes: escape the five predefined entities, nothing else. */
function xml(text) {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

const posts = loadPosts()
  .slice()
  .sort((a, b) => b.publishedAt.localeCompare(a.publishedAt));

if (posts.length === 0) throw new Error("no posts to publish");

const rfc822 = (isoDate) => new Date(`${isoDate}T00:00:00Z`).toUTCString();

const items = posts
  .map((post) => {
    const url = `${SITE_URL}/en/blog/${post.slug}`;
    return `    <item>
      <title>${xml(post.titles.en)}</title>
      <link>${url}</link>
      <description>${xml(post.excerpts.en)}</description>
      <pubDate>${rfc822(post.publishedAt)}</pubDate>
      <guid isPermaLink="true">${url}</guid>
    </item>`;
  })
  .join("\n\n");

const feed = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Qulo Blog</title>
    <link>${SITE_URL}/en/blog</link>
    <description>How people actually meet, and what happens when matching runs on questions instead of photos.</description>
    <language>en</language>
    <copyright>© ${new Date().getUTCFullYear()} Qulo. All rights reserved.</copyright>
    <lastBuildDate>${rfc822(posts[0].publishedAt)}</lastBuildDate>
    <atom:link href="${SITE_URL}/feed.xml" rel="self" type="application/rss+xml" />

${items}
  </channel>
</rss>
`;

writeFileSync("public/feed.xml", feed);
console.log(`feed.xml — ${posts.length} posts, newest ${posts[0].publishedAt}`);
