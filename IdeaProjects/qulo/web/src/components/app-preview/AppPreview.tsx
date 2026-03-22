"use client";

import { useEffect, useRef } from "react";
import { motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { PhoneMockup } from "./PhoneMockup";

export function AppPreview() {
  const t = useTranslations("appPreview");
  const sectionRef = useRef<HTMLElement>(null);

  useEffect(() => {
    const initGSAP = async () => {
      const { gsap } = await import("gsap");
      const { ScrollTrigger } = await import("gsap/ScrollTrigger");
      gsap.registerPlugin(ScrollTrigger);

      const phone = sectionRef.current?.querySelector(".phone-gsap") as HTMLElement | null;
      if (!phone) return;

      gsap.fromTo(
        phone,
        { rotateY: -20, rotateX: 5 },
        {
          rotateY: 5,
          rotateX: -2,
          ease: "none",
          scrollTrigger: {
            trigger: sectionRef.current,
            start: "top bottom",
            end: "bottom top",
            scrub: true,
          },
        }
      );
    };

    initGSAP();
  }, []);

  return (
    <section ref={sectionRef} className="relative py-24 px-6 overflow-hidden">
      {/* Ambient — stronger */}
      <div
        className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-[700px] h-[600px] pointer-events-none"
        style={{ background: "radial-gradient(ellipse, rgba(187,134,252,0.10) 0%, transparent 70%)" }}
        aria-hidden="true"
      />
      {/* Top ambient glow behind title */}
      <div
        className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] pointer-events-none"
        style={{ background: "radial-gradient(ellipse, rgba(187,134,252,0.08) 0%, transparent 70%)" }}
        aria-hidden="true"
      />

      <div className="relative z-10 max-w-4xl mx-auto text-center">
        {/* Label */}
        <motion.div
          initial={{ opacity: 0, y: -10 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.4 }}
          className="flex items-center justify-center gap-2 mb-6"
        >
          <div className="w-6 h-[1px] bg-qulo-purple opacity-60" />
          <span className="text-xs font-semibold uppercase tracking-[0.2em] text-qulo-purple-light">
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
          className="text-4xl sm:text-5xl font-black mb-16 leading-none tracking-tight"
        >
          <span className="text-white">{t("title1")} </span>
          <span style={{ color: "#BB86FC", textShadow: "0 0 40px rgba(187,134,252,0.4)" }}>
            {t("title2")}
          </span>
        </motion.h2>

        {/* Phone */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.2 }}
          className="phone-gsap inline-block"
          style={{ transformStyle: "preserve-3d" }}
        >
          <PhoneMockup />
        </motion.div>
      </div>
    </section>
  );
}
