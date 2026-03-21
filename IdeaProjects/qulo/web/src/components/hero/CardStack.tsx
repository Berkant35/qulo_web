export function CardStack() {
  return (
    <div className="relative w-full max-w-sm mx-auto" style={{ height: "420px" }}>
      {/* Pulse rings behind cards */}
      <div
        className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-48 h-48 rounded-full border border-qulo-purple/20 animate-pulse-ring"
        style={{ animationDelay: "0s" }}
        aria-hidden="true"
      />
      <div
        className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-48 h-48 rounded-full border border-qulo-purple/10 animate-pulse-ring"
        style={{ animationDelay: "2s" }}
        aria-hidden="true"
      />

      {/* Back card — z-10, opacity-25 */}
      <div
        className="absolute left-6 right-0 top-10 z-10 animate-float-slow"
        style={{ opacity: 0.25 }}
        aria-hidden="true"
      >
        <div
          className="rounded-2xl p-5"
          style={{
            background: "rgba(255,255,255,0.03)",
            border: "1px solid rgba(255,255,255,0.06)",
            backdropFilter: "blur(12px)",
          }}
        >
          <div
            className="h-3 rounded-full mb-3"
            style={{ background: "linear-gradient(90deg, rgba(187,134,252,0.3), rgba(105,240,174,0.3))", width: "70%" }}
          />
          <div className="space-y-2">
            <div className="h-2 rounded" style={{ background: "rgba(255,255,255,0.08)", width: "90%" }} />
            <div className="h-2 rounded" style={{ background: "rgba(255,255,255,0.06)", width: "60%" }} />
          </div>
        </div>
      </div>

      {/* Middle card — z-20, opacity-55 */}
      <div
        className="absolute left-4 right-4 top-20 z-20 animate-float-slow"
        style={{ opacity: 0.55, animationDelay: "-2s" }}
        aria-hidden="true"
      >
        <div
          className="rounded-2xl p-5"
          style={{
            background: "rgba(105,240,174,0.04)",
            border: "1px solid rgba(105,240,174,0.2)",
            backdropFilter: "blur(16px)",
            boxShadow: "0 0 30px rgba(105,240,174,0.05)",
          }}
        >
          <p className="text-xs text-qulo-text-secondary uppercase tracking-widest mb-2">Soru</p>
          <p className="text-white font-semibold text-base mb-4">Müzik Tercihin?</p>
          <div className="grid grid-cols-2 gap-2">
            <div
              className="rounded-xl px-3 py-2 text-center text-xs text-white/70"
              style={{ background: "rgba(255,255,255,0.06)", border: "1px solid rgba(255,255,255,0.08)" }}
            >
              🎸 Rock
            </div>
            <div
              className="rounded-xl px-3 py-2 text-center text-xs text-white/70"
              style={{ background: "rgba(255,255,255,0.06)", border: "1px solid rgba(255,255,255,0.08)" }}
            >
              🎹 Jazz
            </div>
          </div>
        </div>
      </div>

      {/* Front card — z-30, opacity-100 */}
      <div className="absolute left-0 right-4 top-36 z-30 animate-float-medium">
        {/* Rotating border wrapper */}
        <div className="relative rounded-2xl p-[1px] overflow-hidden">
          {/* Rotating conic gradient border */}
          <div
            className="absolute inset-0 rounded-2xl animate-rotate-border"
            style={{
              background: "conic-gradient(from 0deg, transparent 0%, #BB86FC 20%, transparent 40%, #69F0AE 60%, transparent 80%)",
              filter: "blur(1px)",
            }}
            aria-hidden="true"
          />
          {/* Card content */}
          <div
            className="relative rounded-2xl p-5"
            style={{
              background: "#0D0D16",
              boxShadow: "0 0 40px rgba(187,134,252,0.2), inset 0 0 40px rgba(187,134,252,0.02)",
            }}
          >
            <div className="flex items-center gap-2 mb-3">
              <div className="w-2 h-2 rounded-full bg-qulo-purple animate-pulse" />
              <p className="text-xs text-qulo-purple uppercase tracking-widest font-medium">Soru</p>
            </div>
            <p className="text-white font-bold text-lg mb-4 leading-snug">İdeal Hafta Sonu?</p>
            <div className="space-y-2 mb-4">
              {["🏔️ Doğa yürüyüşü", "🎮 Evde gaming", "🎉 Arkadaş buluşması"].map((option, i) => (
                <div
                  key={i}
                  className="rounded-xl px-4 py-2.5 text-sm text-white/80 transition-all"
                  style={{
                    background: i === 0 ? "rgba(187,134,252,0.12)" : "rgba(255,255,255,0.04)",
                    border: i === 0 ? "1px solid rgba(187,134,252,0.3)" : "1px solid rgba(255,255,255,0.06)",
                  }}
                >
                  {option}
                </div>
              ))}
            </div>
            <button
              className="w-full rounded-xl py-2.5 text-sm font-semibold text-white text-center transition-all"
              style={{
                background: "linear-gradient(135deg, #BB86FC, #9C27B0)",
                boxShadow: "0 4px 20px rgba(187,134,252,0.3)",
              }}
            >
              Cevapla →
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
