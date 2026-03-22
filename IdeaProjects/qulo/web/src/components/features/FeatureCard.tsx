"use client";

import { motion } from "framer-motion";

interface FeatureCardProps {
  iconSrc: string;
  label: string;
  title: string;
  subtitle: string;
  description: string;
  accentColor: "purple" | "green";
  delay?: number;
}

const COLORS = {
  purple: { hex: "#BB86FC", glow: "rgba(187,134,252,0.35)", dimGlow: "rgba(187,134,252,0.12)" },
  green: { hex: "#69F0AE", glow: "rgba(105,240,174,0.35)", dimGlow: "rgba(105,240,174,0.12)" },
};

export function FeatureCard({ iconSrc, label, title, subtitle, description, accentColor, delay = 0 }: FeatureCardProps) {
  const color = COLORS[accentColor];

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.45, delay }}
      whileHover={{ y: -6, transition: { duration: 0.2 } }}
      className="group relative rounded-2xl p-6 overflow-hidden cursor-default"
      style={{
        background: "rgba(255,255,255,0.05)",
        backdropFilter: "blur(16px)",
        border: `1px solid ${color.hex}33`,
        boxShadow: `0 0 0 0 ${color.glow}`,
        transition: "box-shadow 0.3s ease",
      }}
      onMouseEnter={(e) => {
        (e.currentTarget as HTMLDivElement).style.boxShadow = `0 8px 40px ${color.glow}, 0 0 0 1px ${color.hex}22`;
      }}
      onMouseLeave={(e) => {
        (e.currentTarget as HTMLDivElement).style.boxShadow = "0 0 0 0 transparent";
      }}
    >
      {/* Ambient glow top-right — more visible */}
      <div
        className="absolute -top-10 -right-10 w-48 h-48 rounded-full pointer-events-none transition-opacity duration-300 group-hover:opacity-100 opacity-30"
        style={{ background: `radial-gradient(circle, ${color.dimGlow} 0%, transparent 70%)` }}
        aria-hidden="true"
      />

      {/* Subtle gradient bottom border */}
      <div
        className="absolute bottom-0 left-4 right-4 h-px pointer-events-none opacity-40 group-hover:opacity-70 transition-opacity duration-300"
        style={{ background: `linear-gradient(90deg, transparent, ${color.hex}, transparent)` }}
        aria-hidden="true"
      />

      {/* Label tag */}
      <div className="mb-4">
        <span
          className="inline-block text-[10px] font-semibold uppercase tracking-[0.15em] px-2 py-0.5 rounded-full"
          style={{ color: color.hex, background: `${color.hex}20`, border: `1px solid ${color.hex}44` }}
        >
          {label}
        </span>
      </div>

      {/* Icon — larger */}
      <div className="mb-5">
        <img
          src={iconSrc}
          alt={title}
          width={48}
          height={48}
          style={{ filter: `drop-shadow(0 0 10px ${color.glow})` }}
        />
      </div>

      {/* Title & subtitle */}
      <h3 className="text-base font-bold text-white mb-1">{title}</h3>
      <p className="text-xs font-medium mb-3" style={{ color: color.hex }}>{subtitle}</p>

      {/* Description */}
      <p className="text-sm text-gray-400 leading-relaxed">{description}</p>
    </motion.div>
  );
}
