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
        "bg-white/[0.06] backdrop-blur-xl border border-white/[0.12] rounded-2xl",
        className
      )}
      style={borderColor ? { borderColor } : undefined}
    >
      {children}
    </div>
  );
}
