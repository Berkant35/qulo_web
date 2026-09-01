"use client";

import Link from "next/link";
import { useTranslations } from "next-intl";
import { cn } from "@/lib/utils/cn";

export interface FooterLinkItem {
  /** Path after the locale segment, e.g. "privacy-policy" */
  href: string;
  /** Key in the "footer" translation namespace */
  labelKey?: string;
  /** Literal label for proper nouns that are not translated (city names) */
  label?: string;
}

interface FooterLinkColumnProps {
  /** Key in the "footer" namespace used for the column heading */
  titleKey: string;
  /** Tailwind colour token for the heading, e.g. "text-qulo-purple" */
  titleClassName: string;
  locale: string;
  items: readonly FooterLinkItem[];
}

export function FooterLinkColumn({
  titleKey,
  titleClassName,
  locale,
  items,
}: FooterLinkColumnProps) {
  const t = useTranslations("footer");

  return (
    <div>
      <p
        className={cn(
          "text-[10px] font-semibold uppercase tracking-[0.15em] mb-3",
          titleClassName,
        )}
      >
        {t(titleKey)}
      </p>
      <ul className="space-y-2">
        {items.map(({ href, labelKey, label }) => (
          <li key={href}>
            <Link
              href={`/${locale}/${href}`}
              className="text-xs text-qulo-text-secondary hover:text-white transition-colors"
            >
              {labelKey ? t(labelKey) : label}
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
