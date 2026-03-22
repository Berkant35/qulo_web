"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { FeatureCard } from "./FeatureCard";

const CARDS = [
  { key: "diamonds", iconSrc: "/brand/purple_diamond.svg", accentColor: "purple" as const },
  { key: "gamification", iconSrc: "/icons/ic_badge_gold.svg", accentColor: "green" as const },
  { key: "powers", iconSrc: "/icons/ic_zap.svg", accentColor: "purple" as const },
  { key: "ai", iconSrc: "/icons/ic_wand.svg", accentColor: "green" as const },
  { key: "premium", iconSrc: "/icons/ic_crown.svg", accentColor: "purple" as const },
] as const;

export function Features() {
  const t = useTranslations("features");

  return (
    <section className="relative py-24 px-6 overflow-hidden" style={{ background: "rgba(13,13,13,0.6)" }}>
      {/* Subtle mesh */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background: "radial-gradient(ellipse 70% 50% at 50% 60%, rgba(105,240,174,0.06) 0%, transparent 70%)",
        }}
        aria-hidden="true"
      />
      {/* Top ambient glow behind title */}
      <div
        className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] pointer-events-none"
        style={{ background: "radial-gradient(ellipse, rgba(105,240,174,0.08) 0%, transparent 70%)" }}
        aria-hidden="true"
      />

      <div className="relative z-10 max-w-6xl mx-auto">
        {/* Label */}
        <motion.div
          initial={{ opacity: 0, y: -10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.4 }}
          className="flex items-center justify-center gap-2 mb-6"
        >
          <div className="w-6 h-[1px] bg-qulo-green opacity-60" />
          <span className="text-xs font-semibold uppercase tracking-[0.2em] text-qulo-green-light">
            {t("label")}
          </span>
          <div className="w-6 h-[1px] bg-qulo-green opacity-60" />
        </motion.div>

        {/* Title */}
        <motion.h2
          initial={{ opacity: 0, y: -10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.4, delay: 0.1 }}
          className="text-4xl sm:text-5xl font-black text-center mb-16 leading-none tracking-tight"
        >
          <span className="text-white">{t("title1")} </span>
          <span style={{ color: "#69F0AE", textShadow: "0 0 40px rgba(105,240,174,0.4)" }}>
            {t("title2")}
          </span>
        </motion.h2>

        {/* Grid */}
        <div className="grid gap-4" style={{ gridTemplateColumns: "repeat(auto-fill, minmax(260px, 1fr))" }}>
          {CARDS.map(({ key, iconSrc, accentColor }, i) => (
            <FeatureCard
              key={key}
              iconSrc={iconSrc}
              label={t(`${key}.subtitle` as Parameters<typeof t>[0])}
              title={t(`${key}.title` as Parameters<typeof t>[0])}
              subtitle={t(`${key}.subtitle` as Parameters<typeof t>[0])}
              description={t(`${key}.desc` as Parameters<typeof t>[0])}
              accentColor={accentColor}
              delay={i * 0.08}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
