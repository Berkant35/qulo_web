"use client";

import { cn } from "@/lib/utils/cn";

interface IconProps {
  name: string;
  size?: number;
  className?: string;
  folder?: "icons" | "brand";
}

export function Icon({ name, size = 24, className, folder = "icons" }: IconProps) {
  return (
    <img
      src={`/${folder}/${name}.svg`}
      alt={name}
      width={size}
      height={size}
      className={cn("inline-block", className)}
    />
  );
}
