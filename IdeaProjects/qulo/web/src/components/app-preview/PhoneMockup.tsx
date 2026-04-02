"use client";

import { useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { SCREENS } from "./screens.config";

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
