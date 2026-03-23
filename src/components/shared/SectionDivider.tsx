import { cn } from "@/lib/utils/cn";

interface SectionDividerProps {
  className?: string;
}

export function SectionDivider({ className }: SectionDividerProps) {
  return (
    <div
      className={cn("relative w-full flex items-center justify-center py-1", className)}
      aria-hidden="true"
    >
      {/* Left line: fades from transparent to center */}
      <div
        className="flex-1 h-px"
        style={{
          background:
            "linear-gradient(90deg, transparent 0%, rgba(187,134,252,0.25) 60%, rgba(187,134,252,0.4) 100%)",
        }}
      />

      {/* Center diamond */}
      <div className="relative mx-3 flex-shrink-0">
        {/* Glow behind diamond */}
        <div
          className="absolute inset-0 rounded-full pointer-events-none"
          style={{
            boxShadow: "0 0 12px 4px rgba(187,134,252,0.35)",
            borderRadius: "50%",
            transform: "scale(1.4)",
          }}
        />
        {/* Diamond icon (purple_diamond.svg) */}
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img
          src="/brand/purple_diamond.svg"
          alt=""
          width={16}
          height={16}
          className="relative z-10 opacity-90"
          style={{
            filter: "drop-shadow(0 0 6px rgba(187,134,252,0.8)) drop-shadow(0 0 2px rgba(187,134,252,1))",
          }}
        />
      </div>

      {/* Right line: fades from center to transparent */}
      <div
        className="flex-1 h-px"
        style={{
          background:
            "linear-gradient(90deg, rgba(187,134,252,0.4) 0%, rgba(105,240,174,0.25) 60%, transparent 100%)",
        }}
      />
    </div>
  );
}
