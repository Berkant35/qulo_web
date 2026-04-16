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
        className="py-16 px-6"
        style={{ background: "rgba(5,5,8,0.97)" }}
      >
        <div className="max-w-6xl mx-auto flex flex-col sm:flex-row items-start sm:items-center justify-between gap-8">
          {/* Left: logo + copyright */}
          <div>
            <div className="flex items-center gap-2 mb-2">
              <img src="/brand/purple_diamond.svg" alt="Qulo" width={20} height={20} style={{ filter: "drop-shadow(0 0 8px rgba(187,134,252,0.6))" }} />
              <p
                className="text-xl font-bold tracking-tight"
                style={{
                  color: "#BB86FC",
                  textShadow: "0 0 30px rgba(187,134,252,0.5)",
                }}
              >
                Qulo
              </p>
            </div>
            <p className="text-xs text-gray-600">{t("copyright")}</p>
            {/* Made with heart */}
            <div className="flex items-center gap-1 mt-2">
              <p className="text-[10px] text-gray-700">{t("madeWith")}</p>
              <svg width="10" height="9" viewBox="0 0 10 9" fill="none" style={{ flexShrink: 0 }}>
                <path d="M5 8L0.9 3.7C0.3 3.1 0.3 2.1 0.9 1.5C1.5 0.9 2.5 0.9 3.1 1.5L5 3.4L6.9 1.5C7.5 0.9 8.5 0.9 9.1 1.5C9.7 2.1 9.7 3.1 9.1 3.7L5 8Z" fill="rgba(187,134,252,0.5)" />
              </svg>
              <p className="text-[10px] text-gray-700">{t("inCity")}</p>
            </div>
          </div>

          {/* Right columns */}
          <div className="flex flex-wrap items-start gap-10">
            {/* Company */}
            <div>
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-green mb-3">
                {t("company")}
              </p>
              <ul className="space-y-2">
                <li>
                  <Link
                    href={`/${locale}/about`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("about")}
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/blog`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("blog")}
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/help`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("help")}
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/compare`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("compare")}
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/glossary`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    {t("glossary")}
                  </Link>
                </li>
              </ul>
            </div>

            {/* Cities */}
            <div>
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-qulo-purple mb-3">
                {t("cities")}
              </p>
              <ul className="space-y-2">
                <li>
                  <Link
                    href={`/${locale}/dating/istanbul`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    Istanbul
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/dating/london`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    London
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/dating/new-york`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    New York
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/dating/paris`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    Paris
                  </Link>
                </li>
                <li>
                  <Link
                    href={`/${locale}/dating/tokyo`}
                    className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
                  >
                    Tokyo
                  </Link>
                </li>
              </ul>
            </div>

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
                    href={`/${locale}/terms`}
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
              <p className="text-[10px] font-semibold uppercase tracking-[0.15em] text-gray-600 mb-3">
                {t("language")}
              </p>
              <LanguageSwitcher />
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}
