"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { StepCard } from "./StepCard";

function MiniQuestionPreview() {
  const t = useTranslations("howItWorks");
  return (
    <div
      className="rounded-xl p-3 mt-2"
      style={{ background: "rgba(187,134,252,0.06)", border: "1px solid rgba(187,134,252,0.15)" }}
    >
      <div className="flex items-center gap-1.5 mb-2">
        <img src="/icons/ic_chats.svg" alt="question" width={12} height={12} style={{ opacity: 0.7 }} />
        <p className="text-xs text-white/70">{t("previewQuestion")}</p>
      </div>
      <div className="flex gap-2 flex-wrap">
        {[t("previewOption1"), t("previewOption2"), t("previewOption3")].map((opt) => (
          <span
            key={opt}
            className="text-[10px] px-2 py-0.5 rounded-full"
            style={{ background: "rgba(187,134,252,0.12)", color: "#BB86FC", border: "1px solid rgba(187,134,252,0.2)" }}
          >
            {opt}
          </span>
        ))}
      </div>
    </div>
  );
}

function MatchAnimation() {
  const t = useTranslations("howItWorks");
  return (
    <div className="flex flex-col items-center gap-2 mt-2 py-2">
      <div className="flex items-center gap-4">
        <div
          className="w-10 h-10 rounded-full flex items-center justify-center"
          style={{ background: "rgba(105,240,174,0.12)", border: "1px solid rgba(105,240,174,0.2)" }}
        >
          <img src="/icons/ic_user.svg" alt="user" width={20} height={20} style={{ opacity: 0.7 }} />
        </div>
        <motion.div
          animate={{ scale: [1, 1.25, 1] }}
          transition={{ duration: 1.5, repeat: Infinity, ease: "easeInOut" }}
        >
          <img
            src="/icons/ic_heart_filled.svg"
            alt="match"
            width={28}
            height={28}
            style={{ filter: "drop-shadow(0 0 8px rgba(105,240,174,0.6))" }}
          />
        </motion.div>
        <div
          className="w-10 h-10 rounded-full flex items-center justify-center"
          style={{ background: "rgba(105,240,174,0.12)", border: "1px solid rgba(105,240,174,0.2)" }}
        >
          <img src="/icons/ic_user.svg" alt="user" width={20} height={20} style={{ opacity: 0.7 }} />
        </div>
      </div>
      <p className="text-xs text-qulo-text-secondary italic">{t("matchSubtitle")}</p>
    </div>
  );
}

export function HowItWorks() {
  const t = useTranslations("howItWorks");

  return (
    <section className="relative py-24 px-6 overflow-hidden">
      {/* Background glow */}
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[400px] pointer-events-none"
        style={{
          background: "radial-gradient(ellipse, rgba(187,134,252,0.04) 0%, transparent 70%)",
        }}
        aria-hidden="true"
      />

      <div className="relative z-10 max-w-2xl mx-auto">
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

        {/* Timeline */}
        <div className="relative">
          {/* Vertical gradient line */}
          <div
            className="absolute left-5 top-0 bottom-0 w-[2px] rounded-full"
            style={{ background: "linear-gradient(180deg, #BB86FC 0%, #69F0AE 100%)" }}
            aria-hidden="true"
          />

          <div className="pl-16 space-y-8">
            <StepCard
              stepNumber={1}
              iconSrc="/icons/ic_pencil.svg"
              title={t("step1Title")}
              description={t("step1Desc")}
              detail={t("step1Detail")}
              accentColor="purple"
              delay={0.15}
            >
              <MiniQuestionPreview />
            </StepCard>

            <StepCard
              stepNumber={2}
              iconSrc="/icons/ic_compass_filled.svg"
              title={t("step2Title")}
              description={t("step2Desc")}
              detail={t("step2Detail")}
              accentColor="green"
              delay={0.25}
            />

            <StepCard
              stepNumber={3}
              iconSrc="/icons/ic_heart_filled.svg"
              title={t("step3Title")}
              description={t("step3Desc")}
              detail={t("step3Detail")}
              accentColor="green"
              delay={0.35}
            >
              <MatchAnimation />
            </StepCard>
          </div>
        </div>
      </div>
    </section>
  );
}
