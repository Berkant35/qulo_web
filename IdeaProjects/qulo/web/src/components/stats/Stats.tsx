"use client";

import { useTranslations, useLocale } from "next-intl";
import { motion } from "framer-motion";

const stats = [
  { value: 10000, suffix: "+", key: "questions", color: "#BB86FC" },
  { value: 5000, suffix: "+", key: "matches", color: "#69F0AE" },
  { value: 25000, suffix: "+", key: "users", color: "#BB86FC" },
  { value: 4.8, suffix: "", key: "rating", color: "#69F0AE" },
];

export function Stats() {
  const t = useTranslations("stats");
  const locale = useLocale();

  const formatNumber = (val: number) => {
    if (val < 10) return val.toFixed(1); // For 4.8
    return val.toLocaleString(locale === "tr" ? "tr-TR" : "en-US");
  };

  return (
    <section className="relative py-10 px-6 overflow-hidden">
      <div className="max-w-5xl mx-auto">
        <div
          className="relative rounded-2xl overflow-hidden"
          style={{
            background:
              "linear-gradient(135deg, rgba(255,255,255,0.04) 0%, rgba(255,255,255,0.02) 100%)",
            border: "1px solid rgba(255,255,255,0.08)",
            backdropFilter: "blur(12px)",
            boxShadow:
              "0 4px 24px rgba(0,0,0,0.3), inset 0 1px 0 rgba(255,255,255,0.06)",
          }}
        >
          {/* Subtle gradient background */}
          <div
            className="absolute inset-0 pointer-events-none"
            style={{
              background:
                "radial-gradient(ellipse 60% 80% at 20% 50%, rgba(187,134,252,0.04) 0%, transparent 60%), radial-gradient(ellipse 50% 80% at 80% 50%, rgba(105,240,174,0.04) 0%, transparent 60%)",
            }}
            aria-hidden="true"
          />

          <div className="relative z-10 grid grid-cols-2 sm:grid-cols-4">
            {stats.map((stat, idx) => (
              <motion.div
                key={stat.key}
                initial={{ opacity: 0.85, y: 8 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.4, delay: idx * 0.1 }}
                className="relative flex flex-col items-center justify-center py-8 px-4 text-center"
              >
                {/* Vertical divider (not on last item) */}
                {idx < stats.length - 1 && (
                  <div
                    className="absolute right-0 top-1/2 -translate-y-1/2 w-px h-10 hidden sm:block"
                    style={{
                      background:
                        "linear-gradient(to bottom, transparent, rgba(255,255,255,0.1), transparent)",
                    }}
                    aria-hidden="true"
                  />
                )}
                {/* Horizontal divider for mobile 2x2 grid */}
                {idx < 2 && (
                  <div
                    className="absolute bottom-0 left-1/2 -translate-x-1/2 h-px w-10 sm:hidden"
                    style={{
                      background:
                        "linear-gradient(to right, transparent, rgba(255,255,255,0.1), transparent)",
                    }}
                    aria-hidden="true"
                  />
                )}

                <span
                  className="text-3xl sm:text-4xl font-black tabular-nums"
                  style={{
                    color: stat.color,
                    textShadow: `0 0 30px ${stat.color}40`,
                  }}
                >
                  {formatNumber(stat.value)}{stat.suffix}
                </span>
                <span className="mt-2 text-xs sm:text-sm text-gray-400 leading-tight">
                  {t(stat.key as Parameters<typeof t>[0])}
                </span>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
