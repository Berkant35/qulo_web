import type { Metadata } from "next";
import { SITE_NAME, SITE_URL } from "@/lib/constants/metadata";

/**
 * Metadata for utility routes (invite landings, auth callbacks).
 *
 * These are real pages users land on, but they hold no indexable content. Without
 * their own metadata they inherit the locale layout's — which canonicalises them
 * to the homepage. Each one gets a self-referencing canonical plus `noindex`
 * instead, so the duplicate signal disappears and the page still resolves.
 */
export function utilityRouteMetadata(
  locale: string,
  segment: string,
  title: string,
): Metadata {
  return {
    title: `${title} — ${SITE_NAME}`,
    robots: { index: false, follow: true },
    alternates: { canonical: `${SITE_URL}/${locale}/${segment}` },
  };
}
