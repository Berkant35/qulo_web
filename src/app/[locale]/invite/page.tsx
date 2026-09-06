"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { detectPlatform, type Platform } from "@/lib/utils/detect-platform";
import { storeLinks, STORE_REDIRECT } from "@/lib/constants/links";
import { REFERRAL_REWARD_PURPLE } from "@/lib/constants/referral";
import { NeonButton } from "@/components/shared/NeonButton";

/**
 * Referral landing — `quloapp.com/invite/<code>`.
 *
 * WHY THE PAGE LOOKS LIKE THIS: the app cannot yet read the code back after a
 * fresh install (no Install Referrer / deferred deep link on either platform),
 * so the invitee has to type it in after signing up. Everything here serves
 * that one hand-off: the code is large, one tap copies it, the steps say where
 * it goes, and nothing auto-redirects away before the visitor has seen it —
 * the previous 3-second store redirect sent people off with the code unread.
 *
 * The store links carry the code in the Play referrer (`utm_content`), so Play
 * Console already separates referral installs, and the app can pick the code
 * up automatically once it integrates the Install Referrer API — no change
 * needed on this page at that point.
 */
const CODE_PATTERN = /^[a-zA-Z0-9_-]{1,64}$/;

export default function InvitePage() {
  const t = useTranslations("invite");
  const [code, setCode] = useState<string | null>(null);
  const [platform, setPlatform] = useState<Platform>("desktop");
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    const segments = window.location.pathname.split("/");
    const inviteIdx = segments.indexOf("invite");
    const raw = inviteIdx !== -1 ? segments[inviteIdx + 1] : "";
    if (raw && CODE_PATTERN.test(raw)) setCode(raw.toUpperCase());
    setPlatform(detectPlatform());
  }, []);

  useEffect(() => {
    if (!copied) return;
    const timer = setTimeout(() => setCopied(false), 2500);
    return () => clearTimeout(timer);
  }, [copied]);

  async function copyCode() {
    if (!code) return;
    try {
      await navigator.clipboard.writeText(code);
      setCopied(true);
    } catch {
      // Clipboard API unavailable (old browser / insecure context): the code is
      // still selectable text, so the visitor can copy it by hand.
    }
  }

  const links = storeLinks("referral", code ?? undefined);

  return (
    <main className="min-h-screen flex flex-col items-center justify-center bg-qulo-bg text-white px-6 py-12">
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

      <p className="text-qulo-text-secondary mb-2 text-center max-w-sm">
        {t("desc")}
      </p>
      <p className="text-qulo-green mb-6 text-center max-w-sm font-medium">
        {t("reward", { reward: REFERRAL_REWARD_PURPLE })}
      </p>

      {code && (
        <div className="mb-4 w-full max-w-sm rounded-xl border border-qulo-green/30 bg-qulo-green/5 px-6 py-4">
          <p className="text-qulo-text-secondary text-sm text-center">
            {t("code")}
          </p>
          <p
            className="text-qulo-green font-mono text-3xl font-bold text-center tracking-widest mt-1 select-all"
            aria-live="polite"
          >
            {code}
          </p>
          <button
            type="button"
            onClick={copyCode}
            className="mt-3 w-full rounded-lg border border-qulo-green/40 py-2 text-sm font-semibold text-qulo-green transition-colors hover:bg-qulo-green/10"
          >
            {copied ? t("copied") : t("copy")}
          </button>
        </div>
      )}

      <p className="text-qulo-text-muted mb-8 text-center text-sm max-w-sm">
        {t("howTo")}
      </p>

      {platform === "desktop" ? (
        <>
          <p className="text-qulo-text-secondary mb-4 text-center">
            {t("downloadPrompt")}
          </p>
          <div className="flex gap-4 flex-wrap justify-center">
            <NeonButton href={links.ios}>App Store</NeonButton>
            <NeonButton href={links.android}>Google Play</NeonButton>
          </div>
        </>
      ) : (
        <NeonButton href={STORE_REDIRECT("referral", code ?? undefined)} className="px-10 py-3 text-base">
          {t("download")}
        </NeonButton>
      )}
    </main>
  );
}
