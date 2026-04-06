"use client";

import { useState, useEffect } from "react";
import { useTranslations } from "next-intl";

type Status = "success" | "expired" | "error";

export default function EmailVerifiedPage() {
  const t = useTranslations("emailVerified");
  const [status, setStatus] = useState<Status>("error");

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const s = params.get("status");
    if (s === "success" || s === "expired" || s === "error") {
      setStatus(s);
    }
  }, []);

  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white px-6 py-12">
      {/* Logo */}
      <a
        href="/"
        className="text-3xl font-bold tracking-tight mb-10"
        style={{
          textShadow: "0 0 40px rgba(187,134,252,0.6)",
          color: "#BB86FC",
        }}
      >
        Qulo
      </a>

      <div className="w-full max-w-sm bg-qulo-bg-surface rounded-2xl border border-white/[0.08] p-8 shadow-xl">
        {/* SUCCESS STATE */}
        {status === "success" && (
          <div className="flex flex-col items-center text-center gap-4">
            <div className="w-16 h-16 rounded-full bg-green-500/10 border border-green-500/30 flex items-center justify-center">
              <svg
                className="w-8 h-8 text-green-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M5 13l4 4L19 7"
                />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-white">
              {t("successTitle")}
            </h1>
            <p className="text-sm text-qulo-text-secondary">
              {t("successDesc")}
            </p>
            <a
              href="qulo://"
              className="mt-4 inline-flex items-center justify-center px-6 py-2.5 rounded-xl font-semibold text-sm bg-gradient-to-r from-qulo-purple to-qulo-purple-dark text-white transition-all duration-200 hover:-translate-y-0.5 hover:shadow-[0_0_24px_rgba(187,134,252,0.5)]"
            >
              {t("openApp")}
            </a>
          </div>
        )}

        {/* EXPIRED STATE */}
        {status === "expired" && (
          <div className="flex flex-col items-center text-center gap-4">
            <div className="w-16 h-16 rounded-full bg-yellow-500/10 border border-yellow-500/30 flex items-center justify-center">
              <svg
                className="w-8 h-8 text-yellow-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-white">
              {t("expiredTitle")}
            </h1>
            <p className="text-sm text-qulo-text-secondary">
              {t("expiredDesc")}
            </p>
          </div>
        )}

        {/* ERROR STATE */}
        {status === "error" && (
          <div className="flex flex-col items-center text-center gap-4">
            <div className="w-16 h-16 rounded-full bg-red-500/10 border border-red-500/30 flex items-center justify-center">
              <svg
                className="w-8 h-8 text-red-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                strokeWidth={2}
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </div>
            <h1 className="text-xl font-bold text-white">
              {t("errorTitle")}
            </h1>
            <p className="text-sm text-qulo-text-secondary">
              {t("errorDesc")}
            </p>
          </div>
        )}
      </div>
    </main>
  );
}
