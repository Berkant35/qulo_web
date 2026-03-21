import { cn } from "@/lib/utils/cn";

interface SectionDividerProps {
  className?: string;
}

export function SectionDivider({ className }: SectionDividerProps) {
  return (
    <div
      className={cn("w-full h-px", className)}
      style={{
        background:
          "linear-gradient(90deg, transparent 0%, rgba(187,134,252,0.5) 30%, rgba(105,240,174,0.5) 70%, transparent 100%)",
      }}
      aria-hidden="true"
    />
  );
}
