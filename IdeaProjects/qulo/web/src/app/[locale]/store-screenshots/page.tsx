"use client";

import { useState, useRef, useCallback } from "react";
import { toPng } from "html-to-image";
import texts from "@/data/store-screenshot-texts.json";

// ─── Constants ────────────────────────────────────────────
const SCREENS = ["discover", "question-create", "chat", "profile", "match"] as const;
type Screen = (typeof SCREENS)[number];

const SCREEN_LABELS: Record<Screen, string> = {
  discover: "Discover",
  "question-create": "Question Create",
  chat: "Chat",
  profile: "Profile",
  match: "Match",
};

const LOCALES = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
] as const;
type Locale = (typeof LOCALES)[number];

const RTL_LOCALES = new Set<string>(["ar"]);

const IPHONE_W = 1320;
const IPHONE_H = 2868;

const SIZES = [
  { label: 'iPhone 6.7"', w: 1320, h: 2868 },
  { label: 'iPhone 6.5"', w: 1284, h: 2778 },
  { label: 'iPhone 5.5"', w: 1242, h: 2208 },
  { label: 'iPad 12.9" (6th)', w: 2064, h: 2752 },
  { label: 'iPad 12.9" (3rd)', w: 2048, h: 2732 },
  { label: "Google Play", w: 1080, h: 1920 },
] as const;

// Phone mockup measurements
const MK_W = 1022;
const MK_H = 2082;
const SC_L = (52 / MK_W) * 100;
const SC_T = (46 / MK_H) * 100;
const SC_W = (918 / MK_W) * 100;
const SC_H = (1990 / MK_H) * 100;
const SC_RX = (126 / 918) * 100;
const SC_RY = (126 / 1990) * 100;

// ─── Phone Component ─────────────────────────────────────
function Phone({ src, alt, style, className = "" }: {
  src: string; alt: string; style?: React.CSSProperties; className?: string;
}) {
  return (
    <div className={`relative ${className}`}
      style={{ aspectRatio: `${MK_W}/${MK_H}`, ...style }}>
      <img src="/mockup.png" alt=""
        className="block w-full h-full" draggable={false} />
      <div className="absolute z-10 overflow-hidden"
        style={{
          left: `${SC_L}%`, top: `${SC_T}%`,
          width: `${SC_W}%`, height: `${SC_H}%`,
          borderRadius: `${SC_RX}% / ${SC_RY}%`,
        }}>
        <img src={src} alt={alt}
          className="block w-full h-full object-cover object-top"
          draggable={false} />
      </div>
    </div>
  );
}

// ─── Screenshot Canvas ───────────────────────────────────
function ScreenshotCanvas({
  screen, locale, canvasRef, isExport = false,
}: {
  screen: Screen; locale: Locale;
  canvasRef?: React.Ref<HTMLDivElement>; isExport?: boolean;
}) {
  const t = (texts as any)[screen]?.[locale] ?? (texts as any)[screen]?.["en"];
  const isRtl = RTL_LOCALES.has(locale);
  const W = IPHONE_W;
  const H = IPHONE_H;

  return (
    <div
      ref={canvasRef}
      dir={isRtl ? "rtl" : "ltr"}
      style={{
        width: W,
        height: H,
        background: "#050508",
        position: isExport ? "absolute" : "relative",
        left: isExport ? -9999 : undefined,
        overflow: "hidden",
        fontFamily: "var(--font-inter), system-ui, sans-serif",
      }}
    >
      {/* Light Streak */}
      <div style={{
        position: "absolute",
        top: "20%",
        left: isRtl ? undefined : "-20%",
        right: isRtl ? "-20%" : undefined,
        width: "140%",
        height: 3,
        background: "linear-gradient(90deg, transparent 0%, rgba(102,126,234,0.5) 30%, rgba(118,75,162,0.5) 70%, transparent 100%)",
        transform: `rotate(${isRtl ? "35deg" : "-35deg"})`,
        filter: "blur(1px)",
      }} />
      <div style={{
        position: "absolute",
        top: "22%",
        left: isRtl ? undefined : "-20%",
        right: isRtl ? "-20%" : undefined,
        width: "140%",
        height: 60,
        background: "linear-gradient(90deg, transparent 0%, rgba(102,126,234,0.04) 30%, rgba(118,75,162,0.04) 70%, transparent 100%)",
        transform: `rotate(${isRtl ? "35deg" : "-35deg"})`,
        filter: "blur(25px)",
      }} />

      {/* Phone — centered, slightly below middle */}
      <div style={{
        position: "absolute",
        bottom: 0,
        left: "50%",
        transform: "translateX(-50%) translateY(12%)",
        width: "82%",
        zIndex: 1,
      }}>
        <Phone
          src={`/store-screenshots/${screen}.png`}
          alt={screen}
        />
      </div>

      {/* Title + Subtitle — top area */}
      <div style={{
        position: "absolute",
        top: W * 0.12,
        left: 0,
        right: 0,
        textAlign: "center",
        padding: `0 ${W * 0.08}px`,
        zIndex: 2,
      }}>
        <h2 style={{
          fontSize: W * 0.09,
          fontWeight: 700,
          color: "#FFFFFF",
          lineHeight: 1.05,
          letterSpacing: -0.5,
          margin: 0,
          whiteSpace: "pre-line",
        }}>
          {t.title}
        </h2>
        <p style={{
          fontSize: W * 0.032,
          fontWeight: 300,
          color: "rgba(255,255,255,0.4)",
          letterSpacing: 0.5,
          marginTop: W * 0.025,
        }}>
          {t.subtitle}
        </p>
      </div>
    </div>
  );
}

