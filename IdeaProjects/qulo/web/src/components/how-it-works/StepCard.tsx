"use client";

import { motion } from "framer-motion";
import { GlassCard } from "@/components/shared/GlassCard";

interface StepCardProps {
  stepNumber: number;
  icon: string;
  title: string;
  description: string;
  detail: string;
  accentColor: "purple" | "green";
  children?: React.ReactNode;
  delay?: number;
}

const COLORS = {
  purple: { hex: "#BB86FC", glow: "rgba(187,134,252,0.3)", dimGlow: "rgba(187,134,252,0.08)" },
  green: { hex: "#69F0AE", glow: "rgba(105,240,174,0.3)", dimGlow: "rgba(105,240,174,0.08)" },
};

export function StepCard({ stepNumber, icon, title, description, detail, accentColor, children, delay = 0 }: StepCardProps) {
  const color = COLORS[accentColor];

  return (
    <motion.div
      initial={{ opacity: 0, x: -24 }}
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
          className="absolute -top-8 -right-8 w-32 h-32 rounded-full pointer-events-none"
          style={{ background: `radial-gradient(circle, ${color.dimGlow} 0%, transparent 70%)` }}
          aria-hidden="true"
        />

        {/* Step number badge */}
        <div className="flex items-start gap-4 mb-4">
          <div
            className="flex-shrink-0 w-10 h-10 rounded-full flex items-center justify-center text-sm font-black"
            style={{
              background: `${color.hex}18`,
              border: `1px solid ${color.hex}44`,
              color: color.hex,
              boxShadow: `0 0 12px ${color.glow}`,
            }}
          >
            {stepNumber}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 mb-1">
              <span className="text-xl">{icon}</span>
              <h3 className="text-lg font-bold text-white">{title}</h3>
            </div>
            <p className="text-sm text-qulo-text-secondary">{description}</p>
          </div>
        </div>

        <p className="text-xs text-qulo-text-muted mb-4">{detail}</p>

        {children && <div className="mt-4">{children}</div>}
      </GlassCard>
    </motion.div>
  );
}
