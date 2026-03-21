"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useTranslations } from "next-intl";
import { LanguageSwitcher } from "@/components/shared/LanguageSwitcher";
import { SOCIAL } from "@/lib/constants/links";

export function Footer() {
  const t = useTranslations("footer");
  const pathname = usePathname();
  const locale = pathname.split("/")[1] || "tr";

  return (
    <footer className="relative">
      {/* Top gradient border */}
      <div
        className="w-full h-px"
        style={{
          background:
            "linear-gradient(90deg, transparent 0%, rgba(187,134,252,0.5) 30%, rgba(105,240,174,0.5) 70%, transparent 100%)",
        }}
        aria-hidden="true"
      />

      <div
        className="py-10 px-6"
        style={{ background: "rgba(5,5,8,0.95)" }}
      >
        <div className="max-w-6xl mx-auto flex flex-col sm:flex-row items-start sm:items-center justify-between gap-8">
          {/* Left: logo + copyright */}
          <div>
            <p
              className="text-xl font-bold mb-1 tracking-tight"
              style={{
                color: "#BB86FC",
                textShadow: "0 0 30px rgba(187,134,252,0.4)",
              }}
            >
              Qulo
            </p>
            <p className="text-xs text-qulo-text-muted">{t("copyright")}</p>
          </div>

          {/* Right columns */}
          <div className="flex flex-wrap items-start gap-10">
            {/* Legal */}
            <div>
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-purple mb-3">
                {t("legal")}
              </p>
              <ul className="space-y-2">
                <li>
                  <Link
                    href={`/${locale}/privacy-policy`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("privacy")}
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/terms-of-service`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("terms")}
                  </Link>
                </li>
              </ul>
            </div>

            {/* Social */}
            <div>
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-green mb-3">
                {t("social")}
              </p>
              <ul className="space-y-2">
                <li>
                  <a
                    href={SOCIAL.instagram}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    Instagram
                  </a>
                </li>
                <li>
                  <a
                    href={SOCIAL.tiktok}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    TikTok
                  </a>
                </li>
              </ul>
            </div>

            {/* Language switcher */}
            <div>
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-text-muted mb-3">
                Language
              </p>
              <LanguageSwitcher />
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}