// ─── Main Page ───────────────────────────────────────────
export default function StoreScreenshotsPage() {
  const [locale, setLocale] = useState<Locale>("en");
  const [screen, setScreen] = useState<Screen>("discover");
  const [sizeIdx, setSizeIdx] = useState(0);
  const [exporting, setExporting] = useState(false);
  const exportRef = useRef<HTMLDivElement>(null);

  const selectedSize = SIZES[sizeIdx];

  // Preview scale — fit 1320x2868 into ~360px wide preview
  const previewScale = 360 / IPHONE_W;

  const exportSingle = useCallback(async () => {
    if (!exportRef.current || exporting) return;
    setExporting(true);
    try {
      const el = exportRef.current;
      el.style.left = "0px";
      el.style.opacity = "1";
      el.style.zIndex = "-1";

      const opts = { width: IPHONE_W, height: IPHONE_H, pixelRatio: 1, cacheBust: true };

      // Double-call trick for font rendering
      await toPng(el, opts);
      const dataUrl = await toPng(el, opts);

      el.style.left = "-9999px";
      el.style.opacity = "";
      el.style.zIndex = "";

      // Resize to target size if different
      const { w, h } = selectedSize;
      if (w === IPHONE_W && h === IPHONE_H) {
        const link = document.createElement("a");
        link.download = `${screen}-${locale}-${w}x${h}.png`;
        link.href = dataUrl;
        link.click();
      } else {
        const img = new Image();
        img.onload = () => {
          const canvas = document.createElement("canvas");
          canvas.width = w;
          canvas.height = h;
          const ctx = canvas.getContext("2d")!;
          ctx.drawImage(img, 0, 0, w, h);
          const link = document.createElement("a");
          link.download = `${screen}-${locale}-${w}x${h}.png`;
          link.href = canvas.toDataURL("image/png");
          link.click();
        };
        img.src = dataUrl;
      }
    } finally {
      setExporting(false);
    }
  }, [screen, locale, selectedSize, exporting]);

  return (
    <div className="min-h-screen bg-qulo-bg text-white p-8">
      <h1 className="text-2xl font-bold mb-6">Store Screenshot Generator</h1>

      {/* Controls */}
      <div className="flex flex-wrap gap-4 mb-8">
        {/* Locale selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Language</label>
          <select
            value={locale}
            onChange={(e) => setLocale(e.target.value as Locale)}
            className="bg-qulo-bg-card border border-white/10 rounded px-3 py-2 text-sm"
          >
            {LOCALES.map((l) => (
              <option key={l} value={l}>{l.toUpperCase()}</option>
            ))}
          </select>
        </div>

        {/* Screen selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Screen</label>
          <div className="flex gap-1">
            {SCREENS.map((s) => (
              <button
                key={s}
                onClick={() => setScreen(s)}
                className={`px-3 py-2 text-sm rounded transition-colors ${
                  screen === s
                    ? "bg-qulo-purple text-white"
                    : "bg-qulo-bg-card text-qulo-text-secondary hover:bg-qulo-bg-surface"
                }`}
              >
                {SCREEN_LABELS[s]}
              </button>
            ))}
          </div>
        </div>

        {/* Size selector */}
        <div>
          <label className="text-xs text-qulo-text-muted block mb-1">Export Size</label>
          <select
            value={sizeIdx}
            onChange={(e) => setSizeIdx(Number(e.target.value))}
            className="bg-qulo-bg-card border border-white/10 rounded px-3 py-2 text-sm"
          >
            {SIZES.map((s, i) => (
              <option key={i} value={i}>{s.label} ({s.w}×{s.h})</option>
            ))}
          </select>
        </div>

        {/* Export button */}
        <div className="flex items-end">
          <button
            onClick={exportSingle}
            disabled={exporting}
            className="px-6 py-2 bg-qulo-purple hover:bg-qulo-purple-dark rounded text-sm font-medium transition-colors disabled:opacity-50"
          >
            {exporting ? "Exporting..." : "Export PNG"}
          </button>
        </div>
      </div>

      {/* Preview */}
      <div className="border border-white/10 rounded-xl p-4 inline-block bg-qulo-bg-card">
        <div style={{
          width: IPHONE_W * previewScale,
          height: IPHONE_H * previewScale,
          overflow: "hidden",
        }}>
          <div style={{
            transform: `scale(${previewScale})`,
            transformOrigin: "top left",
          }}>
            <ScreenshotCanvas screen={screen} locale={locale} />
          </div>
        </div>
      </div>

      {/* Offscreen export container */}
      <ScreenshotCanvas
        screen={screen}
        locale={locale}
        canvasRef={exportRef}
        isExport
      />
    </div>
  );
}
