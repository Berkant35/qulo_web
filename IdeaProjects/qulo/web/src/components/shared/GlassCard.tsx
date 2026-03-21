import { cn } from "@/lib/utils/cn";

interface GlassCardProps {
  children: React.ReactNode;
  className?: string;
  borderColor?: string;
}

export function GlassCard({ children, className, borderColor }: GlassCardProps) {
  return (
    <div
      className={cn(
        "bg-white/[0.03] backdrop-blur-xl border border-white/[0.08] rounded-2xl",
        className
      )}
      style={borderColor ? { borderColor } : undefined}
    >
      {children}
    </div>
  );
}
