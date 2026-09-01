import { type StatSource } from "@/lib/constants/stats";

interface SourceListProps {
  sources: StatSource[];
  /** Localized section heading. */
  heading: string;
  /** Localized paragraph explaining the sourcing rule for the page. */
  intro: string;
}

/**
 * The full source list for a page that invites citation. A journalist checks
 * this before citing anything, so it is rendered above the "cite this report"
 * block on both /dating-statistics and /trends/2026.
 */
export function SourceList({ sources, heading, intro }: SourceListProps) {
  if (sources.length === 0) return null;

  return (
    <section
      id="sources"
      aria-labelledby="sources-heading"
      className="mb-16 rounded-2xl border border-white/[0.08] bg-white/[0.03] p-8 scroll-mt-28"
    >
      <h2 id="sources-heading" className="text-2xl font-bold text-qulo-green mb-3">
        {heading}
      </h2>
      <p className="text-sm text-qulo-text-secondary mb-6">{intro}</p>
      <ol className="space-y-4">
        {sources.map((source) => (
          <li key={source.url} className="text-sm">
            <a
              href={source.url}
              target="_blank"
              rel="noopener noreferrer nofollow"
              className="text-white font-medium underline hover:text-qulo-purple"
            >
              {source.publisher} — {source.title}
            </a>
            <p className="text-qulo-text-secondary text-xs mt-1">
              {source.date}
              {source.sample ? ` · ${source.sample}` : ""}
            </p>
          </li>
        ))}
      </ol>
    </section>
  );
}
