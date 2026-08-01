import { SITE_NAME, SITE_URL } from "@/lib/constants/metadata";

/**
 * Shared Open Graph / Twitter image helpers.
 *
 * Next.js REPLACES a parent's `openGraph` object when a route defines its own —
 * it never deep-merges. So every page whose `generateMetadata` sets `openGraph`
 * drops the root layout's `images` and silently ships without an `og:image`.
 * These helpers keep the fallback in one place instead of repeating the same
 * literal in every route.
 */
interface OgImage {
  url: string;
  width: number;
  height: number;
  alt: string;
}

/** Site-wide fallback share image — `public/images/og-image.png` (1200x630). */
export const DEFAULT_OG_IMAGE: OgImage = {
  url: `${SITE_URL}/images/og-image.png`,
  width: 1200,
  height: 630,
  alt: SITE_NAME,
};

/**
 * Image list for a page's `openGraph.images` / `twitter.images`.
 *
 * @param image Optional site-relative path (`/images/blog/foo.png`) or absolute
 *   URL. Falls back to {@link DEFAULT_OG_IMAGE} when omitted.
 * @param alt Optional alt text; defaults to the site name.
 */
export function ogImages(image?: string, alt?: string): OgImage[] {
  if (!image) {
    return [alt ? { ...DEFAULT_OG_IMAGE, alt } : DEFAULT_OG_IMAGE];
  }
  return [
    {
      ...DEFAULT_OG_IMAGE,
      url: image.startsWith("http") ? image : `${SITE_URL}${image}`,
      ...(alt && { alt }),
    },
  ];
}
