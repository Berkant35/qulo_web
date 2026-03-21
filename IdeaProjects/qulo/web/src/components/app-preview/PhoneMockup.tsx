"use client";

import { useState } from "react";

const SCREENS = [
  {
    label: "Discover",
    bg: "linear-gradient(135deg, rgba(187,134,252,0.2) 0%, rgba(187,134,252,0.05) 100%)",
    content: (
      <>
        <div className="w-full h-3 rounded bg-white/10 mb-2" />
        <div className="w-3/4 h-3 rounded bg-white/[0.06] mb-4" />
        <div className="w-full rounded-xl" style={{ height: 100, background: "rgba(187,134,252,0.12)", border: "1px solid rgba(187,134,252,0.2)" }} />
        <div className="flex gap-2 mt-3">
          <div className="flex-1 h-7 rounded-lg" style={{ background: "rgba(187,134,252,0.15)" }} />
          <div className="flex-1 h-7 rounded-lg" style={{ background: "rgba(105,240,174,0.12)" }} />
        </div>
      </>
    ),
  },
  {
    label: "Question",
    bg: "linear-gradient(135deg, rgba(105,240,174,0.15) 0%, rgba(105,240,174,0.03) 100%)",
    content: (
      <>
        <div className="text-center mb-3">
          <div className="text-2xl mb-1">💬</div>
          <div className="w-full h-3 rounded bg-white/10 mb-1" />
          <div className="w-2/3 mx-auto h-3 rounded bg-white/[0.06]" />
        </div>
        {["A", "B", "C", "D"].map((opt) => (
          <div key={opt} className="flex items-center gap-2 mb-1.5">
            <div className="w-5 h-5 rounded-full flex-shrink-0" style={{ background: "rgba(105,240,174,0.15)", border: "1px solid rgba(105,240,174,0.25)" }} />
            <div className="flex-1 h-3 rounded bg-white/[0.06]" />
          </div>
        ))}
      </>
    ),
  },
  {
    label: "Match",
    bg: "linear-gradient(135deg, rgba(187,134,252,0.15) 0%, rgba(105,240,174,0.08) 100%)",
    content: (
      <>
        <div className="flex justify-center gap-4 mb-3 pt-2">
          <div className="w-12 h-12 rounded-full" style={{ background: "rgba(187,134,252,0.2)", border: "1px solid rgba(187,134,252,0.3)" }} />
          <div className="self-center text-xl">💚</div>
          <div className="w-12 h-12 rounded-full" style={{ background: "rgba(105,240,174,0.2)", border: "1px solid rgba(105,240,174,0.3)" }} />
        </div>
        <div className="w-3/4 mx-auto h-3 rounded bg-white/10 mb-2" />
        <div className="w-1/2 mx-auto h-3 rounded bg-white/[0.06] mb-4" />
        <div className="w-full h-8 rounded-xl" style={{ background: "rgba(187,134,252,0.2)", border: "1px solid rgba(187,134,252,0.3)" }} />
      </>
    ),
  },
];

export function PhoneMockup() {
  const [active, setActive] = useState(0);

  return (
    <div className="flex flex-col items-center gap-4">
      {/* Phone frame */}
      <div
        className="relative"
        style={{
          width: 220,
          perspective: 800,
        }}
      >
        <div
          style={{
            width: 220,
            height: 440,
            borderRadius: 36,
            background: "rgba(255,255,255,0.04)",
            border: "1.5px solid rgba(255,255,255,0.12)",
            boxShadow: "0 0 60px rgba(187,134,252,0.12), 0 24px 64px rgba(0,0,0,0.6)",
            padding: "12px 10px",
            transform: "rotateY(-10deg) rotateX(3deg)",
            transition: "transform 0.6s ease",
            backdropFilter: "blur(20px)",
          }}
        >
          {/* Notch */}
          <div
            className="mx-auto mb-3"
            style={{
              width: 80,
              height: 10,
              borderRadius: 10,
              background: "rgba(255,255,255,0.08)",
            }}
          />

          {/* Screen content */}
          <div
            className="rounded-2xl overflow-hidden p-3"
            style={{
              height: 370,
              background: SCREENS[active].bg,
              border: "1px solid rgba(255,255,255,0.06)",
              transition: "background 0.4s ease",
            }}
          >
            {/* Status bar */}
            <div className="flex justify-between items-center mb-3">
              <span className="text-[9px] text-white/40">{SCREENS[active].label}</span>
              <div className="flex gap-1">
                <div className="w-6 h-1.5 rounded bg-white/20" />
                <div className="w-1 h-1.5 rounded bg-white/20" />
              </div>
            </div>
            {SCREENS[active].content}
          </div>
        </div>
      </div>

      {/* Screen tabs */}
      <div className="flex gap-2">
        {SCREENS.map((s, i) => (
          <button
            key={s.label}
            onClick={() => setActive(i)}
            className="text-[10px] px-3 py-1 rounded-full font-medium transition-all duration-200"
            style={
              i === active
                ? { background: "rgba(187,134,252,0.2)", color: "#BB86FC", border: "1px solid rgba(187,134,252,0.4)" }
                : { background: "transparent", color: "rgba(255,255,255,0.35)", border: "1px solid rgba(255,255,255,0.08)" }
            }
          >
            {s.label}
          </button>
        ))}
      </div>
    </div>
  );
}
