"use client";

import { useTranslations } from "next-intl";
import { LanguageSwitcher } from "./LanguageSwitcher";
import { NeonButton } from "./NeonButton";
import { APP_STORE_URL } from "@/lib/constants/links";

export function Navbar() {
  const t = useTranslations("nav");

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
            href="/"
            className="text-xl font-bold tracking-tight"
            style={{
              animation: "glitchText 6s ease-in-out infinite",
              textShadow: "0 0 40px rgba(187,134,252,0.6)",
              color: "#BB86FC",
            }}
          >
            Qulo
          </a>

          {/* Right side */}
          <div className="flex items-center gap-4">
            <LanguageSwitcher />
            <NeonButton href={APP_STORE_URL !== "#" ? APP_STORE_URL : undefined}>
              {t("download")}
            </NeonButton>
          </div>
        </div>
      </div>
    </header>
  );
}
