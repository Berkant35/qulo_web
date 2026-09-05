"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";
import { LanguageSwitcher } from "./LanguageSwitcher";
import { NeonButton } from "./NeonButton";
import { STORE_REDIRECT } from "@/lib/constants/links";

export function Navbar() {
  const t = useTranslations("nav");
  const pathname = usePathname();

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
            {/* The only store link above the fold, so it must be right in the
                first paint: /go/app reads the User-Agent at the edge. Choosing
                the store in the browser left Android users pointed at the App
                Store until hydration finished — seconds, on mobile. */}
            <NeonButton href={STORE_REDIRECT("web-nav")}>
              {t("download")}
            </NeonButton>
          </div>
        </div>
      </div>
    </header>
  );
}
