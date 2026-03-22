"use client";

import { useRef, useEffect, useState } from "react";
import { motion, useInView, useSpring, useMotionValue } from "framer-motion";
import { useTranslations } from "next-intl";

interface StatItem {
  value: number;
  suffix: string;
  prefix?: string;
  labelKey: string;
  color: "purple" | "green";
}

const STATS: StatItem[] = [
  { value: 10000, suffix: "+", labelKey: "questions", color: "purple" },
  { value: 5000, suffix: "+", labelKey: "matches", color: "green" },
  { value: 25000, suffix: "+", labelKey: "users", color: "purple" },
  { value: 4.8, suffix: "", prefix: "", labelKey: "rating", color: "green" },
];

function AnimatedCounter({
  value,
  suffix,
  prefix,
  color,
  inView,
}: {
  value: number;
  suffix: string;
  prefix?: string;
  color: "purple" | "green";
  inView: boolean;
}) {
  const isDecimal = value % 1 !== 0;
  const motionValue = useMotionValue(0);
  const spring = useSpring(motionValue, { damping: 30, stiffness: 100 });
  const [display, setDisplay] = useState("0");

  useEffect(() => {
    if (inView) {
      motionValue.set(value);
    }
  }, [inView, value, motionValue]);

  useEffect(() => {
    const unsubscribe = spring.on("change", (v) => {
      if (isDecimal) {
        setDisplay(v.toFixed(1));
      } else {
        setDisplay(Math.floor(v).toLocaleString("en-US"));
      }
    });
    return unsubscribe;
  }, [spring, isDecimal]);

  const glowColor =
    color === "purple" ? "rgba(187,134,252,0.6)" : "rgba(105,240,174,0.6)";
  const textColor = color === "purple" ? "#BB86FC" : "#69F0AE";

  return (
    <span
      className="text-3xl sm:text-4xl font-black tabular-nums"
      style={{
        color: textColor,
        textShadow: `0 0 20px ${glowColor}, 0 0 40px ${glowColor.replace("0.6", "0.2")}`,
      }}
    >
      {prefix}
      {display}
      {suffix}
    </span>
  );
}

export function Stats() {
  const t = useTranslations("stats");
  const ref = useRef<HTMLDivElement>(null);
  const inView = useInView(ref, { once: true, margin: "-80px" });

  return (
    <section
      ref={ref}
      className="relative py-10 px-6 overflow-hidden"
      style={{ opacity: 0.85 }}
    >
      <div className="max-w-5xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={inView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.6, ease: "easeOut" }}
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
            {STATS.map((stat, idx) => (
              <div
                key={stat.labelKey}
                className="relative flex flex-col items-center justify-center py-8 px-4 text-center"
              >
                {/* Vertical divider (not on last item) */}
                {idx < STATS.length - 1 && (
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

                <AnimatedCounter
                  value={stat.value}
                  suffix={stat.suffix}
                  prefix={stat.prefix}
                  color={stat.color}
                  inView={inView}
                />
                <span className="mt-2 text-xs sm:text-sm text-gray-400 leading-tight">
                  {t(stat.labelKey)}
                </span>
              </div>
            ))}
          </div>
        </motion.div>
      </div>
    </section>
  );
}
