"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { detectPlatform } from "@/lib/utils/detect-platform";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";
import { NeonButton } from "@/components/shared/NeonButton";

export default function InvitePage() {
  const t = useTranslations("invite");
  const [code, setCode] = useState<string | null>(null);
  const [platform, setPlatform] = useState<ReturnType<typeof detectPlatform>>("desktop");

  useEffect(() => {
    const segments = window.location.pathname.split("/");
    const inviteIdx = segments.indexOf("invite");
    if (inviteIdx !== -1 && segments[inviteIdx + 1]) {
      setCode(segments[inviteIdx + 1]);
    }
    setPlatform(detectPlatform());
  }, []);

  useEffect(() => {
    if (!code) return;
    const storeUrl =
      platform === "ios"
        ? APP_STORE_URL
        : platform === "android"
          ? PLAY_STORE_URL
          : null;
    if (storeUrl) {
      const timer = setTimeout(() => {
        window.location.href = storeUrl;
      }, 3000);
      return () => clearTimeout(timer);
    }
  }, [code, platform]);

  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white px-6">
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

      <h1 className="text-4xl font-bold text-qulo-purple mb-4 text-center">
        {t("title")}
      </h1>

      <p className="text-qulo-text-secondary mb-6 text-center max-w-sm">
        {t("desc")}
      </p>

      {code && (
        <div className="mb-6 px-6 py-3 rounded-xl border border-qulo-green/30 bg-qulo-green/5">
          <p className="text-qulo-text-secondary text-sm text-center">
            {t("code")}
          </p>
          <p className="text-qulo-green font-mono text-2xl font-bold text-center tracking-widest mt-1">
            {code}
          </p>
        </div>
      )}

      {platform !== "desktop" && (
        <p className="text-qulo-text-muted mb-8 animate-pulse text-sm">
          {t("redirecting")}
        </p>
      )}

      {platform === "desktop" && (
        <p className="text-qulo-text-secondary mb-8 text-center">
          {t("downloadPrompt")}
        </p>
      )}

      <div className="flex gap-4 flex-wrap justify-center">
        <NeonButton href={APP_STORE_URL} disabled={false}>
          App Store
        </NeonButton>
        <NeonButton href={PLAY_STORE_URL} disabled={false}>
          Google Play
        </NeonButton>
      </div>
    </main>
  );
}
