import Link from "next/link";
import { SITE_URL } from "@/lib/constants/metadata";

export interface BreadcrumbItem {
  label: string;
  href?: string; // last item has no href (current page)
}

interface BreadcrumbProps {
  items: BreadcrumbItem[];
  locale: string;
}

/**
 * Visual breadcrumb navigation + BreadcrumbList JSON-LD schema.
 * Renders <nav> with <ol> and structured data for Google rich snippets.
 *
 * Security: All breadcrumb data comes from server-side route params and static
 * constants (no user input). JSON-LD injection is the standard pattern for
 * structured data in Next.js Server Components.
 */
export function Breadcrumb({ items, locale }: BreadcrumbProps) {
  // Always include "Home" as first item
  const fullItems: BreadcrumbItem[] = [
    { label: "Qulo", href: `/${locale}` },
    ...items,
  ];

  // Build BreadcrumbList JSON-LD from trusted static data
  const jsonLd = JSON.stringify({
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: fullItems.map((item, index) => ({
      "@type": "ListItem",
      position: index + 1,
      name: item.label,
      ...(item.href ? { item: `${SITE_URL}${item.href}` } : {}),
    })),
  });

  return (
    <>
      {/* JSON-LD: trusted server-side route params + static constants only */}
      <script
        type="application/ld+json"
        // eslint-disable-next-line react/no-danger
        dangerouslySetInnerHTML={{ __html: jsonLd }}
      />
      <nav aria-label="Breadcrumb" className="mb-6">
        <ol className="flex flex-wrap items-center gap-2 text-xs text-qulo-text-secondary">
          {fullItems.map((item, index) => {
            const isLast = index === fullItems.length - 1;
            return (
              <li key={index} className="flex items-center gap-2">
                {item.href && !isLast ? (
                  <Link
                    href={item.href}
                    className="hover:text-qulo-purple transition-colors"
                  >
                    {item.label}
                  </Link>
                ) : (
                  <span aria-current="page" className="text-white">
                    {item.label}
                  </span>
                )}
                {!isLast && (
                  <span aria-hidden="true" className="text-qulo-text-secondary/40">
                    /
                  </span>
                )}
              </li>
            );
          })}
        </ol>
      </nav>
    </>
  );
}
