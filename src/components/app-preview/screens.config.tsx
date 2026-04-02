import { type ReactNode } from "react";
import { motion } from "framer-motion";

export interface ScreenConfig {
  label: string;
  accentColor: string;
  accentGlow: string;
  bg: string;
  content: ReactNode;
}

export const SCREENS: ScreenConfig[] = [
  {
    label: "Discover",
    accentColor: "#BB86FC",
    accentGlow: "rgba(187,134,252,0.25)",
    bg: "linear-gradient(160deg, rgba(187,134,252,0.15) 0%, rgba(13,13,20,0.95) 60%)",
    content: (
      <div className="flex flex-col gap-2 h-full">
        {/* Header */}
        <div className="flex items-center justify-between mb-1">
          <div>
            <div className="h-2 w-16 rounded bg-white/20 mb-1" />
            <div className="h-1.5 w-10 rounded bg-white/10" />
          </div>
          <div className="w-7 h-7 rounded-full flex items-center justify-center" style={{ background: "rgba(187,134,252,0.2)", border: "1px solid rgba(187,134,252,0.3)" }}>
            <div className="w-3 h-3 rounded-full" style={{ background: "rgba(187,134,252,0.6)" }} />
          </div>
        </div>

        {/* Profile card */}
        <div className="rounded-xl flex-1 relative overflow-hidden" style={{ background: "rgba(187,134,252,0.1)", border: "1px solid rgba(187,134,252,0.2)" }}>
          {/* Profile silhouette */}
          <div className="absolute inset-0 flex items-center justify-center opacity-20">
            <svg width="60" height="80" viewBox="0 0 60 80" fill="none">
              <circle cx="30" cy="22" r="16" fill="#BB86FC" />
              <path d="M5 70 Q5 48 30 48 Q55 48 55 70" fill="#BB86FC" />
            </svg>
          </div>
          {/* Gradient overlay at bottom */}
          <div className="absolute bottom-0 left-0 right-0 h-16 rounded-b-xl" style={{ background: "linear-gradient(0deg, rgba(187,134,252,0.2), transparent)" }} />
          {/* Name tag */}
          <div className="absolute bottom-2 left-2 right-2">
            <div className="h-2 w-14 rounded bg-white/30 mb-1" />
            <div className="h-1.5 w-10 rounded bg-white/15" />
          </div>
        </div>

        {/* Action buttons */}
        <div className="flex gap-2 mt-1">
          <div className="flex-1 h-8 rounded-lg flex items-center justify-center" style={{ background: "rgba(255,255,255,0.06)", border: "1px solid rgba(255,255,255,0.1)" }}>
            <div className="h-1.5 w-3 rounded bg-white/30" />
          </div>
          <div className="flex-1 h-8 rounded-lg flex items-center justify-center" style={{ background: "rgba(187,134,252,0.2)", border: "1px solid rgba(187,134,252,0.35)" }}>
            <div className="h-1.5 w-6 rounded" style={{ background: "rgba(187,134,252,0.8)" }} />
          </div>
        </div>
      </div>
    ),
  },
  {
    label: "Question",
    accentColor: "#69F0AE",
    accentGlow: "rgba(105,240,174,0.25)",
    bg: "linear-gradient(160deg, rgba(105,240,174,0.12) 0%, rgba(13,13,20,0.95) 60%)",
    content: (
      <div className="flex flex-col gap-2 h-full">
        {/* Top label */}
        <div className="flex items-center gap-1.5 mb-1">
          <div className="w-1.5 h-1.5 rounded-full animate-pulse" style={{ background: "#69F0AE" }} />
          <div className="h-1.5 w-8 rounded" style={{ background: "rgba(105,240,174,0.5)" }} />
        </div>

        {/* Question card */}
        <div className="rounded-xl p-3 flex-1" style={{ background: "rgba(105,240,174,0.08)", border: "1px solid rgba(105,240,174,0.2)" }}>
          {/* Question text lines */}
          <div className="h-2 w-full rounded bg-white/20 mb-1.5" />
          <div className="h-2 w-4/5 rounded bg-white/15 mb-4" />

          {/* Options */}
          {["A", "B", "C"].map((opt, i) => (
            <div key={opt} className="flex items-center gap-2 mb-2">
              <div
                className="w-5 h-5 rounded-full flex-shrink-0 flex items-center justify-center text-[8px] font-bold"
                style={{
                  background: i === 0 ? "rgba(105,240,174,0.25)" : "rgba(255,255,255,0.05)",
                  border: `1px solid ${i === 0 ? "rgba(105,240,174,0.5)" : "rgba(255,255,255,0.1)"}`,
                  color: i === 0 ? "#69F0AE" : "rgba(255,255,255,0.4)",
                }}
              >
                {opt}
              </div>
              <div className="flex-1 h-1.5 rounded" style={{ background: i === 0 ? "rgba(105,240,174,0.3)" : "rgba(255,255,255,0.08)", width: `${[90, 70, 55][i]}%` }} />
            </div>
          ))}
        </div>

        {/* Submit button */}
        <div className="h-8 rounded-lg flex items-center justify-center" style={{ background: "linear-gradient(135deg, rgba(105,240,174,0.3), rgba(105,240,174,0.15))", border: "1px solid rgba(105,240,174,0.4)" }}>
          <div className="h-1.5 w-12 rounded" style={{ background: "rgba(105,240,174,0.7)" }} />
        </div>
      </div>
    ),
  },
  {
    label: "Match",
    accentColor: "#BB86FC",
    accentGlow: "rgba(187,134,252,0.25)",
    bg: "linear-gradient(160deg, rgba(187,134,252,0.12) 0%, rgba(105,240,174,0.06) 100%)",
    content: (
      <div className="flex flex-col items-center gap-2 h-full">
        {/* Match label */}
        <div className="h-1.5 w-16 rounded mb-1" style={{ background: "rgba(187,134,252,0.5)" }} />

        {/* Profile bubbles + heart */}
        <div className="flex items-center justify-center gap-3 py-2">
          <div className="w-14 h-14 rounded-full relative overflow-hidden" style={{ background: "rgba(187,134,252,0.2)", border: "2px solid rgba(187,134,252,0.4)", boxShadow: "0 0 16px rgba(187,134,252,0.3)" }}>
            <div className="absolute inset-0 flex items-center justify-center opacity-30">
              <svg width="28" height="36" viewBox="0 0 28 36" fill="none">
                <circle cx="14" cy="10" r="7" fill="#BB86FC" />
                <path d="M2 32 Q2 22 14 22 Q26 22 26 32" fill="#BB86FC" />
              </svg>
            </div>
          </div>

          {/* Heart */}
          <motion.div
            animate={{ scale: [1, 1.3, 1] }}
            transition={{ duration: 1.2, repeat: Infinity, ease: "easeInOut" }}
          >
            <svg width="22" height="20" viewBox="0 0 22 20" fill="none">
              <path d="M11 18L2.4 9.2C0.9 7.7 0.9 5.2 2.4 3.7C3.9 2.2 6.4 2.2 7.9 3.7L11 6.8L14.1 3.7C15.6 2.2 18.1 2.2 19.6 3.7C21.1 5.2 21.1 7.7 19.6 9.2L11 18Z" fill="#BB86FC" />
            </svg>
          </motion.div>

          <div className="w-14 h-14 rounded-full relative overflow-hidden" style={{ background: "rgba(105,240,174,0.2)", border: "2px solid rgba(105,240,174,0.4)", boxShadow: "0 0 16px rgba(105,240,174,0.3)" }}>
            <div className="absolute inset-0 flex items-center justify-center opacity-30">
              <svg width="28" height="36" viewBox="0 0 28 36" fill="none">
                <circle cx="14" cy="10" r="7" fill="#69F0AE" />
                <path d="M2 32 Q2 22 14 22 Q26 22 26 32" fill="#69F0AE" />
              </svg>
            </div>
          </div>
        </div>

        {/* Match text */}
        <div className="text-center">
          <div className="h-2 w-20 mx-auto rounded mb-1.5 bg-white/20" />
          <div className="h-1.5 w-14 mx-auto rounded bg-white/10" />
        </div>

        {/* Confetti dots */}
        <div className="flex gap-2 justify-center opacity-60">
          {["#BB86FC", "#69F0AE", "#BB86FC", "#69F0AE", "#BB86FC"].map((c, i) => (
            <div key={i} className="w-1.5 h-1.5 rounded-full" style={{ background: c }} />
          ))}
        </div>

        {/* CTA Button */}
        <div
          className="w-full h-8 rounded-lg flex items-center justify-center mt-auto"
          style={{ background: "linear-gradient(135deg, rgba(187,134,252,0.3), rgba(105,240,174,0.15))", border: "1px solid rgba(187,134,252,0.4)" }}
        >
          <div className="h-1.5 w-16 rounded bg-white/40" />
        </div>
      </div>
    ),
  },
];
