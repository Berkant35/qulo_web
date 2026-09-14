import type { ReactNode } from "react";
import Link from "next/link";
import { findTerm, glossaryTerms } from "@/lib/seo/glossaryLinks";

/**
 * Structured article content model.
 *
 * Blog posts authored as data (not per-locale JSX) so a single article can be
 * fully translated into all 16 locales without duplicating markup. Text may
 * contain `**bold**` spans, rendered as <strong className="text-white">.
 * All content is trusted static data authored in-repo (no user input).
 */
export type ArticleBlock =
  | { type: "h2"; text: string; accent?: "purple" | "green" }
  | { type: "h3"; text: string }
  | { type: "p"; text: string }
  | { type: "ul"; items: string[] }
  | { type: "quote"; text: string };

export type LocalizedArticle = Record<string, ArticleBlock[]>;

/**
 * How many glossary links one article may grow.
 *
 * The point is to give the 432 term pages contextual inbound links from prose
 * that already discusses them; it is not to turn a paragraph into a link farm.
 * One link per term, six per article, body text only — never a heading.
 */
const MAX_GLOSSARY_LINKS = 6;

/** Mutable per-render state so a term is linked once per article, not once per block. */
interface LinkBudget {
  locale: string;
  used: Set<string>;
}

/** Wrap the first standalone mention of an unused glossary term in a link. */
function linkGlossaryTerms(text: string, budget: LinkBudget, key: string): ReactNode[] {
  if (budget.used.size >= MAX_GLOSSARY_LINKS) return [text];

  for (const { slug, term } of glossaryTerms(budget.locale)) {
    if (budget.used.has(slug)) continue;
    const at = findTerm(text, term, budget.locale);
    if (at < 0) continue;

    budget.used.add(slug);
    return [
      text.slice(0, at),
      <Link
        key={`${key}-${slug}`}
        href={`/${budget.locale}/glossary/${slug}`}
        className="text-qulo-purple underline underline-offset-4 decoration-qulo-purple/40 hover:decoration-qulo-purple"
      >
        {text.slice(at, at + term.length)}
      </Link>,
      ...linkGlossaryTerms(text.slice(at + term.length), budget, `${key}-${slug}`),
    ];
  }
  return [text];
}

/**
 * Render `**bold**` spans inside otherwise plain text, and — when a link budget
 * is supplied — turn the first mention of a glossary term into a link to its
 * page. Static input only.
 */
function renderInline(text: string, budget?: LinkBudget, key = "t"): ReactNode[] {
  return text.split(/(\*\*[^*]+\*\*)/g).map((part, i) => {
    if (part.startsWith("**") && part.endsWith("**")) {
      return (
        <strong key={i} className="text-white">
          {part.slice(2, -2)}
        </strong>
      );
    }
    return (
      <span key={i}>{budget ? linkGlossaryTerms(part, budget, `${key}-${i}`) : part}</span>
    );
  });
}

export function ArticleBlocks({
  blocks,
  locale,
  excludeSlug,
}: {
  blocks: ArticleBlock[];
  /**
   * Pass the page's locale to enable automatic glossary linking. Omitted on
   * pages where it would be noise.
   */
  locale?: string;
  /** The glossary slug this page *is*, so it never links to itself. */
  excludeSlug?: string;
}) {
  const budget: LinkBudget | undefined = locale
    ? { locale, used: new Set(excludeSlug ? [excludeSlug] : []) }
    : undefined;

  return (
    <>
      {blocks.map((block, i) => {
        switch (block.type) {
          case "h2":
            return (
              <h2
                key={i}
                className={`text-2xl font-bold ${
                  block.accent === "green" ? "text-qulo-green" : "text-qulo-purple"
                } mb-4 mt-10`}
              >
                {renderInline(block.text)}
              </h2>
            );
          case "h3":
            return (
              <h3 key={i} className="text-xl font-semibold text-white mb-3 mt-6">
                {renderInline(block.text)}
              </h3>
            );
          case "p":
            return (
              <p key={i} className="text-qulo-text-secondary leading-relaxed mb-4">
                {renderInline(block.text, budget, `p${i}`)}
              </p>
            );
          case "ul":
            return (
              <ul
                key={i}
                className="list-disc list-inside text-qulo-text-secondary space-y-2 mb-4"
              >
                {block.items.map((item, j) => (
                  <li key={j}>{renderInline(item, budget, `u${i}-${j}`)}</li>
                ))}
              </ul>
            );
          case "quote":
            return (
              <blockquote
                key={i}
                className="border-l-4 border-qulo-green pl-4 my-8 italic text-qulo-text-secondary"
              >
                {renderInline(block.text)}
              </blockquote>
            );
          default:
            return null;
        }
      })}
    </>
  );
}
