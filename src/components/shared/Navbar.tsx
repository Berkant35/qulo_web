"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";
import { LanguageSwitcher } from "./LanguageSwitcher";
import { NeonButton } from "./NeonButton";
import { storeLinks } from "@/lib/constants/links";

/**
 * The download button in the header is the most prominent call to action on
 * every page, and it linked to the App Store for everyone — so an Android
 * visitor who tapped it landed on an Apple page they cannot install from.
 *
 * Static export means there is no server to read the user agent, so the store
 * is chosen after mount. The initial value stays the App Store: that is what
 * the button already did, so nothing regresses in the moment before hydration,
 * and only the case that was broken changes.
 */
const NAV_CAMPAIGN = "web-nav";

export function Navbar() {
  const t = useTranslations("nav");
  const pathname = usePathname();
  const [storeHref, setStoreHref] = useState(storeLinks(NAV_CAMPAIGN).ios);

  useEffect(() => {
    const links = storeLinks(NAV_CAMPAIGN);
    setStoreHref(/android/i.test(navigator.userAgent) ? links.android : links.ios);
  }, []);
  const locale = pathname.split("/")[1] || "tr";

  return (
    <header className="fixed top-0 left-0 right-0 z-50">
      <div
        className="border-b border-white/[0.06]"
        style={{
          background: "rgba(5,5,8,0.8)",
          backdropFilter: "blur(20px)",
          WebkitBackdropFilter: "blur(20px)",
        }}
      >
        <div className="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
          {/* Logo */}
          <a
            href={`/${locale}`}
            className="flex items-center"
            style={{ filter: "drop-shadow(0 0 12px rgba(187,134,252,0.5))" }}
          >
            <img
              src="/brand/qulo_splash.svg"
              alt="Qulo"
              height={32}
              width={80}
              style={{ objectFit: "contain" }}
            />
          </a>

          {/* Nav links */}
          <nav className="hidden sm:flex items-center gap-6">
            <Link
              href={`/${locale}/features`}
              className="text-sm text-qulo-text-secondary hover:text-white transition-colors"
            >
              {t("features")}
            </Link>
            <Link
              href={`/${locale}/advice`}
              className="text-sm text-qulo-text-secondary hover:text-white transition-colors"
            >
              {t("advice")}
            </Link>
            <Link
              href={`/${locale}/about`}
              className="text-sm text-qulo-text-secondary hover:text-white transition-colors"
            >
              {t("about")}
            </Link>
            <Link
              href={`/${locale}/blog`}
              className="text-sm text-qulo-text-secondary hover:text-white transition-colors"
            >
              {t("blog")}
            </Link>
            <Link
              href={`/${locale}/help`}
              className="text-sm text-qulo-text-secondary hover:text-white transition-colors"
            >
              {t("help")}
            </Link>
          </nav>

          {/* Right side */}
          <div className="flex items-center gap-4">
            <LanguageSwitcher />
            <NeonButton href={storeHref}>
              {t("download")}
            </NeonButton>
          </div>
        </div>
      </div>
    </header>
  );
}
