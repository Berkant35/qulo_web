import { formatSource, type StatSource } from "@/lib/constants/stats";

interface SourceLineProps {
  source: StatSource;
  /** Localized "Source" prefix. Omit where the surrounding copy already says it. */
  label?: string;
}

/**
 * Attribution under a single figure: publisher, report title, publication date,
 * sample size, and a link to the publisher's own page so a reader can check the
 * methodology instead of taking our word for it.
 *
 * Both /dating-statistics and /trends/2026 invite readers to cite them, so every
 * figure on those pages must carry this line.
 */
export function SourceLine({ source, label }: SourceLineProps) {
  return (
    <p className="mt-3 text-[10px] uppercase tracking-wider text-qulo-text-secondary">
      {label ? `${label}: ` : ""}
      <a
        href={source.url}
        target="_blank"
        rel="noopener noreferrer nofollow"
        className="underline hover:text-qulo-purple"
      >
        {formatSource(source)}
      </a>
      {source.sample ? ` · ${source.sample}` : ""}
    </p>
  );
}
