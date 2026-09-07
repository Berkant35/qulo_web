/**
 * qulo-server base URL for the few pages that talk to the API at runtime
 * (password reset, the shareable quiz). The site is a static export, so this
 * is baked in at build time; override with NEXT_PUBLIC_API_URL for previews.
 */
export const API_URL =
  process.env.NEXT_PUBLIC_API_URL || "https://qulo-server-production.up.railway.app";
