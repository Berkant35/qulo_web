export type Platform = "ios" | "android" | "desktop";

export function detectPlatform(): Platform {
  if (typeof window === "undefined") return "desktop";
  const ua = navigator.userAgent;
  if (/iPad|iPhone|iPod/.test(ua)) return "ios";
  if (/Android/.test(ua)) return "android";
  return "desktop";
}
