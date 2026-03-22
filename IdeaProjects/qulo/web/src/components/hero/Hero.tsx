"use client";

import { useTranslations } from "next-intl";
import { CardStack } from "./CardStack";
import { StoreButtons } from "./StoreButtons";

export function Hero() {
  const t = useTranslations("hero");

  return (
    <section className="relative min-h-screen flex items-center overflow-hidden pt-24 pb-16">
      {/* ── Background effects (CSS-only) ── */}

      {/* Gradient mesh */}
      <div
        className="absolute inset-0 pointer-events-none animate-mesh-move z-0"
        style={{
          background:
            "radial-gradient(ellipse 80% 60% at 20% 50%, rgba(187,134,252,0.07) 0%, transparent 60%), radial-gradient(ellipse 60% 80% at 80% 30%, rgba(105,240,174,0.05) 0%, transparent 60%)",
          backgroundSize: "200% 200%",
        }}
        aria-hidden="true"
      />

      {/* Scanline overlay — more subtle */}
      <div
        className="absolute left-0 right-0 h-[2px] pointer-events-none animate-scanline z-0 opacity-[0.025]"
        style={{
          background: "linear-gradient(90deg, transparent, rgba(187,134,252,0.8), transparent)",
        }}
        aria-hidden="true"
      />

      {/* Morphing blob 1 — warm rose/purple tint for romance */}
      <div
        className="absolute top-20 -left-32 w-[500px] h-[500px] pointer-events-none animate-morph-blob z-0 opacity-[0.12]"
        style={{
          background: "radial-gradient(circle, rgba(220,120,200,0.6) 0%, rgba(187,134,252,0.5) 50%, transparent 70%)",
          filter: "blur(40px)",
        }}
        aria-hidden="true"
      />

      {/* Morphing blob 2 */}
      <div
        className="absolute bottom-10 -right-32 w-[420px] h-[420px] pointer-events-none animate-morph-blob z-0 opacity-[0.09]"
        style={{
          background: "radial-gradient(circle, rgba(105,240,174,0.7) 0%, transparent 70%)",
          filter: "blur(40px)",
          animationDelay: "-5s",
        }}
        aria-hidden="true"
      />

      {/* Floating particles */}
      {[
        { top: "15%", left: "10%", color: "rgba(187,134,252,0.6)", size: 4, anim: "animate-float-slow" },
        { top: "70%", left: "5%", color: "rgba(105,240,174,0.5)", size: 3, anim: "animate-float-medium" },
        { top: "30%", right: "8%", color: "rgba(187,134,252,0.5)", size: 5, anim: "animate-float-fast" },
        { top: "80%", right: "12%", color: "rgba(105,240,174,0.6)", size: 3, anim: "animate-float-slow" },
        { top: "50%", left: "48%", color: "rgba(187,134,252,0.4)", size: 4, anim: "animate-float-medium" },
      ].map((p, i) => (
        <div
          key={i}
          className={`absolute rounded-full pointer-events-none z-0 ${p.anim}`}
          style={{
            top: p.top,
            left: "left" in p ? p.left : undefined,
            right: "right" in p ? (p as { right?: string }).right : undefined,
            width: p.size,
            height: p.size,
            background: p.color,
            boxShadow: `0 0 ${p.size * 3}px ${p.color}`,
            animationDelay: `${i * 0.7}s`,
          }}
          aria-hidden="true"
        />
      ))}

      {/* ── Main content ── */}
      <div className="relative z-10 max-w-6xl mx-auto px-6 w-full">
        <div className="flex flex-col lg:flex-row items-center gap-16 lg:gap-8">
          {/* Left: text content */}
          <div className="flex-1 text-center lg:text-left max-w-lg mx-auto lg:mx-0">
            {/* Section label */}
            <div className="inline-flex items-center gap-2 mb-6">
              <div className="w-6 h-[1px] bg-qulo-purple opacity-60" />
              <span className="text-xs font-semibold uppercase tracking-[0.2em] text-qulo-purple">
                {t("label")}
              </span>
              <div className="w-6 h-[1px] bg-qulo-purple opacity-60" />
            </div>

            {/* H1 */}
            <h1 className="text-5xl sm:text-6xl lg:text-7xl font-black leading-none tracking-tight mb-6">
              <span className="text-white block">{t("title1")}</span>
              <span
                className="block"
                style={{
                  color: "#BB86FC",
                  textShadow: "0 0 60px rgba(187,134,252,0.5), 0 0 120px rgba(187,134,252,0.2)",
                }}
              >
                {t("title2")}
              </span>
            </h1>

            {/* Description */}
            <p className="text-base sm:text-lg text-qulo-text-secondary leading-relaxed mb-10 max-w-md mx-auto lg:mx-0">
              {t("description")}
            </p>

            {/* Store buttons */}
            <div className="flex justify-center lg:justify-start">
              <StoreButtons />
            </div>
          </div>

          {/* Right: card stack */}
          <div className="flex-1 w-full max-w-sm lg:max-w-md mx-auto">
            <CardStack />
          </div>
        </div>
      </div>
    </section>
  );
}
