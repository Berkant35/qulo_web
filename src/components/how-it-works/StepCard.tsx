"use client";

import { motion } from "framer-motion";
import { GlassCard } from "@/components/shared/GlassCard";

interface StepCardProps {
  stepNumber: number;
  iconSrc: string;
  title: string;
  description: string;
  detail: string;
  accentColor: "purple" | "green";
  children?: React.ReactNode;
  delay?: number;
}

const COLORS = {
  purple: { hex: "#BB86FC", glow: "rgba(187,134,252,0.4)", dimGlow: "rgba(187,134,252,0.14)" },
  green: { hex: "#69F0AE", glow: "rgba(105,240,174,0.4)", dimGlow: "rgba(105,240,174,0.14)" },
};

export function StepCard({ stepNumber, iconSrc, title, description, detail, accentColor, children, delay = 0 }: StepCardProps) {
  const color = COLORS[accentColor];

  return (
    <motion.div
      initial={{ opacity: 0.85, x: -12 }}
      whileInView={{ opacity: 1, x: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5, delay }}
    >
      <GlassCard
        className="p-6 relative overflow-hidden"
        borderColor={`${color.hex}33`}
      >
        {/* Ambient glow corner */}
        <div
          className="absolute -top-8 -right-8 w-48 h-48 rounded-full pointer-events-none"
          style={{ background: `radial-gradient(circle, ${color.dimGlow} 0%, transparent 70%)` }}
          aria-hidden="true"
        />
        {/* Left accent border */}
        <div
          className="absolute left-0 top-4 bottom-4 w-[2px] rounded-full"
          style={{ background: `linear-gradient(180deg, ${color.hex}88 0%, transparent 100%)` }}
          aria-hidden="true"
        />

        {/* Step number badge */}
        <div className="flex items-start gap-4 mb-4">
          <div
            className="flex-shrink-0 w-10 h-10 rounded-full flex items-center justify-center text-sm font-black"
            style={{
              background: `${color.hex}22`,
              border: `1px solid ${color.hex}66`,
              color: color.hex,
              boxShadow: `0 0 16px ${color.glow}, 0 0 4px ${color.hex}44`,
            }}
          >
            {stepNumber}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 mb-1">
              <img
                src={iconSrc}
                alt={title}
                width={20}
                height={20}
                style={{ filter: `drop-shadow(0 0 6px ${color.glow})` }}
              />
              <h3 className="text-lg font-bold text-white">{title}</h3>
            </div>
            <p className="text-sm text-gray-400">{description}</p>
          </div>
        </div>

        <p className="text-xs text-gray-500 mb-4">{detail}</p>

        {children && <div className="mt-4">{children}</div>}
      </GlassCard>
    </motion.div>
  );
}
