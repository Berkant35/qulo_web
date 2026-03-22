"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { NeonButton } from "@/components/shared/NeonButton";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";

export function DownloadCTA() {
  const t = useTranslations("cta");

  return (
    <section className="relative py-40 px-6 overflow-hidden text-center">
      {/* Large ambient glow — much bigger */}
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[900px] h-[600px] pointer-events-none"
        style={{
          background: "radial-gradient(ellipse, rgba(187,134,252,0.15) 0%, rgba(105,240,174,0.04) 40%, transparent 70%)",
          filter: "blur(30px)",
        }}
        aria-hidden="true"
      />

      {/* Animated pulse ring */}
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[300px] h-[300px] rounded-full pointer-events-none animate-pulse-ring"
        style={{ border: "1px solid rgba(187,134,252,0.15)", animationDelay: "0s" }}
        aria-hidden="true"
      />
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[300px] h-[300px] rounded-full pointer-events-none animate-pulse-ring"
        style={{ border: "1px solid rgba(187,134,252,0.08)", animationDelay: "2s" }}
        aria-hidden="true"
      />

      {/* Floating diamond decorations */}
      <motion.div
        animate={{ y: [-6, 6, -6], rotate: [0, 10, 0] }}
        transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
        className="absolute left-[15%] top-[30%] pointer-events-none opacity-30"
      >
        <img src="/brand/purple_diamond.svg" alt="" width={28} height={28} />
      </motion.div>
      <motion.div
        animate={{ y: [6, -6, 6], rotate: [0, -10, 0] }}
        transition={{ duration: 5, repeat: Infinity, ease: "easeInOut", delay: 1 }}
        className="absolute right-[15%] top-[35%] pointer-events-none opacity-25"
      >
        <img src="/brand/green_diamond.svg" alt="" width={22} height={22} />
      </motion.div>
      <motion.div
        animate={{ y: [-4, 4, -4], rotate: [0, 15, 0] }}
        transition={{ duration: 3.5, repeat: Infinity, ease: "easeInOut", delay: 0.5 }}
        className="absolute left-[25%] bottom-[30%] pointer-events-none opacity-20"
      >
        <img src="/brand/green_diamond.svg" alt="" width={18} height={18} />
      </motion.div>
      <motion.div
        animate={{ y: [4, -4, 4], rotate: [0, -8, 0] }}
        transition={{ duration: 4.5, repeat: Infinity, ease: "easeInOut", delay: 1.5 }}
        className="absolute right-[22%] bottom-[28%] pointer-events-none opacity-20"
      >
        <img src="/brand/purple_diamond.svg" alt="" width={20} height={20} />
      </motion.div>

      <div className="relative z-10 max-w-2xl mx-auto">
        <motion.h2
          initial={{ opacity: 0.85, y: 10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="text-5xl sm:text-6xl lg:text-7xl font-black mb-6 tracking-tight"
          style={{
            color: "#FFFFFF",
            textShadow: "0 0 60px rgba(187,134,252,0.5), 0 0 120px rgba(187,134,252,0.2)",
          }}
        >
          {t("title")}
        </motion.h2>

        <motion.p
          initial={{ opacity: 0.85, y: 8 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="text-base sm:text-lg text-gray-400 mb-10 leading-relaxed"
        >
          {t("desc")}
        </motion.p>

        <motion.div
          initial={{ opacity: 0.85, y: 8 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="flex flex-col items-center gap-5"
        >
          {/* Main button with subtle ring effect */}
          <div className="relative">
            <div
              className="absolute inset-0 rounded-full pointer-events-none animate-glow-pulse"
              style={{ background: "rgba(187,134,252,0.2)", filter: "blur(16px)", transform: "scale(1.4)" }}
              aria-hidden="true"
            />
            <NeonButton
              href={APP_STORE_URL}
              className="relative px-12 py-4 text-base"
            >
              {t("button")}
            </NeonButton>
          </div>

          {/* Store links */}
          <div className="flex items-center gap-6">
            <a
              href={APP_STORE_URL}
              className="flex items-center gap-1.5 text-xs text-gray-500 hover:text-qulo-purple transition-colors"
            >
              <img src="/icons/ic_lock.svg" alt="" width={12} height={12} style={{ opacity: 0.5 }} />
              App Store
            </a>
            <span className="text-white/10 text-xs">|</span>
            <a
              href={PLAY_STORE_URL}
              className="flex items-center gap-1.5 text-xs text-gray-500 hover:text-qulo-green transition-colors"
            >
              <img src="/icons/ic_zap.svg" alt="" width={12} height={12} style={{ opacity: 0.5 }} />
              Google Play
            </a>
          </div>

          {/* Decorative diamonds */}
          <div className="flex items-center gap-3 mt-2 opacity-50">
            <img src="/brand/green_diamond.svg" alt="" width={14} height={14} />
            <img src="/brand/purple_diamond.svg" alt="" width={18} height={18} />
            <img src="/brand/green_diamond.svg" alt="" width={14} height={14} />
          </div>
        </motion.div>
      </div>
    </section>
  );
}
