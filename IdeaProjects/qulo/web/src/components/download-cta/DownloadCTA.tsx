"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { NeonButton } from "@/components/shared/NeonButton";
import { APP_STORE_URL, PLAY_STORE_URL } from "@/lib/constants/links";

export function DownloadCTA() {
  const t = useTranslations("cta");

  return (
    <section className="relative py-32 px-6 overflow-hidden text-center">
      {/* Large ambient glow */}
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[700px] h-[400px] pointer-events-none"
        style={{
          background: "radial-gradient(ellipse, rgba(187,134,252,0.10) 0%, transparent 65%)",
          filter: "blur(20px)",
        }}
        aria-hidden="true"
      />

      <div className="relative z-10 max-w-2xl mx-auto">
        <motion.h2
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5 }}
          className="text-5xl sm:text-7xl font-black mb-6 tracking-tight"
          style={{
            color: "#FFFFFF",
            textShadow: "0 0 60px rgba(187,134,252,0.4), 0 0 120px rgba(187,134,252,0.15)",
          }}
        >
          {t("title")}
        </motion.h2>

        <motion.p
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.1 }}
          className="text-base sm:text-lg text-qulo-text-secondary mb-10 leading-relaxed"
        >
          {t("desc")}
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="flex flex-col items-center gap-5"
        >
          <NeonButton
            href={APP_STORE_URL !== "#" ? APP_STORE_URL : undefined}
            className="px-10 py-4 text-base"
          >
            {t("button")}
          </NeonButton>

          {/* Store links */}
          <div className="flex items-center gap-6">
            <a
              href={APP_STORE_URL}
              className="flex items-center gap-1.5 text-xs text-qulo-text-muted hover:text-qulo-purple transition-colors"
            >
              <img src="/icons/ic_lock.svg" alt="" width={12} height={12} style={{ opacity: 0.6 }} />
              App Store
            </a>
            <span className="text-white/10 text-xs">|</span>
            <a
              href={PLAY_STORE_URL}
              className="flex items-center gap-1.5 text-xs text-qulo-text-muted hover:text-qulo-green transition-colors"
            >
              <img src="/icons/ic_zap.svg" alt="" width={12} height={12} style={{ opacity: 0.6 }} />
              Google Play
            </a>
          </div>
          {/* Decorative diamonds */}
          <div className="flex items-center gap-3 mt-2 opacity-30">
            <img src="/brand/green_diamond.svg" alt="" width={16} height={16} />
            <img src="/brand/purple_diamond.svg" alt="" width={16} height={16} />
            <img src="/brand/green_diamond.svg" alt="" width={16} height={16} />
          </div>
        </motion.div>
      </div>
    </section>
  );
}
