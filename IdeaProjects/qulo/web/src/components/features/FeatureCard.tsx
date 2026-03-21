"use client";

import { motion } from "framer-motion";

interface FeatureCardProps {
  icon: string;
  label: string;
  title: string;
  subtitle: string;
  description: string;
  accentColor: "purple" | "green";
  delay?: number;
}

const COLORS = {
  purple: { hex: "#BB86FC", glow: "rgba(187,134,252,0.25)", dimGlow: "rgba(187,134,252,0.06)" },
  green: { hex: "#69F0AE", glow: "rgba(105,240,174,0.25)", dimGlow: "rgba(105,240,174,0.06)" },
};

export function FeatureCard({ icon, label, title, subtitle, description, accentColor, delay = 0 }: FeatureCardProps) {
  const color = COLORS[accentColor];

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.45, delay }}
      whileHover={{ y: -4 }}
      className="group relative rounded-2xl p-6 overflow-hidden cursor-default"
      style={{
        background: "rgba(255,255,255,0.03)",
        backdropFilter: "blur(16px)",
        border: `1px solid ${color.hex}22`,
        transition: "box-shadow 0.25s",
      }}
    >
      {/* Ambient glow top-right */}
      <div
        className="absolute -top-10 -right-10 w-40 h-40 rounded-full pointer-events-none transition-opacity duration-300 group-hover:opacity-100 opacity-60"
        style={{ background: `radial-gradient(circle, ${color.dimGlow} 0%, transparent 70%)` }}
        aria-hidden="true"
      />

      {/* Label tag */}
      <div className="mb-3">
        <span
          className="inline-block text-[10px] font-semibold uppercase tracking-[0.15em] px-2 py-0.5 rounded-full"
          style={{ color: color.hex, background: `${color.hex}18`, border: `1px solid ${color.hex}33` }}
        >
          {label}
        </span>
      </div>

      {/* Icon */}
      <div className="text-3xl mb-4">{icon}</div>

      {/* Title & subtitle */}
      <h3 className="text-base font-bold text-white mb-0.5">{title}</h3>
      <p className="text-xs font-medium mb-3" style={{ color: color.hex }}>{subtitle}</p>

      {/* Description */}
      <p className="text-sm text-qulo-text-secondary leading-relaxed">{description}</p>
    </motion.div>
  );
}
