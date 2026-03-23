import { cn } from "@/lib/utils/cn";

interface NeonButtonProps {
  children: React.ReactNode;
  href?: string;
  className?: string;
  disabled?: boolean;
}

export function NeonButton({ children, href, className, disabled }: NeonButtonProps) {
  const baseClasses = cn(
    "inline-flex items-center justify-center px-6 py-2.5 rounded-xl font-semibold text-sm",
    "bg-gradient-to-r from-qulo-purple to-qulo-purple-dark text-white",
    "transition-all duration-200",
    !disabled && "hover:-translate-y-0.5 hover:shadow-[0_0_24px_rgba(187,134,252,0.5)] cursor-pointer",
    disabled && "opacity-50 cursor-not-allowed",
    className
  );

  if (href && !disabled) {
    return (
      <a href={href} className={baseClasses}>
        {children}
      </a>
    );
  }

  return <span className={baseClasses}>{children}</span>;
}
