"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";

interface ShareRowProps {
  /** Full message including the link — WhatsApp and X get it verbatim. */
  text: string;
  /** Bare link for the copy button. */
  url: string;
}

/**
 * WhatsApp first: TÜİK 2026 puts it on 90% of Turkish internet users and Branch
 * measured 90%+ of app-invite traffic on WhatsApp/SMS. X second, copy for the rest.
 */
export function ShareRow({ text, url }: ShareRowProps) {
  const t = useTranslations("quiz");
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (!copied) return;
    const timer = setTimeout(() => setCopied(false), 2500);
    return () => clearTimeout(timer);
  }, [copied]);

  async function copy() {
    try {
      await navigator.clipboard.writeText(url);
      setCopied(true);
    } catch {
      // Clipboard unavailable — the link is also shown as selectable text by the caller.
    }
  }

  const encoded = encodeURIComponent(text);

  return (
    <div className="flex flex-col gap-2">
      <a
        href={`https://wa.me/?text=${encoded}`}
        target="_blank"
        rel="noopener noreferrer"
        className="inline-flex items-center justify-center rounded-xl bg-[#25D366] px-5 py-2.5 text-sm font-semibold text-black hover:brightness-110"
      >
        {t("whatsapp")}
      </a>
      <div className="flex gap-2">
        <a
          href={`https://twitter.com/intent/tweet?text=${encoded}`}
          target="_blank"
          rel="noopener noreferrer"
          className="flex-1 inline-flex items-center justify-center rounded-xl border border-white/15 px-4 py-2.5 text-sm font-semibold hover:bg-white/5"
        >
          {t("shareX")}
        </a>
        <button
          type="button"
          onClick={copy}
          className="flex-1 rounded-xl border border-qulo-green/40 px-4 py-2.5 text-sm font-semibold text-qulo-green hover:bg-qulo-green/10"
        >
          {copied ? t("copied") : t("copyLink")}
        </button>
      </div>
    </div>
  );
}
