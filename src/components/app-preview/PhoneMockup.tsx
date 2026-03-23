"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";

const SCREENS = [
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

export function PhoneMockup() {
  const [active, setActive] = useState(0);
  const screen = SCREENS[active];

  return (
    <div className="flex flex-col items-center gap-5">
      {/* Phone frame */}
      <div
        className="relative"
        style={{
          width: 230,
          perspective: 900,
        }}
      >
        {/* Glow behind phone */}
        <div
          className="absolute inset-0 rounded-[40px] pointer-events-none"
          style={{
            background: `radial-gradient(ellipse at 50% 50%, ${screen.accentGlow} 0%, transparent 70%)`,
            filter: "blur(20px)",
            transform: "scale(1.3)",
            transition: "background 0.4s ease",
          }}
          aria-hidden="true"
        />

        <div
          style={{
            width: 230,
            height: 460,
            borderRadius: 40,
            background: "rgba(12,12,18,0.95)",
            border: "1.5px solid rgba(255,255,255,0.14)",
            boxShadow: `0 0 60px ${screen.accentGlow}, 0 24px 80px rgba(0,0,0,0.7)`,
            padding: "12px 10px 16px",
            transform: "rotateY(-10deg) rotateX(3deg)",
            transition: "box-shadow 0.4s ease",
            backdropFilter: "blur(20px)",
          }}
        >
          {/* Dynamic Island / Notch */}
          <div
            className="mx-auto mb-3"
            style={{
              width: 72,
              height: 10,
              borderRadius: 10,
              background: "rgba(0,0,0,0.9)",
              border: "1px solid rgba(255,255,255,0.08)",
            }}
          />

          {/* Screen content */}
          <AnimatePresence mode="wait">
            <motion.div
              key={active}
              initial={{ opacity: 0, y: 8 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -8 }}
              transition={{ duration: 0.3 }}
              className="rounded-2xl overflow-hidden p-3"
              style={{
                height: 390,
                background: screen.bg,
                border: "1px solid rgba(255,255,255,0.07)",
              }}
            >
              {/* Status bar */}
              <div className="flex justify-between items-center mb-3">
                <span className="text-[9px] font-semibold" style={{ color: screen.accentColor, opacity: 0.9 }}>
                  {screen.label}
                </span>
                <div className="flex gap-1 items-center">
                  <div className="w-5 h-1.5 rounded-full bg-white/20" />
                  <div className="w-1 h-1.5 rounded-full bg-white/20" />
                </div>
              </div>
              {screen.content}
            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      {/* Screen tabs */}
      <div className="flex gap-2">
        {SCREENS.map((s, i) => (
          <button
            key={s.label}
            onClick={() => setActive(i)}
            className="text-[10px] px-3 py-1.5 rounded-full font-semibold transition-all duration-200"
            style={
              i === active
                ? {
                    background: `${s.accentColor}22`,
                    color: s.accentColor,
                    border: `1px solid ${s.accentColor}55`,
                    boxShadow: `0 0 10px ${s.accentColor}22`,
                  }
                : {
                    background: "transparent",
                    color: "rgba(255,255,255,0.4)",
                    border: "1px solid rgba(255,255,255,0.1)",
                  }
            }
          >
            {s.label}
          </button>
        ))}
      </div>
    </div>
  );
}
