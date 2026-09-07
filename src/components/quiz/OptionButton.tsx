import { cn } from "@/lib/utils/cn";

interface OptionButtonProps {
  label: string;
  state: "idle" | "selected" | "correct" | "wrong" | "disabled";
  onClick?: () => void;
}

/** One answer choice. `correct`/`wrong` are only used on the result screen. */
export function OptionButton({ label, state, onClick }: OptionButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      disabled={state === "disabled" || !onClick}
      className={cn(
        "w-full text-left rounded-lg border px-4 py-2.5 text-sm transition-colors",
        state === "idle" && "border-white/10 bg-white/5 hover:border-qulo-purple/60",
        state === "selected" && "border-qulo-purple bg-qulo-purple/20 text-white",
        state === "correct" && "border-qulo-green bg-qulo-green/15 text-qulo-green",
        state === "wrong" && "border-red-400/70 bg-red-400/10 text-red-200 line-through",
        state === "disabled" && "border-white/5 bg-white/[0.03] text-qulo-text-muted cursor-not-allowed",
      )}
    >
      {label}
    </button>
  );
}
