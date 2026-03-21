"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";

interface DiffCardProps {
  othersTitle: string;
  othersDesc: string;
  quloTitle: string;
  quloDesc: string;
  othersIcon: string;
  quloIcon: string;
  othersLabel: string;
  quloLabel: string;
  delay: number;
}

function DiffCard({
  othersTitle,
  othersDesc,
  quloTitle,
  quloDesc,
  othersIcon,
  quloIcon,
  othersLabel,
  quloLabel,
  delay,
}: DiffCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay }}
      className="rounded-2xl overflow-hidden"
      style={{
        background: "rgba(255,255,255,0.03)",
        backdropFilter: "blur(16px)",
        border: "1px solid rgba(187,134,252,0.12)",
      }}
    >
      <div className="grid grid-cols-2">
        {/* Others side */}
        <div
          className="p-5"
          style={{ borderRight: "1px solid rgba(255,255,255,0.06)" }}
        >
          <div className="flex items-center gap-2 mb-3">
            <div
              className="w-7 h-7 rounded-lg flex items-center justify-center flex-shrink-0"
              style={{ background: "rgba(255,255,255,0.05)", border: "1px solid rgba(255,255,255,0.08)" }}
            >
              <img
                src={`/icons/${othersIcon}`}
                alt={othersLabel}
                width={14}
                height={14}
                style={{ opacity: 0.4 }}
              />
            </div>
            <span
              className="text-[10px] font-semibold uppercase tracking-widest"
              style={{ color: "rgba(255,255,255,0.3)" }}
            >
              {othersLabel}
            </span>
          </div>
          <p className="text-sm font-semibold mb-1" style={{ color: "rgba(255,255,255,0.35)" }}>
            {othersTitle}
          </p>
          <p className="text-xs leading-relaxed" style={{ color: "rgba(255,255,255,0.2)" }}>
            {othersDesc}
          </p>
        </div>

        {/* Qulo side */}
        <div className="p-5">
          <div className="flex items-center gap-2 mb-3">
            <div
              className="w-7 h-7 rounded-lg flex items-center justify-center flex-shrink-0"
              style={{
                background: "rgba(187,134,252,0.15)",
                border: "1px solid rgba(187,134,252,0.3)",
                boxShadow: "0 0 10px rgba(187,134,252,0.15)",
              }}
            >
              <img
                src={`/icons/${quloIcon}`}
                alt={quloLabel}
                width={14}
                height={14}
                style={{ filter: "drop-shadow(0 0 4px rgba(187,134,252,0.6))" }}
              />
            </div>
            <span
              className="text-[10px] font-semibold uppercase tracking-widest"
              style={{ color: "#BB86FC" }}
            >
              {quloLabel}
            </span>
          </div>
          <p className="text-sm font-semibold mb-1 text-white">{quloTitle}</p>
          <p className="text-xs leading-relaxed" style={{ color: "rgba(105,240,174,0.8)" }}>
            {quloDesc}
          </p>
        </div>
      </div>
    </motion.div>
  );
}

const DIFFS = [
  { othersIcon: "ic_split.svg", quloIcon: "ic_chats.svg" },
  { othersIcon: "ic_fast_forward.svg", quloIcon: "ic_heart_filled.svg" },
  { othersIcon: "ic_user.svg", quloIcon: "ic_badge_gold.svg" },
  { othersIcon: "ic_globe.svg", quloIcon: "ic_wand.svg" },
] as const;

export function WhyDifferent() {
  const t = useTranslations("whyDifferent");

  return (
    <section className="relative py-24 px-6 overflow-hidden">
      {/* Background glow */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background:
            "radial-gradient(ellipse 70% 50% at 50% 50%, rgba(187,134,252,0.04) 0%, transparent 70%)",
        }}
        aria-hidden="true"
      />

      <div className="relative z-10 max-w-4xl mx-auto">
        {/* Section label */}
        <motion.div
          initial={{ opacity: 0, y: -10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.4 }}
          className="flex items-center justify-center gap-2 mb-6"
        >
          <div className="w-6 h-[1px] bg-qulo-purple opacity-60" />
          <span className="text-xs font-semibold uppercase tracking-[0.2em] text-qulo-purple">
            {t("label")}
          </span>
          <div className="w-6 h-[1px] bg-qulo-purple opacity-60" />
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
          <span style={{ color: "#BB86FC", textShadow: "0 0 40px rgba(187,134,252,0.4)" }}>
            {t("title2")}
          </span>
        </motion.h2>

        {/* 2x2 grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          {DIFFS.map((diff, i) => (
            <DiffCard
              key={i}
              othersTitle={t(`diff${i + 1}OthersTitle` as Parameters<typeof t>[0])}
              othersDesc={t(`diff${i + 1}OthersDesc` as Parameters<typeof t>[0])}
              quloTitle={t(`diff${i + 1}QuloTitle` as Parameters<typeof t>[0])}
              quloDesc={t(`diff${i + 1}QuloDesc` as Parameters<typeof t>[0])}
              othersIcon={diff.othersIcon}
              quloIcon={diff.quloIcon}
              othersLabel={t("others")}
              quloLabel={t("qulo")}
              delay={i * 0.1}
            />
          ))}
        </div>
      </div>
    </section>
  );
}
