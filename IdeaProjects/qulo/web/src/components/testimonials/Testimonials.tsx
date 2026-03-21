"use client";

import { motion } from "framer-motion";
import { useTranslations } from "next-intl";

const TESTIMONIALS = [
  { avatar: "👩", name: "Selin K.", quote: "Sorular sayesinde gerçekten uyumlu biriyle tanıştım. Yüzeysel değil, derinlemesine bağlantı." },
  { avatar: "👨", name: "Mehmet A.", quote: "AI soru oluşturma özelliği harika. Kendimi en iyi anlatan soruları bulmama yardım etti." },
  { avatar: "👩‍🦱", name: "Ayşe M.", quote: "Elmas sistemi çok eğlenceli. Sorularım çözüldükçe kazanmak motive edici." },
  { avatar: "🧑", name: "Emre T.", quote: "Match olmak gerçekten anlamlı çünkü o kişi beni anlamış demek oluyor." },
  { avatar: "👩‍🦰", name: "Zeynep B.", quote: "Premium almadan önce denedim, zaten etkileyiciydi. Şimdi çok daha iyi." },
];

const ALL = [...TESTIMONIALS, ...TESTIMONIALS]; // duplicate for seamless loop

export function Testimonials() {
  const t = useTranslations("testimonials");

  return (
    <section className="relative py-24 overflow-hidden">
      {/* Background */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{ background: "radial-gradient(ellipse 80% 40% at 50% 50%, rgba(187,134,252,0.03) 0%, transparent 70%)" }}
        aria-hidden="true"
      />

      <div className="relative z-10">
        {/* Label + title */}
        <div className="px-6 text-center mb-12">
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

          <motion.h2
            initial={{ opacity: 0, y: -10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.4, delay: 0.1 }}
            className="text-4xl sm:text-5xl font-black leading-none tracking-tight"
          >
            <span className="text-white">{t("title1")} </span>
            <span style={{ color: "#BB86FC", textShadow: "0 0 40px rgba(187,134,252,0.4)" }}>
              {t("title2")}
            </span>
          </motion.h2>
        </div>

        {/* Carousel */}
        <div
          className="group flex gap-4 w-full overflow-hidden"
          style={{ maskImage: "linear-gradient(90deg, transparent 0%, black 10%, black 90%, transparent 100%)" }}
        >
          <div
            className="flex gap-4 animate-[scroll_30s_linear_infinite] group-hover:[animation-play-state:paused]"
            style={{ willChange: "transform" }}
          >
            {ALL.map((item, i) => (
              <div
                key={i}
                className="flex-shrink-0 w-72 rounded-2xl p-5"
                style={{
                  background: "rgba(255,255,255,0.03)",
                  backdropFilter: "blur(16px)",
                  border: "1px solid rgba(187,134,252,0.12)",
                }}
              >
                <div className="flex items-center gap-3 mb-3">
                  <div
                    className="w-10 h-10 rounded-full flex items-center justify-center text-xl flex-shrink-0"
                    style={{ background: "rgba(187,134,252,0.1)", border: "1px solid rgba(187,134,252,0.2)" }}
                  >
                    {item.avatar}
                  </div>
                  <div>
                    <p className="text-sm font-semibold text-white">{item.name}</p>
                    <div className="flex gap-0.5">
                      {[...Array(5)].map((_, s) => (
                        <span key={s} className="text-[10px]" style={{ color: "#BB86FC" }}>★</span>
                      ))}
                    </div>
                  </div>
                </div>
                <p className="text-sm text-qulo-text-secondary leading-relaxed">{item.quote}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
